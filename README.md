#!/bin/bash
# Project KAVACH - Production Ready Setup Script
# Run this once in your project-kavach directory

set -e

echo "🚀 Building Production-Ready Project KAVACH..."
echo "=============================================="

# 1. Create verify.sh
cat > verify.sh << 'EOF'
#!/bin/bash
# Project KAVACH - Environment Verification Script

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔍 Project KAVACH Verification"
echo "=============================="
echo ""

# Check Docker
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker installed${NC}"
    docker --version
else
    echo -e "${RED}❌ Docker not installed${NC}"
    exit 1
fi

# Check Docker Compose
if command -v docker-compose &> /dev/null; then
    echo -e "${GREEN}✅ Docker Compose installed${NC}"
    docker-compose --version
else
    echo -e "${RED}❌ Docker Compose not installed${NC}"
    exit 1
fi

# Check running containers
echo ""
echo "📦 Container Status:"
if docker ps | grep -q dvwa; then
    echo -e "${GREEN}✅ DVWA running${NC} → http://localhost:4280"
else
    echo -e "${YELLOW}⚠️  DVWA not running${NC}"
fi

if docker ps | grep -q juice-shop; then
    echo -e "${GREEN}✅ Juice Shop running${NC} → http://localhost:3000"
else
    echo -e "${YELLOW}⚠️  Juice Shop not running${NC}"
fi

# Check ports
echo ""
echo "🔌 Port Status:"
nc -zv localhost 4280 2>/dev/null && echo -e "${GREEN}✅ Port 4280 (DVWA) accessible${NC}" || echo -e "${RED}❌ Port 4280 not accessible${NC}"
nc -zv localhost 3000 2>/dev/null && echo -e "${GREEN}✅ Port 3000 (Juice Shop) accessible${NC}" || echo -e "${RED}❌ Port 3000 not accessible${NC}"

echo ""
echo -e "${GREEN}✓ Verification complete${NC}"
EOF

chmod +x verify.sh

# 2. Remove obsolete version from docker-compose.yml
if [ -f "docker-compose.yml" ] && grep -q "^version:" docker-compose.yml; then
    sed -i '/^version:/d' docker-compose.yml
    echo "✅ Removed obsolete 'version:' from docker-compose.yml"
fi

# 3. Create Makefile
cat > Makefile << 'EOF'
.PHONY: help up down restart logs verify clean

help:
	@echo "Project KAVACH Commands:"
	@echo "  make up       - Start all containers"
	@echo "  make down     - Stop all containers"
	@echo "  make restart  - Restart all containers"
	@echo "  make logs     - View container logs"
	@echo "  make verify   - Verify setup"
	@echo "  make clean    - Remove containers and volumes"

up:
	docker-compose up -d
	@echo "✨ Environment ready:"
	@echo "   DVWA: http://localhost:4280"
	@echo "   Juice Shop: http://localhost:3000"

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f

verify:
	./verify.sh

clean:
	docker-compose down -v
	docker system prune -f
EOF

# 4. Create .env.example
cat > .env.example << 'EOF'
# Project KAVACH Environment Configuration
# Copy to .env and modify as needed

# DVWA Configuration
DVWA_PORT=4280

# Juice Shop Configuration
JUICE_SHOP_PORT=3000

# Optional: Set to 'true' for production deployment
PRODUCTION_MODE=false
EOF

# 5. Create .gitignore if not exists
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
# Docker
*.log
*.pid

# Environment
.env

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Temp files
*.tmp
*.temp
EOF
else
    # Add .env to existing .gitignore if not already there
    if ! grep -q "^.env$" .gitignore; then
        echo ".env" >> .gitignore
    fi
fi

# 6. Create updated README.md
cat > README.md << 'EOF'
# 🔐 Project KAVACH - Meridian FinServe Security Assessment

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://docker.com)
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen)]()
[![Shell](https://img.shields.io/badge/Shell-97.2%25-blue)]()

**Two-Surface Security Assessment:** Network Forensics + Web Application Security  
**Sprint 2-3 Combined Engagement** | IIT Roorkee × Futurense AI Clinic  

---

## 🚀 Quick Start (30 seconds)

```bash
git clone https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach
make up
make verify
