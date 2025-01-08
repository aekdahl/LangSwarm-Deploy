# Use an official lightweight Python image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy package files
COPY langswarm-core/ ./langswarm-core/
COPY langswarm-backend/ ./langswarm-backend/

# Install dependencies
RUN pip install ./langswarm-core ./langswarm-backend

# Set environment variables
ENV APP_PORT=8080

# Expose the application port
EXPOSE 8080

# Start the backend application
CMD ["python", "-m", "langswarm-backend.main"]
