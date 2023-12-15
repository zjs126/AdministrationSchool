<template>
  <div class="apply-container">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-s-promotion"></i> 缓考申请
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="course-list">
      <el-card v-for="course in courses" :key="course.courseId" class="course-card">
        <div class="course-info">
          <div class="info-item">
            <strong>课程号:</strong> {{ course.courseId }}
          </div>
          <div class="info-item">
            <strong>课程名称:</strong> {{ course.courseName }}
          </div>
          <div class="info-item">
            <strong>学年:</strong> {{ course.year }}
          </div>
          <div class="info-item">
            <strong>学期:</strong> {{ course.trimesters }}
          </div>
          <div class="info-item">
            <strong>学校:</strong> {{ course.university }}
          </div>
        </div>
        <el-button type="primary" @click="applyDeferredExam(course)" size="mini">
          申请缓考
        </el-button>
      </el-card>
    </div>

    <el-dialog title="填写缓考申请" :visible.sync="applyDialogVisible">
      <el-form :model="applyForm" :rules="applyRules" ref="applyForm" label-width="80px">
        <el-form-item label="申请原因" prop="reason">
          <el-input type="textarea" v-model="applyForm.reason" :rows="4" placeholder="请输入申请原因"></el-input>
        </el-form-item>
        <input type="hidden" v-for="(value, key) in applyForm.course" :key="key" :name="key" :value="value">
        <el-form-item>
          <el-button type="primary" @click="submitApplyForm">提交申请</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-message-solid"></i> 申请状态
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="container">
      <el-table :data="myApplies" stripe>
        <el-table-column label="课程名称" prop="courseName" />
        <el-table-column label="课程号" prop="courseId" />
        <el-table-column label="学校" prop="university" />
        <el-table-column label="学年" prop="year" />
        <el-table-column label="学期" prop="trimesters" />
        <el-table-column label="申请时间" prop="createTime" />
        <el-table-column label="审核状态" prop="situation">
          <template slot-scope="scope">
            {{ scope.row.submit === 2 ? '未审核' : (scope.row.situation === 1 ? '审核通过' : '审核不通过') }}
          </template>
        </el-table-column>
      </el-table>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      courses: [],
      myApplies: [],
      applyDialogVisible: false,
      applyForm: {
        course: {},
        reason: ''
      },
      applyRules: {
        reason: [
          { required: true, message: '请输入申请原因', trigger: 'blur' },
          { min: 5, max: 200, message: '长度在 5 到 200 个字符', trigger: 'blur' }
        ]
      }
    };
  },
  mounted() {
    this.fetchStudentSchedule();
    this.fetchMyApplyStatus();
  },
  methods: {
    fetchStudentSchedule() {
      axios.get('http://localhost:8085/selection/mySelection', {
        headers: {
          token: localStorage.getItem("token")
        },
      })
        .then(response => {
          console.log(response.data)
          this.courses = response.data.data;
        })
        .catch(error => {
          console.error(error);
        });
    },

    fetchMyApplyStatus() {
      axios.get('http://localhost:8085/apply/getMyApply', {
        headers: {
          token: localStorage.getItem("token")
        },
      })
        .then(response => {
          console.log(response.data)
          this.myApplies = response.data.data;
        })
        .catch(error => {
          console.error(error);
        });
    },

    applyDeferredExam(course) {
      this.applyForm.course = course;
      this.applyDialogVisible = true;
    },

    submitApplyForm() {
      this.$refs.applyForm.validate((valid) => {
        this.applyForm.course.reason = this.applyForm.reason;
        if (valid) {
          axios.post('http://localhost:8085/apply/addApply', this.applyForm.course, {
            headers: {
              token: localStorage.getItem("token")
            },
          })
            .then(response => {
              console.log(response.data);
              this.applyDialogVisible = false;
              this.$message.success('申请成功');
              this.fetchMyApplyStatus();
            })
            .catch(error => {
              console.error(error);
              this.$message.error('申请失败，请稍后重试');
            });
        }
      });
    }

  }
};
</script>

<style scoped>
.apply-container {
  margin: 20px;
}

.course-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.course-info {
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
}

.info-item {
  margin-bottom: 5px;
}

.course-card {
  text-align: center;
  width: 400px;
  margin-bottom: 20px;
  border: 1px solid #e0e0e0;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.el-dialog {
  width: 30%;
}

.el-button {
  margin-top: 5px;
}

.apply-status {
  margin-top: 20px;
}

.apply-card {
  width: 400px;
  margin-bottom: 20px;
  border: 1px solid #e0e0e0;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.apply-info {
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
}
</style>
