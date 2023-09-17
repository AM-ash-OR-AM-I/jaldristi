import { Link } from "react-router-dom";

const Public = () => {
  const content = (
    <>
      <section className="bg-blue-500 text-white p-4 flex justify-between items-center">
        <header className="text-center">
          <h1 className="text-2xl font-bold title">Jal Dristi</h1>
        </header>
        <footer className=" flex justify-center items-center space-x-4">
          <Link to="/login">
            <button className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
              Login
            </button>
          </Link>
          <Link to="/register">
            <button className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">
              Register
            </button>
          </Link>
        </footer>
      </section>
    </>
  );
  return content;
};

export default Public;
