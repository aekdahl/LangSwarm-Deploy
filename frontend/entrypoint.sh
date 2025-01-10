#!/bin/sh

# Generate the runtime config.js file with environment variables
cat <<EOF > /usr/share/nginx/html/config.js
window._env_ = {
  REACT_APP_BACKEND_URL: "${REACT_APP_BACKEND_URL}"
};
EOF
