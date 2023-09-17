import React from "react";
import Departments from "./Departments";

const Dashboard = () => {
  const userType = localStorage.getItem("userType");
  const DepartmentCard = ({ department, index }) => {
    // Define an onClick handler for the card that redirects to /dashboard/{index}
    const handleCardClick = () => {
      // Redirect to the appropriate URL
      window.location.href = `/dashboard/${index}`;
    };

    return (
      <div
        className="bg-white border rounded-lg p-4 m-4 w-64 shadow-md"
        onClick={handleCardClick} // Add the onClick handler to the card
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
      <h1>Welcome to the Dashboard</h1>
      <p>User Type: {userType}</p>
      <div className="flex flex-wrap justify-center">
        {userType === "public" && departmentCards}
      </div>
    </div>
  );
};

export default Dashboard;
