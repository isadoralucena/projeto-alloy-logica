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


// ---- Funções ----


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


// ---- Predicados ----


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

/* Cenário exemplo que define um possível modelo(s) para o projeto.
*/
pred cenarioExemplo {
  one u: Usuario | #u.repositorios = 0
  one u: Usuario | #u.repositorios = 5
  one r: Repositorio | #r.(~repositorios) = 0
  one o: Organizacao | #usuariosDaOrganizacao[o] = 0
  one o: Organizacao | #repositoriosDaOrganizacao[o] = 0
}


// ---- Fatos ----


/* Os predicados que constituem as especificação do projeto.
*/
fact especificacao {
  restricaoAcessoUsuarioRepositorio
  limiteRepositoriosPorUsuario
}


// ---- Asserts - Verificações Diretas ----


/* Usuários só devem ter acesso aos repositórios da sua própria organização.
 * Se houver contraexemplo, significa que a regra está sendo violada.
*/
assert usuarioNaoAcessaRepositorioDeOutraOrganizacao {
  all u: Usuario, r: u.repositorios | r.organizacao = u.organizacao
}

/* Não se espera que um usuário tenha um volume muito alto de acessos: geralmente,
 * um desenvolvedor participa ativamente de no máximo cinco repositórios.
 * Se houver contraexemplo, significa que a regra está sendo violada.
*/
assert nenhumUsuarioUltrapassaCincoRepositorios {
  all u: Usuario | #u.repositorios <= 5
}

/* Todo usuário pertence a exatamente uma organização */
assert usuarioPertenceAUmaOrganizacao {
  all u: Usuario | one u.organizacao
}

/* Todo repositório pertence a exatamente uma organização */
assert repositorioPertenceAUmaOrganizacao {
  all r: Repositorio | one r.organizacao
}


// ---- Asserts - Verificações Indiretas ----


/* Organizações podem ter zero usuários
 * Se este assert gerar um contraexemplo, confirma que o modelo
 * permite organizações sem usuários.
*/
assert organizacaoDeveTerUsuarios {
  all o: Organizacao |
    some usuariosDaOrganizacao[o]
}

/* Organizações podem ter zero repositórios.
 * Se este assert gerar um contraexemplo, confirma que o modelo
 * permite organizações sem repositórios.
*/
assert organizacaoDeveTerRepositorios {
  all o: Organizacao |
    some repositoriosDaOrganizacao[o]
}

/* Organizações podem ter usuários
 * Se este assert gerar um contraexemplo, confirma que o modelo
 * permite organizações com usuários.
*/
assert organizacaoNaoPodeTerUsuarios {
  all o: Organizacao |
    no usuariosDaOrganizacao[o]
}

/* Organizações podem ter repositórios.
 * Se este assert gerar um contraexemplo, confirma que o modelo
 * permite organizações com repositórios.
*/
assert organizacaoNaoPodeTerRepositorios {
  all o: Organizacao |
    no repositoriosDaOrganizacao[o]
}

/* É aceitável que existam usuários sem acesso a repositórios.
 * Isso é verificado caso este assert gere um modelo contraexemplo.
*/
assert todosUsuariosComAcessoARepositorios {
  all u: Usuario | some u.repositorios
}

/* É aceitável que existam repositórios sem usuários definidos.
 * Isso é verificado caso este assert gere um modelo contraexemplo.
*/
assert todosRepositoriosComUsuarios {
  all r: Repositorio | some r.(~repositorios)
}


// ---- Testes ----


run cenarioExemplo for 6

check usuarioNaoAcessaRepositorioDeOutraOrganizacao
check nenhumUsuarioUltrapassaCincoRepositorios
check usuarioPertenceAUmaOrganizacao
check repositorioPertenceAUmaOrganizacao
check organizacaoDeveTerUsuarios
check organizacaoDeveTerRepositorios
check organizacaoNaoPodeTerUsuarios
check organizacaoNaoPodeTerRepositorios
check todosUsuariosComAcessoARepositorios
check todosRepositoriosComUsuarios
