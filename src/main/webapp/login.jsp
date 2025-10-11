<%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 10/11/25
  Time: 7:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h2>LOGIN</h2>

<form action="login" method="post">
    <label>Email: <input type="text" name="email" required /></label><br>
    <label>Password: <input type="text" name="password" required /></label><br>
    <button type="submit">Login</button>
</form>

<%-- Show error messages if present --%>
<%
    String error = request.getParameter("error");
    if ("invalid".equals(error)) {
        out.println("<p style='color:red;'>Invalid email or password.</p>");
    }
    if ("unknownrole".equals(error)) {
        out.println("<p style='color:red;'>Unknown user role.</p>");
    }
%>

</body>
</html>
