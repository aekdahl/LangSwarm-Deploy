# Step 1: Use Node.js image to build the frontend
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Clone the frontend code from a GitHub release or branch
# Replace `TAG` with a version or branch name
ARG REPO_URL=https://github.com/your-org/frontend-repo
ARG TAG=main
RUN git clone --branch ${TAG} ${REPO_URL} /app

# Install dependencies and build the frontend
RUN npm install
RUN npm run build

# Step 2: Use Nginx to serve the built static files
FROM nginx:stable

# Copy the build artifacts
COPY --from=build /app/build /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
