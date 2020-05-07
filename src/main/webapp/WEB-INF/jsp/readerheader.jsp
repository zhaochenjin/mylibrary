<!--读者 登陆页面头部-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书管理系统</title>
    <link rel="stylesheet" href="<%=basePath%>css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/modules/code.css">
    <link rel="stylesheet" href="<%=basePath%>css/modules/laydate/default/laydate.css">
    <link rel="stylesheet" href="<%=basePath%>css/modules/layer/default/layer.css">
<style type="text/css">
.layui-table-cell{
    height:36px;
    line-height: 36px;
}
</style>
</head>
<body>
	<div class="layui-header">
    <div class="layui-logo">图书管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item"><a href="<%=basePath%>frontIndex.action">图书列表</a></li>
        <li class="layui-nav-item"><a href="<%=basePath%>listDisBack.action">借阅记录</a></li>
        <li class="layui-nav-item"><a href="<%=basePath%>listRecommendation.action">猜你喜欢</a></li>
        <li class="layui-nav-item"><a onclick="alterPwd();">修改密码</a></li>
        <li class="layui-nav-item"><a href="<%=basePath%>loginout.action">退出</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
    <img src="http://pic140.huitu.com/res/20200410/1811645_20200410141941812060_1.jpg" class="layui-nav-img">
${admin2.name }
        </a>

      </li>

    </ul>
  </div>

    <div style="padding: 15px;"></div>
        <script>

            function alterPwd(){//添加
                layer.open({
                    type: 2,
                    title: '修改密码',
                    skin: 'layui-layer-demo', //加上边框
                    area: ['500px', '300px'], //宽高
                    content: '<%=basePath%>toAlterpwdPage.action'
                });
            }

        </script>
</body>
</html>