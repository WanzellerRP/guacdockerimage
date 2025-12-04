# Quick Start Guide

## Para Usuários (Usar a Imagem)

### Opção 1: Baixar e Carregar a Imagem

```bash
# 1. Baixar o arquivo da imagem do GitHub Releases
# (Link será disponibilizado quando a release for criada)

# 2. Extrair (se comprimido)
7z x guacplayer-caixa-image.tar.7z
# ou
gunzip guacplayer-caixa-image.tar.gz

# 3. Carregar a imagem no Docker
docker load -i guacplayer-caixa-image.tar

# 4. Executar o container
docker run -d -p 8080:80 guacplayer-caixa:latest

# 5. Acessar
open http://localhost:8080/guacplayer-caixa/
```

### Opção 2: Pull do Registry (quando disponível)

```bash
# Pull da imagem
docker pull ghcr.io/wanzellerrp/guacplayer-caixa:latest

# Executar
docker run -d -p 8080:80 ghcr.io/wanzellerrp/guacplayer-caixa:latest
```

---

## Para Desenvolvedores (Build da Imagem)

### Método Automático (Recomendado)

```bash
# 1. Clonar este repositório
git clone https://github.com/WanzellerRP/guacdockerimage.git
cd guacdockerimage

# 2. Executar o script de build
./build-and-export.sh

# 3. A imagem será construída e exportada para ./exports/
```

### Método Manual

```bash
# 1. Clonar o repositório do código fonte
git clone https://github.com/WanzellerRP/guacplayer.git
cd guacplayer

# 2. Build com Maven
mvn clean package -DskipTests

# 3. Build da imagem Docker
docker build -t guacplayer-caixa:latest .

# 4. Executar
docker run -d -p 8080:80 guacplayer-caixa:latest
```

---

## Exportar a Imagem

### Para compartilhar ou fazer backup:

```bash
# Salvar como TAR
docker save guacplayer-caixa:latest -o guacplayer-caixa-image.tar

# Comprimir com gzip
gzip guacplayer-caixa-image.tar

# OU comprimir com 7zip (melhor compressão)
7z a -t7z -mx=9 guacplayer-caixa-image.tar.7z guacplayer-caixa-image.tar
```

---

## Comandos Úteis

### Verificar imagens
```bash
docker images | grep guacplayer
```

### Ver containers rodando
```bash
docker ps | grep guacplayer
```

### Ver logs do container
```bash
docker logs <container_id>
```

### Parar o container
```bash
docker stop <container_id>
```

### Remover o container
```bash
docker rm <container_id>
```

### Remover a imagem
```bash
docker rmi guacplayer-caixa:latest
```

---

## Troubleshooting

### Porta 8080 já em uso
```bash
# Usar outra porta
docker run -d -p 3000:80 guacplayer-caixa:latest
```

### Permissão negada ao executar script
```bash
chmod +x build-and-export.sh
```

### Docker não encontrado
```bash
# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Maven não encontrado
```bash
# Instalar Maven
sudo apt-get update
sudo apt-get install maven
```

---

## Requisitos

- **Docker**: 20.10+
- **Maven**: 3.8+ (apenas para build)
- **7zip**: 16.02+ (opcional, para compressão)
- **Git**: 2.0+

---

## Suporte

- **Issues**: https://github.com/WanzellerRP/guacplayer/issues
- **Documentação**: https://github.com/WanzellerRP/guacplayer
