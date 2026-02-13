import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/home/presentation/widget/drawer/drawer_expansion_widget.dart';
import 'package:treina_app/app/pages/home/presentation/widget/drawer/menu_item_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/presentation/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  //ExpansionTileController controllerPanel = ExpansionTileController();
  //ExpansionTileController controllerSettings = ExpansionTileController();
  ExpansibleController controllerPanel = ExpansibleController();
  ExpansibleController controllerSettings = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Color(0xFFFFFFFF),
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: const Key("drawer"),
      width: 260, // tamanho definido no figma;
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 30),
                MenuItemWidget(
                  text: 'Início',
                  icon: 'assets/icons/home.svg',
                  isSelected: Modular.to.path.startsWith('/home'), //== '/home',
                  onTap: () {
                    //Modular.to.pop();
                    Navigator.of(context).pop();
                    Modular.to.navigate('/home');
                  },
                ),

                //------------------------------------------------------------------------------
                DrawerExpansionWidget(
                  controller: controllerPanel,
                  icon: 'assets/icons/control_panel.svg',
                  title: 'Painel de Controle',
                  expansionKey: const Key("drawer_painel-de-controle"),
                  level: 1,
                  onTap: (currentRoute) {
                    controllerPanel.collapse();
                    Modular.to.pop();
                    Modular.to.pushNamed(currentRoute);
                  },
                  tabList: [
                    ListTileModel.asDropdown(
                      title: 'Agendamento de Tarefas',
                      route: '/scheduled_tasks',
                      tabList: [
                        ListTileModel(title: 'Agendar Tarefas', route: '/scheduled_tasks/create_or_edit'),
                        ListTileModel(title: 'Lista de Tarefas Agendadas', route: '/scheduled_tasks'),
                      ],
                      onTap: (currentRoute) {
                        controllerPanel.collapse();
                        Modular.to.pop();
                        Modular.to.pushNamed(currentRoute);
                      },
                      level: 2,
                    ),
                    ListTileModel(title: 'Histórico de Eventos e Falhas', route: '/events_and_failures/'),
                    ListTileModel(key: const Key("drawer_historico-ups"), title: 'Histórico de UPS', route: '/history_screen'),
                    ListTileModel(title: 'Histórico de Testes de Autonomia', route: '/autonomy_tests_history/'),
                  ],
                ),

                //------------------------------------------------------------------------------
                DrawerExpansionWidget(
                  controller: controllerSettings,
                  icon: 'assets/icons/config.svg',
                  title: 'Configurações',
                  expansionKey: const Key("drawer_config"),
                  level: 1,
                  onTap: (currentRoute) {
                    controllerPanel.collapse();
                    Modular.to.pop();
                    Modular.to.pushNamed(currentRoute);
                  },
                  tabList: [
                    ListTileModel(title: 'Gestão do Histórico do UPS', route: '/404'),
                    ListTileModel(title: 'Notificações', route: '/notifications/config'),
                  ],
                ),
                //------------------------------------------------------------------------------
                MenuItemWidget(
                  text: 'Contraste',
                  icon: 'assets/icons/dark_mode.svg',
                  onTap: () {
                    //Modular.to.pop();
                    Navigator.of(context).pop();
                    Provider.of<ThemeController>(context, listen: false).toggleTheme();
                  },
                ),
                //------------------------------------------------------------------------------
                MenuItemWidget(
                  text: 'Desconectar',
                  icon: 'assets/icons/disconnect.svg',
                  onTap: () {
                    //Modular.to.pop();
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Atenção'),
                        content: const Text('Funcionalidade indisponível'),
                        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
