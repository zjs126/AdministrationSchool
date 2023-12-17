<template>
  <div class="admin-classroom-apply">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-fa fa-edit"></i> 缓考申请审核
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="container">
      <el-row justify="center" type="flex">
        <el-pagination :current-page.sync="pageIndex" :page-size="pageSize" :total="total" @current-change="getPage"
          background layout="prev, pager, next">
        </el-pagination>
      </el-row>

      <div class="query-form">
        <el-row :gutter="20">
          <el-col :offset="10" :span="2">
            <el-input @keyup.enter.native="query" placeholder="课程名" v-model="queryForm.courseName" />
          </el-col>
          <el-col :span="3">
            <el-select v-model="queryForm.trimesters" placeholder="请选择学期">
              <el-option :key="index" :label="'第一学期'" :value="1">
              </el-option>
              <el-option :key="index" :label="'第二学期'" :value="2">
              </el-option>
            </el-select>
          </el-col>
          <el-col :span="3">
            <el-select v-model="queryForm.year" placeholder="请选择学年">
              <el-option :key="index" :label="'2020-2021'" :value="'2020-2021'">
              </el-option>
              <el-option :key="index" :label="'2021-2022'" :value="'2021-2022'">
              </el-option>
              <el-option :key="index" :label="'2022-2023'" :value="'2022-2023'">
              </el-option>
              <el-option :key="index" :label="'2023-2024'" :value="'2023-2024'">
              </el-option>
            </el-select>
          </el-col>
          <el-col :span="3">
            <el-button @click="query" icon="el-icon-search" type="primary">搜索
            </el-button>
          </el-col>
        </el-row>
      </div>

      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="未审核" name="first">
          <div class="table">
            <el-table :data="applications" stripe>
              <el-table-column label="学号" prop="stuId" />
              <el-table-column label="申请人" prop="studentName" />
              <el-table-column label="课程编号" prop="courseId" />
              <el-table-column label="课程名称" prop="courseName" />
              <el-table-column label="学年" prop="year" />
              <el-table-column label="学期" prop="trimesters" />
              <el-table-column label="申请时间" prop="createTime" width="180px" />
              <el-table-column align="center" label="操作" width="250px">
                <template slot-scope="scope">
                  <el-button type="text" @click="open(scope.$index)">查看详情</el-button>
                  <el-button type="text" @click="handleApprove(scope.$index)">审核通过</el-button>
                  <el-button type="text" @click="handleReject(scope.$index)">审核不通过</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>
        <el-tab-pane label="审核通过" name="second">
          <div class="table">
            <el-table :data="applications" stripe>
              <el-table-column label="学号" prop="stuId" />
              <el-table-column label="申请人" prop="studentName" />
              <el-table-column label="课程编号" prop="courseId" />
              <el-table-column label="课程名称" prop="courseName" />
              <el-table-column label="学年" prop="year" />
              <el-table-column label="学期" prop="trimesters" />
              <el-table-column label="申请时间" prop="createTime" width="180px" />
              <el-table-column align="center" label="操作" width="200px">
                <template slot-scope="scope">
                  <el-button type="text" @click="open(scope.$index)">查看详情</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>
        <el-tab-pane label="审核未通过" name="third">
          <div class="table">
            <el-table :data="applications" stripe>
              <el-table-column label="学号" prop="stuId" />
              <el-table-column label="申请人" prop="studentName" />
              <el-table-column label="课程编号" prop="courseId" />
              <el-table-column label="课程名称" prop="courseName" />
              <el-table-column label="学年" prop="year" />
              <el-table-column label="学期" prop="trimesters" />
              <el-table-column label="申请时间" prop="createTime" width="180px" />
              <el-table-column align="center" label="操作" width="200px">
                <template slot-scope="scope">
                  <el-button type="text" @click="open(scope.$index)">查看详情</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>
  
<script>
import * as api from '../../api/admin/apply'

export default {
  name: "AdminApply",
  data() {
    return {
      applications: [],
      queryForm: {
        courseName: null,
        year: null,
        trimesters: null,
        situation: 2
      },
      pageIndex: 1,
      pageSize: api.pageSize,
      total: 0,
      activeName: "first"
    };
  },
  methods: {
    open(index) {
      this.$alert(this.applications[index].reason, '申请理由', {
        confirmButtonText: '确定',
      })
    },
    handleApprove(index) {
      api.audit({
        stuId: this.applications[index].stuId,
        courseId: this.applications[index].courseId,
        year: this.applications[index].year,
        situation: 1,
        trimesters: this.applications[index].trimesters,
      }).then(() => {
        this.getPage();
        this.$message({
          type: 'success',
          message: '审核通过成功!',
        });
      });
    },
    handleReject(index) {
      api.audit({
        stuId: this.applications[index].stuId,
        courseId: this.applications[index].courseId,
        year: this.applications[index].year,
        situation: 0,
        trimesters: this.applications[index].trimesters,
      }).then(() => {
        this.getPage();
        this.$message({
          type: 'success',
          message: '审核不通过成功!',
        });
      });
    },
    getPage() {
      api.getPage({
        page: this.pageIndex,
        pageSize: api.pageSize,
        situation: this.queryForm.situation
      }).then(
        res => {
          console.log(res);
          this.applications = res.rows;
          this.total = res.total
        }
      )
    },
    handleClick(tab, event) {
      console.log(tab, event);
      tab.name === 'second' ? this.queryForm.situation = 1 : (tab.name === 'third' ? this.queryForm.situation = 0 : this.queryForm.situation = 2)
      this.getPage();
    },
    query() {
      api.getPage({
        page: this.pageIndex,
        pageSize: api.pageSize,
        courseName: this.queryForm.courseName,
        year: this.queryForm.year,
        trimesters: this.queryForm.trimesters,
        situation: this.queryForm.situation
      }).then(
        res => {
          this.applications = res.rows;
          this.total = res.total;
        }
      )
    }
  },
  created() {
    this.getPage();
  },
};
</script>
  
<style scoped></style>
  