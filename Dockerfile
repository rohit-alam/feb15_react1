# Stage 1: Build React app
FROM node:14 AS builder

# Set working directory
WORKDIR /app

# Copy package.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve React app with Apache
FROM httpd:latest

# Copy built files from the first stage to Apache's document root
COPY --from=builder /app/build/ /usr/local/apache2/htdocs/

