# Use a lightweight base image for serving static files
FROM nginx:stable

# Set an argument for the release URL
ARG RELEASE_URL=https://github.com/aekdahl/LangSwarm-UI/releases/download/v0.0.23/frontend-build.zip

# Set the working directory
WORKDIR /usr/share/nginx/html

# Download and extract the pre-built frontend artifacts
RUN apt-get update && apt-get install -y curl unzip && \
    curl -L -o build.zip ${RELEASE_URL} && \
    unzip -o build.zip && \
    rm build.zip && \
    apt-get remove -y curl unzip && apt-get clean

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose the default Nginx port
EXPOSE 80

# Run the entrypoint script before starting Nginx
ENTRYPOINT ["/entrypoint.sh"]

# Start Nginx as the main container process
CMD ["nginx", "-g", "daemon off;"]
