# Use nginx Alpine image
FROM nginx:alpine

# Copy built app from dist folder
COPY dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]