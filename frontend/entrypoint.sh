#!/bin/sh

echo "Starting entrypoint script..."

# Check if REACT_APP_BACKEND_URL is set
if [ -z "$REACT_APP_BACKEND_URL" ]; then
  echo "Warning: REACT_APP_BACKEND_URL is not set. Using default backend URL in config.js."
fi

# Generate the runtime config.js file
cat <<EOF > /usr/share/nginx/html/config.js
window._env_ = {
  REACT_APP_BACKEND_URL: "${REACT_APP_BACKEND_URL}"
};
EOF

echo "config.js created:"
cat /usr/share/nginx/html/config.js

# Start Nginx
echo "Starting Nginx..."
exec "$@"
