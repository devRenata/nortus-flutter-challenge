# 📱 Flutter News App — Loomi Challenge

## Introdução

Este projeto foi desenvolvido como parte do Flutter Challenge da Loomi, com o objetivo de demonstrar arquitetura, qualidade de código, gerenciamento de estado, integração de API e tomada de decisões sob restrições de tempo.
O aplicativo **Nortus News** permite que os usuários se autentiquem, naveguem por um feed de notícias paginado, pesquisem localmente, visualizem detalhes, gerenciem favoritos e atualizem seus perfis.

## 🏗️ Arquitetura

## ✔️ Fluxos implementados
### Autenticação
- [x] Login com validação de formulários
- [x] Manter-se conectado via shared_preferences
- [x] Autenticação simulada via API mockada
### Lista de notícias
- [x] Rolagem infinita com paginação via API
- [x] Exibição de título, image e resumo
- [x] Busca de notícias local por texto
### Detalhes da notícia
- [x] Exibição de conteúdo completo obtido da API
- [x] Notícias relacionadas ao final da página
### Favoritos
- [x] Persistência em memória durante build
### Perfil
- [x] Obtido dados do usuário da API
- [x] Campos preenchidos previamente com dados do usuário
- [x] Simulação de atualização perfil
### Feedback & UI
- [x] Snackbars para sucesso e erro
- [x] Indicadores de carregamento para todas as requisições
- [x] Responsividade básica

## 🖼️ Screenshots
<p align="left">
  <img src="docs/screenshots/splesh-screen.jpeg" width="20%"/>
  <img src="docs/screenshots/sign-in-screen.jpeg" width="20%"/>
  <img src="docs/screenshots/sign-up-screen.jpeg" width="20%"/>
</p>

## 🚀 Pontos para melhoria futura
- Adicionar cobertura de testes para Repositories, Datasources e Usecases;
- Adicionar suporte à offline, utilizando informações em cache;
- Otimizar carregamento de imagens;

## 🧰 Tecnologias utilizadas
- Dio;
- Bloc;
- Provider;
- GoRouter;
- GetIt;
- Shared Preferences;

## 🚀 Como executar o projeto

1. **Clone o repositório**
```bash
git clone https://github.com/devRenata/nortus-flutter-challenge.git
cd nortus-flutter-challenge
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```
