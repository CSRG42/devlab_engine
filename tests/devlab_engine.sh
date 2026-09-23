#!/bin/bash
# ==========================
# AUTO-INSTALAÇÃO E CHECKUP
# ==========================
check_and_install() {
    local CMD=$1
    local PACKAGE=$2
    
    if ! command -v "$CMD" &>/dev/null; then
        echo -e "${YELLOW}🛠️  Instalando $PACKAGE para você...${NC}"
        sudo apt update && sudo apt install "$PACKAGE" -y
        if command -v "$CMD" &>/dev/null; then
            echo -e "${GREEN}✅ $PACKAGE instalado com sucesso!${NC}"
        else
            echo -e "${RED}❌ Falha ao instalar $PACKAGE. Verifique sua conexão.${NC}"
            exit 1
        fi
    else
        echo -e "${BLUE}🔄 $PACKAGE já está instalado. Seguindo...${NC}"
    fi
}

check_and_install "git" "git"
check_and_install "gh" "gh"

printf "\033[H\033[J"

# =========================
# CONFIGURAÇÕES
# =========================
AUTHOR_FILE="César Godinho (CSRG42)"
LICENSE_FILE="MIT License"
BASE_DIR="Core"
VERSION_FILE=".devlab_version"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# =========================
# DEVLAB ENGINE
# =========================
clear
echo -e "${GREEN}┌──────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│                       🚀 DEVLAB ENGINE                   │${NC}"
echo -e "${GREEN}└──────────────────────────────────────────────────────────┘${NC}"

# =========================
# FUNÇÕES DE SUPORTE
# =========================
install_gh() {
    echo -e "${YELLOW}📦 GitHub CLI não encontrado. Tentando instalação automática...${NC}"
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt install gh -y
    elif command -v dnf &>/dev/null; then
        sudo dnf install gh -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm github-cli
    elif command -v brew &>/dev/null; then
        brew install gh
    else
        echo -e "${RED}❌ Sistema não suportado para auto-instalação.${NC}"
        exit 1
    fi
}

# =========================
# CHECK GIT
# =========================
ensure_gh_auth() {
    if ! gh auth status &>/dev/null; then
        echo -e "${YELLOW}🔐 Login no GitHub necessário...${NC}"
        gh auth login || { echo -e "${RED}❌ Falha no login${NC}"; exit 1; }
    fi
}

# =========================
# GERADOR DE HEADER 
# =========================
create_file_with_header() {
    local file="$1"
    shift
    local content=("$@")

    # NÃO recria se já existir
    if [ -f "$file" ]; then
        return
    fi

    if [[ "${content[0]}" =~ ^#! ]]; then
        echo "${content[0]}" > "$file"
        generate_header >> "$file"
        echo "" >> "$file"

        for (( i=1; i<${#content[@]}; i++ )); do
            echo "${content[$i]}" >> "$file"
        done
    else
        generate_header > "$file"
        echo "" >> "$file"

        for line in "${content[@]}"; do
            echo "$line" >> "$file"
        done
    fi
}

generate_header() {
    case $STACK_NAME in

    "Python"|"Bash")
        cat <<EOF

# ==============================================================================
# Project: $PROJECT_SAFE_NAME
# Stack:   $STACK_NAME
# Version: $PROJECT_VERSION
# Author:  $AUTHOR_FILE
# License: $LICENSE_FILE
# Created: $(date +'%d/%m/%Y %H:%M')
# ==============================================================================
EOF
        ;;

    "JavaScript"|"TypeScript"|"Node.js"|"Java"|"CSharp"|"Go"|"Rust"|"Kotlin"|"Swift")
        cat <<EOF
// ==============================================================================
// Project: $PROJECT_SAFE_NAME
// Stack:   $STACK_NAME
// Version: $PROJECT_VERSION
// Author:  $AUTHOR_FILE
// License: $LICENSE_FILE
// Created: $(date +'%d/%m/%Y %H:%M')
// ==============================================================================
EOF
        ;;

    "PHP")
        cat <<EOF
// ==============================================================================
// Project: $PROJECT_SAFE_NAME
// Stack:   $STACK_NAME
// Version: $PROJECT_VERSION
// Author:  $AUTHOR_FILE
// License: $LICENSE_FILE
// Created: $(date +'%d/%m/%Y %H:%M')
// ==============================================================================
EOF
        ;;
    "HTML")
        cat <<EOF
<!-- ==============================================================================
Project: $PROJECT_SAFE_NAME
Stack:   $STACK_NAME
Version: $PROJECT_VERSION
Author:  $AUTHOR_FILE
License: $LICENSE_FILE
Created: $(date +'%d/%m/%Y %H:%M')
============================================================================== -->
EOF
        ;;

    "CSS")
        cat <<EOF
/* ==============================================================================
   Project: $PROJECT_SAFE_NAME
   Stack:   $STACK_NAME
   Version: $PROJECT_VERSION
   Author:  $AUTHOR_FILE
   License: $LICENSE_FILE
   Created: $(date +'%d/%m/%Y %H:%M')
============================================================================== */
EOF
        ;;

    esac
}

# =========================
# VERSION SYSTEM
# =========================

VERSION_FILE=".devlab_version"

get_current_version() {
    if [[ ! -f "$VERSION_FILE" ]]; then
        echo "1.0.0 - init - Projeto criado - $(date +'%d/%m/%Y %H:%M')" > "$VERSION_FILE"
        echo "1.0.0"
        return
    fi

    tail -n 1 "$VERSION_FILE" | cut -d' ' -f1
}

PROJECT_VERSION=$(get_current_version)

increment_version() {
    local CURRENT_V MAJOR MINOR PATCH NEW_VERSION COMMIT_HASH DATE_NOW

    CURRENT_V=$(get_current_version)

    IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_V"

    PATCH=$((PATCH + 1))
    NEW_VERSION="$MAJOR.$MINOR.$PATCH"

    update_file_versions

    COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null || echo "init")
    DATE_NOW=$(date +'%d/%m/%Y %H:%M')

    local SAFE_DESC="${DESC:-Atualização automática}"

    # =========================
    # VERSÃO ATUAL
    # =========================
    echo "$NEW_VERSION" > .devlab_version

    # =========================
    # HISTÓRICO (APPEND)
    # =========================
    echo "$NEW_VERSION - $COMMIT_HASH - $SAFE_DESC - $DATE_NOW" >> .devlab_history

    echo "$NEW_VERSION"
}

# =========================
# INPUT
# =========================
echo -e "${YELLOW}📋 CONFIGURAÇÃO INICIAL${NC}"
read -rp "    📦 Nome do projeto: " INPUT_NAME
PROJECT_NAME=${INPUT_NAME:-"DevLab_Project"}

PROJECT_SAFE_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -cd '[:alnum:]_')

mkdir -p "$BASE_DIR"
PROJECT_PATH="$BASE_DIR/$PROJECT_SAFE_NAME"

if [ -d "$PROJECT_PATH" ]; then
    i=2
    while [ -d "${PROJECT_PATH}_${i}" ]; do ((i++)); done
    PROJECT_SAFE_NAME="${PROJECT_SAFE_NAME}_${i}"
    PROJECT_PATH="${BASE_DIR}/${PROJECT_SAFE_NAME}"
fi

echo -e "\n${GREEN}✅ Identidade definida:${NC}"
echo -e "    📂 Pasta: ${NC}$PROJECT_SAFE_NAME"
echo -e "    📌 Versão: ${NC}$PROJECT_VERSION"
echo -e "${GREEN}------------------------------------------------------------${NC}"
# =========================
# ESCOLHA DE STACK
# =========================
echo -e "${YELLOW}┌──────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│                🧠 SELECIONE A TECNOLOGIA                 │${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────────────────────┘${NC}"
echo -e "  1) HTML      2) CSS       3) JavaScript     4) TypeScript"
echo -e "  5) Node.js   6) Python    7) PHP            8) Ruby"
echo -e "  9) Java      10) Go       11) Rust          12) C#"
echo -e "  13) Flutter  14) Kotlin   15) Swift         16) Bash"
echo -e "${YELLOW}------------------------------------------------------------${NC}"
read -rp "👉 Escolha: " STACK_OPT
STACK_OPT=${STACK_OPT:-16}

mkdir -p "$PROJECT_PATH"/{src,docs,tests,logs,assets,build,releases}
cd "$PROJECT_PATH" || exit 1

# =========================
# TEMPLATES
# =========================
case $STACK_OPT in
    1) STACK_NAME="HTML"; TEST_CMD="echo 'HTML Lint'" ;;
    2) STACK_NAME="CSS"; TEST_CMD="echo 'CSS Lint'" ;;
    3) STACK_NAME="JavaScript"; TEST_CMD="npm test" ;;
    4) STACK_NAME="TypeScript"; TEST_CMD="npm test" ;;
    5) STACK_NAME="Node.js"; TEST_CMD="npm install && npm test" ;;
    6) STACK_NAME="Python"; TEST_CMD="python -m unittest discover" ;;
    7) STACK_NAME="PHP"; TEST_CMD="php -l src/*.php" ;;
    8) STACK_NAME="Ruby"; TEST_CMD="ruby -c src/*.rb" ;;
    9) STACK_NAME="Java"; TEST_CMD="javac src/*.java" ;;
    10) STACK_NAME="Go"; TEST_CMD="go test ./..." ;;
    11) STACK_NAME="Rust"; TEST_CMD="[ -f Cargo.toml ] && cargo test || echo 'Aviso: Cargo.toml não encontrado.'" ;;
    12) STACK_NAME="CSharp"; TEST_CMD="dotnet test" ;;
    13) STACK_NAME="Flutter"; TEST_CMD="flutter test" ;;
    14) STACK_NAME="Kotlin"; TEST_CMD="kotlinc src/*.kt" ;;
    15) STACK_NAME="Swift"; TEST_CMD="swift test" ;;
    16) STACK_NAME="Bash"; TEST_CMD="shellcheck src/*.sh" ;;
    *) STACK_NAME="Vanilla"; TEST_CMD="echo 'No tests defined'" ;;
esac
# =========================
# CRIAÇÃO INICIAL
# =========================
mkdir -p src docs logs build tests assets

case $STACK_OPT in

1) # HTML
    create_file_with_header "src/index.html" \
    "<!DOCTYPE html>" \
    "<html>" \
    "<head>" \
    "    <title>$PROJECT_SAFE_NAME</title>" \
    "</head>" \
    "<body>" \
    "    <h1>🚀 $PROJECT_SAFE_NAME</h1>" \
    "</body>" \
    "</html>"
    ;;

2) # CSS
    create_file_with_header "src/style.css" \
    "body { font-family: Arial; }"
    ;;

3) # JavaScript
    create_file_with_header "src/index.js" \
    "console.log('🚀 $PROJECT_SAFE_NAME');"
    ;;

4) # TypeScript
    create_file_with_header "src/index.ts" \
    "console.log('🚀 $PROJECT_SAFE_NAME');"
    ;;

5) # Node.js
    create_file_with_header "src/index.js" \
    "#!/usr/bin/env node" \
    "console.log('🚀 $PROJECT_SAFE_NAME');"

    chmod +x src/index.js
    echo '{}' > package.json
    ;;

6) # Python
    create_file_with_header "src/main.py" \
    "#!/usr/bin/env python3" \
    "print('🚀 $PROJECT_SAFE_NAME')"

    chmod +x src/main.py
    ;;

7) # PHP
    create_file_with_header "src/index.php" \
    "<?php" \
    "echo '🚀 $PROJECT_SAFE_NAME';" \
    "?>"
    ;;

8) # Ruby
    create_file_with_header "src/main.rb" \
    "#!/usr/bin/env ruby" \
    "puts '🚀 $PROJECT_SAFE_NAME'"

    chmod +x src/main.rb
    ;;

9) # Java
    create_file_with_header "src/Main.java" \
    "public class Main {" \
    "    public static void main(String[] args) {" \
    "        System.out.println(\"🚀 $PROJECT_SAFE_NAME\");" \
    "    }" \
    "}"
    ;;

10) # Go
    create_file_with_header "src/main.go" \
    "package main" \
    "" \
    "import \"fmt\"" \
    "" \
    "func main() {" \
    "    fmt.Println(\"🚀 $PROJECT_SAFE_NAME\")" \
    "}"
    ;;

11) # Rust
    cat <<EOF > Cargo.toml
[package]
name = "$PROJECT_SAFE_NAME"
version = "$PROJECT_VERSION"
authors = ["$AUTHOR_FILE"]
edition = "2021"

[dependencies]
EOF
    create_file_with_header "src/main.rs" \
    "fn main() {" \
    "    println!(\"🚀 $PROJECT_SAFE_NAME\");" \
    "}"
    ;;

12) # C#
    create_file_with_header "src/Program.cs" \
    "using System;" \
    "" \
    "class Program {" \
    "    static void Main() {" \
    "        Console.WriteLine(\"🚀 $PROJECT_SAFE_NAME\");" \
    "    }" \
    "}"
    ;;

13) # Flutter
    mkdir -p lib
    create_file_with_header "lib/main.dart" \
    "void main() {" \
    "  print('🚀 $PROJECT_SAFE_NAME');" \
    "}"
    ;;

14) # Kotlin
    create_file_with_header "src/main.kt" \
    "fun main() {" \
    "    println(\"🚀 $PROJECT_SAFE_NAME\")" \
    "}"
    ;;

15) # Swift
    create_file_with_header "src/main.swift" \
    "print(\"🚀 $PROJECT_SAFE_NAME\")"
    ;;

16) # Bash
    create_file_with_header "src/main.sh" \
    "#!/bin/bash" \
    "echo '🚀 $PROJECT_SAFE_NAME'"

    chmod +x src/main.sh
    ;;

esac
# =========================
# LICENSE
# =========================
cat <<EOF > LICENSES
MIT License (English Version)

Copyright (c) $(date +'%Y') $AUTHOR_FILE

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

------------------------------------------------------------------------------

Licença MIT (Versão em Português)

Copyright (c) $(date +'%Y') $AUTHOR_FILE

A permissão é concedida, gratuitamente, a qualquer pessoa que obtenha uma cópia deste software e dos arquivos de documentação associados (o "Software"), para lidar no Software sem restrição, incluindo, sem limitação, os direitos de usar, copiar, modificar, mesclar, publicar, distribuir, sublicenciar e/ou vender cópias do Software, e permitir que as pessoas a quem o Software é fornecido o façam, mediante as seguintes condições:

O aviso de copyright acima e este aviso de permissão devem ser incluídos em todas as cópias ou partes substanciais do Software.

O SOFTWARE É FORNECIDO "COMO ESTÁ", SEM GARANTIA DE QUALQUER TIPO, EXPRESSA OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO ÀS GARANTIAS DE COMERCIALIZAÇÃO, ADEQUAÇÃO A UM DETERMINADO FIM E NÃO INFRAÇÃO. EM NENHUM CASO OS AUTORES OU TITULARES DE COPYRIGHT SERÃO RESPONSÁVEIS POR QUALQUER RECLAMAÇÃO, DANOS OU OUTRA RESPONSABILIDADE, SEJA EM AÇÃO DE CONTRATO, DELITO OU DE OUTRA FORMA, DECORRENTE DE, FORA DE OU EM CONEXÃO COM O SOFTWARE OU O USO OU OUTRAS NEGOCIAÇÕES NO SOFTWARE.
EOF

# =========================
# CONTRIBUTING
# =========================
cat <<EOF > CONTRIBUTING.md
# 🤝 Contribuindo para $PROJECT_SAFE_NAME

Primeiramente, obrigado por se interessar em contribuir! 

## 📋 Regras de Ouro
1. **Branches:** Crie uma branch para sua feature (\`git checkout -b feature/minha-feature\`).
2. **Commits:** Siga o padrão de [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
3. **Pull Requests:** Abra um PR descrevendo suas mudanças detalhadamente.

## 🚀 Processo
- Faça o Fork do projeto
- Commit suas mudanças
- Push para a Branch
- Abra um Pull Request
EOF

# =========================
# CODE OF CONDUCT
# =========================
cat <<EOF > CODE_OF_CONDUCT.md
# Código de Conduta

## Nosso Compromisso
Nós, como membros, contribuintes e líderes, nos comprometemos a tornar a participação em nosso projeto e nossa comunidade uma experiência livre de assédio para todos.

## Nossos Padrões
- Use linguagem acolhedora e inclusiva.
- Respeite pontos de vista diferentes.
- Aceite críticas construtivas com elegância.
- Foque no que é melhor para a comunidade.

*Para mais detalhes, consulte o Contributor Covenant.*
EOF

# =========================
# CHANGELOG
# =========================
cat <<EOF > CHANGELOG.md
# 📜 Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.


## [$PROJECT_VERSION] - $(date +'%Y-%m-%d')
### 🚀 Inicial
- Início de projeto
- Estrutura inicial do projeto $PROJECT_SAFE_NAME com o DevLab CLI.
- Configuração de CI/CD (GitHub Actions).
- Headers de licença MIT e bilingue.

### 🛠️ Alterado
- Stack definida para: $STACK_NAME.
EOF

# =========================
# README
# =========================
cat <<EOF > README.md
# 🚀 $PROJECT_SAFE_NAME

> **Stack:** $STACK_NAME | **Versão:** $PROJECT_VERSION | **Licença:** $LICENSE_FILE

O **$PROJECT_SAFE_NAME** é um projeto estruturado automaticamente através do ecossistema **DevLab Engine**, garantindo padrões de desenvolvimento profissionais e organização modular.

---
EOF
cat <<'EOF' >> README.md

## 📂 Estrutura de Diretórios

A arquitetura do projeto segue o padrão de separação de responsabilidades para garantir escalabilidade:

| Pasta       | Função           | Descrição                                              |
| :---------- | :--------------- | :----------------------------------------------------- |
| `src/`      | **Source**       | Onde fica o código principal e os scripts de execução. |
| `docs/`     | **Documentação** | Manuais, guias e referências do projeto.               |
| `tests/`    | **Testes**       | Scripts de validação e unit tests.                     |
| `logs/`     | **Registros**    | Logs de execução, erros e depuração.                   |
| `assets/`   | **Recursos**     | Arquivos estáticos (imagens, CSS, ícones).             |
| `build/`    | **Build**        | Código compilado ou minificado para produção.          |
| `releases/` | **Releases**     | Versões finais empacotadas para distribuição.          |

---

## 🎨 Padronização de Commits (Conventional Commits)

Este projeto utiliza emojis e prefixos padronizados para manter um histórico de alterações legível e organizado:

| Tipo                | Descrição                         | Tipo                | Descrição                         |
| :------------------ | :-------------------------------- | :------------------ | :-------------------------------- |
| 🚀 **Adicionado**   | Nova funcionalidade/recurso       | 🐛 **Corrigido**    | Correção de bugs ou erros         |
| 🛠️ **Manutenção**  | Manutenção geral e chores         | ♻️ **Refatorado**   | Melhorias no código existente     |
| ⚡ **Performance**   | Otimização de velocidade/recursos | 🎨 **Estilo**       | Formatação e ajustes visuais      |
| 📝 **Documentação** | Atualizações no README ou docs    | 🧪 **Testes**       | Criação ou ajuste de testes       |
| 🔧 **Build**        | Mudanças no sistema de build      | ⚙️ **CI/CD**        | Workflows e integração contínua   |
| 🔙 **Reversão**     | Reverter commits anteriores       | 🔥 **Inicial**      | Início do projeto/First commit    |
| 🔐 **Segurança**    | Patches e chaves de segurança     | 📦 **Dependências** | Atualização de pacotes/libs       |
| 🌐 **Traduções**    | Localização e idiomas             | 📎 **Assets**       | Manipulação de arquivos estáticos |

## 🤖 Automação DevLab
As operações realizadas pelo **DevLab Git Manager** incluem ícones contextuais (🔄 Sincronização, ⬆️ Push, ⬇️ Pull) para facilitar o rastreio via CLI.

---
EOF

cat <<EOF >> README.md

## 🛠️ Tecnologias e Ferramentas

- **Linguagem Base:** $STACK_NAME
- **Gerenciador de Versão:** DevLab Version System
- **CI/CD:** GitHub Actions
- **Git Flow:** Integrado com GitHub CLI

---

## 📦 Identificadores de Operação
| Emoji | Tag         | Descrição                                |
| :---- | :---------- | :--------------------------------------- |
| 🔄    | **SYNC**    | Sincronização geral (Pull + Push).       |
| ⬆️    | **PUSH**    | Envio de dados para o servidor remoto.   |
| ⬇️    | **PULL**    | Recebimento de dados do remoto.          |
| ✅     | **SUCCESS** | Operação concluída com êxito.            |
| ❌     | **ERROR**   | Falha crítica no processo.               |
| 🤖    | **AUTO**    | Processo automatizado via script DevLab. |

---
## 🚀 Como usar

1. Clone o repositório
2. Instale as dependências se houver
3. Execute o projeto via src/

---

## 👨‍💻 Developed by
**$AUTHOR_FILE**

## 🌐 Links
- [GitHub](https://github.com/#)
- [Instagram](https://instagram.com/#/)
- [YouTube](https://youtube.com/#)

---

*Criado em: $(date +'%d/%m/%Y %H:%M')*

EOF

# =========================
# GERAÇÃO DO GITHUB ACTIONS
# =========================
mkdir -p .github/workflows
cat <<EOF > .github/workflows/ci.yml
name: DevLab CI

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Run Stack Tests
        run: |
          echo "Iniciando testes para $STACK_NAME..."
          
          if [[ "$STACK_NAME" == "Rust" && -f "Cargo.toml" ]]; then
            cargo test
          elif [[ "$STACK_NAME" == "Node.js" && -f "package.json" ]]; then
            npm test
          elif [[ "$STACK_NAME" == "Python" ]]; then
            python3 -m unittest discover tests
          elif [[ "$STACK_NAME" == "Bash" ]]; then
            # -s bash: força o padrão do seu sistema
            # -e SC1128: ignora o erro de shebang/linha 1
            shellcheck -s bash -e SC1128 src/*.sh
          else
            echo "⚠️  Nenhum teste específico configurado ou arquivo de manifesto ausente. Pulando..."
          fi
EOF

# ==============================================================================
#                             DEVLAB GIT MANAGER
# ==============================================================================
cat <<'EOF' > devlab_git_manager.sh

EOF
chmod +x devlab_git_manager.sh

# =========================
# CI/CD & GIT
# =========================
mkdir -p .github/workflows
cat <<EOF > .github/workflows/ci.yml
name: CI - $PROJECT_SAFE_NAME
on:
  push:
    branches: [ "main" ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: $TEST_CMD
EOF
# =========================
# GIT & GITHUB FLOW
# =========================
echo -e "\n${YELLOW}⚙️ CONFIGURAÇÕES DE DEPLOY:${NC}"
read -rp "    > Criar no GitHub? (y/n): " CREATE_GH

if [[ "$CREATE_GH" =~ ^[Yy]$ ]]; then

    GIT_USER=$(git config --global user.name)
    GIT_EMAIL=$(git config --global user.email)

    if [[ -z "$GIT_USER" || -z "$GIT_EMAIL" ]]; then
        echo -e "\n${YELLOW}👤 Identidade Git não encontrada! Necessário para o GitHub.${NC}"
        read -rp "   📧 E-mail do GitHub: " NEW_EMAIL
        read -rp "   👤 Nome de Usuário: " NEW_NAME
        git config --global user.email "$NEW_EMAIL"
        git config --global user.name "$NEW_NAME"
    fi

    ensure_gh_auth
fi

git init &>/dev/null
git branch -M main &>/dev/null
git add .
git commit -m "🔥 init: ($PROJECT_SAFE_NAME) | $STACK_NAME | v$PROJECT_VERSION | Início de projeto" &>/dev/null

if [[ "$CREATE_GH" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}🌐 Verificando repositório remoto...${NC}"
    
    if gh repo create "$PROJECT_SAFE_NAME" --private --source=. --remote=origin &>/dev/null; then
        git push -u origin main &>/dev/null
        echo -e "${GREEN}✅ Repositório criado e sincronizado!${NC}"
    else
        echo -e "${YELLOW}⚠️  Repo já existe. Sincronizando com cautela...${NC}"
        GH_USER=$(gh api user -q .login)
        git remote add origin "https://github.com/$GH_USER/$PROJECT_SAFE_NAME.git" 2>/dev/null
        
        git fetch origin main &>/dev/null
        
        git merge origin/main --allow-unrelated-histories -X ours -m "📡 integração: Repositório local e remoto sincronizados" &>/dev/null
        
        git push -u origin main &>/dev/null
        echo -e "${GREEN}✅ Vinculado e protegido contra conflitos!${NC}"
    fi
fi

# =========================
# FINALIZAÇÃO
# =========================
echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│    🚀 DEVLAB FINALIZADO COM SUCESSO!     │${NC}"
echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
echo -e " 📍 LOCAL:   ${NC}$PROJECT_PATH"
echo -e " 📌 VERSÃO:  ${NC}$PROJECT_VERSION"
echo -e " 🧠 STACK:   ${NC}$STACK_NAME"
echo -e " 🛠️  GIT MGR: ${NC}./devlab_git_manager.sh"
echo -e "${GREEN}------------------------------------------------------------${NC}"