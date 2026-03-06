# 🚀 Guia para Rodar a API

## 🐳 Rodando com Docker

Para rodar a API em um ambiente containerizado, siga os passos abaixo:

### **1️⃣ Configurar variáveis de ambiente**
Crie um arquivo `.env` na raiz do projeto com base no `.env.example`:
```sh
cp .env.example .env
```

### **2️⃣ Construir a imagem e subir os containers**
```sh
docker compose up --build -d
```

### **3️⃣ Verificar se os containers estão rodando**
```sh
docker ps
```

### **4️⃣ Parar os containers**
```sh
docker compose down
```

A API estará disponível por padrão em: **http://localhost:3333**

---

## 💻 Rodando para Desenvolvimento

Se você deseja rodar a API localmente sem Docker, com hot reload ativado, siga os passos:

### **1️⃣ Instalar as dependências**
Caso ainda não tenha instalado, rode:
```sh
pnpm install
```

### **2️⃣ Subir o banco de dados com Docker**
```sh
docker compose up -d postgres
```

### **3️⃣ Rodar as migrations**
```sh
pnpm prisma migrate dev
```

### **4️⃣ Executar a API em modo desenvolvimento**
```sh
pnpm run start:dev
```

A API estará rodando com hot reload ativado em: **http://localhost:3333**

---

## 🚀 Deploy em Produção

### **Com Docker**

A imagem Docker utiliza multi-stage build e executa automaticamente as migrations do Prisma ao iniciar. Para fazer o deploy:

1. Defina as variáveis de ambiente (`DATABASE_URL`, `JWT_PRIVATE_KEY`, `JWT_PUBLIC_KEY`, `PORT`)
2. Construa e execute a imagem:

```sh
docker build -t ebd-api .
docker run -p 3333:3333 \
  -e DATABASE_URL="postgresql://user:pass@host:5432/ebd?schema=public" \
  -e JWT_PRIVATE_KEY="..." \
  -e JWT_PUBLIC_KEY="..." \
  -e PORT=3333 \
  ebd-api
```

### **CI/CD**

O projeto inclui um workflow de GitHub Actions (`.github/workflows/ci.yml`) que é executado automaticamente em:
- **Push** para a branch `main`
- **Pull Requests** para a branch `main`

O pipeline realiza:
- Instalação de dependências
- Linting
- Build
- Testes unitários
- Build da imagem Docker (apenas em push para `main`)

---

## 📄 Documentação da API (Swagger)

A documentação da API está disponível no Swagger e pode ser acessada através do seguinte link:

🔗 **[Swagger UI](http://localhost:3333/api)**

---

## 🛢️ Gerenciando o Banco de Dados com Prisma

### **Rodar as migrations**
```sh
pnpm prisma migrate dev
```

### **Executar SEED**
```sh
pnpm prisma db seed
```

### **Ver o banco de dados com Prisma Studio**
```sh
pnpm prisma studio
```