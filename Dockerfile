FROM node:24-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:24-alpine AS production

# Set working directory
WORKDIR /app

# Copy built app from build stage
COPY --from=build /app .

# Expose port (assuming server.js listens on 8080 or similar; adjust if needed)
EXPOSE 8080

# Command to run the server
CMD ["node", "server.js"]