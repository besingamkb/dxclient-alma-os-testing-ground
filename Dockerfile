# Use the Alma Linux base image
FROM almalinux:latest

# Update package repository and install Node.js 18, npm, and make
RUN curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - && \
    yum install -y nodejs make && \
    yum clean all

# Display Node.js and npm versions
RUN node -v && npm -v

# Install Xvfb
RUN dnf -y install xorg-x11-server-Xvfb

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json if present
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# No need to expose port 3000 or specify CMD instruction

