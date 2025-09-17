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
 * garantindo que as regras de acesso permaneçam consistentes e previsíveis.
*/
sig Usuario{
  organizacao: one Organizacao,
  repositorios: set Repositorio
}

/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Sob nenhuma circunstância um usuário pode acessar repositórios de outras organizações,
 * mesmo que participe de múltiplos projetos. 
 * Isso garante segurança e especifica os limites entre organizações.
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

/* Uma função que retorna os repositórios de uma determinada organização.
*/
fun repositoriosDaOrganizacao[o: Organizacao]: Repositorio {
  o.(~(this/Repositorio <: organizacao))
}

/* Uma função que retorna os usuários de uma determinada organização.
*/
fun usuariosDaOrganizacao[o: Organizacao]: Usuario {
  o.(~(this/Usuario <: organizacao))
}

/* Cenário exemplo que define um possível modelo(s) para o projeto.
*/
pred cenarioExemplo {
  one u: Usuario | #u.repositorios = 0
  one u: Usuario | #u.repositorios = 5
  one r: Repositorio | #r.(~repositorios) = 0
  one o: Organizacao | #usuariosDaOrganizacao[o] = 0
  one o: Organizacao | #repositoriosDaOrganizacao[o] = 0
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
 * o que nem sempre é verdade.
*/
assert todosRepositoriosComUsuarios {
  all r: Repositorio | some r.(~repositorios)
}

/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Se houver contraexemplo, significa que a regra está sendo violada.
*/
assert usuarioNaoAcessaRepositorioDeOutraOrganizacao {
  all u: Usuario, r: u.repositorios | r.organizacao = u.organizacao
}

/* Não se espera que um usuário tenha um volume muito alto de acessos: geralmente,
 * um desenvolvedor participa ativamente de no máximo cinco repositórios, 
 * o que ajuda a manter a produtividade e a organização.
 * Se houver contraexemplo, significa que a regra está sendo violada.
*/
assert nenhumUsuarioUltrapassaCincoRepositorios {
  all u: Usuario | #u.repositorios <= 5
}

/* A plataforma não permite, sob nenhuma hipótese, 
 * que um usuário acesse repositórios fora de sua organização, 
 * mesmo que esteja envolvido em múltiplos projetos.
 * Se houver contraexemplo, significa que a regra está sendo violada.
*/
assert repositoriosDoUsuarioNaMesmaOrganizacao {
 all u: Usuario | all r: u.repositorios | r.organizacao = u.organizacao
}
run cenarioExemplo for 6

check todosUsuariosComAcessoARepositorios
check todosRepositoriosComUsuarios
check usuarioNaoAcessaRepositorioDeOutraOrganizacao
check nenhumUsuarioUltrapassaCincoRepositorios
check repositoriosDoUsuarioNaMesmaOrganizacao