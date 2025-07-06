# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements file first (so Docker cache works better)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port (internal app port)
EXPOSE 5000

# Run Flask application
CMD ["python", "app.py"]
