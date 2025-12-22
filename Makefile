EMQX   = docker/emqx.docker-compose.yml
KAFKA  = docker/kafka.docker-compose.yml

network:
	@if ! docker network inspect bridge_network > /dev/null 2>&1; then \
		echo "Network bridge_network not found, creating..."; \
		docker network create --driver=bridge bridge_network; \
	else \
		echo "Network bridge_network already exists."; \
	fi

# ======================== prune ========================  
clean:system volume
	@echo "🧹 Docker cleanup completed."
volume:
	@echo "🧹 Docker volume cleanup completed."
	rm -rf docker/kafka
	docker volume prune -a -f 
system: 
	@echo "🧹 Docker system cleanup completed."
	docker system prune -a -f

# ======================== kafka ========================
kafka-up:network
	@echo "🐳 Starting (Kafka & AKHQ) containers ..."
	mkdir docker/kafka
	chmod -R 777 docker/kafka
	docker compose -f $(KAFKA) up --force-recreate -d --build 
	@echo "✅ (Kafka & AKHQ) are up"

kafka-down:
	@echo "🛑 Stopping (Kafka + AKHQ) containers ..."
	docker compose -f $(KAFKA) down
	@echo "✅ (Kafka + AKHQ) Containers stopped"


# ======================== emqx ========================
emqx-up:network
	@echo "🐳 Starting (EMQX) containers ..."
	docker compose -f $(EMQX) up --force-recreate -d --build 
	@echo "✅ (EMQX) are up"

emqx-down:
	@echo "🛑 Stopping (EMQX) containers ..."
	docker compose -f $(EMQX) down
	@echo "✅ (EMQX) Containers stopped"

# ======================== log ========================  
ps:
	@echo "📋 Checking container status..."
	docker ps -a --filter "name=bridge"

emqx:
	@echo "📜 Showing AKHQ logs..."
	docker logs -f bridge-emqx

kafka:
	@echo "📜 Showing Kafka logs..."
	docker logs -f bridge-kafka

