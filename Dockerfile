# Use Node.js LTS (lightweight Alpine version)
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy application files
COPY . .

# Expose port
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
