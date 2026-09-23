#!/bin/bash
# ==============================================================================
# Project: devlab_engine
# Stack:   Bash
# Version: 1.0.0
# Author:  César Godinho (CSRG42)
# License: MIT License
# Created: 23/09/2026 19:05
# ==============================================================================

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
#!/bin/bash
# =========================
# CONFIGURAÇÕES
# =========================
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
echo -e "${GREEN}│                  🧠 DEVLAB GIT MANAGER                   │${NC}"
echo -e "${GREEN}└──────────────────────────────────────────────────────────┘${NC}"

# =========================
# FUNÇÕES DE SUPORTE
# =========================
pause() {
    echo
    read -rp "Pressione ENTER para continuar..."
}

# =========================================================
# ATUALIZA APENAS HEADERS JÁ GERADOS
# =========================================================
update_file_versions() {
    local FILE

    # pega apenas arquivos modificados
    for FILE in $(git diff --name-only); do

        # ignora se não existir
        [[ ! -f "$FILE" ]] && continue

        if grep -Eq 'Version:[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+' "$FILE"; then

            sed -Ei \
            "s/(Version:[[:space:]]+)[0-9]+\.[0-9]+\.[0-9]+/\1$PROJECT_VERSION/g" \
            "$FILE"

        fi
    done
}

# =========================
# CONTEXTO
# =========================
get_context() {
    # 1. Nome do Repo e Path
    REPO_NAME=$(basename "$PWD")
    LOCAL_PATH=$(pwd)
    
    # 2. Branch e Versão
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
    [[ -z "$CURRENT_BRANCH" ]] && CURRENT_BRANCH="main"
    
    PROJECT_VERSION=$(cat .devlab_version 2>/dev/null || echo "1.0.0")
    VERSION="$PROJECT_VERSION"
    
    # 3. Stack
    STACK_NAME=$(cat .devlab_stack 2>/dev/null || echo "Não Definida")

    # 4. Verificação de Remote e Privacidade baseada exclusivamente no Git local
    REMOTE_URL=$(git remote get-url origin 2>/dev/null)

    if [[ -n "$REMOTE_URL" ]]; then
        DISPLAY_REMOTE="$REMOTE_URL"
        
        # Tenta checar visibilidade sem remover origin em caso de falha
        IS_PRIVATE=$(gh repo view --json isPrivate -q .isPrivate 2>/dev/null)
        if [[ "$IS_PRIVATE" == "true" ]]; then
            PRIVACY_STATUS="PRIVADO"
            PRIVACY_LABEL="PRIVADO"
            COLOR="${GREEN}"
        elif [[ "$IS_PRIVATE" == "false" ]]; then
            PRIVACY_STATUS="PÚBLICO"
            PRIVACY_LABEL="PÚBLICO"
            COLOR="${YELLOW}"
        else
            PRIVACY_STATUS="CONECTADO"
            PRIVACY_LABEL="REMOTO"
            COLOR="${GREEN}"
        fi
    else
        DISPLAY_REMOTE="Não Sincronizado"
        REMOTE_URL="Sem Remote"
        PRIVACY_STATUS="Localhost (sem GH)"
        PRIVACY_LABEL="LOCAL"
        COLOR="${YELLOW}"
    fi
}

# =========================================================
# VERIFICADOR DE AUTENTICAÇÃO E CONEXÃO COM A NUVEM
# =========================================================

ensure_gh_auth() {
    local HAS_SSH=false

    if compgen -G "$HOME/.ssh/id_*" > /dev/null 2>&1; then
        HAS_SSH=true
    fi

    if ! gh auth status &>/dev/null; then
        echo -e "${YELLOW}🔐 Login no GitHub necessário...${NC}"
        
        if [ "$HAS_SSH" = true ]; then
            echo -e "${GREEN}🔑 Chave SSH detectada em ~/.ssh/${NC}"
            echo -e "${BLUE}Iniciando autenticação... (Escolha SSH no menu a seguir)${NC}\n"
        else
            echo -e "${YELLOW}⚠️ Nenhuma chave SSH encontrada em ~/.ssh/${NC}"
            echo -e "${BLUE}Iniciando autenticação via Web/HTTPS...${NC}\n"
        fi

        gh auth login || {
            echo -e "${RED}❌ Falha na autenticação com o GitHub.${NC}"
            return 1
        }
    fi

    return 0
}

startup_check() {
    echo -e "${BLUE}🔍 Executando verificações iniciais...${NC}"

    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo -e "${YELLOW}⚠️ Diretório não é um repositório Git local. Inicializando...${NC}"
        git init -b main &>/dev/null
    fi

    ensure_gh_auth || return 1

    if [ -z "$(git config --global user.email 2>/dev/null)" ]; then
        echo -e "${YELLOW}⚙️ Configurando identidade do Git a partir do GitHub...${NC}"
        local GH_NAME GH_EMAIL GH_LOGIN GH_ID

        GH_LOGIN=$(gh api user -q .login 2>/dev/null)
        GH_NAME=$(gh api user -q '.name // .login' 2>/dev/null)
        GH_EMAIL=$(gh api user -q '.email // empty' 2>/dev/null)

        if [ -z "$GH_EMAIL" ]; then
            GH_ID=$(gh api user -q .id 2>/dev/null)
            GH_EMAIL="${GH_ID}+${GH_LOGIN}@users.noreply.github.com"
        fi

        git config --global user.name "$GH_NAME"
        git config --global user.email "$GH_EMAIL"
        echo -e "${GREEN}✅ Configurado: $GH_NAME <$GH_EMAIL>${NC}"
    fi

    local REPO_NAME GH_USER CURRENT_BRANCH
    REPO_NAME=$(basename "$PWD")
    GH_USER=$(gh api user -q .login 2>/dev/null)
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

    if [[ -z "$GH_USER" ]]; then
        echo -e "${RED}❌ Não foi possível identificar seu usuário do GitHub.${NC}"
        return 1
    fi

    if gh repo view "$GH_USER/$REPO_NAME" &>/dev/null; then
        echo -e "${GREEN}✅ Repositório encontrado no GitHub!${NC}"

        if ! git remote get-url origin &>/dev/null; then
            echo -e "${BLUE}🔗 Vinculando repositório remoto...${NC}"
            if compgen -G "$HOME/.ssh/id_*" > /dev/null 2>&1; then
                git remote add origin "git@github.com:$GH_USER/$REPO_NAME.git"
            else
                git remote add origin "https://github.com/$GH_USER/$REPO_NAME.git"
            fi
        fi
    else
        echo -e "${BLUE}ℹ️ Repositório '${REPO_NAME}' não existe no GitHub (apenas local).${NC}"
    fi

    echo -e "${GREEN}------------------------------------------${NC}"
    sleep 1
}

# Executa o verificador assim que abre o script
startup_check

# =========================
# INPUT / MENU PRINCIPAL
# =========================
while true; do
    printf "\033[H\033[J"
    get_context
    COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null || echo "N/A")

    echo -e "${GREEN}✅ STATUS ATUAL:${NC}"
    echo -e "    📂 Repo:       ${NC}${REPO_NAME}"
    echo -e "    🌿 Branch:     ${NC}${CURRENT_BRANCH}"
    echo -e "    🏷️ Versão:     ${COLOR}${VERSION}${NC} (Commit: ${COMMIT_HASH})"
    echo -e "    🔗 Remote:     ${COLOR}${REMOTE_URL}${NC}"
    echo -e "    🔐 Privacidade: ${COLOR}${PRIVACY_LABEL}${NC}"
    echo -e "${GREEN}------------------------------------------${NC}"

    echo -e "\n${YELLOW}📦 DEVLAB • GIT MANAGER:${NC}"
    echo -e "  1) 🔄 Sincronizar repositório"
    echo -e "  2) 📝 Commit Salvar alterações"
    echo -e "  3) ⬆️ Push Enviar para repositório"
    echo -e "  4) ⬇️ Pull Atualizar repositório local"
    echo -e "  5) 🧾 Log Histórico de Commits"
    echo -e "  6) 🧹 Limpar Cache/Temp"
    echo -e "  7) ⏪ Reset (Seguro)"
    echo -e "  8) ✏️ Renomear repositório"
    echo -e "  9) 🔐 Privacidade do repositório"
    echo -e " 10) 🗑️ Deletar repositório"
    echo -e " 11) ✏️ Corrigir último commit (texto)"
    #echo -e " 12) ☢️ REINICIAR DO ZERO (LIMPAR TUDO)"
    #echo -e " 13) 🚨 ZERAR REPOSITÓRIO (WIPE TOTAL)"
    echo -e "\n  0) 👋 Sair"
    echo -e "${GREEN}------------------------------------------${NC}"
    
    read -p "👉 Escolha: " OPT
    
    case $OPT in
        1) # SINCRONIZAR REPOSITÓRIO
            printf "\033[H\033[J"
            get_context
            ensure_gh_auth

            echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
            echo -e "${GREEN}│        🔄 SINCRONIZAÇÃO INTELIGENTE      │${NC}"
            echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"

            GH_USER=$(gh api user -q .login 2>/dev/null)
            CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
            [[ -z "$CURRENT_BRANCH" ]] && CURRENT_BRANCH="main"

            if git remote | grep -q "origin"; then
                echo -e "${BLUE}📡 Conectando ao GitHub...${NC}"
                git fetch origin >/dev/null 2>&1

                # Se a branch remota existir, alinha o histórico antes
                if git rev-parse --verify "origin/$CURRENT_BRANCH" &>/dev/null; then
                    if ! git rev-parse --verify HEAD &>/dev/null; then
                        git reset --mixed "origin/$CURRENT_BRANCH"
                    fi
                    
                    # Guarda alterações locais temporariamente
                    git stash push -u -m "autostash_sync" >/dev/null 2>&1
                    git pull origin "$CURRENT_BRANCH" --rebase
                    git stash pop >/dev/null 2>&1
                fi
            else
                REPO_EXISTS=$(gh repo view "$GH_USER/$REPO_NAME" --json name -q .name 2>/dev/null)
                if [[ -n "$REPO_EXISTS" ]]; then
                    echo -e "${BLUE}🔗 Vinculando ao repositório existente no GitHub...${NC}"
                    git remote add origin "git@github.com:$GH_USER/$REPO_NAME.git" 2>/dev/null || \
                    git remote add origin "https://github.com/$GH_USER/$REPO_NAME.git"
                    git fetch origin
                    git reset --mixed "origin/main"
                else
                    echo -e "${YELLOW}✨ Criando novo repositório no GitHub...${NC}"
                    gh repo create "$REPO_NAME" --private --source=. --remote=origin
                fi
            fi

            # Realiza o commit das pendências se houver
            if [[ -n $(git status --porcelain) ]]; then
                echo -e "${BLUE}📦 Salvando alterações locais...${NC}"
                git add .
                git commit -m "chores: sincronização automática de arquivos"
            fi

            git branch -M main
            if git push -u origin main; then
                echo -e "\n${GREEN}✅ Repositório local e GitHub sincronizados com sucesso!${NC}"
            else
                echo -e "\n${RED}❌ Falha ao enviar arquivos. Verifique se há conflitos manuais.${NC}"
            fi

            pause
            ;;

        2) # COMMIT PADRONIZADO
            printf "\033[H\033[J"
            get_context

            if [[ -z $(git status --porcelain) ]]; then
                echo -e "${GREEN}✨ Tudo atualizado. Nada para commitar.${NC}"
            else
                ensure_gh_auth

                # 1. SCANNER DE STACKS
                MAP_STACKS=""

                if [[ -d "src" ]]; then
                    FILES=$(find src -type f 2>/dev/null)

                    [[ "$FILES" =~ \.html ]] && MAP_STACKS+="HTML+"
                    [[ "$FILES" =~ \.css ]] && MAP_STACKS+="CSS+"
                    [[ "$FILES" =~ \.js ]] && MAP_STACKS+="JavaScript+"
                    [[ "$FILES" =~ \.ts ]] && MAP_STACKS+="TypeScript+"

                    [[ "$FILES" =~ \.php ]] && MAP_STACKS+="PHP+"
                    [[ "$FILES" =~ \.py ]] && MAP_STACKS+="Python+"
                    [[ "$FILES" =~ \.rb ]] && MAP_STACKS+="Ruby+"
                    [[ "$FILES" =~ \.java ]] && MAP_STACKS+="Java+"
                    [[ "$FILES" =~ \.go ]] && MAP_STACKS+="Go+"
                    [[ "$FILES" =~ \.rs ]] && MAP_STACKS+="Rust+"
                    [[ "$FILES" =~ \.cs ]] && MAP_STACKS+="CSharp+"

                    [[ "$FILES" =~ \.sh ]] && MAP_STACKS+="Bash+"
                    [[ "$FILES" =~ \.sql ]] && MAP_STACKS+="SQL+"
                fi

                [[ -f "package.json" ]] && MAP_STACKS+="Node+"
                [[ -f "composer.json" ]] && MAP_STACKS+="Composer+"
                [[ -f "requirements.txt" || -f "pyproject.toml" ]] && MAP_STACKS+="PythonEnv+"
                [[ -f "Dockerfile" || -f "docker-compose.yml" ]] && MAP_STACKS+="Docker+"

                MAP_STACKS="${MAP_STACKS%+}"

                STACK_COUNT=$(echo "$MAP_STACKS" | tr -cd '+' | wc -c)
                [[ -n "$MAP_STACKS" ]] && ((STACK_COUNT++))

                if [[ $STACK_COUNT -gt 1 ]]; then
                    FINAL_STACK="Multi-Stack"
                else
                    FINAL_STACK="${MAP_STACKS:-$STACK_NAME}"
                fi

                # 2. CONTROLE DE VERSÃO
                CURRENT_LINE=$(tail -n 1 .devlab_version 2>/dev/null)

                if [[ -z "$CURRENT_LINE" ]]; then
                    CURRENT_VERSION="1.0.0"
                else
                    CURRENT_VERSION=$(echo "$CURRENT_LINE" | awk '{print $1}')
                fi

                IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

                PATCH=$((PATCH + 1))
                PROJECT_VERSION="${MAJOR}.${MINOR}.${PATCH}"

                update_file_versions

                # 3. MENU DE TIPO DE COMMIT
                echo -e "${GREEN}┌──────────────────────────────────────────────────────────┐${NC}"
                echo -e "${GREEN}│             📝 SELECIONE O TIPO DE COMMIT                │${NC}"
                echo -e "${GREEN}└──────────────────────────────────────────────────────────┘${NC}"
                echo

                echo -e "  1) 🚀 Adicionado           2) 🐛 Corrigido"
                echo -e "  3) 🛠️  Manutenção           4) ♻️  Refatorado"
                echo -e "  5) ⚡ Performance          6) 🎨 Estilo"
                echo
                echo -e "  7) 📝 Documentação         8) 🧪 Testes"
                echo -e "  9) 🔧 Build                10) ⚙️  CI/CD"
                echo -e "  11) 🔙 Reversão            12) 🔥 Inicial"
                echo
                echo -e "  13) 🔐 Segurança           14) 📦 Dependências"
                echo -e "  15) 🌐 Traduções           16) 📎 Assets"

                echo -e "${GREEN}------------------------------------------------------------${NC}"

                read -rp "👉 Tipo: " T_OPT

                case $T_OPT in
                    1) TYPE="🚀 feat:"; CAT="### 🚀 Novas Funcionalidades" ;;
                    2) TYPE="🐛 fix:"; CAT="### 🐛 Correções de Bugs" ;;
                    3) TYPE="🛠️ chore:"; CAT="### 🛠️ Manutenção Geral" ;;
                    4) TYPE="♻️ refactor:"; CAT="### ♻️ Refatoração de Código" ;;
                    5) TYPE="⚡ perf:"; CAT="### ⚡ Melhorias de Performance" ;;
                    6) TYPE="🎨 style:"; CAT="### 🎨 Ajustes Visuais" ;;
                    7) TYPE="📝 docs:"; CAT="### 📝 Atualizações de Documentação" ;;
                    8) TYPE="🧪 test:"; CAT="### 🧪 Testes Automatizados" ;;
                    9) TYPE="🔧 build:"; CAT="### 🔧 Sistema de Build" ;;
                    10) TYPE="⚙️ ci:"; CAT="### ⚙️ Integração Contínua" ;;
                    11) TYPE="🔙 revert:"; CAT="### 🔙 Reversão de Alterações" ;;
                    12) TYPE="🔥 init:"; CAT="### 🚀 Inicialização do Projeto" ;;
                    13) TYPE="🔐 security:"; CAT="### 🔐 Atualizações de Segurança" ;;
                    14) TYPE="📦 deps:"; CAT="### 📦 Atualizações de Dependências" ;;
                    15) TYPE="🌐 i18n:"; CAT="### 🌐 Suporte a Idiomas" ;;
                    16) TYPE="📎 assets:"; CAT="### 📎 Atualizações de Recursos" ;;
                    *) TYPE="🛠️ chore:"; CAT="### 🛠️ Manutenção Geral Automática" ;;
                esac

                if [[ "$T_OPT" -eq 12 ]]; then
                    DESC="Início de projeto"
                else
                    read -rp "💬 Descrição: " DESC_RAW
                    DESC_CLEAN=$(echo "${DESC_RAW:-Atualização automática}" | xargs)
                    DESC="$(echo "${DESC_CLEAN:0:1}" | tr '[:lower:]' '[:upper:]')${DESC_CLEAN:1}"
                fi

                # 4. MENSAGEM DE COMMIT
                COMMIT_MSG="$TYPE ($REPO_NAME) | $FINAL_STACK | v$PROJECT_VERSION | $DESC"

                # 5. CHANGELOG
                if [[ -f "CHANGELOG.md" ]]; then
                    DATE_NOW=$(date +'%Y-%m-%d')
                    BLOCK="## [$PROJECT_VERSION] - $DATE_NOW\n$CAT\n- $DESC\n- [Descrição manual]\n"
                    sed -i "5i $BLOCK" CHANGELOG.md
                fi

                # 6. EXECUÇÃO DO COMMIT
                git add .

                if git commit -m "$COMMIT_MSG"; then
                    COMMIT_HASH=$(git rev-parse --short HEAD)
                    COMMIT_DATE=$(date +"%Y-%m-%d %H:%M")

                    echo "$PROJECT_VERSION" > .devlab_version
                    echo "$PROJECT_VERSION - $COMMIT_HASH - $DESC - $COMMIT_DATE" >> .devlab_history

                    git add .devlab_version
                    git commit --amend --no-edit >/dev/null 2>&1

                    echo -e "\n${GREEN}✅ Commit v$PROJECT_VERSION realizado com sucesso!${NC}"

                    if git remote | grep -q "origin"; then
                        echo -e "${YELLOW}🚀 Enviando alterações para o GitHub...${NC}"
                        if git push origin "$CURRENT_BRANCH"; then
                            echo -e "${GREEN}🚀 Sincronizado com GitHub!${NC}"
                        else
                            echo -e "${RED}⚠️ Commit salvo localmente, mas ocorreu um erro no push para o GitHub.${NC}"
                        fi
                    else
                        echo -e "${YELLOW}ℹ️ Commit salvo apenas localmente. Use a opção 1 para conectar ao GitHub.${NC}"
                    fi
                fi
            fi

            pause
            ;;

        3) # PUSH - ENVIAR PARA O REPOSITÓRIO
            printf "\033[H\033[J"
            get_context
            
            echo -e "${YELLOW}⬆️  PREPARANDO ENVIO PARA GITHUB...${NC}"
            ensure_gh_auth
            
            if ! git remote | grep -q "origin"; then
                echo -e "${RED}❌ Erro: Nenhum repositório remoto (origin) configurado.${NC}"
                echo -e "Use a opção 1 para sincronizar primeiro."
            else
                echo -e "📡 Enviando branch ${GREEN}$CURRENT_BRANCH${NC} para ${GREEN}origin${NC}..."
                
                if git push -u origin "$CURRENT_BRANCH"; then
                    echo -e "\n${GREEN}┌──────────────────────────────────────────┐${NC}"
                    echo -e "${GREEN}│      🚀 SUCESSO! PROJETO ATUALIZADO      │${NC}"
                    echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
                    echo -e "✨ Seus arquivos já estão seguros no GitHub."
                else
                    echo -e "\n${RED}❌ FALHA NO PUSH!${NC}"
                    echo -e "Dica: Talvez existam mudanças no GitHub que você não tem localmente."
                    echo -e "Tente usar a opção ${YELLOW}4) Pull${NC} antes de tentar o Push novamente."
                fi
            fi
            
            pause
            ;;

        4) # PULL - ATUALIZAR REPOSITÓRIO LOCAL
            printf "\033[H\033[J"
            get_context

            echo -e "${YELLOW}⬇️  BUSCANDO ATUALIZAÇÕES NO GITHUB...${NC}"

            if ! git remote | grep -q "origin"; then
                echo -e "${RED}❌ Erro: Remote 'origin' não encontrado.${NC}"
            else
                echo -e "📡 Sincronizando branch ${GREEN}$CURRENT_BRANCH${NC}..."
                
                if git pull origin "$CURRENT_BRANCH" --rebase; then
                    echo -e "\n${GREEN}┌──────────────────────────────────────────┐${NC}"
                    echo -e "${GREEN}│       ✅ REPOSITÓRIO ATUALIZADO!         │${NC}"
                    echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
                    echo -e "✨ Seu código local está em sincronia com a nuvem."
                else
                    echo -e "\n${RED}⚠️  ATENÇÃO: CONFLITO DETECTADO!${NC}"
                    echo -e "Resolva os conflitos manualmente antes de continuar."
                fi
            fi

            pause
            ;;

        5) # LOG - HISTÓRICO DE COMMITS
            printf "\033[H\033[J"
            get_context

            echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
            echo -e "${GREEN}│      📜 HISTÓRICO DE COMMITS DEVLAB      │${NC}"
            echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
            echo -e "Exibindo os últimos 15 commits do projeto: ${YELLOW}$REPO_NAME${NC}\n"

            git log -n 15 --pretty=format:"%C(yellow)%h%C(reset) | %s %C(bold green)(%ad)%C(reset) %C(blue)[%an]%C(reset)" --date=format:'%d/%m/%Y %H:%M'
            
            echo -e "\n\n${GREEN}------------------------------------------${NC}"
            echo -e "${YELLOW}Dica:${NC} Seus commits seguem o padrão Conventional Commits."
            
            pause
            ;;

        6) # LIMPAR CACHE / TEMP
            printf "\033[H\033[J"
            get_context

            echo -e "${YELLOW}🧹 INICIANDO LIMPEZA DO PROJETO: ${NC}$REPO_NAME"
            echo -e "${GREEN}------------------------------------------${NC}"

            echo -e "📦 ${YELLOW}Otimizando banco de dados Git...${NC}"
            git gc --prune=now --aggressive &>/dev/null
            
            echo -e "📁 ${YELLOW}Removendo arquivos temporários e logs...${NC}"
            
            find . -type f -name "*.log" -delete 2>/dev/null
            find . -type f -name "*~" -delete 2>/dev/null
            find . -type f -name ".DS_Store" -delete 2>/dev/null
            
            case $STACK_NAME in
                "Node.js") [ -d "node_modules/.cache" ] && rm -rf node_modules/.cache ;;
                "Python") find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null ;;
            esac

            echo -e "\n${GREEN}┌──────────────────────────────────────────┐${NC}"
            echo -e "${GREEN}│    ✨ LIMPEZA CONCLUÍDA COM SUCESSO!     │${NC}"
            echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"

            pause
            ;;

        7) # RESET (SEGURO)
            printf "\033[H\033[J"
            get_context

            echo -e "${RED}┌──────────────────────────────────────────┐${NC}"
            echo -e "${RED}│          ⚠️  AVISO DE RESET SEGURO        │${NC}"
            echo -e "${RED}└──────────────────────────────────────────┘${NC}"
            echo -e "Isso irá descartar todas as alterações não salvas nos arquivos existentes."
            echo -e "\n${YELLOW}Tem certeza que deseja continuar? (y/n)${NC}"
            read -rp "👉 Escolha: " CONFIRM

            if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                echo -e "\n${YELLOW}⏪ Restaurando arquivos para o último commit...${NC}"
                git checkout .
                echo -e "\n${GREEN}✅ Reset concluído!${NC}"
            else
                echo -e "\n${BLUE}ℹ️  Operação cancelada pelo usuário.${NC}"
            fi

            pause
            ;;

        8) # RENOMEAR REPOSITÓRIO
            printf "\033[H\033[J"
            get_context
            ensure_gh_auth

            echo -e "${YELLOW}✏️  RENOMEAR PROJETO ATUAL: ${NC}$REPO_NAME"
            echo -e "${GREEN}------------------------------------------${NC}"
            
            read -rp "👉 Digite o novo nome para o repositório: " NEW_NAME
            
            if [[ -z "$NEW_NAME" ]]; then
                echo -e "${RED}❌ O nome não pode ser vazio.${NC}"
            else
                NEW_SAFE_NAME=$(echo "$NEW_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
                USER_NAME=$(gh api user -q .login)
                
                echo -e "\n${YELLOW}📡 Enviando solicitação para o GitHub...${NC}"
                
                if gh api -X PATCH "repos/$USER_NAME/$REPO_NAME" -f name="$NEW_SAFE_NAME" > /dev/null; then
                    NEW_URL="https://github.com/$USER_NAME/$NEW_SAFE_NAME.git"
                    git remote set-url origin "$NEW_URL" 2>/dev/null
                    
                    echo -e "${GREEN}✅ Sucesso no GitHub!${NC}"

                    OLD_NAME="$REPO_NAME"
                    REPO_NAME="$NEW_SAFE_NAME"
                    
                    echo -e "${YELLOW}📂 Renomeando pasta local de ${NC}$OLD_NAME ${YELLOW}para ${NC}$NEW_SAFE_NAME..."
                    
                    if cd .. && mv "$OLD_NAME" "$NEW_SAFE_NAME"; then
                        cd "$NEW_SAFE_NAME"
                        echo -e "${GREEN}✅ Pasta local renomeada e sincronizada!${NC}"
                    else
                        echo -e "${RED}⚠️  GitHub alterado, mas não foi possível renomear a pasta local.${NC}"
                        cd "$OLD_NAME"
                    fi
                else
                    echo -e "${RED}❌ O GitHub recusou a alteração.${NC}"
                fi
            fi

            pause
            ;;

        9) # PRIVACIDADE DO REPOSITÓRIO
            printf "\033[H\033[J"
            get_context
            ensure_gh_auth

            echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
            echo -e "${GREEN}│        🔐 GESTÃO DE PRIVACIDADE GH       │${NC}"
            echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
            echo -e "Repositório atual: ${YELLOW}$REPO_NAME${NC}"
            
            USER_NAME=$(gh api user -q .login)
            IS_PRIVATE=$(gh api "repos/$USER_NAME/$REPO_NAME" -q .private 2>/dev/null)

            if [[ "$IS_PRIVATE" == "true" ]]; then
                echo -e "Status atual: ${RED}🔒 PRIVADO${NC}"
            else
                echo -e "Status atual: ${GREEN}🌐 PÚBLICO${NC}"
            fi

            echo -e "\n${YELLOW}ALTERAR PARA:${NC}"
            echo "1) Tornar PRIVADO"
            echo "2) Tornar PÚBLICO"
            echo "0) Cancelar"
            echo -e "${GREEN}------------------------------------------${NC}"
            read -rp "👉 Escolha: " P_OPT

            case $P_OPT in
                1)
                    echo -e "\n${YELLOW}🔒 Alterando para PRIVADO...${NC}"
                    if gh api -X PATCH "repos/$USER_NAME/$REPO_NAME" -f visibility='private' > /dev/null; then
                        echo -e "${GREEN}✅ Sucesso! Agora o repositório é PRIVADO.${NC}"
                    else
                        echo -e "${RED}❌ Falha ao alterar. Verifique o repositório no GitHub.${NC}"
                    fi
                    ;;
                2)
                    echo -e "\n${YELLOW}🌐 Alterando para PÚBLICO...${NC}"
                    if gh api -X PATCH "repos/$USER_NAME/$REPO_NAME" -f visibility='public' > /dev/null; then
                        echo -e "${GREEN}✅ Sucesso! Agora o repositório é PÚBLICO.${NC}"
                    else
                        echo -e "${RED}❌ Falha ao alterar. Verifique as permissões.${NC}"
                    fi
                    ;;
                0) echo -e "\n${BLUE}ℹ️ Operação cancelada.${NC}" ;;
                *) echo -e "\n${RED}❌ Opção inválida.${NC}" ;;
            esac

            pause
            ;;

        10) # DELETAR REPOSITÓRIO (GITHUB)
            printf "\033[H\033[J"
            get_context
            ensure_gh_auth

            echo -e "${RED}┌──────────────────────────────────────────┐${NC}"
            echo -e "${RED}│          🚨 PERIGO: DELETAR REPO         │${NC}"
            echo -e "${RED}└──────────────────────────────────────────┘${NC}"
            echo -e "Você está prestes a deletar: ${YELLOW}$REPO_NAME${NC}"
            echo -e "${RED}Esta ação não pode ser desfeita no GitHub!${NC}"
            
            echo -e "\n${YELLOW}Para confirmar, digite o nome do projeto (${NC}${REPO_NAME}${YELLOW}):${NC}"
            read -rp "👉 " CONFIRM_NAME

            if [[ "$CONFIRM_NAME" == "$REPO_NAME" ]]; then
                USER_NAME=$(gh api user -q .login)
                echo -e "\n${RED}💣 Deletando repositório no GitHub...${NC}"
                
                if gh repo delete "$USER_NAME/$REPO_NAME" --yes &>/dev/null; then
                    echo -e "${GREEN}✅ Repositório deletado do GitHub com sucesso!${NC}"
                    if git remote | grep -q "origin"; then
                        git remote remove origin
                        echo -e "${YELLOW}🧹 Vinculação remota (origin) removida do projeto local.${NC}"
                    fi
                else
                    echo -e "${RED}❌ Falha ao deletar repositório. Verifique permissões do GH CLI.${NC}"
                fi
            else
                echo -e "\n${BLUE}ℹ️ Confirmação incorreta. Operação cancelada.${NC}"
            fi

            pause
            ;;

        11) # CORRIGIR ÚLTIMO COMMIT (TEXTO)
            printf "\033[H\033[J"
            get_context

            LAST_MSG=$(git log -1 --pretty=%B 2>/dev/null)

            if [[ -z "$LAST_MSG" ]]; then
                echo -e "${RED}❌ Nenhum commit encontrado neste repositório.${NC}"
            else
                echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
                echo -e "${GREEN}│      ✏️ CORRIGIR MENSAGEM DE COMMIT      │${NC}"
                echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
                echo -e "Mensagem atual:\n${YELLOW}$LAST_MSG${NC}\n"
                
                read -rp "💬 Digite a nova mensagem: " NEW_MSG
                
                if [[ -n "$NEW_MSG" ]]; then
                    if git commit --amend -m "$NEW_MSG"; then
                        echo -e "\n${GREEN}✅ Mensagem de commit atualizada com sucesso!${NC}"
                        if git remote | grep -q "origin"; then
                            echo -e "${YELLOW}⚠️ Caso já tenha feito push anteriormente, será necessário forçar a atualização (push --force-with-lease).${NC}"
                        fi
                    else
                        echo -e "\n${RED}❌ Falha ao alterar a mensagem do commit.${NC}"
                    fi
                else
                    echo -e "\n${BLUE}ℹ️ Operação cancelada. Nenhuma mensagem fornecida.${NC}"
                fi
            fi

            pause
            ;;

        12) # REINICIAR DO ZERO
            printf "\033[H\033[J"
            get_context

            echo -e "${RED}┌──────────────────────────────────────────┐${NC}"
            echo -e "${RED}│      🚨 PERIGO: REINICIAR PROJETO        │${NC}"
            echo -e "${RED}└──────────────────────────────────────────┘${NC}"
            echo -e "Esta opção irá deletar TODO o histórico do Git local."
            echo -e "Os seus arquivos serão mantidos, mas o Git será resetado."
            echo -e "Útil para transformar um projeto velho em um novo 'v1.0.0'."
            
            echo -e "\n${YELLOW}Deseja apagar o histórico e começar do zero? (y/n)${NC}"
            read -rp "👉 Escolha: " CONFIRM

            if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                echo -e "\n${YELLOW}💣 Explodindo pasta .git e reiniciando...${NC}"
                
                rm -rf .git
                
                git init -b main &>/dev/null
                
                # (O get_context vai atualizar o cabeçalho automaticamente)
                
                echo -e "${GREEN}✅ O projeto foi reiniciado com sucesso!${NC}"
                echo -e "Agora você pode usar a ${YELLOW}Opção 1${NC} para criar um novo repo no GitHub."
            else
                echo -e "\n${BLUE}ℹ️  Operação cancelada.${NC}"
            fi

            pause
            ;;

        13) # ZERAR REPOSITÓRIO
            printf "\033[H\033[J"
            REPO_NAME=$(basename "$PWD") # Pega o nome da pasta atual
            
            echo -e "${RED}┌──────────────────────────────────────────┐${NC}"
            echo -e "${RED}│      🚨 PERIGO: DESTRUIÇÃO TOTAL         │${NC}"
            echo -e "${RED}└──────────────────────────────────────────┘${NC}"
            echo -e "Esta opção irá apagar TUDO na pasta: ${YELLOW}$REPO_NAME${NC}"
            read -rp "👉 Digite 'LIMPAR' para confirmar: " CONFIRM_CLEAN

            if [[ "$CONFIRM_CLEAN" == "LIMPAR" ]]; then
                echo -e "\n${YELLOW}💣 Iniciando limpeza profunda...${NC}"
                
                rm -rf .git
                find . -maxdepth 1 ! -name "$(basename "$0")" ! -name "." -exec rm -rf {} +
                
                git init -b main &>/dev/null
                echo "1.0.0" > .devlab_version
                echo "Shell" > .devlab_stack
                
                echo -e "${GREEN}✅ Pasta limpa!${NC}"
                
                echo -e "${YELLOW}🔍 Verificando se existe backup no GitHub...${NC}"
                ensure_gh_auth
                GH_USER=$(gh api user -q .login)
                
                if gh repo view "$GH_USER/$REPO_NAME" &>/dev/null; then
                    echo -e "${BLUE}ℹ️  Repositório encontrado no GitHub!${NC}"
                    read -rp "❓ Deseja restaurar os arquivos agora? (y/n): " RESTORE_OPT
                    
                    if [[ "$RESTORE_OPT" =~ ^[Yy]$ ]]; then
                        echo -e "${YELLOW}📡 Restaurando via Modo À Prova de Falhas...${NC}"
                        git remote add origin "https://github.com/$GH_USER/$REPO_NAME.git"
                        git fetch origin main &>/dev/null
                        
                        if git reset --hard origin/main; then
                            echo -e "${GREEN}✅ Sincronização completa! O projeto foi restaurado.${NC}"
                        else
                            echo -e "${RED}❌ Falha ao sincronizar. Tente a Opção 4 manualmente.${NC}"
                        fi
                    fi
                else
                    echo -e "${YELLOW}ℹ️  Nenhum repositório encontrado com o nome '${REPO_NAME}'.${NC}"
                    echo -e "Você pode iniciar um novo projeto do zero agora."
                fi
            else
                echo -e "\n${BLUE}ℹ️  Operação cancelada.${NC}"
            fi
            pause
            ;;
            
        0) # SAIR
            printf "\033[H\033[J"
            echo -e "${GREEN} Atividades encerradas no DevLab Manager. Até logo! 👋${NC}\n"
            exit 0
            ;;

        *)
            echo -e "\n${RED}❌ Opção inválida. Escolha um número do menu.${NC}"
            pause
            ;;
    esac
done
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