import { Routes, Route } from "react-router-dom";
import Public from "./components/Public";
import Dashboard from "./components/Dashboard";
import Login from "./components/Login";
import Register from "./components/Register";
import WebView from "./components/WebView";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Public />}>
        <Route index element={<Public />} />
      </Route>
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/dashboard" element={<Dashboard />} />
      <Route path="/webview" element={<WebView />} />
    </Routes>
  );
}

export default App;
