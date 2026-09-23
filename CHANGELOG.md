# 📜 Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

## [1.0.60] - 2026-09-23
### 📝 Atualizações de Documentação
- Atualização automática
- [Descrição manual]

## [1.0.59] - 2026-04-26
### ♻️ Refatoração de Código
- Atualização automática
- [Descrição manual]

## [1.0.58] - 2026-04-26
### 🐛 Correções de Bugs
- Atualização automática
- [Descrição manual]

## [1.0.57] - 2026-04-26
### ♻️ Refatoração de Código
- Atualização automática
- [Descrição manual]

## [1.0.56] - 2026-04-26
### 🐛 Corrigido
- Atualização automática
- Correção da variável `PROJECT_VERSION` no setup e testes
- Ajuste na leitura da versão atual do sistema de versionamento
- Sincronização do `.devlab_version` após correção estrutural

## [1.0.55] - 2026-04-26
### 🧪 Testes
- Atualização automática
- Incremento de versão para 1.0.55 no sistema DevLab Engine
- Ajuste de controle de versão no `.devlab_version`
- Padronização do fluxo de incremento de versão nos testes

## [1.0.54] - 2026-04-26
### 🧪 Testes
- Atualização automática
- Correção do sistema de versionamento para sobrescrita correta do `.devlab_version`
- Ajuste do fluxo de incremento de versão no `increment_version()`
- Padronização do controle de histórico em `.devlab_history`

## [1.0.53] - 2026-04-26
### 🧪 Testes
- Atualização automática
- Criação inicial do `.devlab_history` com histórico completo de versões
- Ajuste no sistema de gravação de versão no `devlab_git_manager.sh`

## [1.0.52] - 2026-04-26
### 🧪 Testes
- Atualização automática
- Registro adicional de histórico em `.devlab_history`
- Sincronização da versão 1.0.52 no devlab_engine

## [1.0.51] - 2026-04-26
### ♻️ Refatorado
- Atualização automática
- Sincronização do arquivo `.devlab_version`
- Ajuste de CI/CD e Git Flow no README e scripts

## [1.0.50] - 2026-04-26
### ♻️ Refatorado
- Atualização automática
- Correção de histórico no .devlab_version
- Atualização do CHANGELOG.md

## [1.0.49] - 2026-04-26
### ♻️ Refatorado
- Ajuste de metadados no setup_devlab.sh
- Refatoração e reorganização do README.md

## [1.0.48] - 2026-04-25
### 🐛 Correções de Bugs
- Corrigido o bloco de geração automática do `CHANGELOG.md` para incluir novamente o campo `- [Descrição manual]` no padrão oficial.
- Ajustado o fluxo de commit para preservar a estrutura esperada do changelog sem perder compatibilidade com o modelo definido.
- Removidos resíduos de testes (`typeset`) inseridos indevidamente em `src/main.sh` e `releases/setup_devlab.sh`.
- Restaurada a limpeza dos arquivos principais após execuções de testes automatizados.
- Atualizado o versionamento interno dos headers para `v1.0.48`, mantendo consistência entre arquivos e histórico de commits.

## [1.0.47] - 2026-04-25
### 🧪 Testes Automatizados
- Validado novo ciclo de atualização automática após avanço das versões intermediárias até `v1.0.47`
- Confirmada atualização incremental do header em `src/main.sh`:
  `Version: 1.0.60 → Version: 1.0.60`
- Persistido novo snapshot de versão com hash (`fea09d5`) em `.devlab_version`
- Registrada entrada automática correspondente no `CHANGELOG.md`
- Evidenciada regressão severa de contaminação de stage com multiplicação massiva de `typeset`
- Detectado crescimento exponencial de lixo de shell dentro de `src/main.sh`
- Confirmado que o processo de commit ainda está capturando estado indevido do terminal/bash
- Reforçada a necessidade de eliminar definitivamente o uso permissivo de `git add .`
- Validado que o controle de exclusão de arquivos ainda não está suficientemente protegido contra auto-modificação do próprio sistema

## [1.0.46] - 2026-04-25
### 🧪 Testes Automatizados
- Ajustado o fluxo de testes para validar a atualização automática de versionamento em arquivos gerados.
- Validada a propagação da nova versão para headers existentes em `setup_devlab.sh`.
- Confirmado o incremento correto da versão para `v1.0.46` com persistência no histórico de `.devlab_version`.
- Testado o comportamento do append automático no arquivo `CHANGELOG.md`.
- Verificada a estabilidade do processo de atualização sem impacto no fluxo principal de commit.

## [1.0.45] - 2026-04-25
### 🧪 Testes Automatizados
- Realizado teste removendo temporariamente os filtros de proteção dentro de `update_file_versions()`
- Comentadas validações que ignoravam:
  - `.devlab_version`
  - `CHANGELOG.md`
  - `setup_devlab.sh`
  - arquivos relacionados ao `generate_header()`
- Confirmado impacto direto da ausência de filtros no versionamento automático
- `releases/setup_devlab.sh` voltou a ter header atualizado automaticamente:
  `Version: 1.0.60 → Version: 1.0.60`
- `src/main.sh` também recebeu atualização automática de header:
  `Version: 1.0.60 → Version: 1.0.60`
- Persistência do problema de contaminação com múltiplas inserções de `typeset`
- Validado que remover proteções reabre o risco de alterar arquivos críticos de template e release
- Registrado novo snapshot de versão com hash em `.devlab_version`

## [1.0.44] - 2026-04-25
### 🧪 Testes Automatizados
- Validado comportamento da rotina `update_file_versions()` também em arquivos dentro de `releases/`
- Confirmada atualização automática de header em:
  `releases/setup_devlab.sh`
- Header corrigido
- Persistido novo registro histórico com hash  em `.devlab_version`
- Atualização automática adicionada corretamente ao `CHANGELOG.md`
- Confirmado que o filtro ainda precisa excluir com mais precisão arquivos de release/template para evitar versionamento indevido de instaladores

## [1.0.43] - 2026-04-25
### 🧪 Testes Automatizados
- Validado funcionamento da nova rotina `update_file_versions()` após integração no fluxo de commit
- Confirmada atualização automática de headers 
- Testado comportamento de preservação de templates com:
  `Version: $PROJECT_VERSION`
- Persistido novo snapshot de versão com hash em `.devlab_version`
- Registrada atualização automática no `CHANGELOG.md`
- Identificada regressão com inserção repetida de `typeset` em:
  - `src/main.sh`
  - `releases/setup_devlab.sh`
- Confirmado que ainda existe contaminação de stage e vazamento de estado do shell durante o processo de commit

## [1.0.42] - 2026-04-25
### 🐛 Correções de Bugs
- Criada a função `update_file_versions()` para atualizar apenas arquivos já gerados com versão fixa
- Implementado filtro usando `git diff --name-only` para processar somente arquivos realmente modificados
- Adicionada proteção para ignorar arquivos de controle:
  - `.devlab_version`
  - `CHANGELOG.md`
- Adicionada proteção para evitar alteração de arquivos de template e geração:
  - `setup_devlab.sh`
  - arquivos relacionados ao `generate_header()`
- Aplicado regex seguro para atualizar apenas padrões como:
  `Version: 1.0.60`
- Garantido que linhas como:
  `Version: $PROJECT_VERSION`
  sejam preservadas e não sobrescritas
- Integrada execução automática de `update_file_versions()` no fluxo de incremento de versão
- Corrigido problema estrutural de sobrescrita indevida de headers durante commits automáticos

## [1.0.41] - 2026-04-25
### 🧪 Testes Automatizados
- Implementado registro histórico incremental em `.devlab_version`
- Adicionado novo snapshot de versão com hash do commit
- Validado fluxo de persistência de versão sem sobrescrever histórico anterior
- Atualização automática registrada no `CHANGELOG.md`
- Detectado problema de stage indevido com inserção acidental de `typeset` em `src/main.sh`
- Confirmado que ainda existe necessidade de controle mais rígido sobre `git add`

## [1.0.40] - 2026-04-25
### 🐛 Correções de Bugs
- Reformulado o sistema de versionamento automático para registrar histórico completo no arquivo `.devlab_version`.
- Alterado o controle de versão para utilizar append com hash do commit, descrição e data, em vez de sobrescrever apenas a versão atual.
- Removida a atualização automática de headers de arquivos durante o commit, separando versionamento de release do versionamento interno de commit.
- Corrigida a leitura da versão atual utilizando apenas a última linha válida do `.devlab_version`.
- Ajustado o fluxo para realizar `git commit --amend --no-edit` após registrar o histórico de versão, garantindo rastreabilidade no mesmo commit.
- Simplificado o changelog automático para registrar apenas a entrada principal sem placeholder adicional.
- Padronizada a descrição automática de fallback para `Atualização automática`.
- Corrigido o template de testes para utilizar `Version: $PROJECT_VERSION` em vez de valor fixo hardcoded.
- Melhorada a organização interna do `devlab_git_manager.sh` com separação mais clara por blocos de responsabilidade.

## [1.0.39] - 2026-04-25
### 🐛 Correções de Bugs
- Atualizada a versão global do projeto para `v1.0.39`.
- Sincronizados os headers de versão nos arquivos principais (`setup_devlab.sh`, `main.sh` e `tests/devlab_engine.sh`).
- Removido o arquivo redundante `tests/.devlab_version`, evitando conflito de versionamento paralelo dentro da pasta de testes.
- Mantida a centralização do controle de versão apenas no arquivo raiz `.devlab_version`.
- Ajustado o fluxo de versionamento automático para garantir maior consistência entre ambiente principal e estrutura de testes.

## [1.0.38] - 2026-04-25
### 🐛 Correções de Bugs
- Ajustado o gerenciamento automático de versão nos headers do projeto.
- Adicionada a função `update_project_header_version()` para atualizar apenas a primeira ocorrência de `Version:` nos arquivos alvo.
- Corrigido o comportamento de atualização de versão para evitar substituições indevidas em múltiplos pontos do arquivo.
- Restaurado o fluxo simplificado de `git add .` no gerenciador Git.
- Removido o bloco manual de stage seletivo e exclusões forçadas de arquivos do próprio gerenciador.
- Sincronizada a versão dos arquivos principais (`setup_devlab.sh`, `main.sh`, testes e scripts auxiliares) para `v1.0.38`.
- Mantida a automação de changelog e versionamento com execução mais previsível.

## [1.0.35] - 2026-04-25
### 🐛 Correções de Bugs
- Correção incremental no sistema de atualização automática para validar a estabilidade completa do novo fluxo de versionamento.
- Sincronização da versão `1.0.35` entre `.devlab_version` e `CHANGELOG.md`, mantendo consistência após os últimos ajustes de commit automático.
- Verificação final da persistência das regras de stage controlado e exclusão de arquivos internos do processo de versionamento.
- Reforço da estabilidade do DevLab Engine no ciclo automático de commits e geração contínua de releases.

## [1.0.34] - 2026-04-25
### 🐛 Correções de Bugs
- Correção final no fluxo de atualização automática de versão para garantir consistência imediata após os ajustes realizados no sistema de stage e commit controlado.
- Sincronização da versão `1.0.34` entre `.devlab_version` e `CHANGELOG.md`, evitando divergências após a sequência de correções anteriores.
- Estabilização do processo de commit automático após refatoração do `git add`, assegurando que apenas arquivos válidos sejam versionados.
- Consolidação das melhorias recentes no gerenciamento de commits, reduzindo riscos de alterações indevidas em scripts internos do DevLab Engine.

## [1.0.33] - 2026-04-25
### 🐛 Correções de Bugs
- Correção no sistema de versionamento com ajuste entre as versões `1.0.31`, `1.0.32` e `1.0.33`, evitando inconsistências entre `.devlab_version`, `CHANGELOG.md` e arquivos principais.
- Ajuste nos testes de geração de headers com retorno do `cat <<EOF`, permitindo novamente a expansão correta das variáveis como `$PROJECT_VERSION`, `$PROJECT_SAFE_NAME` e data de criação.
- Correção no `git manager` para substituir `git add .` por um stage controlado e seguro, adicionando apenas arquivos relevantes do projeto.
- Implementação de exclusão automática do próprio gerenciador (`main.sh`, `devlab_git_manager.sh`, `devlab.sh`, `setup_devlab.sh`) do stage, evitando commits acidentais das ferramentas internas.
- Melhoria na segurança do fluxo de commit automático, reduzindo risco de versionamento indevido de arquivos administrativos e preservando a integridade do projeto principal.

## [1.0.32] - 2026-04-25
### 🐛 Correções de Bugs
- 🤖 Atualização Automática
- [Descrição manual]

## [1.0.31] - 2026-04-25
### 🐛 Correções de Bugs
- Correção no arquivo `setup_devlab.sh` com remoção de código duplicado e excessivo que havia sido incorporado indevidamente no release final.
- Restauração da estrutura limpa do script de setup, mantendo apenas o header principal e evitando distribuição de uma versão inflada e inconsistente.
- Ajuste da versão interna do projeto para `1.0.31`, garantindo sincronização entre `.devlab_version`, `CHANGELOG.md` e arquivos de release.
- Redução do risco de conflitos de manutenção e erros de atualização automática causados pela replicação indevida de blocos completos do `main.sh`.
- Melhoria na organização do release final, preservando a separação correta entre ambiente de desenvolvimento (`src`) e ambiente de distribuição (`releases`).

## [1.0.30] - 2026-04-25
### 🐛 Correções de Bugs
- Correção na geração automática de headers usando `cat <<'EOF'` para evitar expansão indevida de variáveis durante a criação dos templates.
- Ajuste no campo `Version` dos headers de JavaScript, TypeScript, PHP, HTML e CSS para preservar corretamente `$PROJECT_VERSION` no template gerado.
- Correção no template de Bash/Python para manter consistência da versão interna do projeto.
- Adição da variável de cor `BLUE` no sistema de feedback visual dos scripts para melhorar mensagens de status no terminal.
- Sincronização das alterações entre `src/main.sh`, `releases/setup_devlab.sh` e arquivos de teste para evitar divergência de comportamento entre ambiente principal e testes.

## [1.0.29] - 2026-04-25
### 🐛 Correções de Bugs
- 🤖 Atualização Automática
- Sincronização da versão do projeto de 1.0.28 para 1.0.29 em todos os arquivos principais.
- Atualização dos headers de versão em `src/main.sh`, `releases/setup_devlab.sh` e `tests/devlab_engine.sh`.
- Registro automático da nova versão no `CHANGELOG.md`.
- Correção dos templates de cabeçalho para preservar literalmente `$PROJECT_VERSION` em arquivos gerados de C, C++, HTML e CSS.
- Substituição de `Version: $PROJECT_VERSION` por `Version: \$PROJECT_VERSION`, evitando expansão indevida da variável durante a geração dos arquivos.
- Garantia de compatibilidade entre `generate_header()` e o versionamento dinâmico dos templates multi-stack.
- Adição da variável de cor `BLUE` em `tests/devlab_git_manager.sh` para evitar inconsistências visuais e chamadas de cor não definidas.

## [1.0.28] - 2026-04-25
### 🐛 Correções de Bugs
- 🤖 Atualização Automática
- Atualização dos headers de versão em `src/main.sh`, `releases/setup_devlab.sh` e `tests/devlab_engine.sh`.
- Registro automático da nova versão no `CHANGELOG.md`.
- Remoção definitiva do comando `find + sed` responsável por substituir `# Version:` em massa durante o commit automático.
- Correção de conflitos entre `generate_header()` e substituições automáticas redundantes de versão.
- Maior estabilidade no fluxo de versionamento automático e prevenção de sobrescritas indevidas.

## [1.0.27] - 2026-04-25
### 🐛 Correções de Bugs
- 🤖 Atualização Automática
- Atualização dos headers de versão em `src/main.sh`, `releases/setup_devlab.sh` e `tests/devlab_engine.sh`.
- Registro automático da nova versão no `CHANGELOG.md`.
- Correção no fluxo de atualização automática ao desativar temporariamente o comando `find + sed` que sobrescrevia versões indevidamente.
- Prevenção de conflitos entre `generate_header()` e substituições automáticas em massa de `# Version:`.

## [1.0.26] - 2026-04-25
### ♻️ Refatoração de Código
- categoria `♻️ Refatoração de Código`
- descrição automática padrão
- espaço reservado para descrição manual futura

#### 🧩 Atualização da função `generate_header()`
A função responsável por gerar cabeçalhos automáticos dos arquivos foi atualizada para refletir corretamente a nova versão do projeto.

## [1.0.25] - 2026-04-24
### 🐛 Correções de Bugs
- 🤖 Atualização automática de versão aplicada para `v1.0.25`
- 🔄 Sincronização do `CHANGELOG.md` com novo bloco de release
- 🏷️ Atualização dos headers internos de versão em `setup_devlab.sh`, `src/main.sh` e `tests/devlab_engine.sh`
- 🛠️ Correção da rotina automática de substituição de `# Version:` durante commits versionados
- ♻️ Restauração completa da estrutura principal de `src/main.sh` com retorno da lógica de auto-instalação e checkup inicial
- 📦 Reintegração do fluxo `check_and_install()` para validação automática de dependências (`git` e `gh`)
- 🔧 Recuperação do bootstrap original do DEVLAB ENGINE após remoção indevida da base principal
- 🧹 Reorganização da engine principal mantendo compatibilidade com geração automática de versões

## [1.0.24] - 2026-04-24
### 🐛 Correções de Bugs
- 🤖 Atualização automática de versão aplicada para `v1.0.24`
- 🔄 Sincronização do `CHANGELOG.md` com novo bloco de release
- 🏷️ Atualização dos headers internos de versão em `setup_devlab.sh` e `tests/devlab_engine.sh`
- 🛠️ Correção da substituição automática de `# Version:` durante o processo de commit
- ♻️ Remoção completa da geração inline do `devlab_git_manager.sh` dentro de `src/main.sh`
- 📦 Restauração de `src/main.sh` como arquivo principal do projeto com header limpo e padronizado
- 🧹 Redução massiva de código duplicado e limpeza estrutural do bootstrap principal
- 🔒 Separação mais segura entre engine principal e scripts auxiliares

## [1.0.22] - 2026-04-24
### 🐛 Correções de Bugs
- Refatorado completamente o `src/main.sh`, substituindo a lógica anterior do DEVLAB ENGINE por um novo fluxo focado em gerenciamento Git com geração automática do script `devlab_git_manager.sh`.
- Removida toda a estrutura de auto-instalação de dependências (`git`, `gh`) e criação inicial de projetos, incluindo seleção de stack, templates e geração automática de arquivos base.
- Eliminado o sistema anterior de versionamento incremental (`increment_version`, `get_version`) e a lógica de criação automática de headers (`generate_header`, `create_file_with_header`).
- Implementada validação imediata para garantir que a execução ocorra apenas dentro de um repositório Git válido.
- Adicionado novo sistema de captura de contexto do projeto (`get_context`), incluindo leitura automática de branch atual, versão (`.devlab_version`), stack (`.devlab_stack`) e path local.
- Implementada verificação inteligente de repositório remoto e status de privacidade via GitHub CLI (`gh repo view`), distinguindo projetos locais, públicos e privados.
- Adicionada captura automática do hash do último commit para rastreabilidade operacional.
- Criado novo fluxo de verificação e criação automática de repositório remoto no GitHub quando `origin` não existir.
- Interface principal alterada de “🚀 DEVLAB ENGINE” para “🧠 DEVLAB GIT MANAGER”, refletindo a nova proposta funcional do sistema.
- Introduzida função `pause()` para melhor controle de navegação e experiência de uso no terminal.

## [1.0.22] - 2026-04-24
### 🐛 Correções de Bugs
- 🤖 Atualização Automática
- Correção definitiva do erro crítico em `check_and_install()`, substituindo `if comando; then` por `if command -v "$CMD" &>/dev/null; then`
- Renomeação de `ensure_gh_login()` para `ensure_gh_auth()` para padronização com o restante do sistema
- Adição da variável de cor `BLUE='\033[0;34m'`
- Inclusão automática da pasta `releases/` na estrutura inicial criada pelo projeto
- Ajuste do `generate_header()` para refletir corretamente a versão `1.0.22`
- Correções replicadas também em `tests/devlab_engine.sh`

### ♻️ Refatoração de Código

- Extração completa do `devlab_git_manager.sh`, removendo o bloco inline gigante dentro de `main.sh`
- Separação estrutural entre `main.sh`, `devlab_git_manager.sh` e `tests/devlab_engine.sh`
- Rename oficial de `tests/setup_devlab.sh` para `tests/devlab_engine.sh`
- Criação do arquivo `releases/setup_devlab.sh`
- Melhoria da organização interna e manutenção futura do projeto

## [1.0.21] - 2026-04-24
### 🐛 Correções de Bugs
- Correção definitiva da posição do shebang `#!/bin/bash` para garantir compatibilidade correta com execução de scripts
- Ajuste na declaração de `VERSION_FILE`, removendo uso incorreto de `local` fora de função
- Correção da estrutura de versionamento automático e persistência da versão em `.devlab_version`
- Ajustes na atualização automática da versão em arquivos `.sh` e `README.md`
- Revisão da configuração do GitHub Actions para execução mais segura do `shellcheck`
- Adicionado `shellcheck -s bash -e SC1128` para evitar falso positivo relacionado ao shebang
- Limpeza e simplificação da função `get_context()` com remoção de variáveis redundantes
- Correção da lógica de detecção de privacidade e status do repositório GitHub
- Ajuste no tratamento de repositórios locais sem vínculo remoto
- Melhorias gerais de estabilidade no fluxo automático de sincronização e manutenção

## [1.0.20] - 2026-04-24
### 🐛 Correções de Bugs
- Correção e revisão do método de instalação automática de dependências no `check_and_install`
- Ajustes na função `increment_version()` para melhorar controle de `MAJOR.MINOR.PATCH`
- Reorganização da leitura e escrita do arquivo `.devlab_version`
- Padronização de prompts com `read -rp` em todo o fluxo principal
- Correção de entradas interativas no menu principal e configurações de deploy
- Ajustes no fluxo de criação automática de repositório GitHub
- Correção na atualização automática da versão em arquivos `.sh` e `README.md`
- Revisão do setup inicial de stack e seleção de ambiente
- Melhorias gerais de estabilidade no processo de bootstrap do projeto

## [1.0.19] - 2026-04-24
### 🐛 Correções de Bugs
- Ajustes no fluxo de incremento e leitura de versão automática do arquivo `.devlab_version`
- Correção na persistência da versão atual do projeto durante a criação inicial
- Padronização de entradas interativas com substituição de `read -p` por `read -rp`
- Correção no comportamento de prompts de criação e configuração inicial
- Ajustes na atualização automática de versão dentro dos arquivos `.sh` e `README.md`
- Revisão no processo de criação de repositório remoto no GitHub
- Melhorias no fluxo de autenticação e entrada de credenciais Git
- Correções no setup de deploy inicial e integração com GitHub
- Ajustes internos para evitar falhas silenciosas em operações automáticas

## [1.0.18] - 2026-04-24
### ♻️ Refatoração de Código
- Ajustado `create_file_with_header()` para preservar corretamente o shebang na primeira linha dos arquivos executáveis
- Reestruturado o controle de versão para evitar incremento automático indevido ao recriar projetos
- Melhorada a leitura e persistência de `.devlab_version` com fallback seguro para `1.0.0`
- Refinado `generate_header()` para atualização correta da versão apenas em arquivos fixos
- Corrigido posicionamento de headers em scripts Bash e arquivos executáveis
- Padronizado fallback automático de descrição para `🤖 Atualização Automática`
- Melhorada a consistência visual do fluxo de criação inicial e saída de terminal
- Reorganizado o menu de tipos de commit com categorias mais claras e nomes mais descritivos
- Ajustado o tratamento de stack Rust com fallback seguro quando `Cargo.toml` não existir
- Corrigida geração inicial de projeto Rust com criação automática de `Cargo.toml`
- Revisado o fluxo de sincronização entre repositório local e remoto com merge protegido contra conflitos
- Melhorado `get_context()` com atualização mais confiável de branch, stack, versão e status remoto
- Refinado o sistema de detcção de privacidade e fallback para projetos sem GitHub vinculado
- Ajustado o amend de commits para manter o padrão completo de mensagem versionada

### ⚙️ Integração Contínua
- Adicionada geração automática de workflow GitHub Actions (`.github/workflows/ci.yml`)
- Implementado suporte inicial para testes automatizados por stack no CI

### ✏️ Gestão de Repositório
- Implementada função de renomear repositório local e remoto com sincronização automática
- Adicionado fluxo seguro de atualização de `origin` após rename no GitHub
- Melhorado sistema de alteração de privacidade usando GitHub API via `gh api`
- Refinado processo de rename com tentativa automática de renomear também a pasta local

### 🛠️ Manutenção Geral
- Alterado nome padrão da categoria fallback para `Manutenção Geral Automática`
- Ajustado nome do arquivo de licença gerado para `LICENSES`
- Corrigidos detalhes de formatação, espaçamento e consistência visual no output geral do sistema

## [1.0.17] - 2026-04-24
### 🧪 Testes Automatizados
- Refatoração e expansão do `devlab_git_manager.sh`
- Adicionado painel mais completo de status do repositório
- Inclusão de exibição de versão, branch, remote e privacidade
- Nova opção para corrigir a mensagem do último commit (`amend`)
- Melhorias na validação de repositório remoto e sincronização GitHub
- Ajustes no fluxo de rename de repositório local + remoto
- Melhorias no controle de privacidade via API do GitHub
- Refinamento do fluxo de push, pull e sincronização inteligente
- Melhor organização estrutural e visual do menu principal
- Refatoração do `setup_devlab.sh`
- Correção no posicionamento de shebang + header automático
- Melhorias no gerador de headers por stack
- Ajustes no controle e persistência de versão (`.devlab_version`)
- Adição automática de `Cargo.toml` para projetos Rust
- Melhorias no GitHub Actions e CI inicial
- Ajustes no processo de criação inicial de projetos
- Refinamento do fluxo de restore e limpeza profunda
- Melhorias gerais de estabilidade e automação interna


## [1.0.16] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.16`
- Restauração completa do sistema de auto-instalação e verificação de dependências com retorno do `check_and_install()`
- Reativação da instalação automática de `git` e `gh`, eliminando falhas em ambientes sem pré-configuração
- Reintrodução das variáveis globais `AUTHOR_FILE` e `LICENSE_FILE` para padronização dos headers gerados
- Retorno do método `create_file_with_header()` para centralizar e padronizar a criação de arquivos iniciais
- Recuperação da arquitetura avançada do `generate_header()` com suporte a múltiplos formatos por stack (`#`, `//`, `<!-- -->`, `/* */`)
- Restauração completa do menu expandido de stacks com suporte a 16 tecnologias diferentes
- Reimplementação do sistema completo de bootstrap inicial com geração automática de estrutura para HTML, CSS, JavaScript, TypeScript, Node.js, Python, PHP, Ruby, Java, Go, Rust, C#, Flutter, Kotlin, Swift e Bash
- Retorno da criação automática de diretórios padrão (`src`, `docs`, `logs`, `build`, `tests`, `assets`)
- Correção estrutural no `README.md`, separando blocos heredoc para evitar quebra de variáveis e inconsistências no template final
- Ajuste do bloco de tecnologias e metadados do README para permitir expansão dinâmica com variáveis do projeto
- Padronização da mensagem de merge automático com repositório remoto para `🔄 Sincronizado com Repositório Remoto`
- Reversão da simplificação excessiva introduzida anteriormente, restaurando a proposta original do DevLab como engine multi-stack completa

## [1.0.15] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.15`
- Reversão controlada do modelo de CHANGELOG para estrutura mais detalhada de “Inicialização de projeto”
- Reintrodução do bloco `### 🚀 Inicial` com descrição expandida de bootstrap do projeto no `CHANGELOG.md`
- Retorno da descrição completa de estrutura inicial do projeto no primeiro registro do changelog
- Ajuste no `setup_devlab.sh` para restaurar formato mais informativo do CHANGELOG na criação inicial
- Reforço da geração de contexto inicial incluindo nome do projeto no histórico (`$PROJECT_SAFE_NAME`)
- Reintrodução de texto descritivo no bootstrap para melhor rastreabilidade do histórico de geração do projeto
- Pequeno ajuste no template de README para voltar ao modo expandido (`cat <<EOF` ao invés de heredoc protegido)
- Padronização do fluxo de inicialização para manter consistência entre versão, changelog e README na criação do projeto
- Correção de inconsistência estrutural introduzida nas versões anteriores onde o CHANGELOG estava simplificado demais

## [1.0.14] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.14`
- Ajuste do sistema de sincronização de repositório GitHub no `setup_devlab.sh`
- Melhoria no fluxo de criação de repositório remoto via `gh repo create`, com tratamento para repositórios já existentes
- Implementação de fallback inteligente quando o repositório remoto já existe, evitando falhas de criação
- Adição de estratégia de merge automático com `--allow-unrelated-histories` para integração segura com repositórios pré-existentes
- Inclusão de proteção de histórico local usando estratégia `-X ours` para evitar conflitos destrutivos em sincronização inicial
- Reescrita do fluxo de “push inicial” para um modelo mais resiliente a estados inconsistentes do GitHub
- Melhoria na detecção de estado do repositório remoto antes de tentar criação
- Ajuste de mensagens de log para maior clareza no processo de sync (criação vs vinculação)
- Atualização do comentário estrutural do `devlab_git_manager.sh` indicando correção no gerador automático
- Pequena correção de UX no fluxo de inicialização do projeto, reduzindo falhas silenciosas em ambientes já versionados

## [1.0.13] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão para `v1.0.13`
- Refatoração do `setup_devlab.sh`, removendo estrutura antiga baseada em templates extensos por linguagem
- Simplificação do sistema de criação de arquivos iniciais para geração direta por stack
- Redução do menu de seleção de stack para um conjunto essencial (Node.js, Python, PHP, Bash, HTML)
- Substituição do `create_file_with_header()` por fluxo direto com `generate_header()`
- Correção e padronização do header generator mantendo versão controlada via runtime
- Remoção do auto-installer (`check_and_install`) e adoção de verificação direta de dependências críticas
- Reescrita do fluxo de bootstrap do projeto para reduzir complexidade e melhorar manutenção
- Descontinuação dos templates completos por linguagem (Java, Go, Rust, C#, etc.)
- Ajuste do `CHANGELOG.md` para estrutura mais simples e direta
- Consolidação do sistema de incremento de versão via `.devlab_version`
- Melhoria no fluxo de commit incremental e padronização do `devlab_git_manager.sh`

## [1.0.12] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.12`
- Reativação do fluxo de versionamento automático baseado em `.devlab_version`
- Correção do sistema de substituição de versão nos headers dos arquivos (`src/main.sh`, `setup_devlab.sh`)
- Reintegração do scanner de stacks com detecção de linguagens e ecossistemas (`Node`, `Composer`, `Docker`, `PythonEnv`)
- Ajuste do cálculo de `FINAL_STACK` para classificação entre stack única e `Multi-Stack`
- Reativação do sistema de injeção automática no `CHANGELOG.md` com bloqueio de versões iniciais (`v1.0.0`)
- Correção do fluxo de commit automático com `git add .` antes do commit final
- Reativação da opção de restauração de repositório via GitHub (`reset --hard origin/main`)
- Ajuste de segurança na opção de “wipe total” para exigir confirmação explícita (`LIMPAR`)

## [1.0.11] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.11`
- Restauração completa do fluxo de `COMMIT PADRONIZADO (INCREMENTAL)` no ambiente de testes (`tests/devlab_git_manager.sh`)
- Reimplementação do scanner automático de stacks com detecção de tecnologias em `src/` e ecossistemas externos (`Node`, `Composer`, `Docker`, `PythonEnv`)
- Retorno da classificação automática entre stack única e `Multi-Stack`
- Reativação do incremento automático de versão com leitura de `.devlab_version` e controle progressivo de patch version
- Recuperação da lógica que mantém `v1.0.0` apenas para inicialização sem commits anteriores
- Restauração do menu completo e organizado de tipos de commit com categorias por contexto (Features, Bugs, Manutenção, DevOps, Segurança e Extras)
- Retorno da associação entre tipo de commit (`TYPE`) e categoria de changelog (`CAT`) para geração automática do histórico
- Reimplementação da criação automática de blocos no `CHANGELOG.md` com inserção estruturada abaixo do cabeçalho principal
- Retorno da atualização automática dos headers de versão em arquivos `.sh` e `README.md`
- Reativação do fluxo completo de commit com `git add`, commit versionado e push automático quando conectado ao GitHub
- Padronização novamente da mensagem final utilizando `FINAL_STACK` em vez de `STACK_NAME`, garantindo maior precisão no histórico de commits
- Sincronização de testes e setup com a nova versão `v1.0.11` para manter consistência entre ambiente principal e ambiente de validação

## [1.0.10] - 2026-04-24
### 🧪 Testes Automatizados
- Atualização global da versão do projeto para `v1.0.10`
- Validação da propagação correta da nova versão em `src/main.sh`, `tests/setup_devlab.sh` e rotinas internas de atualização automática
- Continuidade dos testes de substituição seletiva de headers fixos `# Version: X.X.X` preservando placeholders dinâmicos como `$PROJECT_VERSION`
- Alteração do changelog automático para utilizar `🤖 auto-up` como descrição padrão de commits automáticos
- Reintrodução da rotina `☢️ REINICIAR DO ZERO (LIMPAR TUDO)` no ambiente de testes (`tests/devlab_git_manager.sh`)
- Recuperação da opção de reset completo do histórico Git local com preservação dos arquivos do projeto
- Testes do fluxo de remoção da pasta `.git`, reinicialização com `git init -b main` e reinício controlado do versionamento
- Validação do processo de recomeço de projetos antigos como nova base `v1.0.0`
- Ajustes de consistência entre setup, ambiente principal e scripts de testes para manter comportamento previsível durante reinicializações estruturais

## [1.0.9] - 2026-04-24
### 🧪 Testes Automatizados
- Ajuste no fallback padrão do tipo de commit para remover a categoria `Manutenção Geral Automática` e manter apenas `🛠️ Manutenção Geral`
- Alteração da descrição automática padrão de `🤖 Atualização Automática` para `🤖 auto-up`
- Refinamento do comportamento padrão para commits sem descrição manual informada
- Atualização global de versão para `v1.0.9`
- Validação da propagação correta da nova versão em `src/main.sh`, `tests/setup_devlab.sh` e `devlab_git_manager.sh`
- Continuidade dos testes de substituição seletiva de headers fixos sem afetar placeholders dinâmicos do `generate_header()`
- Ajustes de consistência entre ambiente principal e scripts de setup/testes para garantir sincronização completa da versão do projeto

## [1.0.8] - 2026-04-24
### 🧪 Testes Automatizados

- Atualização de versão global para `v1.0.8`
- Testes no `generate_header()` para garantir atualização correta apenas de valores fixos de versão (`# Version: X.X.X`)
- Validação da lógica para ignorar placeholders dinâmicos como `# Version: $PROJECT_VERSION`
- Ajustes no `sed` responsável pela substituição automática de versões nos arquivos `.sh` e `README.md`
- Revisão em `tests/devlab_git_manager.sh` simplificando o menu e removendo opções avançadas de reset e correção de commit
- Refatoração temporária da rotina de commit padronizado no ambiente de testes para validação isolada do fluxo principal
- Simplificação do fluxo de commits automáticos usando `git add .` antecipado e commit direto com mensagem formatada
- Testes de consistência entre versão persistida em `.devlab_version` e headers gerados automaticamente

### ♻️ Refatoração de Código

- Simplificada a lógica de atualização automática de versões dentro do processo de commit padronizado em `tests/devlab_git_manager.sh`.
- Removido temporariamente o sistema complexo de scanner automático de stacks (`MAP_STACKS`) durante os testes, priorizando validação direta do fluxo principal.
- Substituído o uso de `FINAL_STACK` por `STACK_NAME` capturado diretamente via `get_context()`, reduzindo inconsistências no nome da stack durante commits.
- Simplificado o processo de montagem de `COMMIT_MSG`, tornando o fluxo mais previsível para testes e depuração.

### 🛠️ Manutenção Geral

- Adicionado `git add .` logo no início do processo de commit padronizado para garantir inclusão automática de arquivos novos, modificados e deletados antes da geração do commit.
- Alterado o comportamento da descrição automática: ao pressionar ENTER sem informar texto, o sistema agora força `🧹 chore(auto):` com descrição padrão `Atualização automática`.
- Melhorado o tratamento de capitalização da primeira letra da descrição manual com formatação mais segura para UTF-8.
- Ajustado o fluxo de exibição da mensagem final de commit para exibir primeiro o commit gerado antes da execução.

### 🧹 Limpeza Estrutural

- Removidas temporariamente do ambiente de testes as opções:
  - Corrigir último commit
  - Reiniciar do zero
  - Zerar repositório completo
- O objetivo foi isolar o comportamento principal do sistema de commits e reduzir ruído durante a fase de validação funcional.

### 📝 Ajustes de Interface

- Simplificado o menu visual de tipos de commit no ambiente de testes para exibição mais compacta em linha única.
- Reduzido excesso de comentários internos e blocos auxiliares para facilitar leitura e inspeção durante debugging.
- Mantida a experiência de uso focada apenas no fluxo essencial de commit, push, pull e sincronização durante a fase de testes.

## [1.0.7] - 2026-04-24
### 🛠️ Manutenção Geral

- Reorganização estrutural completa do `devlab_git_manager.sh`, separando seções de CHECKUP, CONFIGURAÇÕES, CONTEXTO, STATUS, INPUT e funções auxiliares para melhor legibilidade e manutenção.
- Adicionado check inicial automático para validar se o diretório atual é realmente um repositório Git antes da execução do script.
- Implementado banner visual inicial do DEVLAB GIT MANAGER com carregamento mais limpo e padronizado.
- Criada função `pause()` centralizada para reutilização e melhor controle de fluxo entre operações do menu.
- Refatorada a função `get_context()` com leitura mais robusta de repositório, branch, versão, stack e status remoto.
- Adicionada leitura automática de `.devlab_version` e `.devlab_stack` com fallback seguro para projetos sem configuração prévia.
- Implementado sistema mais confiável de detecção de privacidade do repositório (`PRIVADO`, `PÚBLICO` e `LOCAL`) com cores visuais dinâmicas.
- Corrigido tratamento de repositórios órfãos ou removidos do GitHub, incluindo remoção automática de `origin` inválido.
- Adicionada captura automática do hash do último commit (`COMMIT_HASH`) para futura rastreabilidade.
- Criada verificação preventiva de conexão remota e exibição mais clara de status de sincronização.
- Adicionada verificação automática para ausência de repositório remoto com opção imediata de criação no GitHub.
- Melhorado o menu principal com exibição de versão atual, status remoto e privacidade de forma mais visual e organizada.

### ♻️ Refatoração de Código

- Reestruturado o fluxo da opção de sincronização de repositório para lidar melhor com repositórios locais, remotos e estados híbridos.
- Adicionado `git merge --allow-unrelated-histories -X ours` para integração segura entre repositório local e remoto já existente.
- Simplificado o processo de push e pull com mensagens mais claras e validações mais consistentes.
- Refatorado o scanner automático de stacks para detecção mais limpa e confiável de múltiplas tecnologias.
- Melhorada a classificação de projetos Multi-Stack com fallback automático para stack padrão.
- Reorganizado completamente o sistema de commit padronizado com nova estrutura visual e nova categorização de tipos.
- Padronizadas categorias mais profissionais para changelog como:
  - Novas Funcionalidades
  - Correções de Bugs
  - Manutenção Geral
  - Refatoração de Código
  - Atualizações de Segurança
  - Atualizações de Dependências
  - Integração Contínua
  - Suporte a Idiomas
- Ajustado o fallback automático para commits sem escolha válida usando padrão seguro de manutenção geral automática.
- Melhorado o tratamento de descrição padrão com uso de `🤖 Atualização Automática` quando o usuário não informa descrição.

### 🔐 Atualizações de Segurança

- Criado novo módulo dedicado de gestão de privacidade do repositório GitHub com leitura direta via API do GitHub CLI.
- Implementada alteração direta entre repositório PRIVADO e PÚBLICO usando `gh api -X PATCH`, reduzindo falhas com flags antigas.
- Melhorada a validação de permissões e feedback visual durante mudanças de visibilidade do repositório.

### 🧹 Limpeza e Controle

- Melhorada a limpeza automática de cache e arquivos temporários com otimização mais agressiva do banco Git (`git gc --prune=now --aggressive`).
- Mantida remoção automática de logs, arquivos temporários, backups e arquivos residuais de sistema como `.DS_Store`.
- Preservada limpeza específica por stack para ambientes Node.js e Python.

### 🔙 Ajustes Operacionais

- Melhorado o sistema de correção do último commit (`git commit --amend`) agora respeitando o padrão completo de nomenclatura do projeto.
- Ajustado o reset completo de repositório com fluxo mais limpo para reinicialização total local.
- Refinado o modo de limpeza extrema (`ZERAR REPOSITÓRIO`) com restauração automática opcional via GitHub.
- Simplificadas descrições e comentários internos das opções do menu para reduzir ruído visual e facilitar manutenção futura.

## [1.0.6] - 2026-04-24
### ♻️ Refatorado
- Revisão completa da estrutura principal do `devlab_engine`
- Reorganização interna do fluxo de criação de projetos
- Padronização visual da interface CLI com novo layout centralizado
- Ajuste estrutural no sistema de geração automática de arquivos
- Separação da lógica de criação com `create_file_with_header()`
- Refatoração completa do `generate_header()` com suporte dinâmico por stack
- Melhor organização dos blocos de funções e carregamento inicial

### 🚀 Adicionado
- Suporte expandido para múltiplas stacks:
  - HTML
  - CSS
  - JavaScript
  - TypeScript
  - Node.js
  - Python
  - PHP
  - Ruby
  - Java
  - Go
  - Rust
  - C#
  - Flutter
  - Kotlin
  - Swift
  - Bash
- Geração automática de headers específicos por linguagem
- Sistema de criação automática com templates iniciais por stack
- Novo menu visual de seleção de tecnologia
- Criação padronizada de estrutura profissional:
  - `src`
  - `docs`
  - `tests`
  - `logs`
  - `assets`
  - `build`
- Inicialização automática de `.devlab_version`
- Controle inicial de versionamento automático
- Expansão massiva da documentação no `README.md`
- Guia completo de estrutura de pastas
- Guia de padronização de emojis e commits
- Conventional Commits documentado diretamente no projeto
- Novo sistema de commit padronizado no `devlab_git_manager`
- Scanner automático de stacks do projeto
- Detecção de projetos Multi-Stack
- Menu profissional de tipos de commit
- Categorias automáticas para `CHANGELOG.md`
- Correção automática de mensagens e padronização de commits
- Sistema de edição do último commit (`amend`)
- Sistema de reset seguro
- Sistema de reinicialização completa do projeto
- Sistema de destruição total com recuperação opcional via GitHub
- Limpeza automática de cache e arquivos temporários
- Push e Pull separados como operações independentes
- Sistema inteligente de sincronização com GitHub
- Vinculação automática de repositórios órfãos
- Criação automática de repositórios ausentes
- Detecção automática de privacidade do repositório
- Gerenciamento visual de privacidade (público/privado)
- Renomeação completa de repositório local/remoto
- Exclusão segura de repositório GitHub
- Histórico de commits formatado profissionalmente

### 📝 Alterado
- `CONTRIBUTING` renomeado e padronizado
- `CODE OF CONDUCT` reorganizado
- Estrutura inicial do `CHANGELOG.md` reformulada
- Template inicial do README completamente expandido
- Processo de criação de repositório GitHub agora mais seguro
- Fluxo de sincronização com repositórios já existentes foi protegido contra conflitos
- Commit inicial alterado para padrão:
  `🔥 init: (...)`

### 🐛 Corrigido
- Correção de inconsistência visual no cabeçalho principal da CLI
- Correção na lógica de criação de arquivos iniciais
- Correção no fluxo de versionamento automático
- Correção de falhas em repositórios já existentes no GitHub
- Correção de problemas com `remote origin` órfão
- Correção no processo de sincronização entre local e remoto
- Correção de conflitos durante criação de projeto com mesmo nome existente
- Ajustes em permissões automáticas de arquivos executáveis

## [1.0.5] - 2026-04-23
### 🛠️ Reinicializado
- Reestruturação do fluxo após falha crítica identificada na versão anterior.
- Reinício controlado do desenvolvimento para preservar estabilidade do projeto.
- Ajuste da base de versionamento para evitar propagação de inconsistências.
- Nova preparação da estrutura principal mantendo o histórico funcional anterior.
- Continuidade do projeto a partir de uma base mais segura e previsível.

## [1.0.4] - 2026-04-23
### 🐛 Corrigido
- Correção no sistema de captura e exibição dinâmica da stack do projeto via `README.md`.
- Ajuste no processo de versionamento automático com inclusão do hash do último commit no `CHANGELOG`.
- Correção da atualização automática de headers `# Version:` para refletir corretamente a nova versão.
- Ajuste no fluxo de sincronização Git para evitar inconsistências entre commit, versionamento e push remoto.
- Correção na exibição de status do repositório com versão atual, remote e privacidade do GitHub.
- Tratamento mais seguro para repositórios sem conexão remota ou sem sincronização com GitHub.

### 🛠️ Melhorado
- Reestruturação do menu do Git Manager com operações mais seguras de reset, rename, delete e alteração de privacidade.
- Melhoria no fluxo de criação de repositório remoto com validação automática de identidade Git.
- Simplificação e estabilização do workflow de CI para execução direta dos testes configurados.
- Melhor feedback visual e operacional durante processos críticos de Git e GitHub.

## [1.0.2] - 2026-04-22
### 🚀 Adicionado
- Implementação do sistema de versionamento dinâmico automático.
- Criação das funções de leitura e incremento de versão via `.devlab_version`.
- Atualização automática de headers e controle de versão em arquivos do projeto.
- Geração automática de entradas no `CHANGELOG.md` durante novos commits.
- Estrutura inicial de CI com workflow GitHub Actions (`.github/workflows/ci.yml`).
- Templates expandidos com LICENSE, CONTRIBUTING, CODE_OF_CONDUCT e README mais completos.
- Validação de repositório Git local e verificação automática de repositório remoto no GitHub.

### 🛠️ Alterado
- Refatoração do gerador de headers com suporte a versão dinâmica.
- Melhoria no fluxo de criação de projetos e definição automática de stack.
- Reorganização do Git Manager com sincronização mais segura entre local e remoto.
- Padronização da criação de commits com incremento automático de versão.
- Melhorias na experiência de uso com feedback visual, validações e status operacional.

## [1.0.1] - 2026-04-22
### 🚀 Adicionado
- Estrutura inicial de configurações do projeto.
- Implementação da versão 1.0.1 no controle interno (.devlab_version).
- Atualização do CHANGELOG com início do versionamento incremental.
- Base preparada para futuras automações e gerenciamento de configuração.

## [1.0.0] - 2026-04-22
### 🚀 Inicial
- Início de projeto
- Estrutura inicial do projeto devlab_engine com o DevLab CLI.
- Configuração de CI/CD (GitHub Actions).
- Headers de licença MIT e bilingue.

### 🛠️ Alterado
- Stack definida para: Bash.
