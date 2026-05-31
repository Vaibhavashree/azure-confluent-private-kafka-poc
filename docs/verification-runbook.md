Verification Steps

1. Verify AKS
2. Verify DNS
3. Verify Private Endpoint
4. Verify Topics
5. Verify ACLs
6. Verify Producer
7. Verify Consumer

To ensure the architecture works as intended, complies with strict security frameworks, and is completely isolated from the public internet, execute the following validation matrix from your terminal.

Test A: Private Network Boundary Verification (Negative Test)
This test proves that the Confluent Cloud Dedicated Cluster cannot be accessed via the public internet. Run a connectivity probe to your Confluent bootstrap broker address from your local machine (outside the Azure VNet):

Command:
nc -zv <your-cluster-bootstrap-server>.azure.confluent.cloud 9092
Expected Result: Connection timeout or Connection refused. This confirms that the public internet routing layer is completely blocked and secure.

Test B: Internal Network and DNS Resolution (Positive Test)
This test verifies that the AKS cluster can successfully resolve the Confluent Private Endpoint internally through the Azure Private DNS Zone.

Connect to your newly provisioned AKS compute workspace:

command
az aks get-credentials --resource-group rg-confluent-private-kafka-poc --name aks-cluster-kafka-client

2. Spin up an interactive troubleshooting pod (`kcat`) directly inside the AKS node subnet:
   command
   kubectl run kafka-network-tester -it --rm --image=edenhill/kcat:v1.7.0 --restart=Never -- /bin/sh
Inside the pod terminal, verify DNS resolution to ensure it points to an internal 10.0.x.x private IP address:

command
nslookup <your-cluster-bootstrap-server>.azure.confluent.cloud

---

### Test C: End-to-End Smart Grid Data Plane Validation
Using the interactive terminal inside the `kafka-network-tester` pod from Test B, run the following commands using your generated Kafka Service Account API Key and Secret to validate ingestion and consumption.

#### 1. Inspect Cluster Metadata
Verify that the service account can see your provisioned topics:
commands:
kcat -b <your-cluster-bootstrap-server>.azure.confluent.cloud:9092 \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=PLAIN \
     -X sasl.username="<CLIENT_API_KEY>" \
     -X sasl.password="<CLIENT_API_SECRET>" \
     -L
Expected Result: The metadata output lists both grid-alerts and meter-readings topics successfully.

2. Test Ingestion on grid-alerts (Producer Mode)
Simulate a high-priority substation grid alert payload:

command:
echo '{"substation_id": "SUB_042", "event": "Transformer Overheating", "severity": "CRITICAL"}' | \
kcat -b <your-cluster-bootstrap-server>.azure.confluent.cloud:9092 \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=PLAIN \
     -X sasl.username="<CLIENT_API_KEY>" \
     -X sasl.password="<CLIENT_API_SECRET>" \
     -P -t grid-alerts
3. Test Consumption on grid-alerts (Consumer Mode)
Read back the event from the private cluster to confirm end-to-end routing works perfectly:

command:
kcat -b <your-cluster-bootstrap-server>.azure.confluent.cloud:9092 \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=PLAIN \
     -X sasl.username="<CLIENT_API_KEY>" \
     -X sasl.password="<CLIENT_API_SECRET>" \
     -C -t grid-alerts -c 1
Expected Result: The console cleanly outputs the JSON payload: {"substation_id": "SUB_042", "event": "Transformer Overheating", "severity": "CRITICAL"}.

4. Test Ingestion on meter-readings (Producer Mode)
Simulate an automated smart-meter telemetry payload:

command:
echo '{"meter_id": "MTR_9912", "kwh_reading": 412.85, "timestamp": 1717142400}' | \
kcat -b <your-cluster-bootstrap-server>.azure.confluent.cloud:9092 \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=PLAIN \
     -X sasl.username="<CLIENT_API_KEY>" \
     -X sasl.password="<CLIENT_API_SECRET>" \
     -P -t meter-readings
