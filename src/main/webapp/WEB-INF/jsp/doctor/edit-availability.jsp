<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.DOCTOR) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
    com.clinique.model.Availability availability = (com.clinique.model.Availability) request.getAttribute("availability");
    if (availability == null) {
%>
<div class="alert alert-danger">Disponibilité introuvable.</div>
<%
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier la Disponibilité</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card mx-auto" style="max-width: 500px;">
        <div class="card-body">
            <h4 class="card-title mb-4">Modifier la Disponibilité</h4>
            <form method="post" action="${pageContext.request.contextPath}/doctor/availabilities/update">
                <input type="hidden" name="id" value="${availability.id}" />
                <div class="mb-3">
                    <label for="dayOfWeek" class="form-label">Jour</label>
                    <select name="dayOfWeek" id="dayOfWeek" class="form-select" required>
                        <option value="MONDAY" ${availability.dayOfWeek == 'MONDAY' ? 'selected' : ''}>MONDAY</option>
                        <option value="TUESDAY" ${availability.dayOfWeek == 'TUESDAY' ? 'selected' : ''}>TUESDAY</option>
                        <option value="WEDNESDAY" ${availability.dayOfWeek == 'WEDNESDAY' ? 'selected' : ''}>WEDNESDAY</option>
                        <option value="THURSDAY" ${availability.dayOfWeek == 'THURSDAY' ? 'selected' : ''}>THURSDAY</option>
                        <option value="FRIDAY" ${availability.dayOfWeek == 'FRIDAY' ? 'selected' : ''}>FRIDAY</option>
                        <option value="SATURDAY" ${availability.dayOfWeek == 'SATURDAY' ? 'selected' : ''}>SATURDAY</option>
                        <option value="SUNDAY" ${availability.dayOfWeek == 'SUNDAY' ? 'selected' : ''}>SUNDAY</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="startTime" class="form-label">Début</label>
                    <input type="time" name="startTime" id="startTime" class="form-control"
                           value="${availability.startTime}" required>
                </div>
                <div class="mb-3">
                    <label for="endTime" class="form-label">Fin</label>
                    <input type="time" name="endTime" id="endTime" class="form-control"
                           value="${availability.endTime}" required>
                </div>
                <button type="submit" class="btn btn-success w-100">Enregistrer les modifications</button>
            </form>
            <a href="${pageContext.request.contextPath}/doctor/availabilities" class="btn btn-secondary w-100 mt-2">Annuler</a>
        </div>
    </div>
</div>
</body>
</html>