<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digital</title>
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
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Retour</a>
                    <a href="${pageContext.request.contextPath}/register-patient.jsp" class="btn btn-primary">S'inscrire</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Login Form -->
    <div style="margin-top: 80px; padding: 2rem 0; min-height: calc(100vh - 80px); display: flex; align-items: center;">
        <div class="container">
            <div class="form-container fade-in-up">
                <h2>🏥 Connexion</h2>
                
                <% String error = request.getParameter("error"); %>
                <% if ("invalid".equals(error)) { %>
                    <div class="alert alert-error">
                        Email ou mot de passe incorrect.
                    </div>
                <% } else if ("unknownrole".equals(error)) { %>
                    <div class="alert alert-error">
                        Rôle utilisateur inconnu.
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                        <label for="email">Adresse Email</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="Entrez votre email" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mot de Passe</label>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Entrez votre mot de passe" required />
                    </div>
                    
                    <button type="submit" class="form-submit">Se Connecter</button>
                </form>
                
                <div style="text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #e9ecef;">
                    <p>Pas encore de compte ?</p>
                    <a href="${pageContext.request.contextPath}/register-patient.jsp" 
                       style="color: #2c5aa0; text-decoration: none; font-weight: 600;">
                        Créer un compte patient
                    </a>
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
        // Add some interactive effects
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>