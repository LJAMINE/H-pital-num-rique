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
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
        }

        .container {
            max-width: 480px;
            background: #fff;
            margin: 60px auto;
            padding: 32px 28px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h2 {
            margin-top: 0;
            color: #2d3436;
            text-align: center;
        }

        form.add-form {
            margin-bottom: 28px;
            text-align: center;
        }

        form.add-form input[type="text"] {
            width: 70%;
            padding: 8px 10px;
            margin-right: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form.add-form button {
            padding: 8px 18px;
            background: #00b894;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.2s;
        }

        form.add-form button:hover {
            background: #55efc4;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            background: #f1f2f6;
            margin-bottom: 15px;
            padding: 10px 12px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dept-edit-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .dept-edit-form input[type="text"] {
            padding: 6px 10px;
            border: 1px solid #b2bec3;
            border-radius: 4px;
            width: 130px;
        }

        .dept-edit-form button {
            padding: 6px 14px;
            background: #0984e3;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .dept-edit-form button:hover {
            background: #74b9ff;
        }

        .delete-link {
            margin-left: 14px;
            color: #d63031;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            background: #ffeaa7;
            padding: 7px 12px;
            border-radius: 5px;
            transition: background 0.2s;
        }

        .delete-link:hover {
            background: #fab1a0;
        }

        .back-link {
            display: block;
            margin: 40px auto 0 auto;
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
    <h2>Department Management</h2>

    <!-- Add Department Form -->
    <form class="add-form" method="post" action="departement">
        <input type="text" name="nom" placeholder="Department Name" required/>
        <button type="submit">Add Department</button>
    </form>

    <ul>
        <% for (Departement dep : departements) { %>
        <li>
            <form class="dept-edit-form" method="post" action="departement" style="display:inline;">
                <input type="hidden" name="idDepartement" value="<%= dep.getIdDepartement() %>"/>
                <input type="text" name="nom" value="<%= dep.getNom() %>"/>
                <input type="hidden" name="action" value="update"/>
                <button type="submit">Update</button>
            </form>
            <form method="post" action="departement" style="display:inline;">
                <input type="hidden" name="idDepartement" value="<%= dep.getIdDepartement() %>"/>
                <input type="hidden" name="action" value="delete"/>
                <button type="submit" style="background:#d63031;color:#fff;">Delete</button>
            </form>
        </li>
        <% } %>
    </ul>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>

<%--    <a class="back-link" href="dashboard">Back to Admin Dashboard</a>--%>
</div>
</body>
</html>