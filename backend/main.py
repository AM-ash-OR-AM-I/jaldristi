import os
import boto3
import logging
from uuid import uuid4

from fastapi import FastAPI, Depends, HTTPException, Form, UploadFile, File, status, Query
from fastapi.security import OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from . import models, schemas, auth
from .database import get_db

S3_BUCKET = "jaldristi"
S3_REGION = "us-east-1"
LOGGING_LEVEL = os.environ.get("LOGGING_LEVEL", 20)
logging.basicConfig(format="%(levelname)s - %(message)s", level=logging.INFO)

app = FastAPI()
origins = ["*"]  # This allows requests from all domains

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

S3 = boto3.resource("s3")


def s3_upload(data, key):
    S3.meta.client.put_object(
        Bucket=S3_BUCKET,
        Key=key,
        Body=data,
    )
    return "https://jaldristi.s3.amazonaws.com/" + key



@app.post("/login", response_model=schemas.UserInResponse, tags=["Login"])
async def login(user_login: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = db.query(models.User).filter(
        models.User.username == user_login.username,
                models.User.password == user_login.password,
                                        ).first()
    if user is None:
        raise HTTPException(401, "Username or Password is incorrect")
    token = auth.create_token(user)
    return schemas.UserInResponse(
        user=user,
        access_token=token,
        user_type=user.user_type,
        token_type="Bearer"
    )


@app.post("/register", response_model=schemas.UserInResponse, tags=["Register"])
async def register(user: schemas.UserRegister, db: Session = Depends(get_db)):
    # handle when user already exists
    if db.query(models.User).filter(models.User.username == user.username).first():
        raise HTTPException(400, "User already exists")

    user = models.User(
        username=user.username,
        password=user.password,
        first_name=user.first_name,
        last_name=user.last_name,
        user_type=schemas.UserType.public,
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    token = auth.create_token(user)
    return schemas.UserInResponse(
        user=user,
        access_token=token,
        token_type="Bearer",
    )


@app.post("/api/incidents/", response_model=schemas.Incident, tags=["Incidents"])
async def create_incident(
        db: Session = Depends(get_db),
        user: schemas.User = Depends(auth.get_current_user),
        image: UploadFile = File(...),
        department_id: int = Form(...),
        category: str = Form(...),
        description: str = Form(...),
        latitude: float = Form(...),
        longitude: float = Form(...),
):
    # Check if department exists
    if not db.query(models.Department).filter(models.Department.id == department_id).first():
        raise HTTPException(400, "Department does not exist")


    image_data = await image.read()
    image_key = str(uuid4()) + image.filename
    image_url = s3_upload(image_data, image_key)

    incident = models.Incident(
        image_url=image_url,
        description=description,
        latitude=latitude,
        longitude=longitude,
        department_id=department_id,
        reported_by_id=user.id,
        reviewed=False,
        closed=False,
        category=category,
    )

    db.add(incident)
    db.commit()
    db.refresh(incident)
    return incident



@app.get("/api/incidents/{incident_id}", response_model=schemas.Incident, tags=["Incidents"])
async def get_incident(
        db: Session = Depends(get_db),
        user: schemas.User = Depends(auth.get_current_user),
        incident_id: int = Query(...),
):
    incident = db.query(models.Incident).filter(models.Incident.id == incident_id).first()
    if incident is None:
        raise HTTPException(404, "Incident does not exist")
    return incident



if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
