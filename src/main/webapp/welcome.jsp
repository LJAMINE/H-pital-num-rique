<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenue - Clinique Digital</title>
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
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Se Connecter</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Welcome Section -->
    <div style="margin-top: 80px; padding: 4rem 0; min-height: calc(100vh - 80px); display: flex; align-items: center;">
        <div class="container">
            <div class="form-container fade-in-up" style="text-align: center; max-width: 600px;">
                <div style="font-size: 4rem; margin-bottom: 1rem;">🎉</div>
                <h1 style="color: #28a745; margin-bottom: 1rem;">Bienvenue !</h1>
                
                <div class="success-message">
                    <h2 style="margin-bottom: 1rem;">Inscription Réussie</h2>
                    <p>
                        Félicitations ! Votre compte patient a été créé avec succès. 
                        Vous pouvez maintenant vous connecter et accéder à tous nos services médicaux.
                    </p>
                </div>
                
                <div style="margin: 2rem 0;">
                    <h3 style="color: #2c5aa0; margin-bottom: 1rem;">Prochaines Étapes</h3>
                    <div style="text-align: left; max-width: 400px; margin: 0 auto;">
                        <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                            <div style="background: #2c5aa0; color: white; width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem; font-weight: bold;">1</div>
                            <span>Connectez-vous à votre compte</span>
                        </div>
                        <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                            <div style="background: #2c5aa0; color: white; width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem; font-weight: bold;">2</div>
                            <span>Complétez votre profil médical</span>
                        </div>
                        <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                            <div style="background: #2c5aa0; color: white; width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem; font-weight: bold;">3</div>
                            <span>Prenez votre premier rendez-vous</span>
                        </div>
                    </div>
                </div>
                
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary pulse">Se Connecter Maintenant</a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Retour à l'Accueil</a>
                </div>
                
                <div style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #e9ecef; color: #666;">
                    <p>
                        <strong>Besoin d'aide ?</strong><br>
                        Notre équipe support est disponible 24h/24 pour vous accompagner.<br>
                        Email: support@clinique-digital.com | Tél: +33 1 23 45 67 89
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Clinique Digital. Tous droits réservés.</p>
        </div>
    </footer>

    <script>
        // Auto-redirect to login after 10 seconds (optional)
        setTimeout(function() {
            const redirect = confirm("Voulez-vous être redirigé vers la page de connexion ?");
            if (redirect) {
                window.location.href = "${pageContext.request.contextPath}/login.jsp";
            }
        }, 10000);
    </script>
</body>
</html>