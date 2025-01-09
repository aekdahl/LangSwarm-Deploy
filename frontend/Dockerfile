# Use a lightweight base image for serving static files
FROM nginx:stable

# Set an argument for the release URL
ARG RELEASE_URL=https://github.com/aekdahl/LangSwarm-UI/releases/download/v0.0.11/frontend-build.zip

# Set the working directory
WORKDIR /usr/share/nginx/html

# Download and extract the pre-built frontend artifacts
RUN apt-get update && apt-get install -y curl unzip && \
    curl -L -o build.zip ${RELEASE_URL} && \
    unzip -o build.zip && \
    rm build.zip && \
    apt-get remove -y curl unzip && apt-get clean

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
