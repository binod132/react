# Use official Node.js image as a base
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app
# RUN pwd
# RUN ls -al
# Copy package.json and install dependencies
COPY package.json  ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app
RUN npm run build

# Use Nginx to serve the built React app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
