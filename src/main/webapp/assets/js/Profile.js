const navLinks = document.querySelectorAll('.sidebar-nav li a[data-target]');
        const contentSections = document.querySelectorAll('.content-section');
        const navItems = document.querySelectorAll('.sidebar-nav li');

        navLinks.forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault(); 
                const targetId = this.getAttribute('data-target');
                const targetSection = document.getElementById(targetId);

                contentSections.forEach(section => section.classList.remove('active'));
                navItems.forEach(item => item.classList.remove('active'));

                if (targetSection) {
                    targetSection.classList.add('active');
                }
                this.parentElement.classList.add('active');
            });
        });
/**
 * 
 */