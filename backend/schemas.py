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
    type: UserType

    class Config:
        orm_mode = True


class UserInLogin(BaseModel):
    username: str
    password: str


class UserInResponse(BaseModel):
    user: User
    access_token: str
    token_type: str
    user_type: UserType


class UserRegister(BaseModel):
    username: str
    password: str
    first_name: str
    last_name: str

class IncidentCreate(BaseModel):
    image_url: str
    description: str
    latitude: float
    longitude: float
    department_id: int


class IncidentReview(BaseModel):
    is_valid: bool
    comments: Optional[str] = None


class DepartmentAssignment(BaseModel):
    department_id: int


class IncidentClose(BaseModel):
    comments: Optional[str] = None
