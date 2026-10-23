FROM python:3.12-slim

WORKDIR /app

# Copy dependencies
COPY requirements.txt .

# Install dependencies during image build
RUN pip install --no-cache-dir -r requirements.txt

# Copy Streamlit application
COPY app.py .

# Create a non-root user and set ownership
RUN useradd --create-home appuser && \
    chown -R appuser:appuser /app

# Run the application as non-root
USER appuser

EXPOSE 8501

CMD ["streamlit", "run", "app.py", \
     "--server.address=0.0.0.0", \
     "--server.port=8501", \
     "--server.headless=true"]