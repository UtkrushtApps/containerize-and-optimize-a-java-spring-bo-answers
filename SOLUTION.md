# Solution Steps

1. 1. Create a multi-stage Dockerfile: use an OpenJDK 17 (Temurin) base for build and a slimmer JRE base for runtime; copy only the built jar for a minimal runtime image.

2. 2. In the Dockerfile, set JVM memory optimizations using JAVA_OPTS, configure for non-root security, and expose the app port.

3. 3. Create a docker-compose.yml with two services: 'db' (PostgreSQL) and 'app' (Spring Boot), wiring environment variables for credentials and database settings.

4. 4. Set database volumes, secure credentials, healthchecks, and strict resource limits/quotas (cpus/memory/reservations) for both containers.

5. 5. Configure robust logging for the app container with log rotation using docker's json-file driver options.

6. 6. In application.properties, parameterize the database URL, user, and password to use environment variables provided by Docker; default values allow local dev.

7. 7. For concurrency, add a property videoenc.threadpool.size in application.properties, default 8, that can be overridden by an env variable (VIDEOENC_THREADPOOL_SIZE).

8. 8. (If not already present) In your Java code, reference the thread pool size from videoenc.threadpool.size property (not asked to code here).

9. 9. Ensure the JDBC driver (postgresql) is included as a dependency in your pom.xml for production.

10. 10. Build and run using: 'docker-compose build' then 'docker-compose up' to start both services with proper isolation, resource bounds, and env-driven tuning.

