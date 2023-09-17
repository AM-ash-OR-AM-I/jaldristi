import React, { useEffect, useState } from "react";

const DisplayIssues = () => {
  const pathname = window.location.pathname;
  const match = pathname.match(/\/(\d+)$/);
  const lastNumber = parseInt(match[1], 10);
  const [response, setResponse] = useState(null);
  const access_token = localStorage.getItem("access_token");

  useEffect(() => {
    fetch("https://jaldristi.shubhendra.in/api/incidents/", {
      method: "GET",
      headers: {
        accept: "application/json",
        Authorization: `Bearer ${access_token}`,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        const filteredIssues = data.filter(
          (issue) => issue.department.id === lastNumber + 1
        );
        console.log(filteredIssues);
        setResponse(filteredIssues); // Set filtered issues instead of the entire data array
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  }, [lastNumber]);

  return (
    <div>
      <div className="container mx-auto py-8">
        <h1 className="text-2xl font-semibold mb-4">List of Issues</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {response ? (
            response.map((issue) => (
              <div key={issue.id} className="bg-white shadow-lg rounded-lg p-4">
                <img
                  src={issue.image_url}
                  alt={issue.description}
                  className="w-full h-40 object-cover mb-2 rounded-lg"
                />
                <h2 className="text-lg font-semibold mb-2">
                  {issue.description}
                </h2>
                <p className="text-gray-600 mb-2">Category: {issue.category}</p>
                <p className="text-gray-600 mb-2">Latitude: {issue.latitude}</p>
                <p className="text-gray-600 mb-2">
                  Longitude: {issue.longitude}
                </p>
                <p className="text-gray-600">
                  Reported by ID : {issue.reported_by_id}
                </p>
              </div>
            ))
          ) : (
            <p>Loading...</p>
          )}
        </div>
      </div>
    </div>
  );
};
export default DisplayIssues;
