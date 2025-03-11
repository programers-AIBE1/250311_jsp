<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
    <% System.out.println("hello"); %>   <%-- 서버에서 실행 --%>
    <% response.getWriter().println("Hello"); %>
    <%="HHHELLO"%>
    <%! int i = 0; %>
    <%=i++%>
    <%=i++%>
    <%=i++%>
    <%=i++%>
</body>
</html>