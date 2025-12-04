# Guacamole Recording Player - Docker Image

Docker image repository for **Guacamole Recording Player - Caixa Edition**.

This repository contains scripts and instructions for building, exporting, and distributing the Docker image of the Guacamole Recording Player customized with Caixa Econômica Federal branding.

---

## 🐳 Quick Start

### Pull and Run (quando disponível)

```bash
# Pull the image
docker pull ghcr.io/wanzellerrp/guacplayer-caixa:latest

# Run the container
docker run -d -p 8080:80 ghcr.io/wanzellerrp/guacplayer-caixa:latest

# Access the application
open http://localhost:8080/guacplayer-caixa/
```

---

## 🛠️ Building from Source

### Prerequisites

- Docker installed
- Git installed
- Maven 3.8+ (for building the application)

### Build Instructions

```bash
# 1. Clone the source repository
git clone https://github.com/WanzellerRP/guacplayer.git
cd guacplayer

# 2. Build the project with Maven
mvn clean package -DskipTests

# 3. Build the Docker image
docker build -t guacplayer-caixa:latest .

# 4. Run the container
docker run -d -p 8080:80 guacplayer-caixa:latest
```

---

## 📦 Exporting and Saving the Image

### Export as TAR file

```bash
# Save the image to a tar file
docker save guacplayer-caixa:latest -o guacplayer-caixa-image.tar

# Compress with gzip
gzip guacplayer-caixa-image.tar

# Result: guacplayer-caixa-image.tar.gz
```

### Export as 7z (maximum compression)

```bash
# Save the image
docker save guacplayer-caixa:latest -o guacplayer-caixa-image.tar

# Compress with 7zip (maximum compression)
7z a -t7z -mx=9 guacplayer-caixa-image.tar.7z guacplayer-caixa-image.tar

# Clean up uncompressed tar
rm guacplayer-caixa-image.tar
```

---

## 📥 Loading the Image

### From TAR file

```bash
# Decompress if needed
gunzip guacplayer-caixa-image.tar.gz

# Load the image
docker load -i guacplayer-caixa-image.tar

# Verify
docker images | grep guacplayer-caixa
```

### From 7z file

```bash
# Extract the tar file
7z x guacplayer-caixa-image.tar.7z

# Load the image
docker load -i guacplayer-caixa-image.tar

# Clean up
rm guacplayer-caixa-image.tar
```

---

## 🚀 Usage

### Run with custom port

```bash
docker run -d -p 3000:80 guacplayer-caixa:latest
```

### Run with volume mount (for custom configurations)

```bash
docker run -d \
  -p 8080:80 \
  -v /path/to/custom/nginx.conf:/etc/nginx/conf.d/default.conf \
  guacplayer-caixa:latest
```

### Run with environment variables

```bash
docker run -d \
  -p 8080:80 \
  -e TZ=America/Sao_Paulo \
  guacplayer-caixa:latest
```

---

## 📋 Image Details

| Property | Value |
|----------|-------|
| **Base Image** | nginx:alpine |
| **Application** | Guacamole Recording Player |
| **Customization** | Caixa Econômica Federal branding |
| **Base-href** | /guacplayer-caixa/ |
| **Port** | 80 |
| **Size** | ~50 MB (compressed: ~20 MB) |

---

## 🎨 Customizations

The Docker image includes:

- ✅ **Caixa institutional colors** (blue #0644ab, orange #e67817)
- ✅ **Caixa logo** in the top-right corner
- ✅ **Base-href** configured for `/guacplayer-caixa/`
- ✅ **Minified assets** for optimal performance
- ✅ **Nginx configuration** optimized for SPA

---

## 📖 Documentation

For more information about the application:

- **Source Repository**: [github.com/WanzellerRP/guacplayer](https://github.com/WanzellerRP/guacplayer)
- **Installation Guide**: [GUIA_INSTALACAO.md](https://github.com/WanzellerRP/guacplayer/blob/main/GUIA_INSTALACAO.md)
- **Customization Details**: [ALTERACOES_CAIXA.md](https://github.com/WanzellerRP/guacplayer/blob/main/ALTERACOES_CAIXA.md)

---

## 🔧 Troubleshooting

### Container won't start

```bash
# Check logs
docker logs <container_id>

# Check if port is already in use
lsof -i :8080
```

### Application not accessible

```bash
# Verify container is running
docker ps | grep guacplayer-caixa

# Test from inside the container
docker exec -it <container_id> wget -O- http://localhost/guacplayer-caixa/
```

### Image too large

```bash
# Check image size
docker images guacplayer-caixa

# Clean up unused layers
docker image prune
```

---

## 📊 Build Scripts

### Automated Build Script

```bash
#!/bin/bash
# build-and-export.sh

set -e

echo "Building Guacplayer Caixa Docker Image..."

# Clone source
git clone https://github.com/WanzellerRP/guacplayer.git
cd guacplayer

# Build with Maven
mvn clean package -DskipTests

# Build Docker image
docker build -t guacplayer-caixa:latest .

# Export image
docker save guacplayer-caixa:latest -o ../guacplayer-caixa-image.tar

# Compress
cd ..
7z a -t7z -mx=9 guacplayer-caixa-image.tar.7z guacplayer-caixa-image.tar

# Clean up
rm guacplayer-caixa-image.tar

echo "Done! Image saved to: guacplayer-caixa-image.tar.7z"
```

---

## 🌐 Deployment

### Docker Compose

```yaml
version: '3.8'

services:
  guacplayer:
    image: guacplayer-caixa:latest
    ports:
      - "8080:80"
    restart: unless-stopped
    environment:
      - TZ=America/Sao_Paulo
```

### Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: guacplayer-caixa
spec:
  replicas: 2
  selector:
    matchLabels:
      app: guacplayer-caixa
  template:
    metadata:
      labels:
        app: guacplayer-caixa
    spec:
      containers:
      - name: guacplayer
        image: guacplayer-caixa:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: guacplayer-service
spec:
  selector:
    app: guacplayer-caixa
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
```

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.1.0-1 | 2025-12-04 | Initial Docker image with Caixa branding |

---

## 🆘 Support

- **Issues**: [github.com/WanzellerRP/guacplayer/issues](https://github.com/WanzellerRP/guacplayer/issues)
- **Source Code**: [github.com/WanzellerRP/guacplayer](https://github.com/WanzellerRP/guacplayer)

---

## 📄 License

This project is based on Apache Guacamole Player and follows the same licensing terms.

---

## ✅ Checklist for Building and Distributing

- [ ] Clone source repository
- [ ] Build with Maven (`mvn clean package -DskipTests`)
- [ ] Build Docker image (`docker build -t guacplayer-caixa:latest .`)
- [ ] Test the image locally (`docker run -p 8080:80 guacplayer-caixa:latest`)
- [ ] Export image (`docker save guacplayer-caixa:latest -o image.tar`)
- [ ] Compress with 7z (`7z a -t7z -mx=9 image.tar.7z image.tar`)
- [ ] Upload to GitHub Releases or container registry
- [ ] Update documentation with download links

---

**Ready for deployment!** 🚀
