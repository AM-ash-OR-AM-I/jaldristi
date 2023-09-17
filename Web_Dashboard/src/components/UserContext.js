import { createContext, useContext, useState } from "react";

const UserContext = createContext();

export function useUserContext() {
  return useContext(UserContext);
}

export function UserProvider({ children }) {
  const [userType, setUserType] = useState(""); // Initialize userType with an initial value

  return (
    <UserContext.Provider value={{ userType, setUserType }}>
      {children}
    </UserContext.Provider>
  );
}
