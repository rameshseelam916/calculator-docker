
# Stage 1: Build React application
FROM node:16-alpine AS build

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# Serve React app from root URL
ENV PUBLIC_URL=/

# Build production files
RUN npm run build


# Stage 2: Serve using Nginx
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
