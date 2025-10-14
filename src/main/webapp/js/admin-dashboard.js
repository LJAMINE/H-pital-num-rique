// Admin Dashboard JavaScript
class AdminDashboard {
    constructor() {
        this.initializeStats();
        this.initializeCharts();
        this.initializeRealTimeUpdates();
    }

    // Initialize statistics with animation
    initializeStats() {
        const statCards = document.querySelectorAll('.stat-card');
        
        // Add loading class initially
        statCards.forEach(card => card.classList.add('loading'));
        
        // Simulate API call delay
        setTimeout(() => {
            this.loadStats();
        }, 1000);
    }

    // Load statistics (replace with actual API calls)
    loadStats() {
        const statNumbers = document.querySelectorAll('.stat-number');
        const mockData = {
            patients: 0, // Will be loaded from backend
            doctors: 0,  // Will be loaded from backend
            departments: 0, // Will be loaded from backend
            consultations: 0 // Will be loaded from backend
        };

        // Remove loading class
        document.querySelectorAll('.stat-card').forEach(card => {
            card.classList.remove('loading');
        });

        // Animate numbers
        statNumbers.forEach((element, index) => {
            const values = Object.values(mockData);
            this.animateNumber(element, 0, values[index], 2000);
        });
    }

    // Animate number counting
    animateNumber(element, start, end, duration) {
        const range = end - start;
        const increment = range / (duration / 16);
        let current = start;
        
        const timer = setInterval(() => {
            current += increment;
            if (current >= end) {
                current = end;
                clearInterval(timer);
            }
            element.textContent = Math.floor(current);
        }, 16);
    }

    // Initialize chart placeholders (ready for Chart.js integration)
    initializeCharts() {
        const chartPlaceholders = document.querySelectorAll('.chart-placeholder');
        
        chartPlaceholders.forEach((placeholder, index) => {
            placeholder.addEventListener('click', () => {
                this.showChartInfo(index);
            });
        });
    }

    // Show chart information modal
    showChartInfo(chartIndex) {
        const chartTypes = [
            'Consultations par mois - Graphique linéaire',
            'Répartition par département - Graphique circulaire',
            'Performance hebdomadaire - Graphique en barres'
        ];
        
        alert(`Graphique: ${chartTypes[chartIndex] || 'Graphique personnalisé'}\n\nCette fonctionnalité sera implémentée avec Chart.js dans la prochaine version.`);
    }

    // Initialize real-time updates simulation
    initializeRealTimeUpdates() {
        // Simulate real-time activity updates
        setInterval(() => {
            this.updateLastActivity();
        }, 30000); // Update every 30 seconds
    }

    // Update last activity timestamp
    updateLastActivity() {
        const activityItems = document.querySelectorAll('.activity-item');
        if (activityItems.length > 0) {
            // Add timestamp to first activity item
            const firstActivity = activityItems[0];
            const timeElement = firstActivity.querySelector('.activity-time');
            if (!timeElement) {
                const timeSpan = document.createElement('span');
                timeSpan.className = 'activity-time';
                timeSpan.style.fontSize = '0.8rem';
                timeSpan.style.color = '#999';
                timeSpan.style.float = 'right';
                timeSpan.textContent = 'À l\'instant';
                firstActivity.querySelector('div:last-child').appendChild(timeSpan);
            }
        }
    }

    // Method to refresh statistics (can be called from backend)
    refreshStats(newStats) {
        const statNumbers = document.querySelectorAll('.stat-number');
        
        statNumbers.forEach((element, index) => {
            const newValue = Object.values(newStats)[index];
            const currentValue = parseInt(element.textContent);
            
            if (newValue !== currentValue) {
                element.style.color = '#28a745'; // Green for increase
                this.animateNumber(element, currentValue, newValue, 1000);
                
                // Reset color after animation
                setTimeout(() => {
                    element.style.color = '';
                }, 1500);
            }
        });
    }

    // Add new activity item
    addActivity(type, title, description) {
        const activityContainer = document.querySelector('.recent-activity');
        const activityList = activityContainer.querySelector('div');
        
        const newActivity = document.createElement('div');
        newActivity.className = 'activity-item';
        newActivity.style.opacity = '0';
        newActivity.style.transform = 'translateY(-20px)';
        
        const iconClasses = {
            success: 'activity-success',
            info: 'activity-info',
            warning: 'activity-warning'
        };
        
        const icons = {
            success: '✓',
            info: 'ℹ',
            warning: '⚠'
        };
        
        newActivity.innerHTML = `
            <div class="activity-icon ${iconClasses[type]}">${icons[type]}</div>
            <div>
                <div><strong>${title}</strong></div>
                <div style="font-size: 0.9rem; color: #666;">${description}</div>
            </div>
        `;
        
        // Insert at the beginning
        activityList.insertBefore(newActivity, activityList.firstChild);
        
        // Animate in
        setTimeout(() => {
            newActivity.style.opacity = '1';
            newActivity.style.transform = 'translateY(0)';
            newActivity.style.transition = 'all 0.3s ease';
        }, 100);
        
        // Remove oldest activity if more than 5
        const activities = activityList.querySelectorAll('.activity-item');
        if (activities.length > 5) {
            activities[activities.length - 1].remove();
        }
    }
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    window.adminDashboard = new AdminDashboard();
    
    // Add click handlers for management cards
    document.querySelectorAll('.management-card').forEach(card => {
        card.addEventListener('click', function(e) {
            if (this.style.cursor === 'not-allowed') {
                e.preventDefault();
                alert('Cette fonctionnalité sera bientôt disponible.');
                return false;
            }
            
            // Add loading effect
            this.style.opacity = '0.7';
            setTimeout(() => {
                this.style.opacity = '1';
            }, 200);
        });
    });
    
    // Add keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'r') {
            e.preventDefault();
            location.reload();
        }
    });
});

// Utility functions for backend integration
window.DashboardAPI = {
    // Update statistics from backend
    updateStats: function(stats) {
        if (window.adminDashboard) {
            window.adminDashboard.refreshStats(stats);
        }
    },
    
    // Add new activity from backend
    addActivity: function(type, title, description) {
        if (window.adminDashboard) {
            window.adminDashboard.addActivity(type, title, description);
        }
    },
    
    // Show notification
    showNotification: function(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type}`;
        notification.style.position = 'fixed';
        notification.style.top = '20px';
        notification.style.right = '20px';
        notification.style.zIndex = '9999';
        notification.style.maxWidth = '300px';
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.opacity = '0';
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }
};

// Export for module use if needed
if (typeof module !== 'undefined' && module.exports) {
    module.exports = AdminDashboard;
}