import Vue from "vue";
import VueRouter from "vue-router";
import Container from "./views/Container.vue";
import Login from "./views/Login";
import StudentCourseSelect from "./views/student/StudentCourseSelect";
import StudentCourse from "./views/student/StudentCourse";
import StudentInfo from "./views/student/StudentInfo";
import StudentTimeTable from "./views/student/StudentTimeTable";
import StudentExam from "./views/student/StudentExam";
import StudentScore from "./views/student/StudentScore";
import StudentDeferred from './views/student/StudentDeferred'
import GradeAnalysis from './views/student/GradeAnalysis'
import TeacherCourse from "./views/teacher/TeacherCourse";
import TeacherTimetable from "./views/teacher/TeacherTimetable";
import TeacherGrade from "./views/teacher/TeacherGrade";
import TeacherInfo from "./views/teacher/TeacherInfo"
import AdminDepartment from "./views/admin/AdminDepartment";
import AdminMajor from "./views/admin/AdminMajor";
import AdminClass from "./views/admin/AdminClass";
import AdminStudent from "./views/admin/AdminStudent";
import AdminTeacher from "./views/admin/AdminTeacher";
import AdminCourse from "./views/admin/AdminCourse";
import AdminStudentCourse from "./views/admin/AdminStudentCourse";
import AdminAdmin from "./views/admin/AdminAdmin";
import AdminApply from "./views/admin/AdminApply"
import AdminInfo from "./views/admin/AdminInfo"
import Home from "./views/Home";
import TeacherBorrowClass from "./views/teacher/TeacherBorrowClass.vue"
import AdminConfirm from "./views/admin/AdminConfirm.vue"
import Forum from "./views/forum.vue"

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "container",
    component: Container,
    children: [
      {
        path: "/student",
        name: "student-home",
        component: Home
      },
      {
        path: "/student/course/select",
        name: "student-course-select",
        component: StudentCourseSelect
      },
      {
        path: "/student/course",
        name: "student-course",
        component: StudentCourse
      },
      {
        path: "/student/timetable",
        name: "student-timetable",
        component: StudentTimeTable
      },
      {
        path: "/student/exam",
        name: "student-exam",
        component: StudentExam
      },
      {
        path: "/student/score",
        name: "student-score",
        component: StudentScore
      },
      {
        path: "/student/info",
        name: "student-info",
        component: StudentInfo
      },
      {
        path: "/student/apply",
        name: "student-apply",
        component: StudentDeferred
      },
      {
        path: "/student/analysis",
        name: "student-analysis",
        component: GradeAnalysis
      },
      {
        path: "/teacher",
        name: "teacher-home",
        component: Home
      },
      {
        path: "/teacher/course",
        name: "teacher-course",
        component: TeacherCourse
      },
      {
        path: "/teacher/timetable",
        name: "teacher-timetable",
        component: TeacherTimetable
      },
      {
        path: "/teacher/grade",
        name: "teacher-grade",
        component: TeacherGrade
      },
      {
        path: "/teacher/borrowClass",
        name: "teacher-borrowClass",
        component: TeacherBorrowClass
      },
      {
        path: "/teacher/info",
        name: "teacher-info",
        component: TeacherInfo
      },
      {
        path: "/admin",
        name: "admin-home",
        component: Home
      },
      {
        path: "/admin/department",
        name: "admin-department",
        component: AdminDepartment
      },
      {
        path: "/admin/major",
        name: "admin-major",
        component: AdminMajor
      },
      {
        path: "/admin/class",
        name: "admin-class",
        component: AdminClass
      },
      {
        path: "/admin/student",
        name: "admin-student",
        component: AdminStudent
      },
      {
        path: "/admin/teacher",
        name: "admin-teacher",
        component: AdminTeacher
      },
      {
        path: "/admin/course",
        name: "admin-course",
        component: AdminCourse
      },
      {
        path: "/admin/student/course",
        name: "admin-student-course",
        component: AdminStudentCourse
      },
      {
        path: "/admin/admin",
        name: "admin-admin",
        component: AdminAdmin
      },
      {
        path: '/admin/confirm',
        name: 'admin-confirm',
        component: AdminConfirm
      },
      {
        path: '/admin/apply',
        name: 'admin-apply',
        component: AdminApply
      },
      {
        path: '/admin/info',
        name: 'admin-info',
        component: AdminInfo
      },
      {
        path: '/forum',
        name: 'forum',
        component: Forum
      }
    ]
  },
  {
    path: "/login",
    name: "login",
    component: Login
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
