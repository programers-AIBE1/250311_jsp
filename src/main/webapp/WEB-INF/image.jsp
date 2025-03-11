
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String imageName = ((String) request.getAttribute("image")).split("/")[1];
    String imagePath = "https://raw.githubusercontent.com/programers-AIBE1/data-storage/refs/heads/main/image/" + imageName + ".jpg";
%>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <title><%= imageName %></title>
    <meta property="og:title" content="<%= imageName %>">
    <meta property="og:description" content="<%= imageName %>입니다.">
    <meta property="og:type" content="website">
    <meta property="og:image" content="<%= imagePath %>">
</head>
<body>
<img src="<%= imagePath %>">
</body>
</html>
