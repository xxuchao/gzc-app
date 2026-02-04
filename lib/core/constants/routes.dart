class AppRoutes {
  // 登录
  static const bootstrap = "/"; // 启动页
  static const webview = "/webview";
  static const loginWithPassword = "/loginWithPassword"; // 登录页
  static const loginWithSms = "/loginWithSms"; // 登录页
  static const loginWithOneTap = "/loginWithOneTap"; // 登录页
  static const forgetPassword = "/forgetPassword"; // 登录页

  // 首页
  static const home = "/home"; // 首页
  static const dashboard = "/dashboard"; // 首页
  static const takingPictures = "/takingPictures"; // 拍照取证
  static const recordVideo = "/recordVideo"; // 录像取证
  static const screenRecording = "/screenRecording"; // 屏幕录制
  static const smsForensics = "/smsForensics"; // 短信取证
  static const liveRecording = "/liveRecording"; // 现场录音
  static const electronicContract = "/electronicContract"; // 电子合同
  static const webForensics = "/webForensics"; // 网页取证
  static const phoneRecording = "/phoneRecording"; // 电话录音

  // 案件
  static const caseDetail = "/casedetail"; // 案件详情

  // 证据
  static const evidenceDetail = "/evidenceDetail"; // 证据详情
  static const evidenceBatch = "/evidenceBatch"; // 证据批量操作

  // 我的
  static const my = "/my"; // 我的页面入口

  static const profile = "/profile"; // 个人中心
  static const applicantManagement = "/applicantManagement"; // 申请人管理
  static const applicantDetail = "/applicantDetail"; // 申请人详情
  static const addressManagement = "/addressManagement"; // 地址管理
  static const addAddress = "/addAddress"; // 新增地址
  static const feeStandard = "/feeStandard"; // 收费标准
  static const invoiceManagement = "/invoiceManagement"; // 发票管理
  static const referralCode = "/referralCode"; // 推荐码
  static const settings = "/settings"; // 设置

  static const about = "/about"; // 关于
}

// Navigator.pushNamed(context, AppRoutes.home)