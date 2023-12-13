<template>
  <div class="course-wrap">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-fa fa-edit"></i> 教室申请
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="container">
      <div class="table">
        <el-table :data="tableData" stripe>
          <el-table-column label="教室Id" prop="Classroom" />
          <el-table-column label="类型" prop="type" />
          <el-table-column label="情况" prop="situation" />
          <el-table-column align="center" label="操作" width="200px">
            <template slot-scope="scope">
              <div>
                <el-button @click="showDialog(scope.row.Classroom)" size="mini" type="danger">申请</el-button>
                <el-dialog :visible.sync="dialogVisible" title="教室申请表" width="30%">
                  <el-form label-width="80px">
                    <el-form-item label="教室ID号">
                      <el-input v-model="form.Classroom"></el-input>
                    </el-form-item>
                    <el-form-item label="教师ID号">
                      <el-input v-model="form.teacherId"></el-input>
                    </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="submitForm">提交</el-button>
                  </div>
                </el-dialog>
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
  name: "TeacherBorrowClass",
  data() {
    return {
      tableData: [],
      dialogVisible: false,
      form: {
        Classroom: undefined,
        teacherId: undefined
      }
    };
  },
  methods: {
    showDialog(Classroom) {
      // 显示弹窗时，设置教室ID号的默认值为当前行的教室ID号
      this.form.Classroom = Classroom;
      this.dialogVisible = true;
    },
    submitForm() {
      const { Classroom, teacherId } = this.form;

      // 在这里进行提交操作（你可以根据实际需求调用后端API或执行其他逻辑）
      // 例如，使用 axios 发送 POST 请求
      axios
        .post("/api/submit", {
          Classroom,
          teacherId
        })
        // eslint-disable-next-line no-unused-vars
        .then(response => {
          // 提交成功的处理逻辑
          console.log("提交成功");
        })
        .catch(error => {
          // 提交失败的处理逻辑
          console.error("提交失败", error);
        });

      this.dialogVisible = false;
    },
    getList() {
      // 获取表格数据（根据实际需求调用后端API或执行其他逻辑）
      // 使用 axios 发送 GET 请求
      axios
        .get("/api/list")
        .then(response => {
          // 获取数据成功时，更新表格数据
          this.tableData = response.data;
        })
        .catch(error => {
          // 获取数据失败的处理逻辑
          console.error("获取表格数据失败", error);
        });
    }
  },
  created() {
    // 在组件创建时，获取表格数据
    this.getList();
  }
};
</script>

<style scoped></style>
