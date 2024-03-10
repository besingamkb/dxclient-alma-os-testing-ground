# Use the Alma Linux base image
FROM almalinux:9.3

RUN yum -y update libgcc* libstdc++* glibc* \
    yum -y install java-1.8.0-openjdk \
    yum -y install git \
    yum -y install gcc gcc-c++ \
    yum -y install libgcc*i686 libstdc++*i686 glibc*i686 \
    yum -y install unzip \
    yum -y install zip

# Update package repository and install Node.js 18, npm, and make
RUN curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - && \
    yum install -y nodejs make && \
    yum clean all

# Display Node.js and npm versions
RUN node -v && npm -v

# Install Xvfb
#RUN dnf -y install xorg-x11-server-Xvfb libatk-bridge-2.0.so.0 atk java-atk-wrapper at-spi2-atk gtk3 libXt libdrm mesa-libgbm
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

