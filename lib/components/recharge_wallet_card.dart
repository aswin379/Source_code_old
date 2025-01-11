import 'package:flutter/material.dart';

class BalanceRechargeCard extends StatelessWidget {
  final Color? color;
  final String? icon;
  final String? name;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  //balance
  final String? balance;
  final TextStyle? balanceStyle;

  const BalanceRechargeCard({
    Key? key,
    this.color,
    this.icon,
    this.textStyle,
    this.name,
    this.onPressed,
    this.balance,
    this.balanceStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            // color: MyTheme.zircon,
            color: color!,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: balance == null ? 22 : 10),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/icon/$icon",
                    height: 16,
                  ),
                  if (balance != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (balance != null)
                    Text(
                      balance!,
                      style: balanceStyle,
                    ),
                  balance == null
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  Text(name!, style: textStyle!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
