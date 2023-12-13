import * as ajax from "../../common/ajax";

export const get = id => ajax.get("/student/" + id);

export const create = entity => ajax.post("/stuRegister", entity);

export const deleteItem = id => ajax.pureDelete("/admin/student/" + id);

export const update = entity => ajax.put("/student/update", entity);

export const getPageCount = () =>
  ajax.get("/student/page");

export const getPage = (index, name, major, className) =>
  ajax.get("/student/page", {
    page: index,
    pageSize: 2,
    name: name,
    major: major,
    className: className
  });

export const listName = () => ajax.pureGet("/admin/student/names");

export const pageSize = 2;
