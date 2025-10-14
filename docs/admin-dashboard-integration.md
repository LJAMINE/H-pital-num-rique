# Admin Dashboard - Backend Integration Guide

## Overview
The admin dashboard provides a comprehensive view of clinic statistics and management tools. This guide explains how to integrate real backend data into the dashboard.

## Statistics Integration

### 1. Controller Updates (AdminController.java)

Add the following services and methods to collect statistics:

```java
@Inject
private PatientService patientService;

@Inject
private ConsultationService consultationService;

// In the dashboard GET method:
if (path == null || "/dashboard".equals(path)) {
    // Collect statistics
    Long totalPatients = patientService.getTotalPatients();
    Long totalDoctors = doctorService.getTotalDoctors();
    Long totalDepartments = departementService.getTotalDepartments();
    Long todayConsultations = consultationService.getTodayConsultations();
    
    // Recent activities (last 5 activities)
    List<ActivityLog> recentActivities = activityService.getRecentActivities(5);
    
    // Set attributes for JSP
    req.setAttribute("totalPatients", totalPatients);
    req.setAttribute("totalDoctors", totalDoctors);
    req.setAttribute("totalDepartments", totalDepartments);
    req.setAttribute("todayConsultations", todayConsultations);
    req.setAttribute("recentActivities", recentActivities);
    
    req.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(req, resp);
}
```

### 2. Service Layer Methods

#### PatientService
```java
public Long getTotalPatients() {
    return patientRepository.count();
}

public Long getPatientsRegisteredToday() {
    LocalDate today = LocalDate.now();
    return patientRepository.countByRegistrationDate(today);
}
```

#### DoctorService
```java
public Long getTotalDoctors() {
    return doctorRepository.count();
}

public Long getActiveDoctors() {
    return doctorRepository.countByStatus("ACTIVE");
}
```

#### DepartementService
```java
public Long getTotalDepartments() {
    return departementRepository.count();
}
```

#### ConsultationService (New Service)
```java
@ApplicationScoped
public class ConsultationService {
    
    @Inject
    private ConsultationRepository consultationRepository;
    
    public Long getTodayConsultations() {
        LocalDate today = LocalDate.now();
        return consultationRepository.countByDate(today);
    }
    
    public Long getWeeklyConsultations() {
        LocalDate startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = startOfWeek.plusDays(6);
        return consultationRepository.countByDateBetween(startOfWeek, endOfWeek);
    }
    
    public Map<String, Long> getConsultationsByDepartment() {
        return consultationRepository.countByDepartment();
    }
}
```

### 3. Repository Updates

Add count methods to existing repositories:

#### PatientRepository
```java
@Query("SELECT COUNT(p) FROM Patient p")
Long count();

@Query("SELECT COUNT(p) FROM Patient p WHERE DATE(p.createdAt) = :date")
Long countByRegistrationDate(@Param("date") LocalDate date);
```

#### DoctorRepository
```java
@Query("SELECT COUNT(d) FROM Doctor d")
Long count();

@Query("SELECT COUNT(d) FROM Doctor d WHERE d.status = :status")
Long countByStatus(@Param("status") String status);
```

#### DepartementRepository
```java
@Query("SELECT COUNT(d) FROM Departement d")
Long count();
```

### 4. JSP Updates

Update the dashboard.jsp to use backend data:

```jsp
<!-- In the statistics section -->
<div class="stat-number" style="color: #2c5aa0;">
    ${totalPatients != null ? totalPatients : 0}
</div>

<div class="stat-number" style="color: #28a745;">
    ${totalDoctors != null ? totalDoctors : 0}
</div>

<div class="stat-number" style="color: #17a2b8;">
    ${totalDepartments != null ? totalDepartments : 0}
</div>

<div class="stat-number" style="color: #fd7e14;">
    ${todayConsultations != null ? todayConsultations : 0}
</div>
```

## AJAX Integration for Real-time Updates

### 1. Create Statistics API Endpoint

```java
@WebServlet("/api/admin/stats")
public class AdminStatsAPI extends HttpServlet {
    
    @Inject
    private PatientService patientService;
    
    @Inject
    private DoctorService doctorService;
    
    @Inject
    private DepartementService departementService;
    
    @Inject
    private ConsultationService consultationService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("patients", patientService.getTotalPatients());
        stats.put("doctors", doctorService.getTotalDoctors());
        stats.put("departments", departementService.getTotalDepartments());
        stats.put("consultations", consultationService.getTodayConsultations());
        
        // Convert to JSON (using Jackson or Gson)
        String jsonResponse = gson.toJson(stats);
        resp.getWriter().write(jsonResponse);
    }
}
```

### 2. Frontend AJAX Call

Update the admin-dashboard.js to fetch real-time data:

```javascript
// Add to AdminDashboard class
async loadRealTimeStats() {
    try {
        const response = await fetch('/clinique-digital/api/admin/stats');
        const stats = await response.json();
        
        this.updateStatsDisplay(stats);
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

updateStatsDisplay(stats) {
    document.getElementById('totalPatients').textContent = stats.patients || 0;
    document.getElementById('totalDoctors').textContent = stats.doctors || 0;
    document.getElementById('totalDepartments').textContent = stats.departments || 0;
    document.getElementById('todayConsultations').textContent = stats.consultations || 0;
}
```

## Chart Integration with Chart.js

### 1. Add Chart.js to JSP
```html
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

### 2. Replace chart placeholders with real charts
```javascript
// Example consultation chart
const consultationChartCtx = document.getElementById('consultationChart').getContext('2d');
const consultationChart = new Chart(consultationChartCtx, {
    type: 'line',
    data: {
        labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun'],
        datasets: [{
            label: 'Consultations',
            data: [12, 19, 3, 5, 2, 3], // Replace with real data
            borderColor: '#2c5aa0',
            backgroundColor: 'rgba(44, 90, 160, 0.1)'
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
```

## Activity Log System

### 1. Create ActivityLog Model
```java
@Entity
public class ActivityLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String type; // SUCCESS, INFO, WARNING
    private String title;
    private String description;
    private LocalDateTime timestamp;
    private Long userId;
    
    // Getters and setters
}
```

### 2. Log Activities in Services
```java
// In DoctorService
public void addDoctor(Doctor doctor) {
    doctorRepository.save(doctor);
    
    // Log activity
    activityService.logActivity(
        ActivityType.SUCCESS,
        "Nouveau médecin ajouté",
        "Dr. " + doctor.getNom() + " - " + doctor.getSpecialite()
    );
}
```

## Security Considerations

1. **Authentication**: Ensure only admin users can access dashboard data
2. **Authorization**: Verify admin role before returning sensitive statistics
3. **Input Validation**: Validate all API parameters
4. **Rate Limiting**: Implement rate limiting for statistics API
5. **CSRF Protection**: Add CSRF tokens for admin actions

## Performance Optimization

1. **Caching**: Cache statistics for 5-10 minutes to reduce database load
2. **Async Loading**: Load charts and statistics asynchronously
3. **Database Indexing**: Add indexes on frequently queried date fields
4. **Connection Pooling**: Ensure proper database connection pooling

## Testing

1. **Unit Tests**: Test service layer methods for statistics
2. **Integration Tests**: Test API endpoints
3. **Frontend Tests**: Test dashboard interactions
4. **Performance Tests**: Test with large datasets

This integration will transform the static dashboard into a fully functional admin panel with real-time statistics and management capabilities.