<%@ page import="com.clinique.model.Consultation" %>
<%@ page import="java.util.List" %>
<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
%>
<div id="success-msg" style="padding:1rem;background:#dff0d8;color:#3c763d;border-radius:6px;margin-bottom:1rem;">
    rendez vous success  !
</div>
<%
    }
    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
    if (consultations != null && !consultations.isEmpty()) {
        for (Consultation c : consultations) {
%>
<div>
    <b>doctor:</b> <%= c.getDoctor().getNom() %> <br/>
    <b>Date/Heure:</b> <%= c.getDateTime() %> <br/>
    <b>Statut:</b> <%= c.getStatus() %>
</div>
<hr/>
<%
    }
} else {
%>
<div>Aucun rendez-vous trouvé.</div>
<%
    }
%>
<script>
    setTimeout(function(){
        var msg = document.getElementById("success-msg");
        if(msg) msg.style.display = "none";
    }, 4000);
</script>