CREATE TABLE api_requests (
    timestamp TIMESTAMPTZ NOT NULL,
    endpoint TEXT,
    method TEXT,
    status_code INT,
    response_time_ms INT,
    service_name TEXT
)
WITH (
    tsdb.hypertable,
    tsdb.segmentby='service_name',
    tsdb.orderby='timestamp DESC'
);