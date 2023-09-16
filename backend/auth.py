import datetime
import os

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
import jwt


from . import models, database

SECRET_KEY = os.environ.get("SECRET_KEY")


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


def create_token(user: models.User):
    token = jwt.encode(
        payload={
            "username": user.username,
            "user_id": str(user.id),
            "exp": datetime.datetime.now() + datetime.timedelta(days=30),
         },
        key=SECRET_KEY,
    )
    print(token)
    return token


def get_current_user(db: Session = Depends(database.get_db), token: str = Depends(oauth2_scheme)) -> models.User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate the token",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        token_data = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
    except jwt.DecodeError:
        raise credentials_exception
    user = db.query(models.User).filter(models.User.id == token_data.get("user_id")).first()
    if user is None:
        raise credentials_exception
    return user
