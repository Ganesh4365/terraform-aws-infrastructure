#!/bin/bash
set -e

# Update system packages
yum update -y
yum install -y httpd

# Start Apache web server
systemctl start httpd
systemctl enable httpd

# Create a simple health check page
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to ${project_name}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; background-color: #f0f0f0; }
        .container { background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        .info { margin: 20px 0; }
        .status { color: green; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to ${project_name}</h1>
        <p class="status">✓ Application is running successfully</p>
        <div class="info">
            <p><strong>Environment:</strong> ${environment}</p>
            <p><strong>Hostname:</strong> <span id="hostname"></span></p>
            <p><strong>Time:</strong> <span id="time"></span></p>
        </div>
    </div>
    <script>
        document.getElementById('hostname').textContent = window.location.hostname;
        document.getElementById('time').textContent = new Date().toLocaleString();
    </script>
</body>
</html>
EOF

# Create CloudWatch agent configuration (optional)
echo "User data script completed successfully"