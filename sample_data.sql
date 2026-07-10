INSERT INTO api_requests VALUES
(NOW(), '/auth/login', 'POST', 200, 145, 'Auth Service'),

(NOW()-INTERVAL '2 minutes',
'/auth/login',
'POST',
401,
520,
'Auth Service'),

(NOW()-INTERVAL '5 minutes',
'/functions/deploy',
'POST',
500,
3200,
'Deployment Service'),

(NOW()-INTERVAL '8 minutes',
'/api/projects',
'GET',
200,
98,
'Projects Service'),

(NOW()-INTERVAL '10 minutes',
'/api/projects',
'GET',
200,
102,
'Projects Service'),

(NOW()-INTERVAL '12 minutes',
'/enterprise/users',
'GET',
503,
1900,
'Enterprise Service'),

(NOW()-INTERVAL '15 minutes',
'/enterprise/users',
'GET',
200,
110,
'Enterprise Service');