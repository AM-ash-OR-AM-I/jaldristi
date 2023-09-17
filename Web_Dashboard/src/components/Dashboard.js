import React, { useEffect } from "react";
import Departments from "./Departments";
import { useNavigate } from "react-router-dom";
import PersonalIssues from "./PersonalIssues";
import ReviewerIssues from "./ReviewerIssues";

const Dashboard = () => {
  const navigate = useNavigate();
  const userType = localStorage.getItem("userType");

  useEffect(() => {
    if (userType === "department") {
      const departmentId = JSON.parse(localStorage.getItem("departmentId"));
      if (departmentId) {
        const dept_id = departmentId - 1;
        navigate(`/dashboard/${dept_id}`);
      }
    }
  }, [userType, navigate]);

  const DepartmentCard = ({ department, index }) => {
    const handleCardClick = () => {
      navigate(`/dashboard/${index}`);
    };

    return (
      <div
        className="bg-white border rounded-lg p-4 m-4 w-64 shadow-md"
        onClick={handleCardClick}
      >
        <img
          src={department.logoUrl}
          alt={`${department.name} Logo`}
          className="h-32 w-32 object-contain mx-auto mb-2"
        />
        <h2 className="text-lg font-semibold">{department.name}</h2>
        <p className="text-gray-600">{department.description}</p>
      </div>
    );
  };

  const departmentCards = Departments.map((department, index) => (
    <div key={index} className="flex mb-4">
      <DepartmentCard department={department} index={index} />
    </div>
  ));

  return (
    <div>
      <h1 className="text-4xl font-bold text-center mt-8">
        Welcome to the Dashboard
      </h1>
      <p className="text-lg text-center text-gray-600 mt-4">
        User Type: {userType}
      </p>
      <div className="flex flex-wrap justify-center">
        {userType === "admin" && departmentCards}
        {userType === "public" && <PersonalIssues />}
        {userType === "reviewer" && <ReviewerIssues />}
      </div>
    </div>
  );
};

export default Dashboard;
