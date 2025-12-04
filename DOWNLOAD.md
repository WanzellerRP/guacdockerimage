# Download da Imagem Docker

A imagem Docker do **Guacplayer Caixa** está disponível para download através do GitHub Releases.

---

## 📦 Arquivo Disponível

**Nome**: `guacplayer-caixa-image.tar.7z`  
**Tamanho**: ~27 MB  
**Formato**: 7z (compressão máxima)  
**Conteúdo**: Imagem Docker completa pronta para load

---

## 🔗 Download

### Opção 1: GitHub Releases (Recomendado)

```bash
# Download direto via wget
wget https://github.com/WanzellerRP/guacdockerimage/releases/download/v1.0.0/guacplayer-caixa-image.tar.7z

# OU via curl
curl -L -O https://github.com/WanzellerRP/guacdockerimage/releases/download/v1.0.0/guacplayer-caixa-image.tar.7z
```

### Opção 2: GitHub CLI

```bash
gh release download v1.0.0 --repo WanzellerRP/guacdockerimage --pattern "guacplayer-caixa-image.tar.7z"
```

### Opção 3: Navegador

Acesse: https://github.com/WanzellerRP/guacdockerimage/releases/latest

---

## 🚀 Como Usar

### 1. Extrair o arquivo

```bash
# Instalar 7zip se necessário
sudo apt-get install p7zip-full

# Extrair
7z x guacplayer-caixa-image.tar.7z
```

### 2. Carregar a imagem no Docker

```bash
docker load -i guacplayer-caixa-image.tar
```

### 3. Verificar a imagem

```bash
docker images | grep guacplayer-caixa
```

### 4. Executar o container

```bash
docker run -d -p 8080:80 guacplayer-caixa:latest
```

### 5. Acessar a aplicação

```
http://localhost:8080/guacplayer-caixa/
```

---

## 📊 Detalhes da Imagem

| Propriedade | Valor |
|-------------|-------|
| **Nome** | guacplayer-caixa |
| **Tag** | latest |
| **Base Image** | nginx:alpine |
| **Tamanho (descomprimido)** | ~28 MB |
| **Tamanho (comprimido 7z)** | ~27 MB |
| **Porta** | 80 |
| **Base-href** | /guacplayer-caixa/ |

---

## 🔧 Comandos Úteis

### Limpar arquivo tar após load

```bash
rm guacplayer-caixa-image.tar
```

### Parar o container

```bash
docker stop $(docker ps -q --filter ancestor=guacplayer-caixa:latest)
```

### Remover a imagem

```bash
docker rmi guacplayer-caixa:latest
```

### Exportar novamente (se necessário)

```bash
docker save guacplayer-caixa:latest -o guacplayer-caixa-image.tar
```

---

## 🌐 Alternativas

### Build from Source

Se preferir compilar a imagem você mesmo:

```bash
# Clonar repositório
git clone https://github.com/WanzellerRP/guacplayer.git
cd guacplayer

# Build com Maven
mvn clean package -DskipTests

# Build da imagem Docker
docker build -t guacplayer-caixa:latest .
```

### Pull do Registry (futuro)

Quando disponível no GitHub Container Registry:

```bash
docker pull ghcr.io/wanzellerrp/guacplayer-caixa:latest
```

---

## ❓ Troubleshooting

### Erro ao extrair com 7zip

```bash
# Verificar se o arquivo foi baixado completamente
ls -lh guacplayer-caixa-image.tar.7z

# Deve mostrar ~27 MB
```

### Erro ao carregar no Docker

```bash
# Verificar se o Docker está rodando
sudo systemctl status docker

# Iniciar se necessário
sudo systemctl start docker
```

### Imagem não aparece após load

```bash
# Listar todas as imagens
docker images

# Procurar por guacplayer
docker images | grep -i guac
```

---

## 📝 Notas

- O arquivo `.tar.7z` não está incluído no repositório Git devido ao tamanho (>25 MB)
- Use GitHub Releases para download
- Após o load, a imagem estará disponível localmente no Docker
- A imagem pode ser redistribuída internamente via registry privado

---

## 🆘 Suporte

- **Issues**: https://github.com/WanzellerRP/guacplayer/issues
- **Documentação**: https://github.com/WanzellerRP/guacplayer
- **Releases**: https://github.com/WanzellerRP/guacdockerimage/releases

---

**Última atualização**: 04 de dezembro de 2025  
**Versão**: 1.0.0
