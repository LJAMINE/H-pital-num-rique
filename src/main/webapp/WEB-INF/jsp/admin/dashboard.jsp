<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.model.Personne" %>
<%
    com.clinique.model.Personne user = (com.clinique.model.Personne) session.getAttribute("user");
    if (user == null || user.getRole() != com.clinique.model.Role.ADMIN) {
        response.sendRedirect("../../login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Clinique Digital</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .admin-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
        }
        
        .admin-navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .admin-user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: #2c5aa0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .main-content {
            padding: 3rem 0;
            min-height: calc(100vh - 80px);
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 1rem;
            margin-bottom: 1rem;
        }
        
        .stat-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .management-section {
            background: white;
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .section-title {
            color: #2c5aa0;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .management-card {
            background: #f8f9fa;
            border: 2px solid transparent;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
        }
        
        .management-card:hover {
            border-color: #2c5aa0;
            background: #2c5aa0;
            color: white;
            transform: translateY(-3px);
        }
        
        .management-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .chart-placeholder {
            height: 300px;
            background: linear-gradient(45deg, #f8f9fa 25%, transparent 25%, transparent 75%, #f8f9fa 75%),
                        linear-gradient(45deg, #f8f9fa 25%, transparent 25%, transparent 75%, #f8f9fa 75%);
            background-size: 20px 20px;
            background-position: 0 0, 10px 10px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            font-size: 1.2rem;
            border: 2px dashed #ddd;
        }
        
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .activity-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.3s ease;
        }
        
        .activity-item:hover {
            background: #f8f9fa;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.2rem;
        }
        
        .activity-success {
            background: #d4edda;
            color: #155724;
        }
        
        .activity-info {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .activity-warning {
            background: #fff3cd;
            color: #856404;
        }
        
        .logout-section {
            text-align: center;
            margin-top: 2rem;
        }
        
        @media (max-width: 768px) {
            .admin-navbar {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .admin-user-info {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .management-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .management-section {
                padding: 2rem 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Admin Header -->
    <header class="admin-header">
        <div class="container">
            <nav class="admin-navbar">
                <a href="${pageContext.request.contextPath}/" class="logo">Clinique Digital - Admin</a>
                
                <div class="admin-user-info">
                    <div class="user-avatar">
                        <%= user.getPrenom().substring(0, 1).toUpperCase() %>
                    </div>
                    <div>
                        <div style="font-weight: bold;"><%= user.getPrenom() %> <%= user.getNom() %></div>
                        <div style="font-size: 0.9rem; color: #666;"><%= user.getEmail() %></div>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary" 
                       style="background: #dc3545; border-color: #dc3545; margin-left: 1rem;" 
                       onclick="return confirm('Are you sure you want to logout?')">
                        Logout
                    </a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Welcome Section -->
            <div style="text-align: center; margin-bottom: 3rem;">
                <h1 style="color: white; font-size: 2.5rem; margin-bottom: 1rem;">Admin Dashboard</h1>
                <p style="color: rgba(255,255,255,0.9); font-size: 1.2rem;">Welcome back, <%= user.getPrenom() %>!</p>
            </div>

            <!-- Management Section -->
            <div class="management-section">
                <h3 class="section-title">
                    <span style="font-size: 1.5rem; margin-right: 0.5rem;">&#8226;</span>
                    Clinic Management
                </h3>
                
                <div class="management-grid">
                    <a href="${pageContext.request.contextPath}/admin/departement" class="management-card">
                        <div class="management-icon" style="background: #2c5aa0; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">D</div>
                        <h4>Manage Departments</h4>
                        <p>Add, edit and delete medical departments</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/doctor" class="management-card">
                        <div class="management-icon" style="background: #28a745; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">M</div>
                        <h4>Manage Doctors</h4>
                        <p>Add and manage doctor accounts</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/doctor-list" class="management-card">
                        <div class="management-icon" style="background: #17a2b8; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">L</div>
                        <h4>Doctors List</h4>
                        <p>View all registered doctors</p>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/salle" class="management-card">
                        <div class="management-icon" style="background: #17a2b8; color: white; border-radius: 50%; width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 1.5rem;">L</div>
                        <h4>Manage salle</h4>
                        <p>Add and manage salle </p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/admin-dashboard.js"></script>
</body>
</html>