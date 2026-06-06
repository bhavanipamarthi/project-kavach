# =============================================
# Project Kavach - Makefile
# One-command shortcuts for development and demo
# =============================================

.PHONY: help up down restart verify logs status clean reset shell dvwa juice

# Default target
help:
	@echo "🚀 Project Kavach - Available Commands"
	@echo "====================================="
	@echo "make up          - Start all services"
	@echo "make down        - Stop all services"
	@echo "make restart     - Restart all services"
	@echo "make verify      - Run environment verification"
	@echo "make logs        - View real-time logs"
	@echo "make status      - Show container status"
	@echo "make clean       - Full cleanup and fresh start"
	@echo "make reset       - Reset environment (down + clean + up)"
	@echo "make dvwa        - Open DVWA shell"
	@echo "make juice       - Open Juice Shop shell"
	@echo "make help        - Show this help message"

# Start services
up:
	@echo "🚀 Starting Project Kavach services..."
	docker compose up -d
	@echo "✅ Services started. Running verification in 10 seconds..."
	@sleep 10
	@$(MAKE) verify

# Stop services
down:
	@echo "🛑 Stopping Project Kavach services..."
	docker compose down
	@echo "✅ All services stopped."

# Restart services
restart:
	@echo "🔄 Restarting Project Kavach services..."
	docker compose restart
	@$(MAKE) status

# Verify environment
verify:
	@echo "🔍 Running environment verification..."
	@chmod +x verify.sh
	./verify.sh

# View logs
logs:
	@echo "📜 Showing real-time logs (Ctrl+C to exit)..."
	docker compose logs -f

# Show status
status:
	@echo "📊 Container Status:"
	docker compose ps

# Full cleanup
clean:
	@echo "🧹 Cleaning up Project Kavach environment..."
	docker compose down -v --rmi local
	docker system prune -f
	@echo "✅ Cleanup completed."

# Full reset (recommended before demo)
reset:
	@echo "🔄 Performing full environment reset..."
	@$(MAKE) down
	@$(MAKE) clean
	@$(MAKE) up

# Access container shells
dvwa:
	@echo "🔐 Opening shell in DVWA container..."
	docker exec -it kavach-dvwa /bin/bash || docker exec -it kavach-dvwa /bin/sh

juice:
	@echo "🔐 Opening shell in Juice Shop container..."
	docker exec -it kavach-juice-shop /bin/sh

# Additional useful targets
rebuild:
	@echo "🔨 Rebuilding containers..."
	docker compose up -d --build

health:
	@echo "❤️  Health Check:"
	docker compose ps
	@echo ""
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:8085/login.php && echo "✅ DVWA is reachable" || echo "❌ DVWA not responding"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:4280 && echo "✅ Juice Shop is reachable" || echo "❌ Juice Shop not responding"
