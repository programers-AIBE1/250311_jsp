<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: marsh825
  Date: 25. 3. 11.
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="UTF-8">
<head>
  <title>S&C</title>
</head>
<body>
<p>Session/Cookie</p>
<p>세션이 전하는 행운의 숫자 : <%= session.getAttribute("num")%></p>
<p>쿠키가 전하는 행운의 숫자 : <%= Arrays.stream(request.getCookies()).filter(cookie -> cookie.getName().equals("cookie_number")).findFirst().orElse(new Cookie("cookie_number", "-1")).getValue() %></p>
<form method="post">
  <label>
    아이디
    <input name="id">
  </label>
  <label>
    비밀번호
    <input name="pw" type="password">
  </label>
  <button>로그인</button>
</form>
</body>
</html>