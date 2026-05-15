# ─────────────────────────────────────────────
#  Muhammad Saad Raza — Data Scientist Portfolio
#  Fixed for Google Cloud Run (dynamic PORT)
# ─────────────────────────────────────────────

FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy portfolio HTML
COPY saad_raza_portfolio.html /usr/share/nginx/html/index.html

# Copy custom nginx config that reads PORT env variable
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Expose 8080 (Cloud Run default)
EXPOSE 8080

# Start nginx using envsubst to inject $PORT at runtime
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
