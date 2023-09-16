import os
import boto3
import logging

from fastapi import FastAPI, Depends, HTTPException, Form, UploadFile, File, status, Query
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from . import models, schemas, auth
from .database import get_db

S3_BUCKET = os.environ.get("S3_BUCKET")
S3_REGION = os.environ.get("S3_REGION")
LOGGING_LEVEL = os.environ.get("LOGGING_LEVEL", 20)
logging.basicConfig(format="%(levelname)s - %(message)s", level=logging.INFO)

app = FastAPI()

S3 = boto3.resource("s3")


def s3_upload(data, key):
    S3.meta.client.put_object(
        Bucket=S3_BUCKET,
        Key=key,
        Body=data,
    )
    object_url = "https://s3-{0}.amazonaws.com/{1}/{2}".format(
        S3_REGION,
        S3_BUCKET,
        key,
    )
    return object_url


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
        user_type=user.user_type,
    )


@app.post("/api/incidents/", response_model=int)
async def create_incident(
        incident: schemas.IncidentCreate,
        db: Session = Depends(get_db),
        user: schemas.User = Depends(auth.get_current_user),
):
    incident = models.Incident(
        image_url=incident.image_url,
        description=incident.description,
        latitude=incident.latitude,
        longitude=incident.longitude,
        department_id=incident.department_id,
        reported_by_id=user.id,
        reviewed=False,
        closed=False,
    )
    db.add(incident)
    db.commit()
    db.refresh(incident)
    return incident.id


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
