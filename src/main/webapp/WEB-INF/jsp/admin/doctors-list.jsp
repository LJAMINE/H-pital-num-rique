<%@ page import="java.util.List" %>
<%@ page import="com.clinique.model.Doctor" %>
<%@ page import="com.clinique.model.Departement" %>
<%
    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
%>
<html>
<head>
    <title>Doctors List</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f6fa; }
        .container { max-width: 700px; margin: 40px auto; background: #fff; padding: 32px 28px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);}
        h2 { text-align: center; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { padding: 12px; border-bottom: 1px solid #dfe6e9; text-align: left; }
        th { background: #0984e3; color: #fff; }
        tr:hover { background: #f1f2f6; }
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
        .back-link:hover { background: #b2bec3; }
    </style>
</head>
<body>
<div class="container">
    <h2>Doctors List</h2>
    <table>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Speciality</th>
            <th>Department</th>
        </tr>
        <% if (doctors != null) {
            for (Doctor doc : doctors) { %>
        <tr>
            <td><%= doc.getPrenom() %></td>
            <td><%= doc.getNom() %></td>
            <td><%= doc.getEmail() %></td>
            <td><%= doc.getSpecialite() != null ? doc.getSpecialite() : "" %></td>
            <td>
                <%= (doc.getDepartement() != null && doc.getDepartement().getNom() != null)
                        ? doc.getDepartement().getNom() : "N/A" %>
            </td>
        </tr>
        <% } } %>
    </table>
    <a class="back-link" href="dashboard">Back to Admin Dashboard</a>
</div>
</body>
</html>