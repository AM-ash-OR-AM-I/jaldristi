import { Link } from "react-router-dom";
import { useAuth0 } from "@auth0/auth0-react";
import LoginButton from "./LoginButton";
import LogoutButton from "./LogoutButton";
import WebView from "./WebView";
import Dashboard from "./Dashboard";

const Public = () => {
  const { isAuthenticated } = useAuth0();

  const content = (
    <>
      <section className="bg-blue-500 text-white p-4 flex justify-between items-center">
        <header className="text-center">
          <h1 className="text-2xl font-bold title">Jal Dristi</h1>
        </header>
        <footer className=" flex justify-center items-center space-x-4">
          <LoginButton />
          <LogoutButton />
        </footer>
      </section>
      {!isAuthenticated && <WebView />}
      {isAuthenticated && <Dashboard />}
    </>
  );
  return content;
};

export default Public;
