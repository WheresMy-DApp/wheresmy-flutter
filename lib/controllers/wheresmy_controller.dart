import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:wheresmy/providers/web3_provider.dart';

import 'package:wheresmy/utils/constants.dart';

class WheresMyController extends ChangeNotifier {
  bool isLoading = true;
  final String _rpcUrl = AppConstants.rpcUrl;
  final String _wsUrl = AppConstants.wssUrl;

  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _mint;
  late ContractFunction _reportLost;
  late ContractFunction _reportFound;
  late ContractFunction _foundDevicePing;
  late ContractFunction _getLatestDeviceLocation;
  late ContractFunction _getLocationHistory;

  WheresMyController() {
    init();
  }

  init() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("lib/contracts/abis/WheresMyNFT.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress = EthereumAddress.fromHex(AppConstants.contractAddress);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "WheresMyNFT"), _contractAddress);

    _mint = _contract.function("mint");
    _reportLost = _contract.function("reportLost");
    _reportFound = _contract.function("reportFound");
    _foundDevicePing = _contract.function("foundDevicePing");
    _getLatestDeviceLocation = _contract.function("getLatestDeviceLocation");
    _getLocationHistory = _contract.function("getLocationHistory");
  }

  mint(deviceHash, locationCode, timestamp) async {
    await Web3Provider.instance.connector.approveSession(
      accounts: [Web3Provider.instance.walletId!],
      chainId: int.parse(AppConstants.chainId),
    );
    var response =
        await _client.call(contract: _contract, function: _mint, params: [
      deviceHash,
      locationCode,
      timestamp,
    ]);
    print(response);
    // var response = await Web3Provider.instance.connector.sendCustomRequest(
    //   method: "eth_sendTransaction",
    //   params: [
    //     {
    //       "from": Web3Provider.instance.walletId,
    //       "to": AppConstants.contractAddress,
    //       "data": _mint.encodeCall([]),
    //     }
    //   ],
    // );
    return response;
  }
}
