import { Routes, Route } from "react-router-dom";
import Public from "./components/Public";
import Dashboard from "./components/Dashboard";
import Login from "./components/Login";
import Register from "./components/Register";
import WebView from "./components/WebView";
import MinistryOfJalShakti from "./departments/MinistryOfJalShakti";
import CentralWaterCommission from "./departments/CentralWaterCommission";
import NationalDisasterResponseForce from "./departments/NationalDisasterResponseForce";
import StateDisasterManagementAuthorities from "./departments/StateDisasterManagementAuthorities";
import IndiaMeteorologicalDepartment from "./departments/IndiaMeteorologicalDepartment";
import CentralGroundWaterBoard from "./departments/CentralGroundWaterBoard";
import NationalWaterDevelopmentAgency from "./departments/NationalWaterDevelopmentAgency";
import NationalDisasterManagementAuthority from "./departments/NationalDisasterManagementAuthority";
import NationalSearchAndRescueAgency from "./departments/NationalSearchAndRescueAgency";
import FireServicesDepartment from "./departments/FireServicesDepartment";
import IndianArmyEngineeringCorps from "./departments/IndianArmyEngineeringCorps";
import IndianNavy from "./departments/IndianNavy";

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
      <Route path="/dashboard/0" element={<MinistryOfJalShakti />} />
      <Route path="/dashboard/1" element={<CentralWaterCommission />} />
      <Route path="/dashboard/2" element={<NationalDisasterResponseForce />} />
      <Route
        path="/dashboard/3"
        element={<StateDisasterManagementAuthorities />}
      />
      <Route path="/dashboard/4" element={<IndiaMeteorologicalDepartment />} />
      <Route path="/dashboard/5" element={<CentralGroundWaterBoard />} />
      <Route path="/dashboard/6" element={<NationalWaterDevelopmentAgency />} />
      <Route
        path="/dashboard/7"
        element={<NationalDisasterManagementAuthority />}
      />
      <Route path="/dashboard/8" element={<NationalSearchAndRescueAgency />} />
      <Route path="/dashboard/9" element={<FireServicesDepartment />} />
      <Route path="/dashboard/10" element={<IndianArmyEngineeringCorps />} />
      <Route path="/dashboard/11" element={<IndianNavy />} />
    </Routes>
  );
}

export default App;
