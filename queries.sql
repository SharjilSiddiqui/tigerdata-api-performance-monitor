-- ==========================================================
-- TigerData API Performance Monitor
-- Example analytical queries using TimescaleDB
-- ==========================================================

--------------------------------------------------------------
-- 1. View all API requests
--------------------------------------------------------------

SELECT *
FROM api_requests
ORDER BY timestamp DESC;

--------------------------------------------------------------
-- 2. Average response time per service
--------------------------------------------------------------

SELECT
    service_name,
    AVG(response_time_ms) AS avg_response_time
FROM api_requests
GROUP BY service_name
ORDER BY avg_response_time DESC;

--------------------------------------------------------------
-- 3. Request volume grouped into 5-minute buckets
--------------------------------------------------------------

SELECT
    time_bucket('5 minutes', timestamp) AS bucket,
    COUNT(*) AS request_count
FROM api_requests
GROUP BY bucket
ORDER BY bucket;

--------------------------------------------------------------
-- 4. Slowest API endpoints
--------------------------------------------------------------

SELECT
    endpoint,
    MAX(response_time_ms) AS max_latency
FROM api_requests
GROUP BY endpoint
ORDER BY max_latency DESC;

--------------------------------------------------------------
-- 5. HTTP status code distribution
--------------------------------------------------------------

SELECT
    status_code,
    COUNT(*) AS total_requests
FROM api_requests
GROUP BY status_code
ORDER BY status_code;

--------------------------------------------------------------
-- 6. Average latency over time (per service)
-- Demonstrates time_bucket() with GROUP BY service
--------------------------------------------------------------

SELECT
    time_bucket('5 minutes', timestamp) AS bucket,
    service_name,
    AVG(response_time_ms) AS avg_latency
FROM api_requests
GROUP BY bucket, service_name
ORDER BY bucket, service_name;