<%@ page import="java.util.List" %>
<%@ page import="com.clinique.model.Departement" %>
<%
    List<Departement> departements = (List<Departement>) request.getAttribute("departements");
%>
<html>
<head>
    <title>Create Doctor</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f6fa; }
        .container { max-width: 480px; margin: 60px auto; background: #fff; padding: 32px 28px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);}
        h2 { text-align: center; }
        label, select, input { display: block; width: 100%; margin-bottom: 12px; }
        button { background: #0984e3; color: #fff; border: none; padding: 10px 0; border-radius: 5px; width: 100%; font-size: 16px; cursor: pointer; }
        button:hover { background: #74b9ff; }
        .back-link {
            display: block;
            margin: 30px auto 0 auto;
            text-align: center;
            color: #636e72;
            text-decoration: none;
            font-weight: bold;
            font-size: 15px;
            padding: 8px 0;
            border-radius: 5px;
            width: 60%;
            background: #dfe6e9;
            transition: background 0.2s;
        }
        .back-link:hover {
            background: #b2bec3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Add Doctor</h2>
    <form method="post" action="doctor">
        <label>Email: <input type="email" name="email" required></label>
        <label>Password: <input type="text" name="password" required></label>
        <label>First Name: <input type="text" name="prenom" required></label>
        <label>Last Name: <input type="text" name="nom" required></label>
        <label>Speciality: <input type="text" name="specialite"></label>
        <label>Department:
            <select name="departementId" required>
                <option value="">Select Department</option>
                <% for (Departement dep : departements) { %>
                <option value="<%= dep.getIdDepartement() %>"><%= dep.getNom() %></option>
                <% } %>
            </select>
        </label>
        <button type="submit">Create Doctor</button>
    </form>
    <a class="back-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>

<%--    <a class="back-link" href="dashboard">Back to Admin Dashboard</a>--%>
</div>
</body>
</html>