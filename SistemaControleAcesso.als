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

run {}