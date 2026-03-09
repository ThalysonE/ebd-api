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

### **Deploy no Railway (recomendado)**

O jeito mais fácil de fazer deploy sem usar a máquina local:

1. Crie uma conta no [Railway](https://railway.app)
2. Crie um novo projeto e clique em **Add a Service > Database > Add PostgreSQL**
3. Clique em **Add a Service > GitHub Repo** e conecte este repositório
4. O Railway vai detectar o `Dockerfile` e o `railway.toml` automaticamente
5. Na aba **Variables** do serviço da API, adicione:
   - `DATABASE_URL` — Use a **reference variable** do PostgreSQL: `${{Postgres.DATABASE_URL}}`
   - `JWT_PUBLIC_KEY` — Chave pública RSA em base64
   - `JWT_PRIVATE_KEY` — Chave privada RSA em base64
6. O Railway atribui a `PORT` automaticamente — não precisa configurar
7. Clique em **Deploy** e pronto!

A cada push na branch `main`, o Railway fará o deploy automaticamente.

### **Deploy com Render.com**

Alternativa usando Render.com:

1. Crie uma conta no [Render.com](https://render.com)
2. Crie um banco de dados PostgreSQL no Render
3. Clique em **New > Blueprint** e conecte este repositório
4. O Render vai detectar o `render.yaml` automaticamente
5. Configure as variáveis de ambiente:
   - `DATABASE_URL` — URL de conexão do PostgreSQL do Render
   - `JWT_PUBLIC_KEY` — Chave pública RSA em base64
   - `JWT_PRIVATE_KEY` — Chave privada RSA em base64
6. Clique em **Apply** e o deploy será feito automaticamente!

A cada push na branch `main`, o Render fará o deploy automaticamente.

### **Deploy com a imagem Docker do GHCR**

A cada push na branch `main`, o CI publica a imagem Docker no GitHub Container Registry:

```sh
docker pull ghcr.io/thalysone/ebd-api:latest
```

Para rodar em qualquer servidor:

```sh
docker run -p 3333:3333 \
  -e DATABASE_URL="postgresql://user:pass@host:5432/ebd?schema=public" \
  -e JWT_PRIVATE_KEY="..." \
  -e JWT_PUBLIC_KEY="..." \
  -e PORT=3333 \
  ghcr.io/thalysone/ebd-api:latest
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
- Build e push da imagem Docker para o GHCR (apenas em push para `main`)

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