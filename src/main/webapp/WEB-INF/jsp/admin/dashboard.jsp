<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.ADMIN) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
%>
<html>
<head><title>admin Dashboard</title></head>
<body>
<h2>Welcome, <%= user.getNom() %> <%= user.getPrenom() %>!</h2>
<p>Your email: <%= user.getEmail() %></p>
<!-- Add patient-specific content here -->
<a href="../../logout">Logout</a>
</body>
</html>