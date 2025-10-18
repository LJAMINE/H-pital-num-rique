<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.model.Consultation" %>
<%@ page import="com.clinique.model.Salle" %>
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    if ("valide".equals(success)) {
%>
<div style="background:#dff0d8;color:#3c763d;padding:10px;border-radius:6px;margin-bottom:10px;">Consultation validée.</div>
<%
} else if ("annule".equals(success)) {
%>
<div style="background:#f2dede;color:#a94442;padding:10px;border-radius:6px;margin-bottom:10px;">Consultation annulée.</div>
<%
} else if ("salle-unavailable".equals(error)) {
%>
<div style="background:#f8d7da;color:#721c24;padding:10px;border-radius:6px;margin-bottom:10px;">Salle non disponible pour ce créneau, choisissez une autre salle.</div>
<%
} else if ("notfound".equals(error)) {
%>
<div style="background:#f8d7da;color:#721c24;padding:10px;border-radius:6px;margin-bottom:10px;">Consultation non trouvée.</div>
<%
    }

    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
    Map<Long, List<Salle>> sallesByDept = (Map<Long, List<Salle>>) request.getAttribute("sallesByDept");

    if (consultations == null || consultations.isEmpty()) {
%>
<div>Aucun rendez-vous en attente.</div>
<%
} else {
    for (Consultation c : consultations) {
%>
<div style="border-bottom:1px solid #ccc;padding:0.7rem 0;">
    <b>Patient:</b> <%= c.getPatient().getNom() %> <%= c.getPatient().getPrenom() %><br/>
    <b>Date/Heure:</b> <%= c.getDateTime() %><br/>
    <b>Statut:</b> <%= c.getStatus() %><br/>

    <form method="post" action="${pageContext.request.contextPath}/doctor/consultation/action" style="margin-top:0.5rem;">
        <input type="hidden" name="consultationId" value="<%= c.getId() %>"/>
        <label for="salle_<%= c.getId() %>">Salle (optionnel):</label>
        <select id="salle_<%= c.getId() %>" name="salleId">
            <option value="">--Aucune (laisser au staff)--</option>
            <%
                Long depId = null;
                if (c.getDoctor() != null && c.getDoctor().getDepartement() != null) {
                    depId = c.getDoctor().getDepartement().getIdDepartement();
                }
                List<Salle> salles = null;
                if (sallesByDept != null && depId != null) {
                    salles = sallesByDept.get(depId);
                }
                if (salles == null || salles.isEmpty()) {
            %>
            <option value="" disabled>Aucune salle disponible</option>
            <%
            } else {
                for (Salle s : salles) {
            %>
            <option value="<%= s.getIdSalle() %>"><%= s.getNomSalle() %> (cap: <%= s.getCapacite() %>)</option>
            <%
                    }
                }
            %>
        </select>

        <button type="submit" name="action" value="valider">Valider</button>
        <button type="submit" name="action" value="annuler" onclick="return confirm('Annuler ce rendez-vous?');" style="background:#d9534f;color:white;">Annuler</button>
    </form>
</div>
<%
        }
    }
%>