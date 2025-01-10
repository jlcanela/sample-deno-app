FROM denoland/deno:alpine-2.1.4

# Use non-root user for security
USER deno

# Set working directory
WORKDIR /app

# Copy configuration files first
COPY deno.json deno.lock ./

# Copy source code
COPY src/ ./src/

# Cache dependencies
RUN deno cache src/app.ts

# Configure runtime
ENV PORT=8000
EXPOSE ${PORT}

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:${PORT}/health || exit 1

# Use production flags for better performance
CMD ["serve", "--no-check", "src/app.ts"]
