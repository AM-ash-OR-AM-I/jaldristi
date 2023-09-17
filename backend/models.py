import datetime

from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, TIMESTAMP, Float, Enum
from sqlalchemy.orm import relationship

from .database import Base, engine


class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, index=True)
    first_name = Column(String(50))
    last_name = Column(String(50))
    password = Column(String(200))
    user_type = Column(Enum('admin', 'department', 'reviewer', 'public', name='user_type'))

    reported_incidents = relationship("Incident", back_populates="reported_by")


class Department(Base):
    __tablename__ = 'departments'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), unique=True, index=True)
    description = Column(String(200))

    incidents = relationship("Incident", back_populates="assigned_department")


class Incident(Base):
    __tablename__ = 'incidents'

    id = Column(Integer, primary_key=True, index=True)
    image_url = Column(String(500))
    description = Column(String(5000))
    latitude = Column(Float)
    longitude = Column(Float)
    reviewed = Column(Boolean, default=False)
    valid = Column(Boolean)
    department_id = Column(Integer, ForeignKey("departments.id"))
    closed = Column(Boolean, default=False)
    category = Column(String(50))

    reported_by_id = Column(Integer, ForeignKey("users.id"))
    reported_by = relationship("User", back_populates="reported_incidents")
    assigned_department = relationship("Department", back_populates="incidents")


Base.metadata.create_all(bind=engine)
