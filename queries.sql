SELECT *
FROM api_requests
ORDER BY timestamp DESC;

SELECT
service_name,
AVG(response_time_ms)
FROM api_requests
GROUP BY service_name;

SELECT
time_bucket('5 minutes', timestamp),
COUNT(*)
FROM api_requests
GROUP BY 1
ORDER BY 1;

SELECT
endpoint,
MAX(response_time_ms)
FROM api_requests
GROUP BY endpoint
ORDER BY MAX(response_time_ms) DESC;

SELECT
status_code,
COUNT(*)
FROM api_requests
GROUP BY status_code;