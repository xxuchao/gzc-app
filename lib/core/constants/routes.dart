class AppRoutes {
  static const bootstrap = "/"; // 启动页
  static const loginWithPassword = "/loginWithPassword"; // 登录页
  static const loginWithSms = "/loginWithSms"; // 登录页
  static const loginWithOneTap = "/loginWithOneTap"; // 登录页
  static const forgetPassword = "/forgetPassword"; // 登录页
  static const home = "/home"; // 首页
  static const dashboard = "/dashboard"; // 首页

  // 案件
  static const caseDetail = "/casedetail"; // 首页

  static const profile = "/profile"; // 个人中心
  static const applicantManagement = "/applicantManagement"; // 申请人管理
  static const applicantDetail = "/applicantDetail"; // 申请人详情
  static const addressManagement = "/addressManagement"; // 地址管理
  static const addAddress = "/addAddress"; // 新增地址
  static const feeStandard = "/feeStandard"; // 收费标准
  static const invoiceManagement = "/invoiceManagement"; // 发票管理
  static const settings = "/settings"; // 设置

  static const about = "/about"; // 关于
}

// Navigator.pushNamed(context, AppRoutes.home)