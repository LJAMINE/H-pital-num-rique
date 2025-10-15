<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Salles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f9fb;}
        .table-container { max-width: 900px; margin: 2rem auto; background: #fff; box-shadow: 0 3px 18px #00000015; border-radius: 8px; padding: 2rem;}
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 0.7rem; border-bottom: 1px solid #e5e9f2; text-align: left;}
        th { background: #f2f7fc; font-weight: 600;}
        tr:last-child td { border-bottom: none;}
        form { display: inline-block; margin-right: 0.5rem;}
        input, select { padding: 0.3rem; border-radius: 3px; border: 1px solid #dbe2ea;}
        button { background: #2574a9; color: #fff; border: none; padding: 0.4rem 1rem; border-radius: 3px; font-weight: 500; transition: background 0.2s;}
        button:hover { background: #125078;}
        h2 { text-align: center;}
        .add-link { display: block; margin: 2rem auto 0; text-align: center;}
    </style>
</head>
<body>
<div class="table-container">
    <h2>Liste des Salles</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Capacité</th>
            <th>Département</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="salle" items="${salles}">
            <tr>
                <td>${salle.idSalle}</td>
                <td>${salle.nomSalle}</td>
                <td>${salle.capacite}</td>
                <td>${salle.departement.nom}</td>
                <td>
                    <!-- Edit Form -->
                    <form method="post" action="${pageContext.request.contextPath}/admin/salle">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="idSalle" value="${salle.idSalle}"/>
                        <input type="text" name="nomSalle" value="${salle.nomSalle}" required style="width:90px"/>
                        <input type="number" name="capacite" value="${salle.capacite}" required min="1" style="width:60px"/>
                        <select name="departementId" required style="width:120px">
                            <option value="">Département...</option>
                            <c:forEach var="dep" items="${departements}">
                                <option value="${dep.idDepartement}" <c:if test="${salle.departement.idDepartement == dep.idDepartement}">selected</c:if>>${dep.nom}</option>
                            </c:forEach>
                        </select>
                        <button type="submit">Modifier</button>
                    </form>
                    <!-- Delete Form -->
                    <form method="post" action="${pageContext.request.contextPath}/admin/salle">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="idSalle" value="${salle.idSalle}"/>
                        <button type="submit" onclick="return confirm('Supprimer cette salle ?')">Supprimer</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a class="add-link" href="${pageContext.request.contextPath}/admin/salle">
        ➕ Ajouter une nouvelle salle
    </a>
</div>
</body>
</html>