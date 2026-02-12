import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void showInfoBottomSheet(BuildContext context) {
  showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => const InfoBottomSheet());
}

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({super.key});

  static const List<String> infos = [
    '1 - O botão "Cancelar evento ativo" só é acionável quando uma tarefa está executando um evento;',
    '2 - Para cancelar tarefas já agendadas, basta deletá-las por meio da "Lista de Tarefas Agendadas";',
    '3 - Os eventos imediatos não podem ser executados enquanto o Shutdown ou outra tarefa estiver ativa;',
    '4 - O evento "Desligar PC + UPS" só desligará o UPS, quando a rede elétrica não estiver presente. Com a presença da rede elétrica o UPS irá apenas religar após 15 segundos;',
    '5 - Tarefas já agendadas não podem ter sua frequência alterada para imediata durante sua edição;',
    '6 - Se duas tarefas agendadas em frequências diferentes se coincidirem em sua execução, a prioridade é que a primeira seja efetuada e a segunda não. Se uma tarefa agendada coincidir com um shutdown, ela não é efetuada;',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      //padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(top: 16, bottom: 24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Informações', style: theme.textTheme.titleMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
                IconButton(
                  icon: Icon(Icons.close, color: theme.colorScheme.primary),
                  onPressed: () => Modular.to.pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: infos
                      .map(
                        (text) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(text, style: theme.textTheme.bodyMedium),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Modular.to.pop(),
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(48, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Color(0xFFFFFFFFF), fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
