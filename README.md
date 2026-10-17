# 🚀 DEVLAB ENGINE

> **CLI de Automação e Gerenciamento de Projetos Multi-Stack** > Desenvolvido por **César Godinho (CSRG42)**

O **DevLab Engine** é uma ferramenta robusta escrita em Bash para acelerar a criação de ambientes de desenvolvimento, padronizar estruturas de pastas e automatizar o ciclo de vida do Git com inteligência.

---

## 🛠️ O que ele faz?

- **Scaffolding Inteligente:** Cria a estrutura de pastas (`src`, `docs`, `tests`, etc.) para 16 tecnologias diferentes.
- **Headers Automáticos:** Insere cabeçalhos de licença e autoria em cada arquivo criado, respeitando o comentário da stack (ex: `#` para Python, `//` para JS).
- **Git Manager Integrado:** Um menu dedicado para gerenciar commits, push, pull e sincronia com o GitHub via `gh cli`.
- **Versionamento Automático:** Controle de versão via arquivo `.devlab_version`.
- **CI/CD Pronto:** Já gera o workflow do GitHub Actions configurado para a stack escolhida.
---

## 📁 Estrutura de Pastas Gerada

O **DevLab Engine** organiza seu projeto seguindo padrões de mercado para garantir escalabilidade e organização:

```
meu-projeto/
├── assets/          # Recursos estáticos (imagens, ícones, fontes)
├── build/           # Arquivos temporários de compilação/transpilação
├── docs/            # Documentação técnica e manuais do usuário
├── logs/            # Registros de execução (inclui .gitkeep)
├── releases/        # Binários e pacotes prontos para distribuição (ex: .deb, .zip)
├── src/             # Código-fonte principal do projeto
├── tests/           # Scripts de testes unitários e de integração
├── .devlab_stack    # Identificador da stack tecnológica utilizada
├── .devlab_version  # Controle de versão semântica do projeto
├── .gitignore       # Regras para ignorar arquivos (incluindo build e releases)
└── README.md        # Guia rápido e visão geral do projeto
```

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

## 🚀 Como Usar

### 1. Requisitos

Certifique-se de ter instalado no seu sistema:

- `git`    
- `gh` (GitHub CLI)

O script tentará instalar se não encontra.

### 2. Instalação

Clone este repositório e dê permissão de execução ao motor:

Bash

```
git clone https://github.com/CSRG42/devlab_engine.git
cd devlab_engine
chmod +x devlab_engine.sh
```

### 3. Criando um Novo Projeto

Execute o motor e siga as instruções no terminal:

```
./setup_devlab.sh
```

1. Digite o nome do projeto.    
2. Escolha a Stack (ex: 6 para Python, 16 para Bash).
3. O motor criará a pasta dentro de `Core/` com tudo configurado.

---

### Git Manager

Dentro da pasta do seu novo projeto, use o gerenciador pelo terminal ou execute-o como programa.

```
./devlab_git_manager.sh
```

---

## 🤖 Padrões de Automação (Logs & Commits)

O motor utiliza prefixos visuais para facilitar a leitura do histórico:

- `📡 integração:` Sincronia entre repositório local e remoto.    
- `🤖 auto-up:` Atualizações automáticas de sistema e versão.
- `✅ sincronia:` Confirmação de pareamento bem-sucedido.

---

## 💡 Recomendações de Uso

1. **Mantenha o `.devlab_version`:** Não apague este arquivo. Ele é o ponto de controle essencial para o motor identificar a versão atual e o status do seu projeto.   
2. **Use o Git Manager:** Para manter o padrão de logs do **DevLab**, evite o `git commit` manual. O gestor realiza o scanner automático de stacks e organiza as mensagens de commit para você.
3. **GitHub Actions:** Após o primeiro push, verifique a aba **Actions** no seu repositório. O motor configura automaticamente o _ShellCheck_ (para scripts Bash) ou os testes específicos da sua stack.
4. **Segurança:** Por segurança, o motor define novos repositórios como **Privados**. Caso precise torná-los públicos, utilize a **opção 9** no menu do Git Manager.
5. **Changelog:** Utilize os comandos abaixo para documentar o progresso ou auxiliar na atualização manual do arquivo de mudanças:

```
#Para salvar o histórico resumido (visual):
git log --oneline --graph --all > historico.txt
      
#Para salvar o histórico detalhado (com diffs de código):
git log -p --all > mudancas_completas.txt
```

## Dica Extra:

Se o seu projeto crescer muito, o arquivo `mudancas_completas.txt`  pode ficar gigantesco. Uma boa prática é sugerir ao usuário limitar o log às últimas alterações, por exemplo: `git log -p -n 5` (para ver apenas as últimas 5).

```
#Histórico Resumido (Visualização de fluxo):
git log --oneline --graph --all -n 5 > historico.txt
      
#Histórico de Alterações Recentes (Código):
git log -p --all -n 5 > mudancas_completas.txt
```

---

## 🚀 Como usar
1. Clone o repositório
2. Instale as dependências (se houver)
3. Execute o projeto via src/

---

## 👨‍💻 Developed by
**César Godinho (CSRG42)**

## 🌐 Links
- [GitHub](https://github.com/CSRG42)
- [Instagram](https://instagram.com/csrg42/)
- [YouTube](https://youtube.com/seucanal)

---

*Criado em: 22/04/2026 15:05*