import Config from "./config";
import axios from "axios";
import ElementUI from "element-ui";

export const vueInstance = {
  instance: null,
  store: null
};

let runningRequest = 0;

function addRequestCount() {
  runningRequest++;
  if (runningRequest > 0 && vueInstance.store != null) {
    vueInstance.store.state.loading = true;
  }
}

function subtractRequestCount() {
  runningRequest--;
  if (runningRequest <= 0 && vueInstance.store != null) {
    vueInstance.store.state.loading = false;
  }
}

function innerMessage(type, message) {
  ElementUI.Message({
    showClose: true,
    duration: 2000,
    message: message,
    type: type
  });
}

const axiosInstance = axios.create({
  baseURL: Config.backEndUrl,
  timeout: 36000,
  // withCredentials: true
});

// 请求拦截器
axiosInstance.interceptors.request.use(
  (config) => {
    // 在请求发送之前添加 token 到 header
    const token = localStorage.getItem("token"); // 从 localStorage 中获取 token
    if (token) {
      config.headers = {
        ...config.headers,
        token: token
      }
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

axiosInstance.interceptors.response.use(
  response => {
    let data = false;
    console.log(response.data);
    response.data.code === 401 ? innerMessage("warning", response.data.msg) : data = response.data.data
    subtractRequestCount();
    return data;
  },
  error => {
    let code = error.response.data.code;
    let message = error.response.data.message;
    let data = error.response.data.data;
    subtractRequestCount();

    if (code === 401) {
      innerMessage("info", "需要登录");
      setTimeout(() => (window.location.href = "/login"), 250);
      return Promise.reject(new Error("NO_LOGIN"));
    } else if (code === 1) {
      innerMessage("error", "错误: " + message);
      return Promise.reject(new Error("FAIL"));
    } else if (code === 2) {
      innerMessage("info", "您不是此角色");
      setTimeout(() => (window.location.href = "/login"), 250);
      return Promise.reject(new Error("ERROR_ROLE"));
    } else if (code === 3) {
      innerMessage("info", "您没有此权限");
      setTimeout(() => (window.location.href = "/login"), 250);
      return Promise.reject(new Error("NO_PERMISSION"));
    } else if (code === 4) {
      let errorMessage = "请求参数错误";
      if (data.length > 0) {
        errorMessage = "参数错误: " + data[0].message;
      }
      innerMessage("error", errorMessage);
      return Promise.reject(new Error("INVALID_PARAMETER"));
    } else if (code === 10) {
      innerMessage("error", "内部服务器错误");
      return Promise.reject(new Error("INTERNAL_SERVER_ERROR"));
    }

    if (typeof error.response === "undefined") {
      innerMessage("error", "与后端服务器通信失败");
      vueInstance.instance.$router.push({ name: "login" });
    } else if (error.response.status >= 400) {
      innerMessage("error", "HTTP错误: " + error.response.status);
    }
    return Promise.reject(error);
  }
);

const dataHandle = response => {
  return response;
};

const innerGet = function () {
  addRequestCount();
  return axiosInstance.get.apply(this, arguments).then(dataHandle);
};

const innerPost = function () {
  addRequestCount();
  return axiosInstance.post.apply(this, arguments).then(dataHandle);
};

const innerDelete = function () {
  addRequestCount();
  return axiosInstance.delete.apply(this, arguments).then(dataHandle);
};

const innerPut = function () {
  addRequestCount();
  return axiosInstance.put.apply(this, arguments).then(dataHandle);
};

const innerPatch = function () {
  addRequestCount();
  return axiosInstance.patch.apply(this, arguments).then(dataHandle);
};

export const pureGet = function (url) {
  return innerGet(url);
};

export const pureDelete = function (url) {
  return innerDelete(url);
};

export const get = function (url, params) {
  return innerGet(url, {
    params: params
  });
};

export const post = function (url, data) {
  return innerPost(url, data, {
    headers: {
      "Content-Type": "application/json"
    }
  });
};

export const postExcel = function (url, data) {
  return innerPost(url, data, {
    headers: {
      "Content-Type": "multipart/form-data", // 设置Content-Type
    }
  });
};

export const del = function (url, data) {
  return innerDelete(url, data, {
    headers: {
      "Content-Type": "application/json"
    }
  })
};

export const put = function (url, data) {
  return innerPut(url, data, {
    headers: {
      "Content-Type": "application/json"
    }
  });
};

export const patch = function (url, data) {
  return innerPatch(url, data, {
    headers: {
      "Content-Type": "application/json"
    }
  });
};
