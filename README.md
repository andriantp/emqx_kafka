
# EMQX-Kafka

This repository contains a demo / framework for integrating the EMQX MQTT broker with Apache Kafka. The goal is to demonstrate how messages published to EMQX can be forwarded into Kafka topics (and optionally vice-versa) using EMQX’s data integration [features](https://docs.emqx.com/en/emqx/latest/data-integration/data-bridge-kafka.html?). 

---

## 🧪 Manual Test

### Subscribe (receive messages)
```bash
mosquitto_sub -h localhost -p 2883 -u atp -P atp@123 -t emqx_kafka/# -v
```
### Publish (send a message)
```bash
mosquitto_pub -h localhost -p 2883 -u atp -P atp@123 -t emqx_kafka/A001 -m 'hi'
```
You should see messages published via MQTT appear in the subscriber — and, if configured, get forwarded into Kafka topics by EMQX. 

---

## 🔗 Overview

EMQX provides built-in Data Integration (Bridge) support that lets you stream MQTT messages into Kafka topics. It combines:

- A rule engine to filter, enrich, and transform messages;
- A Kafka Sink / Source connector to send or receive data to/from Kafka; and
- Topic mapping so that MQTT topics map to Kafka topics. 


---

## 🚀 How It Works

- MQTT Publishing
Devices publish messages to EMQX using the MQTT protocol.

- Rule Evaluation
EMQX’s rule engine evaluates incoming messages against defined SQL-like rules (e.g., "SELECT * FROM emqx_kafka/#"). If matched, actions are triggered to forward the data. 

- Bridge to Kafka
Using the Kafka Data Bridge, the processed message is mapped and written into Kafka topics for downstream processing. 

---

## 📌 Features

- Seamless MQTT → Kafka streaming with minimal configuration 
- Rule-based filtering and transformation using SQL-like rules 
- Optional bi-directional integration (messages can flow from Kafka into MQTT as well) 
- Flexible topic mapping and filtering 

This architecture is suitable for building real-time IoT pipelines, where lightweight MQTT clients publish data that gets streamed into Kafka for processing, storage, analytics, and more. 
emqx.com

---

## 🛠 Example Use Case

A typical production setup might look like this:
```bash
IoT Devices
    ↓ MQTT
 EMQX MQTT Broker
     (Rule Engine + Data Bridge)
    ↓ Kafka Sink
Kafka Cluster → Consumers/Analytics
```

In this pipeline, EMQX handles millions of connections and high message throughput, while Kafka provides durable streaming and processing capabilities. 
emqx.com

---
## 🔗 Reference

Full article:
[How to Forward MQTT Data from EMQX to Kafka](https://andriantriputra.medium.com/devops-how-to-forward-mqtt-data-from-emqx-to-kafka-6f849f5d4e54)

---

## Author

Andrian Tri Putra
- [Medium](https://andriantriputra.medium.com/)
GitHub
- [andriantp](https://github.com/andriantp)
- [AndrianTriPutra](https://github.com/AndrianTriPutra)

---

## License
Licensed under the Apache License 2.0
