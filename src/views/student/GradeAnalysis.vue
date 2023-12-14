<template>
  <div class="grade-analysis-wrap">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-fa fa-book"></i> 成绩分析
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="container">
      <div class="query-form">
        <el-row :gutter="20">
          <el-col :offset="15" :span="3">
            <el-input @keyup.enter.native="query" placeholder="教职工号" v-model="queryForm.teacherId" />
          </el-col>
          <el-col :span="3">
            <el-input @keyup.enter.native="query" placeholder="课程ID" v-model="queryForm.courseId" />
          </el-col>
          <el-col :span="3">
            <el-button @click="query" icon="el-icon-search" type="primary">搜索</el-button>
          </el-col>
        </el-row>
      </div>

      <div class="chart">
        <el-row>
          <el-col :span="24">
            <el-chart :data="chartData" :settings="chartSettings"></el-chart>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "GradeAnalysis",
  data() {
    return {
      queryForm: {
        teacherId: '',
        courseId: ''
      },
      chartData: {
        labels: ['2019年', '2020年', '2021年', '2022年', '2023年'],
        datasets: [
          {
            name: '平均分',
            data: []
          },
          {
            name: '及格率',
            data: []
          }
        ]
      },
      chartSettings: {
        xAxis: {
          name: '年份',
          type: 'category'
        },
        yAxis: {
          name: '值',
          type: 'value',
          min: 0,
          max: 100
        },
        legend: {
          show: true
        },
        series: [
          {
            type: 'bar',
            name: '平均分',
            data: [],
            stack: 'grade'
          },
          {
            type: 'bar',
            name: '及格率',
            data: [],
            stack: 'grade'
          }
        ]
      }
    };
  },
  methods: {
    query() {
      // 向后端发送请求获取数据
      // axios库发送请求，根据实际情况修改URL和请求方式
      axios.get('/api/grade-analysis', {
        params: {
          teacherId: this.queryForm.teacherId,
          courseId: this.queryForm.courseId
        }
      })
        .then(response => {
          // 获取数据成功后更新柱状图数据
          const analysisData = response.data;
          this.chartData.datasets[0].data = analysisData.averageScores;
          this.chartData.datasets[1].data = analysisData.passRates;
        })
        .catch(error => {
          console.error(error);
        });
    }
  }
};
</script>

<style scoped>
.grade-analysis-wrap {
  margin: 20px;
}

.query-form {
  margin-bottom: 20px;
}

.chart {
  height: 300px;
}
</style>