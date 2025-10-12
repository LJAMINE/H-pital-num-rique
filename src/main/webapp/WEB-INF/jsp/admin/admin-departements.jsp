<%@ page import="java.util.List" %>
<%@ page import="com.clinique.model.Personne" %>
<%@ page import="com.clinique.model.Departement" %>
<%
    Personne user = (Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.ADMIN) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
    List<Departement> departements = (List<Departement>) request.getAttribute("departements");
%>
<html>
<head>
    <title>Department Management</title>
</head>
<body>
<h2>Department Management</h2>

<!-- Add Department Form -->
<form method="post" action="departement">
    <input type="text" name="nom" placeholder="Department Name" required />
    <button type="submit">Add Department</button>
</form>

<ul>
    <% for (Departement dep : departements) { %>
    <li>
        <form method="post" action="departement" style="display:inline;">
            <input type="hidden" name="idDepartement" value="<%= dep.getIdDepartement() %>" />
            <input type="text" name="nom" value="<%= dep.getNom() %>" />
            <input type="hidden" name="action" value="update" />
            <button type="submit">Update</button>
        </form>
        <a href="departement?action=delete&idDepartement=<%= dep.getIdDepartement() %>">Delete</a>
    </li>
    <% } %>
</ul>

<br>
<a href="admin-dashboard">Back to Admin Dashboard</a>
</body>
</html>