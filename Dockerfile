# Use an official lightweight Python image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install dependencies
RUN pip install langswarm-core langswarm-backend

# Set environment variables
ENV APP_PORT=8080

# Expose the application port
EXPOSE 8080

# Run the backend application
#CMD ["python", "-c", "from langswarm.backend.main import spin_up; spin_up()"]
CMD ["python", "-c", "from langswarm.backend.main import spin_up;"]
