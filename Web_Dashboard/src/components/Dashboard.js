import React from "react";
import { useUserContext } from "./UserContext";

const Dashboard = () => {
  const { userType } = useUserContext();

  const departments = [
    {
      name: "Department of Water Resources",
      description: "Responsible for water resource management.",
    },
    {
      name: "Ministry of Jal Shakti",
      description: "Works on water-related policies and programs.",
    },
  ];

  const table = (
    <table className="table-auto">
      <thead>
        <tr>
          <th className="px-4 py-2">Department Name</th>
          <th className="px-4 py-2">Description</th>
        </tr>
      </thead>
      <tbody>
        {departments.map((department, index) => (
          <tr key={index}>
            <td className="border px-4 py-2">{department.name}</td>
            <td className="border px-4 py-2">{department.description}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
  return (
    <div>
      <h1>Welcome to the Dashboard</h1>
      <p>User Type: {userType}</p>
      {userType === "department" && table}
    </div>
  );
};

export default Dashboard;
