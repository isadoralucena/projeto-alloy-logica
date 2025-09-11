# Modelagem de Sistema de Controle de Acesso

### Descrição

Modelagem, em Alloy, de um sistema simples de controle de acesso a repositórios de código em uma plataforma colaborativa. 

O sistema garante que cada repositório pertença a uma única organização e que cada usuário esteja vinculado a uma organização. Usuários só podem acessar repositórios de sua própria organização, sendo aceitável que alguns repositórios ou usuários ainda não tenham acessos definidos. Em geral, um usuário participa de no máximo cinco repositórios, mantendo a organização e produtividade.

Projeto final da disciplina de Lógica para Computação, Curso de Ciência da Computação, UFCG, 2025.1.

### Requisitos

1. **Organização dos repositórios**

- Repositórios são sempre gerenciados dentro de uma única organização, ou seja, não existem repositórios "soltos" nem compartilhados entre organizações.

2. **Associação de usuários a organizações**

- Usuários atuam dentro de organizações específicas, estando cada um vinculado a uma única organização.

3. **Acesso interno aos repositórios**

- O acesso dos usuários a repositórios é sempre interno: um usuário pode interagir apenas com os repositórios que fazem parte da mesma organização à qual ele pertence.

- A plataforma não permite, sob nenhuma hipótese, que um usuário acesse repositórios fora de sua organização, mesmo que esteja envolvido em múltiplos projetos.

4. **Situações aceitáveis**

- É aceitável que existam repositórios sem usuários definidos e usuários que ainda não têm acesso a repositórios.

5. **Limite de participação**

- Não se espera que um usuário tenha um volume muito alto de acessos: geralmente, um desenvolvedor participa ativamente de no máximo cinco repositórios, o que ajuda a manter a produtividade e a organização.

### Objetivo

- Exercitar a especificação e modelagem de sistemas usando lógica de predicado, tratando sua indecidibilidade a partir do uso de modelos lógicos finitos.
- A plataforma Alloy Analyzer transforma lógica de predicados em lógica proposicional e utiliza SAT Solvers para medir contradição e satisfatibilidade lógica, mas não prova a validade para todos os escopos, apenas para o escopo finito definido pelo usuário.

### Integrantes do grupo

- Andrey Kauã
- Isadora Lucena
- Lucas Henrique
- Matheus Palmeira
- Thiago Barbosa

### Componente curricular

- **Disciplina:** Lógica para Computação
- **Período:** 2025.1
- **Professor:** Tiago Lima Massoni