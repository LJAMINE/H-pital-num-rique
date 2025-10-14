<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.model.Personne" %>
<%@ page import="com.clinique.model.Role" %>
<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    boolean isPatient = (isLoggedIn && user.getRole() == Role.PATIENT);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digital - Votre Santé Notre Priorité</title>
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
                
                <ul class="nav-links">
                    <li><a href="#home">Accueil</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#doctors">doctors</a></li>
                    <li><a href="#about">À Propos</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                
                <div class="auth-buttons">
                    <% if (isLoggedIn) { %>
                        <% if (isPatient) { %>
                            <div style="display: flex; align-items: center; gap: 1rem;">
                                <div style="background: #2c5aa0; color: white; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                                    <%= user.getPrenom().substring(0, 1).toUpperCase() %>
                                </div>
                                <div>
                                    <div style="font-weight: bold; color: #2c5aa0;"><%= user.getPrenom() %> <%= user.getNom() %></div>
                                </div>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir vous déconnecter ?')">Déconnexion</a>
                            </div>
                        <% } %>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-secondary">Connexion</a>
                        <a href="${pageContext.request.contextPath}/register-patient.jsp" class="btn btn-primary">S'inscrire</a>
                    <% } %>
                </div>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section id="home" class="hero medical-bg fade-in-up">
        <div class="container">
            <% if (isPatient) { %>
                <h1>Bienvenue, <%= user.getPrenom() %>!</h1>
                <p>
                    Vous êtes connecté à votre espace patient. Accédez à vos services médicaux personnalisés 
                    et gérez facilement vos rendez-vous et consultations.
                </p>
                <div class="hero-buttons">
                    <a href="#services" class="btn btn-primary">Mes Services</a>
                    <a href="#patient-actions" class="btn btn-secondary">Actions Rapides</a>
                </div>
            <% } else { %>
                <h1>Votre Santé, Notre Priorité</h1>
                <p>
                    Bienvenue dans notre clinique digitale moderne. Nous offrons des soins médicaux de qualité 
                    avec une approche personnalisée et des technologies de pointe.
                </p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/register-patient.jsp" class="btn btn-primary">Prendre Rendez-vous</a>
                    <a href="#services" class="btn btn-secondary">Nos Services</a>
                </div>
            <% } %>
        </div>
    </section>

    <!-- Patient Quick Actions (Only for logged in patients) -->
    <% if (isPatient) { %>
    <section id="patient-actions" class="features" style="background: #f8f9fa;">
        <div class="container">
            <h2>Actions Rapides</h2>
            <div class="features-grid">
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon" style="background: #28a745; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">R</div>
                    <h3>Prendre Rendez-vous</h3>
                    <p>Planifiez facilement vos consultations avec nos médecins spécialisés.</p>
                    <a href="${pageContext.request.contextPath}/patient/rendez-vous" class="btn btn-primary" style="margin-top: 1rem;">Nouveau RDV</a>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon" style="background: #17a2b8; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">H</div>
                    <h3>Mon Historique</h3>
                    <p>Consultez l'historique de vos consultations et traitements passés.</p>
                    <a href="#" class="btn btn-secondary" style="margin-top: 1rem;">Voir Historique</a>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon" style="background: #fd7e14; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">P</div>
                    <h3>Mon Profil</h3>
                    <p>Mettez à jour vos informations personnelles et médicales.</p>
                    <a href="#" class="btn btn-secondary" style="margin-top: 1rem;">Modifier Profil</a>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <!-- Features Section -->
    <section id="services" class="features">
        <div class="container">
            <h2><%= isPatient ? "Tous Nos Services" : "Nos Services" %></h2>
            <div class="features-grid">
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">🩺</div>
                    <h3>Consultations Médicales</h3>
                    <p>Consultations générales et spécialisées avec nos médecins expérimentés dans différents départements.</p>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">📋</div>
                    <h3>Gestion des Dossiers</h3>
                    <p>Système numérique sécurisé pour la gestion complète de vos dossiers médicaux et historique de soins.</p>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">⏰</div>
                    <h3>Rendez-vous en Ligne</h3>
                    <p>Prenez vos rendez-vous facilement en ligne, 24h/24 et 7j/7, selon la disponibilité des médecins.</p>
                    <% if (isPatient) { %>
                        <a href="${pageContext.request.contextPath}/patient/doctors" class="btn btn-primary" style="margin-top: 1rem;">Voir Nos Médecins</a>
                    <% } %>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">🏥</div>
                    <h3>Départements Spécialisés</h3>
                    <p>Multiple départements médicaux spécialisés pour répondre à tous vos besoins de santé.</p>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">💊</div>
                    <h3>Suivi Médical</h3>
                    <p>Suivi personnalisé de votre traitement et de votre évolution avec nos professionnels de santé.</p>
                </div>
                
                <div class="feature-card medical-card fade-in-up">
                    <div class="feature-icon">🔒</div>
                    <h3>Sécurité & Confidentialité</h3>
                    <p>Protection totale de vos données personnelles et médicales selon les standards les plus élevés.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="features" style="background: #f8f9fa;">
        <div class="container">
            <h2>À Propos de Nous</h2>
            <div class="feature-card" style="max-width: 800px; margin: 0 auto;">
                <p style="font-size: 1.1rem; line-height: 1.8;">
                    La Clinique Digital est un établissement médical moderne qui combine l'expertise médicale traditionnelle 
                    avec les dernières innovations technologiques. Notre équipe de professionnels qualifiés s'engage à 
                    fournir des soins de qualité supérieure dans un environnement accueillant et sécurisé.
                </p>
                <br>
                <p style="font-size: 1.1rem; line-height: 1.8;">
                    Nous croyons que chaque patient mérite une attention personnalisée et des soins adaptés à ses besoins 
                    spécifiques. C'est pourquoi nous avons développé une plateforme numérique intuitive qui facilite 
                    l'accès aux soins et améliore l'expérience patient.
                </p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <% if (isPatient) { %>
                <p>&copy; 2024 Clinique Digital. Tous droits réservés.</p>
                <p>Connecté en tant que patient - Besoin d'aide? Contactez notre support 24h/24</p>
            <% } else { %>
                <p>&copy; 2024 Clinique Digital. Tous droits réservés.</p>
                <p>Votre santé, notre engagement - Service médical de qualité 24h/24</p>
            <% } %>
        </div>
    </footer>

    <script>
        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add scroll effect to navbar
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.header');
            if (window.scrollY > 50) {
                header.style.background = 'rgba(255, 255, 255, 0.98)';
            } else {
                header.style.background = 'rgba(255, 255, 255, 0.95)';
            }
        });
    </script>
</body>
</html>