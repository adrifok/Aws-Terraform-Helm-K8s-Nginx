FROM node:16

WORKDIR /app

# Copy package.json and package-lock.json files for npm install
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Copy Kubernetes deployment files
COPY ./devops-exercise-front.yaml ./
COPY ./devops-exercise-front-service.yaml ./
COPY ./devops-exercise-back.yaml ./
COPY ./devops-exercise-back-service.yaml ./

# Build the application using the script defined in package.json
RUN npm run build

# Expose the port
EXPOSE 4000 6379

# Command to run the application
CMD ["npm", "start"]
