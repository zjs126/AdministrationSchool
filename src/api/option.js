import { patch, pureGet } from "../common/ajax";

export const getAllowStudentSelect = () =>
  pureGet("/admin/allowStudentSelect");

export const setAllowStudentSelect = option =>
  patch("/admin/course/state", {
    state: option
  });

export const getAllowTeacherGrade = () => pureGet("/admin/allowTeacherGrade");

export const setAllowTeacherGrade = option =>
  patch("/admin/selection/status", {
    status: option
  });
