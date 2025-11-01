# CS2 Skins Marketplace (Frontend Only)

Flutter + Dart **frontend** (sem backend) com telas e navegação completas:

## Requisitos Funcionais implementados
- **RF-0001 – Login**: validação simples e navegação para a Home.
- **RF-0002 – Tela Principal (Compras)**: grade responsiva de itens com busca/filtro.
- **RF-0003 – Grid de Itens**: `GridView` com `SkinCard` e imagens nos assets (cover_1.png, cover_2.png, cover_3.png, cover_4.png).
- **RF-0004 – Tela de Item**: detalhes (preço, raridade, wear, StatTrak) + adicionar ao carrinho.
- **RF-0005 – Filtro de Pesquisa**: bottom sheet (`FilterPanel`) com texto, raridade e StatTrak.
- **RF-0006 – Carteira**: saldo, carrinho, simulação de compra, extrato de transações.
- **RF-0007 – Tela de Troca**: seleção de item e envio de oferta (simulado).
- **RF-0008 – Menu do Usuário**: bottom sheet com links para Carteira e Configurações.
- **RF-0009 – Configuração do Usuário**: preferências mock (tema, biometria, notificações).

## Requisitos Não-Funcionais atendidos (frontend)
- **RNF-0001 – Desempenho**: listas/grades eficientes; assets locais; sem I/O de rede.
- **RNF-0002 – Segurança**: sem armazenamento de credenciais; validações de formulário; pronto para adicionar biometria.
- **RNF-0003 – Disponibilidade**: app funciona offline com dados mock.
- **RNF-0004 – Compatibilidade**: Flutter 3.x, Material 3, responsivo (mobile/desktop).
- **RNF-0005 – Desempenho do Banco**: como front-only, usa dados em memória; pronto para Firebase.
- **RNF-0006 – Privacidade**: sem coleta real; configurações de privacidade em tela.
- **RNF-0007 – Monitoramento**: pontos de extensão (ex.: enviar logs ao backend no futuro).
- **RNF-0008 – Manutenibilidade**: camadas separadas (models/data/widgets/screens/theme); Provider para estado.
- **RNF-0009 – Acessibilidade**: labels, tamanhos adequados, contrastes e `tooltip`s.
- **RNF-0010 – Rastreabilidade**: extrato de transações simuladas na Carteira.

## Estrutura
```
flutter_cs2_skins_frontend/
  assets/images/(cover_1.png, cover_2.png, cover_3.png, cover_4.png)
  lib/
    app_state.dart
    main.dart
    theme/app_theme.dart
    models/skin.dart
    data/mock_data.dart
    widgets/skin_card.dart
    widgets/filter_panel.dart
    screens/
      login_screen.dart
      home_screen.dart
      item_detail_screen.dart
      wallet_screen.dart
      trade_screen.dart
      settings_screen.dart
  pubspec.yaml
  analysis_options.yaml
```

## Como rodar
1. **Instale Flutter 3.24+** e um device/emulador.
2. Dentro da pasta do projeto:
   ```bash
   flutter pub get
   flutter run -d chrome   # ou -d windows / -d macos / -d android / -d ios
   ```
3. Login: qualquer email válido e senha com 6+ caracteres.

> **Firebase (opcional)**: dependência já adicionada em `pubspec.yaml`. Para integrar depois:
> - Rodar `flutterfire configure` e gerar `firebase_options.dart`.
> - Inicializar o Firebase em `main()` com `Firebase.initializeApp()`.

## Observação
As imagens usadas nos cards vêm de `assets/images/cover_*.png` e foram copiadas dos anexos.
