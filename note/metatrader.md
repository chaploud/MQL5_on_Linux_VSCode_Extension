# MetaTraderの実行について

## コマンドラインからの実行

- [参考URL](https://www.mql5.com/en/forum/462397)

```python
import subprocess

def start_mt5_backtest(expert, symbol, timeframe, start_date, end_date):
    # Path to MetaTrader 5 terminal executable
    mt5_terminal_path = "C:/Path/To/Your/MetaTrader5/terminal64.exe"  # Update this with your actual path

    # Command line parameters for backtesting
    command_line_params = [
        mt5_terminal_path,
        "/config:Default",
        "/expert:\"{}\"".format(expert),
        "/symbol:\"{}\"".format(symbol),
        "/period:{}".format(timeframe),
        "/from:\"{}\"".format(start_date),
        "/to:\"{}\"".format(end_date),
        "/skipflp",
        "/skipwnd"
    ]

    # Start the MetaTrader 5 terminal process with the specified parameters
    subprocess.Popen(" ".join(command_line_params), shell=True)

if __name__ == "__main__":
    # Example parameters for backtesting
    expert_file = "YourExpert.ex5"  # Update this with the path to your expert advisor file
    symbol = "EURUSD"
    timeframe = 1440  # Daily timeframe
    start_date = "2020.01.01"
    end_date = "2021.01.01"

    # Start the backtest
    start_mt5_backtest(expert_file, symbol, timeframe, start_date, end_date)
```
