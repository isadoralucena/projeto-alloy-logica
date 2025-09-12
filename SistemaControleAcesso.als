module SistemaControleAcesso

/* Define o conjunto de organizações existentes no sistema.
*/
sig Organizacao{
}

/* Define o conjunto de repositórios do sistema.
 * Cada repositório pertence a exatamente uma organização,
 * garantindo que não existam repositórios compartilhados entre múltiplas organizações.
*/
sig Repositorio{
  organizacao: one Organizacao
}

/* Define o conjunto de usuários do sistema.
 * Cada usuário deve estar associado a exatamente uma organização. 
 * Usuários não podem pertencer a múltiplas organizações
 * garantindo que as regras de acesso permaneçam consistentes e previsíveis
*/
sig Usuario{
  organizacao: one Organizacao
  repositorios: set Repositorio
}

/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Sob nenhuma circunstância um usuário pode acessar repositórios de outras organizações, mesmo que participe de múltiplos projetos. 
 * Isso garante segurança e mantém os limites entre organizações
*/
fact AcessoRepositorios {
  all u: Usuario, r: u.repositorios | r.organizacao = u.organizacao
}


run {}
