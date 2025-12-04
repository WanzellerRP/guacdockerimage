#!/bin/bash

# Build and Export Script for Guacplayer Caixa Docker Image
# This script automates the process of building and exporting the Docker image

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Guacplayer Caixa - Build & Export${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Configuration
REPO_URL="https://github.com/WanzellerRP/guacplayer.git"
IMAGE_NAME="guacplayer-caixa"
IMAGE_TAG="latest"
EXPORT_DIR="./exports"
TEMP_DIR="./temp"

# Create directories
mkdir -p "$EXPORT_DIR"
mkdir -p "$TEMP_DIR"

# Step 1: Clone repository
echo -e "${YELLOW}[1/6] Cloning source repository...${NC}"
if [ -d "$TEMP_DIR/guacplayer" ]; then
    echo "Repository already exists, pulling latest changes..."
    cd "$TEMP_DIR/guacplayer"
    git pull
    cd ../..
else
    git clone "$REPO_URL" "$TEMP_DIR/guacplayer"
fi
echo -e "${GREEN}✓ Repository cloned${NC}"
echo ""

# Step 2: Build with Maven
echo -e "${YELLOW}[2/6] Building application with Maven...${NC}"
cd "$TEMP_DIR/guacplayer"
mvn clean package -DskipTests
echo -e "${GREEN}✓ Maven build completed${NC}"
echo ""

# Step 3: Build Docker image
echo -e "${YELLOW}[3/6] Building Docker image...${NC}"
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .
echo -e "${GREEN}✓ Docker image built${NC}"
echo ""

# Step 4: Export Docker image
echo -e "${YELLOW}[4/6] Exporting Docker image to TAR...${NC}"
cd ../..
docker save "$IMAGE_NAME:$IMAGE_TAG" -o "$EXPORT_DIR/$IMAGE_NAME-image.tar"
echo -e "${GREEN}✓ Image exported to TAR${NC}"
echo ""

# Step 5: Compress with gzip
echo -e "${YELLOW}[5/6] Compressing with gzip...${NC}"
gzip -f "$EXPORT_DIR/$IMAGE_NAME-image.tar"
echo -e "${GREEN}✓ Image compressed with gzip${NC}"
echo ""

# Step 6: Compress with 7zip (if available)
echo -e "${YELLOW}[6/6] Compressing with 7zip (maximum compression)...${NC}"
if command -v 7z &> /dev/null; then
    # Decompress gzip first
    gunzip "$EXPORT_DIR/$IMAGE_NAME-image.tar.gz"
    
    # Compress with 7zip
    7z a -t7z -mx=9 -mfb=273 -ms -md=31 "$EXPORT_DIR/$IMAGE_NAME-image.tar.7z" "$EXPORT_DIR/$IMAGE_NAME-image.tar"
    
    # Remove uncompressed tar
    rm "$EXPORT_DIR/$IMAGE_NAME-image.tar"
    
    echo -e "${GREEN}✓ Image compressed with 7zip${NC}"
else
    echo -e "${YELLOW}⚠ 7zip not found, skipping 7z compression${NC}"
    echo -e "${YELLOW}  Install with: sudo apt-get install p7zip-full${NC}"
fi
echo ""

# Summary
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Build and Export Completed!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Docker Image: $IMAGE_NAME:$IMAGE_TAG"
echo "Export Directory: $EXPORT_DIR"
echo ""

# List exported files
echo "Exported files:"
ls -lh "$EXPORT_DIR"
echo ""

# Get image size
IMAGE_SIZE=$(docker images "$IMAGE_NAME:$IMAGE_TAG" --format "{{.Size}}")
echo "Docker Image Size: $IMAGE_SIZE"
echo ""

# Instructions
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Test the image:"
echo "   docker run -d -p 8080:80 $IMAGE_NAME:$IMAGE_TAG"
echo ""
echo "2. Load the image on another machine:"
if [ -f "$EXPORT_DIR/$IMAGE_NAME-image.tar.7z" ]; then
    echo "   7z x $IMAGE_NAME-image.tar.7z"
fi
if [ -f "$EXPORT_DIR/$IMAGE_NAME-image.tar.gz" ]; then
    echo "   gunzip $IMAGE_NAME-image.tar.gz"
fi
echo "   docker load -i $IMAGE_NAME-image.tar"
echo ""
echo "3. Upload to GitHub Releases or container registry"
echo ""

echo -e "${GREEN}Done! 🚀${NC}"
