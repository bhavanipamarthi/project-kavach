#!/bin/bash
echo "🔍 Verifying Project KAVACH Environment..."

if curl -s -o /dev/null -w "%{http_code}" http://localhost:8085/login.php | grep -q "200\|302"; then
    echo "✅ DVWA is running on http://localhost:8085"
else
    echo "❌ DVWA is not responding"
fi

if curl -s -o /dev/null -w "%{http_code}" http://localhost:4280 | grep -q "200"; then
    echo "✅ Juice Shop is running on http://localhost:4280"
else
    echo "❌ Juice Shop is not responding"
fi

echo "Environment check complete!"
