import * as ajax from "../../common/ajax";

export const get = () => ajax.pureGet("/teacher");

export const update = entity => ajax.patch("/teacher/updatePwd", entity);
