#!/bin/bash
# =============================================================================
# Project KAVACH - Environment Verification Script
# Checks Docker services, key files, and basic functionality
# =============================================================================

set -euo pipefail

echo "🔍 Verifying Project KAVACH Environment..."
echo "========================================"

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SUCCESS=0
WARNINGS=0

# 1. Check Docker Compose services
echo -e "\n${YELLOW}→ Checking Docker services...${NC}"
if command -v docker-compose >/dev/null 2>&1 || command -v docker >/dev/null 2>&1; then
    if docker compose ps --services --filter "status=running" 2>/dev/null | grep -q .; then
        echo -e "${GREEN}✅ Docker services are running${NC}"
        
        # Check specific services
        for service in dvwa juice-shop; do
            if docker compose ps "$service" 2>/dev/null | grep -q "Up"; then
                echo -e "   ${GREEN}✓ $service is up${NC}"
            else
                echo -e "   ${RED}✗ $service is not running${NC}"
                SUCCESS=1
            fi
        done
    else
        echo -e "${RED}❌ No Docker services are running. Start with: docker-compose up -d${NC}"
        SUCCESS=1
    fi
else
    echo -e "${RED}❌ Docker is not installed or not in PATH${NC}"
    SUCCESS=1
fi

# 2. Check Web Services Accessibility
echo -e "\n${YELLOW}→ Checking web application endpoints...${NC}"

# DVWA
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8085/login.php | grep -q "200\|302"; then
    echo -e "${GREEN}✅ DVWA is accessible at http://localhost:8085${NC}"
else
    echo -e "${RED}❌ DVWA is not responding[](http://localhost:8085)${NC}"
    SUCCESS=1
fi

# OWASP Juice Shop
if curl -s -o /dev/null -w "%{http_code}" http://localhost:4280 | grep -q "200"; then
    echo -e "${GREEN}✅ OWASP Juice Shop is accessible at http://localhost:4280${NC}"
else
    echo -e "${RED}❌ OWASP Juice Shop is not responding[](http://localhost:4280)${NC}"
    SUCCESS=1
fi

# 3. Check Critical Files & Folders
echo -e "\n${YELLOW}→ Checking key project files and directories...${NC}"

declare -a REQUIRED_FILES=(
    "README.md"
    "REPOSITORY.md"
    "docker-compose.yml"
    "synthesis/threat-model.md"
    "synthesis/defense-in-depth.md"
    "synthesis/exec-readout.md"
    "network/report.md"
    "webapp/report.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}✅ $file exists${NC}"
    else
        echo -e "${RED}❌ Missing: $file${NC}"
        SUCCESS=1
    fi
done

# Check important directories
declare -a REQUIRED_DIRS=(
    "network"
    "webapp"
    "synthesis"
    "diagrams"
    "deliverables"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✅ Directory $dir/ exists${NC}"
    else
        echo -e "${YELLOW}⚠️  Directory $dir/ is missing${NC}"
        WARNINGS=$((WARNINGS+1))
    fi
done

# 4. Final Summary
echo -e "\n========================================"
if [[ $SUCCESS -eq 0 ]]; then
    echo -e "${GREEN}🎉 All core checks passed! Project KAVACH environment looks good.${NC}"
else
    echo -e "${RED}⚠️  Some issues were detected. Please review the messages above.${NC}"
fi

if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}Note: $WARNINGS warnings were found (non-critical).${NC}"
fi

echo -e "\nNext steps:"
echo "   • Access DVWA: http://localhost:8085"
echo "   • Access Juice Shop: http://localhost:4280"
echo "   • Review reports in synthesis/ and network/"
echo ""
echo "Project KAVACH verification complete."
