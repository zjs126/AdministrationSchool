import { post, pureGet } from "../common/ajax";

export const login = (username, password, userType) =>
  post("/login", {
    id: username,
    password: password,
    userType: userType,
    university: "华中师范大学"
  });

export const getLoginStatus = () => pureGet("/login/status");

export const logout = () => pureGet("/user/logout");
