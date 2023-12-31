import 'package:app_finance/common/extensions/sizes.dart';
import 'package:app_finance/features/wallet/wallet_controller.dart';
import 'package:app_finance/features/wallet/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/constants/routes.dart';
import '../../common/widgets/app_header.dart';
import '../../common/widgets/base_page.dart';
import '../../common/widgets/custom_bottom_sheet.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/transaction_listview.dart';
import '../../locator.dart';
import '../balance/balance_controller.dart';
import '../balance/balance_state.dart';
import '../home/home_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin, CustomModalSheetMixin {
  final balanceController = locator.get<BalanceController>();
  final walletController = locator.get<WalletController>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    walletController.getAllTransactions();
    balanceController.getBalances();

    walletController.addListener(() {
      if (walletController.state is WalletStateError) {
        if (!mounted) return;
        showCustomModalBottomSheet(
          context: context,
          content: (walletController.state as WalletStateError).message,
          buttonText: 'Ir para login',
          isDismissible: false,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.signIn,
            ModalRoute.withName(NamedRoute.initial),
          ),
        );
      }
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
      onWillPop: () async {
        locator.get<HomeController>().pageController.jumpToPage(0);
        return false;
      },
      child: Stack(
        children: [
          AppHeader(
            title: 'Carteira',
            onPressed: () {
              locator.get<HomeController>().pageController.jumpToPage(0);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 165.h,
            bottom: 0,
            child: BasePage(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 48.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'Saldo Total',
                      style: AppTextStyles.inputLabelText
                          .apply(color: AppColors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    AnimatedBuilder(
                        animation: balanceController,
                        builder: (context, _) {
                          if (balanceController.state is BalanceStateLoading) {
                            return const CustomCircularProgressIndicator();
                          }
                          return Text(
                            // ignore: unnecessary_string_interpolations
                            '${NumberFormat.currency(
                              locale: 'pt_BR', // Define a localização para o português brasileiro
                              symbol: 'R\$', // Define o símbolo para o real brasileiro
                              decimalDigits: 2, // Define o número de casas decimais
                            ).format(balanceController.balances.totalBalance)}',
                            style: AppTextStyles.mediumText30.apply(color: AppColors.blackGrey),
                          );
                        }),
                    const SizedBox(height: 24.0),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TabBar(
                          labelPadding: EdgeInsets.zero,
                          controller: _tabController,
                          onTap: (_) {
                            if (_tabController.indexIsChanging) {
                              setState(() {});
                            }
                          },
                          tabs: [
                            Tab(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _tabController.index == 0
                                      ? AppColors.icewhit
                                      : AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                                child: Text(
                                  'transações',
                                  style: AppTextStyles.mediumText16w500
                                      .apply(color: AppColors.grey),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _tabController.index == 1
                                      ? AppColors.icewhit
                                      : AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                                child: Text(
                                  'Próximas contas',
                                  style: AppTextStyles.mediumText16w500
                                      .apply(color: AppColors.grey),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 32.0),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: walletController,
                        builder: (context, _) {
                          if (walletController.state is WalletStateLoading) {
                            return const CustomCircularProgressIndicator(
                              color: AppColors.green,
                            );
                          }
                          if (walletController.state is WalletStateError) {
                            return const Center(
                              child: Text('Ocorreu um erro'),
                            );
                          }
                          if (walletController.state is WalletStateSuccess &&
                              walletController.transactions.isNotEmpty) {
                            return TransactionListView.withCalendar(
                              transactionList: walletController.transactions,
                              itemCount: walletController.transactions.length,
                              onChange: () {
                                walletController.getAllTransactions().then(
                                    (_) => balanceController.getBalances());
                              },
                            );
                          }
                          return const Center(
                            child:
                                Text('Não há transações no momento.'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}