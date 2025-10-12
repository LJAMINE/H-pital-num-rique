<%@ page import="com.clinique.model.Personne" %>
<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.ADMIN) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
        }
        .dashboard-container {
            max-width: 420px;
            background: #fff;
            margin: 60px auto;
            padding: 32px 28px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2 {
            margin-top: 0;
            color: #2d3436;
            text-align: center;
        }
        p {
            text-align: center;
            color: #636e72;
        }
        ul {
            list-style: none;
            padding: 0;
            margin-top: 32px;
        }
        ul li {
            margin-bottom: 18px;
        }
        ul li a {
            display: block;
            background: #0984e3;
            color: #fff;
            text-decoration: none;
            font-size: 17px;
            padding: 10px 0;
            border-radius: 6px;
            text-align: center;
            transition: background 0.2s;
        }
        ul li a:hover {
            background: #74b9ff;
        }
        .logout-link {
            display: block;
            margin: 40px auto 0 auto;
            text-align: center;
            color: #d63031;
            text-decoration: none;
            font-weight: bold;
            font-size: 15px;
            padding: 8px 0;
            border-radius: 5px;
            width: 60%;
            background: #ffeaa7;
            transition: background 0.2s;
        }
        .logout-link:hover {
            background: #fab1a0;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h2>Welcome, <%= user.getNom() %> <%= user.getPrenom() %>!</h2>
    <p>Your email: <%= user.getEmail() %></p>

    <ul>
        <li><a href="departement">Manage Departments</a></li>
        <li><a href="doctor">Manage Doctors</a></li>
        <!-- Add more links as needed -->
    </ul>

    <a class="logout-link" href="logout">Logout</a>
</div>
</body>
</html>