#!/bin/bash

# =============================================
# Project Kavach - Environment Verification Script
# Enhanced for 9.5/10 Portfolio Quality
# =============================================

set -euo pipefail

# Colors for professional output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   Project Kavach Environment Check${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# 1. Check Docker Engine
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed or not in PATH${NC}"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker daemon is not running${NC}"
    echo -e "   Start Docker and try again."
    exit 1
fi
echo -e "${GREEN}✅ Docker is running${NC}"

# 2. Check docker-compose
if ! docker compose version &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not available${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Docker Compose is available${NC}"

# 3. Check if containers are running
CONTAINERS=("kavach-dvwa" "kavach-juice-shop")
ALL_RUNNING=true

echo ""
echo -e "${BLUE}Checking Containers:${NC}"
for container in "${CONTAINERS[@]}"; do
    if docker ps --filter "name=^${container}$" --format "{{.Names}}" | grep -q "${container}"; then
        STATUS=$(docker inspect --format='{{.State.Status}}' "${container}")
        HEALTH=$(docker inspect --format='{{.State.Health.Status}}' "${container}" 2>/dev/null || echo "unknown")
        
        if [ "$STATUS" = "running" ] && [ "$HEALTH" = "healthy" ]; then
            echo -e "   ${GREEN}✅ ${container} is running & healthy${NC}"
        elif [ "$STATUS" = "running" ]; then
            echo -e "   ${YELLOW}⚠️  ${container} is running (health: ${HEALTH})${NC}"
        else
            echo -e "   ${RED}❌ ${container} is ${STATUS}${NC}"
            ALL_RUNNING=false
        fi
    else
        echo -e "   ${RED}❌ ${container} is not running${NC}"
        ALL_RUNNING=false
    fi
done

# 4. Port Checks
echo ""
echo -e "${BLUE}Checking Ports:${NC}"

check_port() {
    local port=$1
    local service=$2
    if ss -tuln | grep -q ":${port} " || netstat -tuln 2>/dev/null | grep -q ":${port} "; then
        echo -e "   ${GREEN}✅ Port ${port} (${service}) is listening${NC}"
        return 0
    else
        echo -e "   ${RED}❌ Port ${port} (${service}) is not listening${NC}"
        return 1
    fi
}

check_port 8085 "DVWA"
check_port 4280 "Juice Shop"

# 5. HTTP Health Checks
echo ""
echo -e "${BLUE}Testing Web Applications:${NC}"

check_http() {
    local url=$1
    local service=$2
    if curl -s -o /dev/null -w "%{http_code}" --max-time 5 "${url}" | grep -q "2[0-9][0-9]"; then
        echo -e "   ${GREEN}✅ ${service} is responding (${url})${NC}"
        return 0
    else
        echo -e "   ${RED}❌ ${service} is not responding properly (${url})${NC}"
        return 1
    fi
}

check_http "http://localhost:8085/login.php" "DVWA"
check_http "http://localhost:4280" "Juice Shop"

# Final Summary
echo ""
echo -e "${BLUE}======================================${NC}"
if [ "$ALL_RUNNING" = true ]; then
    echo -e "${GREEN}🎉 All core checks passed!${NC}"
    echo -e "${GREEN}Project Kavach environment is ready for use.${NC}"
    echo ""
    echo -e "Access Points:"
    echo -e "   DVWA      → http://localhost:8085     (admin / password)"
    echo -e "   Juice Shop → http://localhost:4280"
    echo ""
    echo -e "Next: Set DVWA security level to 'low' for testing."
else
    echo -e "${YELLOW}⚠️  Some checks failed. Review the output above.${NC}"
    echo -e "Run: docker compose logs"
fi
echo -e "${BLUE}======================================${NC}"
