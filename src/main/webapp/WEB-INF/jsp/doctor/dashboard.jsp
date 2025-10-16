<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.DOCTOR) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Médecin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
        }
        .profile-card {
            max-width: 420px;
            margin: 40px auto 20px auto;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.13);
            background: white;
        }
        .btn-large {
            padding: 1rem 2.5rem;
            font-size: 1.15rem;
            border-radius: 0.5rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card text-center mt-5">
        <h2 class="mb-3">Bienvenue, Dr. <%= user.getNom() %> <%= user.getPrenom() %></h2>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <hr>
        <a href="${pageContext.request.contextPath}/doctor/availabilities" class="btn btn-primary btn-large mb-3">
            Gérer mes disponibilités
        </a>
        <br>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary btn-sm">logout</a>
    </div>
</div>
</body>
</html>