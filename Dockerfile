# Use a lightweight official Python image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements first (for layer caching)
COPY requirements.txt .

# Install Flask
RUN pip install --no-cache-dir -r requirements.txt

# Copy your entire project into the container
COPY . .

# Expose the port Flask runs on
EXPOSE 5000

# Command to start the app
CMD ["python", "app.py"]