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
 * Usuários não podem pertencer a múltiplas organizações,
 * garantindo que as regras de acesso permaneçam consistentes e previsíveis
*/
sig Usuario{
  organizacao: one Organizacao,
  repositorios: set Repositorio
}

/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Sob nenhuma circunstância um usuário pode acessar repositórios de outras organizações,
 * mesmo que participe de múltiplos projetos. 
 * Isso garante segurança e especifica os limites entre organizações
*/
pred restricaoAcessoUsuarioRepositorio {
  all u: Usuario, r: u.repositorios | r.organizacao = u.organizacao
}

/* Um desenvolvedor participa ativamente de no máximo cinco repositórios,
 * o que ajuda a manter a produtividade e a organização.
*/
pred limiteRepositoriosPorUsuario {
  all u: Usuario | #u.repositorios <= 5
}

/* Os predicados que constituem as especificação do projeto.
*/
fact especificacao {
  restricaoAcessoUsuarioRepositorio
  limiteRepositoriosPorUsuario
}

/* É aceitável que existam usuários sem acesso a repositórios.
 * Isso é verificado caso o assert gere um modelo contraexemplo.
 * A afirmativa diz que todo usuário tem acesso a pelo menos um repositório,
 * o que nem sempre é verdade.
*/
assert todosUsuariosComAcessoARepositorios {
  all u: Usuario | some u.repositorios
}

/* É aceitável que existam repositórios sem usuários definidos.
 * Isso é verificado caso o assert gere um modelo contraexemplo.
 * A afirmativa diz que todo repositório tem pelo menos um usuário definido,
 * o que nem limiteRepositoriosPorUsuariosempre é verdade.
*/
assert todosRepositoriosComUsuarios {
  all r: Repositorio | some r.(~repositorios)
}

/* Cenário exemplo que define um possível modelo para o projeto.
*/
pred cenarioExemplo {
  one u: Usuario | #u.repositorios = 0
  one u: Usuario | #u.repositorios = 5
  one r: Repositorio | #r.(~repositorios) = 0
}

run cenarioExemplo for 5

check todosUsuariosComAcessoARepositorios
check todosRepositoriosComUsuarios
