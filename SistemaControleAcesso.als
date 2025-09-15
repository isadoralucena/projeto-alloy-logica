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
  organizacao: one Organizacao,
  repositorios: set Repositorio
}

/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Sob nenhuma circunstância um usuário pode acessar repositórios de outras organizações,
 * mesmo que participe de múltiplos projetos. 
 * Isso garante segurança e mantém os limites entre organizações
*/
fact RestricaoAcessoUsuarioRepositorio {
  all u: Usuario, r: u.repositorios | r.organizacao = u.organizacao
}

/* Um desenvolvedor participa ativamente de no máximo cinco repositórios,
 * o que ajuda a manter a produtividade e a organização.
*/
fact LimiteRepositoriosPorUsuario {
  all u: Usuario | #u.repositorios <= 5
}

/* É aceitável que existam usuários sem acesso a repositórios.
 * Isso é verificado caso a afirmativa gere um modelo contraexemplo.
 * A afirmativa diz que todo usuário tem acesso a pelo menos um repositório,
 * o que nem sempre é verdade.
*/
assert todosUsuariosComAcessoARepositorios {
  all u: Usuario | some u.repositorios
}

/* É aceitável que existam repositórios sem usuários definidos.
 * Isso é verificado caso a afirmativa gere um modelo contraexemplo.
 * A afirmativa diz que todo repositório tem pelo menos um usuario definido,
 * o que nem sempre é verdade.
*/
assert todosRepositoriosComUsuarios {
  all r: Repositorio | some r.(~repositorios)
}

run {}

check todosUsuariosComAcessoARepositorios
check todosRepositoriosComUsuarios
