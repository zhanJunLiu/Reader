//
//  Api.swift
//  TestNetworking
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

/// 网络测试URL
let TEST_URL = "http://www.weather.com.cn/data/sk/101010100.html"

/// 基 URL
//let BASE_URL = "http://192.168.31.47"
//let BASE_URL = "http://192.168.31.183"
let BASE_URL = "http://123.56.179.162:8080"
//http://192.168.31.47/index.php/committeeReadBook/Recommend
//http://192.168.31.47/index.php/committeeReadBook/HeaderView

//新书推荐头部视图
let HEADERSETTING_URL = "/index.php/newBookRecommed/headerSetting"

//阅读排行
let READRECOMMED_URL = "/index.php/newBookRecommed/readRecord"

//新书推荐详情页面
let NEWBOOKSDETAILS_URL = "/index.php/newBookRecommed/description/id/13"
//let NEWBOOKSDETAILS_URL = "/index.php/politicalBookcase/bookcase/id/2"

//活动页面
let ACTIVITY_URL = "/index.php/newBookRecommed/activity"

//政协书库
let POLITICALBOOKCASE_URL = "/index.php/politicalBookcase/bookcase/id/"

/// 支付宝支付成功返给后台的接口
let ALIPAYISPAYOK = "/alipay.php/Zfbcreateorderww/result_sign"

/// 发送手机验证码
let SEND_CODE = ""

/// 注册
let REGISTER = "/index.php/login/register"

/// 登录
let LOGIN = "/index.php/login/login"

/// 第三方登录
let THIRD_LOGIN = "/index.php/login/third"

/// 加入书架
let ADD_BOOKSTORE = "/index.php/newBookRecommed/add_bookcase"

/// 我的书架
let MYBOOKCASE = "/index.php/newBookRecommed/show_book"

/// 委员读书头部URL
let READING_H_URL = "/index.php/committeeReadBook/HeaderView"

/// 委员读书所有数据的URL
let READING_ALL_URL = "/index.php/committeeReadBook/Recommend"

/// 委员读书详情URL
let REDING_DELIT_URL = "/index.php/committeReadBook/information"

/// 委员读书
let READING = "/index.php/"

/// 搜索
let SEARCH = "/index.php/newBookRecommed/search"

/// 委员读书搜索
let READING_SEARCH = "/index.php/committeeReadBook/search"

/// 搜索详情
let SEARCH_DETIAL = "/index.php/newBookRecommed/searchDescription"

/// 订单详情
let URL_CREATEORDRE = "/alipay.php/Zfbcreateorderww/createOrder"

/// 修改用户密码
let MODIFY_USER_PASSWORD = ""

/// 获取文件信息
let GET_DOCUMENT_INFOS_DETATL = ""

/// 获取收藏列表
let GET_COLLECTION_LIST = "/index.php/myStackroom/myCollect"

/// 添加或删除收藏
let ADD_OR_CANCEL_COLLECTION = "/index.php/myStackroom/AddmyCollect"

/// 添加笔记
let ADD_NOTES = "/index.php/myStackroom/myNotesnotesDescription"

/// 上传用户头像
let UPLOAD_USER_AVATAR = "/index.php/myStackroom/Updatephoto"

/// 获取自己的用户信息
let GET_SELF_USER_INFOMATION = "/index.php/myStackroom/myStackroom"

/// 更新用户信息
let UPDATE_USER_INFOMATION = "/index.php/myStackroom/UpmyStackroom"

/// 获取他人的用户信息
let GET_OTHER_USER_INFOMATION = ""

/// 提交反馈信息
let POST_FEEDBACK = ""
