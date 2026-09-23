# Use Python 3.11
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Prevent Python from creating .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Prevent Python output buffering
ENV PYTHONUNBUFFERED=1

# Install system dependencies
# ffmpeg is required for audio/video processing
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        git \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for Docker caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY core ./core
COPY utils ./utils
COPY test.py .
COPY packages.txt .

# Streamlit port
EXPOSE 8501

# Start Streamlit
CMD ["streamlit", "run", "test.py", "--server.address=0.0.0.0", "--server.port=8501"]