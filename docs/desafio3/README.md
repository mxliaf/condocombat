# 🏗️ Desafio 3 — Infraestrutura como Código (IaC) e Continuous Deployment (CD) com Terraform (Versão Mais Recente)

## 🎯 Objetivo

Evoluir a esteira de CI desenvolvida no **Desafio 2** para uma pipeline completa de **CI/CD (Continuous Integration & Continuous Deployment)** utilizando a **versão mais recente do Terraform (`>= 1.10.0` / `latest`)**.

Neste desafio, você utilizará o **Terraform** para provisionar e gerenciar a infraestrutura das 3 camadas da aplicação **CondoCombat** de forma automatizada, utilizando as **imagens Docker do Backend e do Frontend criadas no Desafio 2** e provedores de nuvem que **não exigem cartão de crédito para cadastro**:

1. 🗄️ **Banco de Dados (PostgreSQL)** — Provisionado via IaC no **Supabase** (ou **Neon**)
2. 🏗️ **Backend (FastAPI)** — Deploy da imagem Docker do backend (`condocombat-backend:latest`) no **Render**
3. 🎨 **Frontend (Next.js)** — Deploy da imagem Docker do frontend (`condocombat-frontend:latest`) no **Render**

---

## 🛠️ Providers Escolhidos (100% Gratuitos & Sem Cartão de Crédito)

| Stack | Serviço | Provider Terraform | Necessita Cartão? | Origem do Deploy | Papel no Projeto |
|-------|---------|---------------------|-------------------|------------------|------------------|
| 🗄️ **Database** | Supabase / Neon | `supabase/supabase` ou `kislerdm/neon` | ❌ **Não** | Instância Gerenciada | Banco de Dados PostgreSQL 16 para persistência dos dados do FastAPI. |
| 🏗️ **Backend** | Render | `render-oss/render` | ❌ **Não** | Imagem DockerHub (CI Desafio 2) | Execução da API FastAPI a partir da imagem Docker criada na esteira de CI. |
| 🎨 **Frontend** | Render | `render-oss/render` | ❌ **Não** | Imagem DockerHub (CI Desafio 2) | Execução do Frontend Next.js 14 a partir da imagem Docker criada na esteira de CI. |

---

## 🔑 Como se Cadastrar e Obter Credenciais

### 1. 🗄️ Supabase (Banco de Dados PostgreSQL)
- **Cadastro Gratuitos**: Acesse [Supabase Dashboard](https://supabase.com/dashboard/sign-in) e faça login via **GitHub** (não exige cartão de crédito).
- **Access Token**: Gere em [Account Settings > Access Tokens](https://supabase.com/dashboard/account/tokens) clicando em **Generate new token** (utilizado como `SUPABASE_ACCESS_TOKEN`).
- **Organization ID**: Obtenha em [Supabase Organizations](https://supabase.com/dashboard/organizations) copiando o ID da sua organização (utilizado em `database.tf`).

### 2. 🚀 Render (Backend e Frontend)
- **Cadastro Gratuito**: Acesse [Render Register](https://dashboard.render.com/register) e cadastre-se via **GitHub** (não exige cartão de crédito no plano gratuito).
- **API Key**: Gere em [Account Settings > API Keys](https://dashboard.render.com/u/settings#api-keys) clicando em **Create API Key** (utilizado como `RENDER_API_KEY`).
- **Owner ID**: Localize na tela de **Account Settings** ou na URL do Dashboard (`usr-xxxxxxxxxxxx` / `tea-xxxxxxxxxxxx`), utilizado como `RENDER_OWNER_ID`.

---

## ⚙️ Versão do Terraform

A pipeline de CD está configurada para utilizar a **versão mais recente do Terraform**:

- **No código HCL (`terraform/providers.tf`)**: `required_version = ">= 1.10.0"`
- **No GitHub Actions**: `terraform_version: "latest"` na action `hashicorp/setup-terraform@v3`
- **No GitLab CI/CD**: Imagem de container oficial `hashicorp/terraform:latest`

---

## 🔄 Fluxo da Esteira CI/CD Completa

```
[ Git Push / PR na branch main ]
               │
               ▼
┌────────────────────────────────────────────────────────┐
│ 1. Etapa de CI (Construída no Desafio 2)               │
│    ├── Lint (Ruff / ESLint)                            │
│    ├── Testes (pytest / Vitest)                        │
│    ├── Build das imagens Docker (Backend e Frontend)   │
│    └── Push das 2 imagens para o DockerHub             │
└──────────────────────────┬─────────────────────────────┘
                           │
                           ▼ (Disparo do CD após sucesso no CI)
┌────────────────────────────────────────────────────────┐
│ 2. Etapa de CD com Terraform (Nova no Desafio 3)       │
│    ├── terraform init (Terraform Latest)               │
│    ├── terraform plan                                  │
│    └── terraform apply -auto-approve                   │
└──────────────────────────┬─────────────────────────────┘
                           │
                           ▼
┌────────────────────────────────────────────────────────┐
│ 3. Aplicação CondoCombat no Ar 🚀                      │
│    ├── Database: Supabase PostgreSQL (URL segura SSL)  │
│    ├── Backend: Render Web Service (https://api...)    │
│    └── Frontend: Render Web Service (https://web...)   │
└──────────────────────────┘
```

---

## ⚠️ Guia da Plataforma de CI/CD

Escolha o guia de acordo com a plataforma que você utilizou no Desafio 2:

| Plataforma | Guia de Implementação |
|-----------|------------------------|
| 🐙 **GitHub Actions** | [`README.github.md`](./README.github.md) |
| 🦊 **GitLab CI/CD** | [`README.gitlab.md`](./README.gitlab.md) |

---

## 📚 Referências

- [Terraform Latest Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry — Render Provider](https://registry.terraform.io/providers/render-oss/render/latest/docs)
- [Terraform Registry — Supabase Provider](https://registry.terraform.io/providers/supabase/supabase/latest/docs)
- [Render — Deploying Public Docker Images](https://render.com/docs/docker-images)
