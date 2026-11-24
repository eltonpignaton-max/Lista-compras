# Lista de Compras
1. Crie um projeto Supabase separado do sistema de convidados.
2. No SQL Editor, execute banco.sql uma única vez. Em Authentication > Users, crie os usuários autorizados e desabilite cadastro público nas configurações de autenticação. Todos os usuários autenticados deste projeto têm acesso integral à lista.
3. Copie .env.example para .env e preencha URL e chave pública anon/publishable do projeto (nunca use service_role).
4. Instale Node.js 22, execute npm install e npm run dev. Para produção, npm run build e publique o conteúdo de dist em hospedagem HTTPS. Se publicar em subpasta, use npm run build -- --base=/compras/ (ajuste o caminho).
5. Excel: primeira aba, primeira linha com Quantidade, Unidade, Tipo, Descrição. Tipos F/G/O. Quantidade positiva. A importação substitui a lista em uma transação; linhas inválidas impedem a substituição. Limite inicial de 1000 linhas por importação. Duplicatas são preservadas.
6. Teste com dois dispositivos: login, importação, marcação, inclusão, exclusão e nova importação. Realtime e atualização periódica dependem de internet. Não há modo offline, histórico ou separação de permissões nesta versão.
