FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: Runtime stage
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local

COPY app.py .

# Ensure Python can find installed packages
ENV PATH=/root/.local/bin:$PATH

# Expose port
EXPOSE 5002

# Run the app
CMD ["python", "app.py"]
