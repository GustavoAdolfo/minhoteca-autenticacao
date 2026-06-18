![GitHub](https://img.shields.io/github/license/GustavoAdolfo/minhoteca-autenticacao)
![CI](https://github.com/GustavoAdolfo/minhoteca-autenticacao/actions/workflows/ci.yml/badge.svg)

# minhoteca-autenticacao

Sistema de autenticação e cadastro de usuários da Minhoteca, gerenciado com Terraform. Provisiona o AWS Cognito User Pool com customizações de UI, domínio personalizado, triggers Lambda e configurações de segurança.

## 🎯 Propósito Social

Minhoteca tem como missão facilitar o acesso gratuito à leitura, gestão de empréstimos e organização de pequenas bibliotecas em comunidades, ONGs e projetos sociais, contribuindo para os Objetivos de Desenvolvimento Sustentável (ODS) da ONU — especialmente os que tratam de educação de qualidade e redução das desigualdades.

**Alinhamento aos ODS:**

- 🎓 ODS 4: Educação de Qualidade
- 📚 ODS 10: Redução das Desigualdades
- 💚 ODS 17: Parcerias para a Implementação dos Objetivos

## Visão geral

Este repositório contém os módulos Terraform responsáveis por provisionar o sistema de autenticação centralizado da Minhoteca no AWS Cognito. O estado remoto é armazenado em S3 com lock habilitado.

### Principais arquivos

- `envs/prod/` — configuração de ambiente para produção
- `modules/cognito/user-pool.tf` — definição do User Pool com políticas de senha, MFA e recuperação de conta
- `modules/cognito/client.tf` — cliente Cognito com URLs de callback/logout e configuração de tokens
- `modules/cognito/domain.tf` — domínio customizado para o Cognito Hosted UI
- `modules/cognito/ui-customization.tf` — personalização da interface de login com CSS e logo
- `modules/cognito/variables.tf` — variáveis compartilhadas dos módulos

## Estrutura do projeto

```
LICENSE
README.md
envs/
  prod/
modules/
  cognito/
    client.tf
    domain.tf
    ui-customization.tf
    user-pool.tf
    variables.tf
.github/
  workflows/
    ci.yml
```

## ✨ Funcionalidades

- **User Pool Cognito:** Gerenciamento centralizado de usuários com validação de email automática
- **Autenticação MFA:** Suporte a autenticação multi-fator configurável
- **Customização UI:** Interface de login personalizada com logo e CSS da Minhoteca
- **Domínio Customizado:** Hosted UI em domínio próprio (ex: auth.minhoteca.com)
- **Triggers Lambda:** Integração com funções Lambda para eventos de usuário (post-confirmação, pre-autenticação, etc)
- **SES Integration:** Envio de emails transacionais via Amazon SES
- **Proteção contra exclusão:** DeletionProtection ativa em produção
- **Recuperação de conta:** Mecanismos de recuperação via email verificado

## Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.x
- [AWS CLI](https://aws.amazon.com/cli/) configurado com as credenciais adequadas
- Acesso ao bucket S3 `projetos-terraform` para o estado remoto
- Email verificado no AWS SES para envio de mensagens transacionais
- (Opcional) Arquivo CSS para customização da UI de login

## Como executar localmente

1. Inicialize o Terraform apontando para o backend:

```bash
cd envs/prod
terraform init
```

2. Valide a configuração:

```bash
terraform validate
```

3. Visualize o plano de execução:

```bash
terraform plan
```

4. Aplique as mudanças (requer confirmação):

```bash
terraform apply
```

## Pipeline CI/CD

O workflow `.github/workflows/ci.yml` executa automaticamente em pushes e pull requests:

- `build-and-test` — roda `terraform init` e `terraform validate` em toda mudança
- `terraform` — executa `terraform plan` em PRs e `terraform apply` após merge na `main`

## Módulos disponíveis

| Módulo            | Descrição                                                       |
| ----------------- | --------------------------------------------------------------- |
| `modules/cognito` | AWS Cognito User Pool com client, domínio e customizações de UI |

## Variáveis de configuração

O módulo Cognito aceita as seguintes variáveis:

- `default_name` — nome do User Pool e domínio
- `deletion_protection` — proteção contra exclusão (`ACTIVE`/`INACTIVE`)
- `default_email` — email padrão para envio de mensagens
- `reply_to_email_address` — email de resposta para mensagens transacionais
- `ses_verified_email_account` — ARN da conta SES verificada
- `mfa_configuration` — nível de MFA (`OFF`/`OPTIONAL`/`REQUIRED`)
- `arn_lambda_trigger` — ARN da função Lambda para triggers do Cognito
- `css_file_path` — caminho para arquivo CSS de customização
- `logo_file_path` — caminho para arquivo de logo
- `application_tags` — tags aplicadas aos recursos
- `client` — objeto com configurações do cliente (tokens, URLs, etc)

### Exemplo de uso em `main.tf`:

```hcl
module "cognito" {
  source = "./modules/cognito"

  default_name               = "minhoteca-prod"
  deletion_protection        = "ACTIVE"
  default_email              = "noreply@minhoteca.com"
  reply_to_email_address     = "contato@minhoteca.com"
  ses_verified_email_account = "arn:aws:ses:us-east-1:ACCOUNT_ID:identity/noreply@minhoteca.com"
  mfa_configuration          = "OPTIONAL"
  arn_lambda_trigger         = aws_lambda_function.cognito_triggers.arn

  client = {
    access_token_validity  = 1
    id_token_validity      = 1
    refresh_token_validity = 30
    unit_access_token      = "hours"
    unit_id_token          = "hours"
    unit_refresh_token     = "days"
    callback_urls          = ["https://minhoteca.com/callback"]
    default_redirect       = "https://minhoteca.com"
    logout_urls            = ["https://minhoteca.com/logout"]
  }

  application_tags = {
    Environment = "production"
    Project     = "Minhoteca"
  }
}
```

## Backend remoto

O estado é armazenado no S3 com as seguintes configurações:

- Bucket: `projetos-terraform`
- Região: `us-east-1`
- Lock: habilitado com DynamoDB

## Contribuindo

Contribuições são bem-vindas! Por favor, abra uma issue ou pull request com suas sugestões ou correções.

## Licença

Este projeto está licenciado sob a MIT License — veja o arquivo [LICENSE](LICENSE) para detalhes.
