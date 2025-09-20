# Modelagem de Sistema de Controle de Acesso

### Descrição

Modelagem, em Alloy, de um sistema simples de controle de acesso a repositórios de código em uma plataforma colaborativa. 

O sistema garante que cada repositório pertença a uma única organização e que cada usuário esteja vinculado a uma organização. Usuários só podem acessar repositórios de sua própria organização, sendo aceitável que alguns repositórios ou usuários ainda não tenham acessos definidos. Em geral, um usuário participa de no máximo cinco repositórios, mantendo a organização e produtividade.

Projeto final da disciplina de Lógica para Computação, Curso de Ciência da Computação, UFCG, 2025.1.

---

### Requisitos do sistema

**1. Organização dos repositórios**

- Repositórios são sempre gerenciados dentro de uma única organização, ou seja, não existem repositórios "soltos" nem compartilhados entre organizações.

**2. Associação de usuários a organizações**

- Usuários atuam dentro de organizações específicas, estando cada um vinculado a uma única organização.

**3. Acesso interno aos repositórios**

- O acesso dos usuários a repositórios é sempre interno: um usuário pode interagir apenas com os repositórios que fazem parte da mesma organização à qual ele pertence.

- A plataforma não permite, sob nenhuma hipótese, que um usuário acesse repositórios fora de sua organização, mesmo que esteja envolvido em múltiplos projetos.

**4. Situações aceitáveis**

- É aceitável que existam repositórios sem usuários definidos e usuários que ainda não têm acesso a repositórios.

**5. Limite de participação**

- Não se espera que um usuário tenha um volume muito alto de acessos: geralmente, um desenvolvedor participa ativamente de no máximo cinco repositórios, o que ajuda a manter a produtividade e a organização.

---

### Objetivo

- Exercitar a especificação e modelagem de sistemas usando lógica de predicado, tratando sua indecidibilidade a partir do uso de modelos lógicos finitos.
- A plataforma Alloy Analyzer transforma lógica de predicados em lógica proposicional e utiliza SAT Solvers para medir contradição e satisfatibilidade lógica, mas não prova a validade para todos os escopos, apenas para o escopo finito definido pelo usuário.

---

### Execução do modelo no Alloy Analyzer

**1. Abrir o Alloy Analyzer**  
   - Inicie o software em sua máquina.

**2. Carregar o arquivo do modelo**  
   - Abra o arquivo `SistemaControleAcesso.als`.

**3. Executar o cenário de exemplo**  
   - No Alloy Analyzer, clique em **Run** e selecione o predicado `cenarioExemplo`.  
   - Defina o **escopo** para 6 elementos (ou conforme desejado):  
     ```alloy
     run cenarioExemplo for 6
     ```
   - Isso gera um modelo possível do sistema, mostrando usuários, repositórios e organizações conforme o predicado.

**4. Verificar as asserções (asserts)**  
   - O modelo possui **dois tipos de asserts**:

     **a) Assert de verificação direta**  
     - Correspondem a regras **que não podem ser violadas** pelo sistema.
       
       ```alloy
       check usuarioNaoAcessaRepositorioDeOutraOrganizacao
       check nenhumUsuarioUltrapassaCincoRepositorios
       check usuarioPertenceAUmaOrganizacao
       check repositorioPertenceAUmaOrganizacao
       ```
     - **Interpretação:**  
       - Se **não houver contraexemplo**, a regra está satisfeita dentro do escopo definido.  
       - Se houver contraexemplo, significa violação da regra obrigatória.

     **b) Assert de verificação indireta**  
     - Correspondem a **situações que são permitidas ou esperadas**, como usuários sem repositórios ou repositórios sem usuários.  
     - Todos esses asserts **devem gerar contraexemplo**, confirmando que o modelo permite essas situações.

       ```alloy
       check organizacaoDeveTerUsuarios
       check organizacaoDeveTerRepositorios
       check organizacaoNaoPodeTerUsuarios
       check organizacaoNaoPodeTerRepositorios
       check todosUsuariosComAcessoARepositorios
       check todosRepositoriosComUsuarios
       ```
     - **Interpretação:**  
       - Se o Alloy gerar um contraexemplo, isso indica que o modelo permite a situação, o que é esperado.  

**5. Explorar o modelo**  
   - Visualize o diagrama gerado pelo Alloy Analyzer para entender a distribuição de usuários, repositórios e organizações.  
   - Identifique cenários específicos, como usuários sem repositórios ou repositórios sem usuários, conforme definido pelos asserts indiretos.

---

### Diretrizes para a modelagem

- Usar assinaturas (`sig`), relações binárias, cardinalidades, `extends` ou `in` (se desejar especializar algo), e quantificadores nos fatos.
- Incluir pelo menos duas asserções(`asserts`) que permitam verificar propriedades desejáveis do sistema.
- Criar um cenário exemplo(`run`) e usar pelo menos escopo 5.

---

### Estrutura do modelo

- **Signatures (assinaturas)**: `Organizacao`, `Repositorio`, `Usuario`  
- **Funções**: `repositoriosDaOrganizacao`, `usuariosDaOrganizacao`  
- **Predicados**: `restricaoAcessoUsuarioRepositorio`, `limiteRepositoriosPorUsuario`, `cenarioExemplo`  
- **Fatos**: regras obrigatórias sempre válidas  
- **Asserts**: verificações diretas e indiretas do modelo

---

### Integrantes do grupo

- [Andrey Kauã](https://github.com/Andrey-Kaua)  
- [Isadora Lucena](https://github.com/isadoralucena)  
- [Lucas Henrique](https://github.com/lucashhps)  
- [Matheus Palmeira](https://github.com/Mapalmeira)  
- [Thiago Barbosa](https://github.com/Thiago-Barbos)

---

### Componente curricular

- **Disciplina:** Lógica para Computação
- **Período:** 2025.1
- **Professor:** Tiago Lima Massoni

---

### Ferramenta utilizada

- **Alloy Analyzer**: [https://alloytools.org/](https://alloytools.org/)  
