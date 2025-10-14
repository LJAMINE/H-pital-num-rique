<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Patient - Clinique Digital</title>
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
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Se Connecter</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Registration Form -->
    <div style="margin-top: 80px; padding: 2rem 0; min-height: calc(100vh - 80px);">
        <div class="container">
            <div class="form-container fade-in-up">
                <h2>👤 Inscription Patient</h2>
                <p style="text-align: center; color: #666; margin-bottom: 2rem;">
                    Créez votre compte pour accéder à nos services médicaux
                </p>
                
                <form method="post" action="${pageContext.request.contextPath}/register-patient">
                    <div class="form-group">
                        <label for="email">Adresse Email *</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="exemple@email.com" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mot de Passe *</label>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Choisissez un mot de passe sécurisé" required minlength="6">
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="prenom">Prénom *</label>
                            <input type="text" id="prenom" name="prenom" class="form-control" 
                                   placeholder="Votre prénom" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="nom">Nom *</label>
                            <input type="text" id="nom" name="nom" class="form-control" 
                                   placeholder="Votre nom de famille" required>
                        </div>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="poids">Poids (kg)</label>
                            <input type="number" id="poids" name="poids" class="form-control" 
                                   placeholder="65.5" step="0.1" min="1" max="500">
                        </div>
                        
                        <div class="form-group">
                            <label for="taille">Taille (cm)</label>
                            <input type="number" id="taille" name="taille" class="form-control" 
                                   placeholder="170" step="0.1" min="50" max="250">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" required style="margin-right: 0.5rem;">
                            J'accepte les <a href="#" style="color: #2c5aa0;">conditions d'utilisation</a> 
                            et la <a href="#" style="color: #2c5aa0;">politique de confidentialité</a>
                        </label>
                    </div>
                    
                    <button type="submit" class="form-submit">Créer mon Compte</button>
                </form>
                
                <div style="text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #e9ecef;">
                    <p>Vous avez déjà un compte ?</p>
                    <a href="${pageContext.request.contextPath}/login.jsp" 
                       style="color: #2c5aa0; text-decoration: none; font-weight: 600;">
                        Se connecter
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
        // Form validation and interactivity
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const inputs = document.querySelectorAll('.form-control');
            
            // Add real-time validation feedback
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    validateField(this);
                });
                
                input.addEventListener('input', function() {
                    if (this.classList.contains('error')) {
                        validateField(this);
                    }
                });
            });
            
            function validateField(field) {
                const value = field.value.trim();
                const fieldName = field.name;
                
                // Remove existing error styling
                field.classList.remove('error');
                field.style.borderColor = '';
                
                // Basic validation
                if (field.required && !value) {
                    showFieldError(field, 'Ce champ est requis');
                    return false;
                }
                
                if (fieldName === 'email' && value) {
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(value)) {
                        showFieldError(field, 'Format d\'email invalide');
                        return false;
                    }
                }
                
                if (fieldName === 'password' && value) {
                    if (value.length < 6) {
                        showFieldError(field, 'Le mot de passe doit contenir au moins 6 caractères');
                        return false;
                    }
                }
                
                return true;
            }
            
            function showFieldError(field, message) {
                field.classList.add('error');
                field.style.borderColor = '#dc3545';
                
                // Remove existing error message
                const existingError = field.parentNode.querySelector('.error-message');
                if (existingError) {
                    existingError.remove();
                }
                
                // Add error message
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                errorDiv.style.color = '#dc3545';
                errorDiv.style.fontSize = '0.875rem';
                errorDiv.style.marginTop = '0.25rem';
                errorDiv.textContent = message;
                field.parentNode.appendChild(errorDiv);
            }
            
            // Form submission validation
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (!validateField(input)) {
                        isValid = false;
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Veuillez corriger les erreurs dans le formulaire');
                }
            });
        });
    </script>
</body>
</html>