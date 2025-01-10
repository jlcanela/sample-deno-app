# 316 MB
#FROM denoland/deno:debian-2.1.4

# 222MB
FROM denoland/deno:alpine-2.1.4

# 234 MB
#FROM denoland/deno:distroless-2.1.4 

# Use non-root user for security
#USER deno

# Set working directory
WORKDIR /app

# Cache dependencies separately to leverage Docker layer caching
COPY deno.json ./
RUN deno cache --lock=deno.lock npm:hono

# Copy application code
COPY . .
RUN deno cache app.ts

# Configure runtime
ENV PORT=8000
EXPOSE ${PORT}

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:${PORT}/health || exit 1

# Use production flags for better performance
CMD ["serve", "--no-check", "app.ts"]
