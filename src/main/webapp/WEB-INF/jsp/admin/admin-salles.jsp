<%@ page import="com.clinique.model.Departement" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Departement> departements = (List<Departement>) request.getAttribute("departements");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Salle</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f9fb; }
        .form-container { max-width: 480px; margin: 2rem auto; background: #fff; box-shadow: 0 3px 18px #00000015; border-radius: 8px; padding: 2rem; }
        label { display: block; margin: 1rem 0 0.2rem; font-weight: 500;}
        input, select { width: 100%; padding: 0.5rem; margin-bottom: 1rem; border-radius: 4px; border: 1px solid #dbe2ea; }
        button { background: #2574a9; color: #fff; border: none; padding: 0.7rem 1.4rem; border-radius: 4px; font-weight: bold; transition: background 0.2s;}
        button:hover { background: #125078; }
        h2 { text-align: center; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Ajouter une Salle</h2>
    <form method="post" action="${pageContext.request.contextPath}/admin/salle">
        <input type="hidden" name="action" value="add"/>
        <label for="nomSalle">Nom de la salle:</label>
        <input type="text" name="nomSalle" id="nomSalle" required placeholder="Nom de la salle"/>
        <label for="capacite">Capacité:</label>
        <input type="number" name="capacite" id="capacite" required min="1" placeholder="Capacité"/>
        <label for="departementId">Département:</label>
        <select name="departementId" id="departementId" required>
            <option value="">Sélectionner un département</option>
            <c:forEach var="dep" items="${departements}">
                <option value="${dep.idDepartement}">${dep.nom}</option>
            </c:forEach>
        </select>
        <button type="submit">Ajouter</button>
    </form>
</div>
</body>
</html>