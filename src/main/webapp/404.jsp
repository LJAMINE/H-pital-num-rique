<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Non Trouvée - Clinique Digital</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical-theme.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/" class="logo">Clinique Digital</a>
                
                <div class="auth-buttons">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Retour à l'Accueil</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- 404 Error Section -->
    <div style="margin-top: 80px; padding: 4rem 0; min-height: calc(100vh - 80px); display: flex; align-items: center;">
        <div class="container">
            <div class="form-container fade-in-up" style="text-align: center; max-width: 600px;">
                <div style="font-size: 6rem; color: #2c5aa0; margin-bottom: 1rem;">🏥</div>
                <h1 style="font-size: 3rem; color: #2c5aa0; margin-bottom: 1rem;">404</h1>
                <h2 style="margin-bottom: 1rem;">Page Non Trouvée</h2>
                <p style="color: #666; margin-bottom: 2rem; font-size: 1.1rem;">
                    Désolé, la page que vous recherchez n'existe pas ou a été déplacée.
                    Notre équipe médicale est toujours disponible pour vous aider !
                </p>
                
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Retour à l'Accueil</a>
                    <a href="${pageContext.request.contextPath}/register-patient.jsp" class="btn btn-secondary">Prendre Rendez-vous</a>
                </div>
                
                <div style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #e9ecef;">
                    <h3 style="color: #2c5aa0; margin-bottom: 1rem;">Liens Utiles</h3>
                    <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/login.jsp" style="color: #2c5aa0; text-decoration: none;">Connexion</a>
                        <a href="${pageContext.request.contextPath}/register-patient.jsp" style="color: #2c5aa0; text-decoration: none;">Inscription</a>
                        <a href="${pageContext.request.contextPath}/#services" style="color: #2c5aa0; text-decoration: none;">Nos Services</a>
                        <a href="${pageContext.request.contextPath}/#contact" style="color: #2c5aa0; text-decoration: none;">Contact</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Clinique Digital. Tous droits reserved.</p>
        </div>
    </footer>
</body>
</html>