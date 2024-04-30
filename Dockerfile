# Build stage
FROM node:20-alpine as builder

# Install pnpm
RUN npm install -g pnpm

# Install necessary tools
RUN apk add --no-cache git sed

# Fetch the application source code
WORKDIR /app
RUN git clone -b main https://github.com/livekit-examples/meet.git .

# Add 'standalone' mode configuration to next.config.js
RUN if ! grep -q "output: 'standalone'" next.config.js; then \
  sed -i "/^const nextConfig = {/a \  output: 'standalone'," next.config.js; \
  fi

# Install dependencies
RUN pnpm install

# Set environment variables
ENV NEXT_PUBLIC_LK_TOKEN_ENDPOINT=/api/token

# Build the application
RUN pnpm run build

# Runtime stage
FROM node:20-alpine
WORKDIR /app

# Copy built files and necessary resources
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Set environment variables
ENV PORT 3000
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
