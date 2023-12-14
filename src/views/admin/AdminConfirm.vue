<template>
    <div class="admin-classroom-apply">
      <div class="crumbs">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item>
            <i class="el-icon-fa fa-edit"></i> 教室申请审核
          </el-breadcrumb-item>
        </el-breadcrumb>
      </div>
  
      <div class="container">
        <div class="table">
          <el-table :data="applications" stripe>
            <el-table-column label="申请人" prop="applicantName" />
            <el-table-column label="教室Id" prop="classroom" />
            <el-table-column label="课程ID" prop="courseId" />
            <el-table-column align="center" label="操作" width="200px">
              <template slot-scope="scope">
                <div>
                  <el-button @click="approveApplication(scope.row)" size="mini" type="success">批准</el-button>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    name: "AdminClassroomApply",
    data() {
      return {
        applications: [],
      };
    },
    methods: {
      getApplications() {
        axios
          .get("http://localhost:8085/admin/classroomApply",{
            headers: {
            // 使用双引号
            token: localStorage.getItem("token")
          }
          })
          .then(response => {
            this.applications = response.data.data.map(application => ({
              applicantName: application.applicantName, 
              classroom: application.classroom,
              courseId: application.courseId,
              id: application.id,
            }));
          })
          .catch(error => {
            console.error("获取申请失败", error);
          });
      },
      approveApplication(application) {
        axios
          .post("http://localhost:8085/admin/classroomApplyconfirm", {
            applicationId: application.id,
          })
          .then(response => {
            console.log("批准成功",response.status);
            // Optionally, you can remove the approved application from the list
            this.applications = this.applications.filter(app => app.id !== application.id);
          })
          .catch(error => {
            console.error("批准失败", error);
          });
      },
    },
    created() {
      this.getApplications();
    },
  };
  </script>
  
  <style scoped></style>
  