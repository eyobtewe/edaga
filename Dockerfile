# Use Node.js v22.13.0 to build the React app
FROM node:22.13.0-alpine AS builder

# Set the working directory
WORKDIR /app 

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install 

# Copy the rest of the app and build it
COPY . . 
RUN npm run build 

# Use Nginx to serve the built React app
FROM nginx:alpine 

# Copy build output from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html 

# Expose port 80
EXPOSE 80 

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


# # Build the Docker image
# docker build -t edaga-frontend .

# # Run the container
# docker run -p 8080:80 my-react-app