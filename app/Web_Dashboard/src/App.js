import { Routes, Route } from "react-router-dom";
import Public from "./components/Public";
import Dashboard from "./components/Dashboard";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Public />}>
        <Route index element={<Public />} />
      </Route>
      <Route path="/dashboard" element={<Dashboard />} />
    </Routes>
  );
}

export default App;
