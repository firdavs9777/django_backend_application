# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /code/hello

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the Pipfile and Pipfile.lock to the working directory
COPY code/hello/Pipfile .
COPY code/hello/Pipfile.lock .

# Install pipenv and dependencies
RUN pip install pipenv && pipenv install --system --deploy

# Copy the entire hello project to the container
COPY code/hello/ /code/hello/

# Set the command to run your Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
