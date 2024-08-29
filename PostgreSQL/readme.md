# Praceando - Banco de Dados

## Descrição

O banco de dados do aplicativo **Praceando** é o núcleo central onde todas as informações são armazenadas, processadas e recuperadas. Ele sustenta todas as operações do aplicativo, garantindo que os dados provenientes de APIs, servlets, formulários e outras fontes sejam armazenados de maneira segura e acessível. Para garantir a melhor performance e atender às diversas necessidades do sistema, os dados são distribuídos em diferentes tipos de bancos de dados, incluindo PostgreSQL, MongoDB, Firebase e Redis.

## Objetivo

O objetivo do banco de dados do Praceando é fornecer uma estrutura robusta e escalável para o armazenamento e recuperação de dados, permitindo que o aplicativo funcione de forma eficiente e confiável. Ele é projetado para suportar uma variedade de operações, desde transações complexas até armazenamento em cache de informações frequentemente acessadas, garantindo a integridade e a disponibilidade dos dados em todo o sistema.

## Tecnologias

O banco de dados do Praceando utiliza as seguintes tecnologias:

- **PostgreSQL**: Utilizado para o armazenamento de dados relacionais, garantindo consistência e suporte a transações complexas.
- **MongoDB**: Empregado para o armazenamento de dados não relacionais, como documentos JSON, permitindo maior flexibilidade na estruturação das informações.
- **Firebase**: Utilizado para autenticação, sincronização em tempo real e notificações push, oferecendo uma solução integrada e escalável para funcionalidades de front-end.
- **Redis**: Utilizado como um banco de dados em memória para caching, proporcionando acesso ultrarrápido a dados frequentemente acessados.

## Endpoints

Os serviços de banco de dados do Praceando são acessados através dos seguintes endpoints:

- **PostgreSQL**:  `postgresql://<user>:<password>@localhost:5432/praceando_db`
- **MongoDB**: `mongodb://<user>:<password>@localhost:27017/praceando_db`
- **Redis**: `redis://<user>:<password>@localhost:6379`
- **Firebase**: `https://<your-database-name>.firebaseio.com/`

Certifique-se de que os endpoints estão configurados corretamente nas configurações do aplicativo para que ele possa se conectar e operar com os bancos de dados.

---
Enviando nossos melhores insights, com 95% de confiança e 100% de amor. 🎲❤️ - equipe de dados!
- [Fernanda Leão](https://github.com/fernandaleaoleita)
- [Guilherme Barbosa](https://github.com/guii-barbosa)
>>>>>>> acf1fb3cb96e89167f8af8f495cfabf48136d720