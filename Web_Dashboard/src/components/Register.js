import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Public from "./Public";

const Register = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    username: "",
    password: "",
    first_name: "",
    last_name: "",
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch("https://jaldristi.shubhendra.in/register", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        console.log("Registration successful");
        navigate("/login");
      } else {
        console.error("Registration failed");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  return (
    <>
      <Public />
      <div className="bg-gray-100 min-h-screen flex justify-center items-center">
        <div className="bg-white p-8 rounded shadow-md w-96">
          <h2 className="text-2xl font-semibold mb-6">Register</h2>
          <form onSubmit={handleSubmit}>
            <div className="mb-4">
              <label htmlFor="username" className="block font-medium mb-2">
                Username:
              </label>
              <input
                type="text"
                id="username"
                name="username"
                value={formData.username}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
                required
              />
            </div>
            <div className="mb-4">
              <label htmlFor="password" className="block font-medium mb-2">
                Password:
              </label>
              <input
                type="password"
                id="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
                required
              />
            </div>
            <div className="mb-4">
              <label htmlFor="first_name" className="block font-medium mb-2">
                First Name:
              </label>
              <input
                type="text"
                id="first_name"
                name="first_name"
                value={formData.first_name}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
                required
              />
            </div>
            <div className="mb-4">
              <label htmlFor="last_name" className="block font-medium mb-2">
                Last Name:
              </label>
              <input
                type="text"
                id="last_name"
                name="last_name"
                value={formData.last_name}
                onChange={handleChange}
                className="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600 transition duration-300"
            >
              Register
            </button>
          </form>
        </div>
      </div>
    </>
  );
};

export default Register;
