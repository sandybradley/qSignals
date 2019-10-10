# QSignals

Real-time trade signals for all major crypto currencies, on all major exchanges, written in KDB+.

This script produces common signal analysis in real time, using qmonitor. The following signals are generated. Note that anyone trading off these signals will need to customise for the current market conditions. My advice is to use qstudio to visually view signals and price action, in order to customise for your own needs. 

- Candlesticks
- Directional volume
- Simple moving average cross-over
- Momentum
- Volatility
- RSI
- PSAR
- Bollinger bands
- MACD
- ATR
- KST
- ADX

Real-time logging in the signals table enables real-time triggers for trading with minimal latency.

Pre-requisites:

KDB+ (https://kx.com/connect-with-us/download/)

qstudio (http://www.timestored.com/qstudio/)

Example with Bitcoin USD market. Start monitor with:

\l qmonitorBTCUSD.q

Start a new q instance and load signals:

\l qsignals.q

Start qstudio. Connect to 5011, plot price action vs signals. E.g.

select time, close, sma20, sma50 from data; 

# Donate for development

BTC - 112eMCQJUkUz7kvxDSFCGf1nnFJZ61CE4W

LTC - LR3BfiS77dZcp3KrEkfbXJS7U2vBoMFS7A

ZEC - t1bQpcWAuSg3CkBs29kegBPXvSRSaHqhy2b

XLM - GAHK7EEG2WWHVKDNT4CEQFZGKF2LGDSW2IVM4S5DP42RBW3K6BTODB4A Memo: 1015040538

Nano - nano_1ca5fxd7uk3t61ghjnfd59icxg4ohmbusjthb7supxh3ufef1sykmq77awzh

XRP - rEb8TK3gBgk5auZkwc6sHnwrGVJH8DuaLh Tag: 103535357

EOS - binancecleos Memo: 103117718

# Recommended links

Getting started - Coinbase - https://www.coinbase.com/join/bradle_6r

Portfolio balance - Binance - www.binance.com/en/register?ref=LTUMGDDC

Futures trading - Deribit - https://www.deribit.com/reg-8106.6912

Cold wallet - https://atomicWallet.io?kid=12GR52 (promo 12GR52) - https://hodler.tech/

Learn to earn (coinbase users) - Stellar - https://coinbase.com/earn/xlm/invite/vps5dfzt
                               -  EOS - https://coinbase.com/earn/eos/invite/xdbgswqk
                               
                               
