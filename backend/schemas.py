from pydantic import BaseModel
from typing import Optional
from enum import Enum


class UserType(str, Enum):
    admin = 'admin'
    department = 'department'
    reviewer = 'reviewer'
    public = 'public'


class User(BaseModel):
    id: int
    username: str
    first_name: str
    last_name: str
    user_type: UserType

    class Config:
        orm_mode = True


class UserInLogin(BaseModel):
    username: str
    password: str


class UserInResponse(BaseModel):
    user: User
    access_token: str
    token_type: str


class UserRegister(BaseModel):
    username: str
    password: str
    first_name: str
    last_name: str


class Incident(BaseModel):
    id: int
    image_url: str
    description: str
    latitude: float
    longitude: float
    reviewed: bool
    valid: Optional[bool]
    department_id: int
    closed: bool
    category: str
    reported_by_id: int

    class Config:
        orm_mode = True


class IncidentReview(BaseModel):
    is_valid: bool
    comments: Optional[str] = None


class IncidentClose(BaseModel):
    comments: Optional[str] = None
