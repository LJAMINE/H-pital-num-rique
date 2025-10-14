<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.model.Doctor" %>
<%@ page import="com.clinique.model.Personne" %>

<%
    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
    Personne patient = (Personne) request.getAttribute("patient");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nos Médecins - Clinique Digital</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical-theme.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .doctors-container {
            padding: 2rem 0;
            min-height: calc(100vh - 160px);
        }
        
        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .doctor-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .doctor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .doctor-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #2c5aa0;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
            margin: 0 auto 1rem;
        }
        
        .doctor-name {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c5aa0;
            margin-bottom: 0.5rem;
        }
        
        .doctor-specialty {
            color: #28a745;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .doctor-department {
            color: #666;
            margin-bottom: 1.5rem;
        }
        
        .appointment-btn {
            width: 100%;
            padding: 1rem;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .appointment-btn:hover {
            background: #218838;
            transform: translateY(-2px);
        }
        
        .page-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
        }
        
        .breadcrumb {
            color: #666;
            margin-bottom: 2rem;
        }
        
        .breadcrumb a {
            color: #2c5aa0;
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .no-doctors {
            text-align: center;
            color: white;
            font-size: 1.2rem;
            margin: 3rem 0;
        }
        
        @media (max-width: 768px) {
            .doctors-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .doctor-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="page-header">
        <div class="container">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/" class="logo">Clinique Digital</a>
                
                <div class="auth-buttons">
                    <div style="display: flex; align-items: center; gap: 1rem;">
                        <div style="background: #2c5aa0; color: white; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                            <%= patient.getPrenom().substring(0, 1).toUpperCase() %>
                        </div>
                        <div>
                            <div style="font-weight: bold; color: #2c5aa0;"><%= patient.getPrenom() %> <%= patient.getNom() %></div>
                        </div>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Accueil</a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary" 
                           onclick="return confirm('Êtes-vous sûr de vouloir vous déconnecter ?')">Déconnexion</a>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <div class="doctors-container">
        <div class="container">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/">Accueil</a> > Nos Médecins
            </div>
            
            <!-- Page Title -->
            <div style="text-align: center; margin-bottom: 2rem;">
                <h1 style="color: white; font-size: 2.5rem; margin-bottom: 1rem;">Nos Médecins</h1>
                <p style="color: rgba(255,255,255,0.9); font-size: 1.2rem;">
                    Choisissez votre médecin et prenez rendez-vous facilement
                </p>
            </div>

            <!-- Doctors Grid -->
            <% if (doctors != null && !doctors.isEmpty()) { %>
                <div class="doctors-grid">
                    <% for (Doctor doctor : doctors) { %>
                        <div class="doctor-card">
                            <div class="doctor-avatar">
                                <%= doctor.getPrenom().substring(0, 1).toUpperCase() %>
                            </div>
                            
                            <div class="doctor-name">
                                Dr. <%= doctor.getPrenom() %> <%= doctor.getNom() %>
                            </div>
                            
                            <div class="doctor-specialty">
                                <%= doctor.getSpecialite() != null ? doctor.getSpecialite() : "Médecine Générale" %>
                            </div>
                            
                            <div class="doctor-department">
                                Département: <%= doctor.getDepartement() != null ? doctor.getDepartement().getNom() : "Non spécifié" %>
                            </div>
                            
                            <button class="appointment-btn" 
                                    data-doctor-id="<%= doctor.getId() %>" 
                                    data-doctor-name="Dr. <%= doctor.getPrenom() %> <%= doctor.getNom() %>">
                                Prendre Rendez-vous
                            </button>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-doctors">
                    <h3>Aucun médecin disponible pour le moment</h3>
                    <p>Veuillez réessayer plus tard ou contactez notre service client.</p>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Clinique Digital. Tous droits réservés.</p>
        </div>
    </footer>
</body>
</html>