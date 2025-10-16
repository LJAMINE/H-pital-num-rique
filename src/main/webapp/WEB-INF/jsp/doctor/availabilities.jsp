<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Gestion des Disponibilités</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .card { margin-top: 2rem; }
        .form-inline .form-control { width: auto; display: inline-block; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mt-4 mb-3">Mes Disponibilités</h2>
    <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-secondary mb-3">&larr; Retour au Dashboard</a>
    <div class="card">
        <div class="card-body">
            <h4 class="card-title mb-3">Ajouter une disponibilité</h4>
            <form method="post" action="${pageContext.request.contextPath}/doctor/availabilities/add" class="row g-3">
                <div class="col-md-3">
                    <label for="dayOfWeek" class="form-label">Jour</label>
                    <select name="dayOfWeek" id="dayOfWeek" class="form-select" required>
                        <option value="">Sélectionner...</option>
                        <option value="MONDAY">Lundi</option>
                        <option value="TUESDAY">Mardi</option>
                        <option value="WEDNESDAY">Mercredi</option>
                        <option value="THURSDAY">Jeudi</option>
                        <option value="FRIDAY">Vendredi</option>
                        <option value="SATURDAY">Samedi</option>
                        <option value="SUNDAY">Dimanche</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="startTime" class="form-label">Début</label>
                    <input type="time" name="startTime" id="startTime" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label for="endTime" class="form-label">Fin</label>
                    <input type="time" name="endTime" id="endTime" class="form-control" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-success w-100">Ajouter</button>
                </div>
            </form>
        </div>
    </div>
    <div class="card mt-4">
        <div class="card-body">
            <h4 class="card-title mb-3">Liste des Disponibilités</h4>
            <c:if test="${not empty availabilities}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Jour</th>
                        <th>Début</th>
                        <th>Fin</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="a" items="${availabilities}">
                        <tr>
                            <td>${a.dayOfWeek}</td>
                            <td>${a.startTime}</td>
                            <td>${a.endTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/doctor/availabilities/edit?id=${a.id}" class="btn btn-warning btn-sm">Modifier</a>
                                <a href="${pageContext.request.contextPath}/doctor/availabilities/delete?id=${a.id}" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Supprimer cette disponibilité ?');">Supprimer</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty availabilities}">
                <div class="alert alert-info">Aucune disponibilité trouvée.</div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>