# 📚 Learnings – TigerData API Performance Monitor

This document captures the concepts I learned while exploring Tiger Cloud and TimescaleDB.

The goal of this project was not simply to complete a tutorial, but to understand how TimescaleDB extends PostgreSQL for time-series workloads.

---

# What is Time-Series Data?

Time-series data is data where every record is associated with a timestamp.

Unlike traditional relational data, the primary goal is to understand how values change over time.

Examples include:

- API request metrics
- Server CPU and memory usage
- Application logs
- IoT sensor readings
- Financial market prices
- GPS tracking
- Kubernetes metrics
- Database monitoring
- Authentication events

In this project, I modeled API request metrics as time-series data.

---

# What is a Hypertable?

A hypertable is TimescaleDB's abstraction over a PostgreSQL table.

Internally, TimescaleDB automatically partitions data into smaller chunks based on time.

Instead of manually creating partitions, developers simply create a hypertable and continue using standard SQL.

Benefits include:

- Faster queries on large datasets
- Automatic time-based partitioning
- Better scalability
- Native PostgreSQL compatibility
- Simpler management

Example:

```sql
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
```

---

# What is time_bucket()?

`time_bucket()` is one of the core TimescaleDB functions.

Instead of grouping by individual timestamps, it groups records into fixed time intervals.

Example:

```sql
SELECT
    time_bucket('5 minutes', timestamp),
    COUNT(*)
FROM api_requests
GROUP BY 1;
```

Instead of seeing every individual request, the data is grouped into five-minute windows, making trends much easier to analyze.

---

# Why Use TimescaleDB Instead of Plain PostgreSQL?

PostgreSQL can store time-series data.

TimescaleDB extends PostgreSQL with features designed specifically for time-series workloads.

Examples include:

- Hypertables
- Automatic chunking
- `time_bucket()`
- Compression
- Continuous aggregates
- Retention policies

This allows developers to continue using PostgreSQL while gaining capabilities optimized for monitoring and analytics.

---

# Project Overview

This project simulates a production API monitoring system.

Each API request contains:

- Timestamp
- Endpoint
- HTTP Method
- Status Code
- Response Time
- Service Name

Example:

| Timestamp | Endpoint          | Status | Response Time |
| --------- | ----------------- | ------ | ------------: |
| 10:00     | /auth/login       | 200    |        145 ms |
| 10:02     | /functions/deploy | 500    |       3200 ms |
| 10:05     | /api/projects     | 200    |         98 ms |

These events naturally form a time-series dataset.

---

# Example Analysis

Using SQL and TimescaleDB, I explored:

- Viewing all API requests
- Average response time by service
- Request volume over time
- Server error frequency
- Slowest API endpoints
- Average latency grouped into time buckets

Example:

```sql
SELECT
    time_bucket('5 minutes', timestamp) AS bucket,
    service_name,
    AVG(response_time_ms) AS avg_latency
FROM api_requests
GROUP BY bucket, service_name
ORDER BY bucket;
```

This type of query can help identify services whose response times increase over time.

---

# Key Takeaways

During this exploration I learned that:

- TimescaleDB extends PostgreSQL instead of replacing it.
- Hypertables automatically manage time-based partitioning.
- Time-series databases are optimized for continuously growing datasets.
- `time_bucket()` simplifies time-based aggregation.
- SQL remains familiar while gaining powerful time-series capabilities.
- Modeling API metrics as time-series data makes production monitoring much easier.

---

# Next Steps

I'd like to continue exploring:

- Continuous Aggregates
- Compression Policies
- Retention Policies
- Query Performance Optimization
- PostgreSQL EXPLAIN / EXPLAIN ANALYZE
- Grafana Dashboards
- Prometheus Integration
- Real production-scale datasets

---

# Reflection

Before applying for the Tiger Data Database Support Engineer role, I wanted to gain practical experience with the platform rather than only reading documentation.

Building this project helped me understand how TimescaleDB models time-series data, how hypertables work, and how SQL can be used to analyze production metrics over time.

This is only a starting point, and I look forward to expanding my PostgreSQL and TimescaleDB knowledge through more hands-on projects.
