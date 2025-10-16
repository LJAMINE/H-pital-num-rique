<%@ page import="java.util.List" %>
<%--<%@ page import="com.clinique.service.Slot" %>--%>
<%@ page import="com.clinique.model.Doctor" %>
<%@ page import="com.clinique.model.Slot" %>
<%@ page import="com.clinique.model.Personne" %>
<%
    Doctor doctor = (Doctor) request.getAttribute("doctor");
    List<Slot> slots = (List<Slot>) request.getAttribute("slots");
    Personne patient = (Personne) request.getAttribute("patient");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Prendre rendez-vous avec <%= doctor.getPrenom() %> <%= doctor.getNom() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .slot-btn {
            margin: 0.5rem 0.5rem 0.5rem 0;
            padding: 1rem 2rem;
            border-radius: 8px;
            background: #28a745;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            display: inline-block;
        }
        .slot-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>
<h2>Rendez-vous avec Dr. <%= doctor.getPrenom() %> <%= doctor.getNom() %></h2>
<p>specialite: <%= doctor.getSpecialite() %></p>
<p>departement: <%= doctor.getDepartement() != null ? doctor.getDepartement().getNom() : "Non spécifié" %></p>
<hr>
<h4>Choisissez un creneu disponible :</h4>
<div>
    <%
        java.time.LocalDate currentDay = null;
        for (Slot slot : slots) {
            java.time.LocalDate slotDay = slot.getStart().toLocalDate();
            if (currentDay == null || !currentDay.equals(slotDay)) {
                if (currentDay != null) { %></div><% }
    currentDay = slotDay;
%>
<h3 style="margin-top:2rem;color:#2c5aa0;"><%= slotDay %></h3>
<div style="margin-bottom:1rem;">
    <%
        }
    %>
    <form method="post" action="${pageContext.request.contextPath}/patient/book" style="display:inline-block;">
        <input type="hidden" name="doctorId" value="<%= doctor.getId() %>"/>
        <input type="hidden" name="slotStart" value="<%= slot.getStart() %>"/>
        <button class="slot-btn">
            <%= slot.getStart().toLocalTime() %> - <%= slot.getEnd().toLocalTime() %>
        </button>
    </form>
    <%
        }
        if (currentDay != null) { %></div><% }
%>
</div>
</body>
</html>
