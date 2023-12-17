<template>
  <div class="info-wrap">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-fa fa-id-badge"></i> 信息维护
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="container">
      <el-form :model="entityForm" class="info-form" label-width="80px">
        <el-form-item label="工号">
          <el-input disabled v-model="entityForm.staffId"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input disabled v-model="entityForm.name"></el-input>
        </el-form-item>
        <el-form-item label="学号">
          <el-input disabled v-model="entityForm.university"></el-input>
        </el-form-item>
        <el-form-item label="学院">
          <el-input disabled v-model="entityForm.college"></el-input>
        </el-form-item>
        <el-form-item label="职务">
          <el-input disabled v-model="entityForm.permission"></el-input>
        </el-form-item>
        <el-form-item label="操作">
          <el-button @click="open" type="primary">更新密码</el-button>
        </el-form-item>
      </el-form>

      <el-dialog :model="passwordForm" :visible.sync="editing" title="更新密码" width="30%">
        <el-form label-width="70px" ref="form">
          <el-form-item label="旧密码">
            <el-input type="password" v-model="entityForm.oldPwd"></el-input>
          </el-form-item>
          <el-form-item label="新密码">
            <el-input type="password" v-model="entityForm.newPwd"></el-input>
          </el-form-item>
          <el-form-item label="确认密码">
            <el-input type="password" v-model="entityForm.rePwd"></el-input>
          </el-form-item>
        </el-form>
        <span class="dialog-footer" slot="footer">
          <el-button @click="update" type="primary">确 定</el-button>
          <el-button @click="this.editing = false">取 消</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import * as api from "../../api/admin/info";

export default {
  name: "AdminInfo",
  data() {
    return {
      entityForm: {
        stuId: "",
        name: "",
        major: "",
        college: "",
        className: "",
        university: "",
        grand: "",
        password: ""
      },
      editing: false,
      passwordForm: {
        oldPwd: null,
        newPwd: null,
        rePwd: null
      }
    };
  },
  methods: {
    showMessage() {
      this.$message.success("这是一个成功消息");
    },
    get() {
      api.get().then(res => {
        if (res.permission === 5) res.permission = "管理员";
        if (res.permission === 2) res.permission = "教学秘书";
        this.entityForm = res;
      });
    },
    update() {
      api.update(this.entityForm).then(() => {
        this.$message.success("更新信息成功,请重新登录");
        this.$router.push('/Login');
        localStorage.removeItem('token');
      });
    },
    open() {
      this.editing = true;
    }
  },
  created() {
    this.get();
  }
};
</script>

<style scoped>
.info-form {
  min-width: 400px;
  width: 35%;
  margin: auto;
}
</style>
