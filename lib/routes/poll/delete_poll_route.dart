import 'dart:async';

import 'package:app/components/poll_result.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:app/controllers/poll_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/params/poll_params.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeletePollRoute extends StatefulWidget {
  const DeletePollRoute({super.key});

  @override
  State<DeletePollRoute> createState() => _DeletePollRouteState();
}

class _DeletePollRouteState extends State<DeletePollRoute> {
  BaseChannel? _channel;
  late String? _channelUrl;

  List<String> optionTextList = [];
  final _authenticationController = Get.find<AuthenticationController>();
  final _pollController = Get.find<PollController>();
  final titleController = TextEditingController();
  final optionController = TextEditingController();
  late SendbirdSdk sendbirdSDK;
  bool isLoading = false;
  late Poll pollResult;

  @override
  void initState() {
    sendbirdSDK = _authenticationController.sendbirdSdk;
    _channelUrl = _pollController.testChannelUrl;

    super.initState();
  }

  Future<BaseChannel?> initialSetup({
    bool loadPrevious = false,
    bool isForce = false,
  }) async {
    final wait = Completer();
    _channel ??= await GroupChannel.getChannel(_channelUrl!);

    if (_channel == null) throw Exception("Unable to retrieve group channel");
    _pollController.pollGroupChannel = _channel as GroupChannel;

    final params = PollCreateParams(
      title: 'Delete Poll Title',
      options: ['1', '2', '3'],
    );

    //Create Poll
    pollResult = await Poll.create(params: params);
    print('init poll created');

    //Send Message with Poll
    final mParams = UserMessageParams(message: 'test', pollId: pollResult.id);
    _channel!.sendUserMessage(
      mParams,
      onCompleted: (message, error) {
        print("message with poll sent");
        wait.complete();
      },
    );

    //Send message with poll

    await wait.future;

    return _channel;
  }

  Future<void> deletePoll(int id) async {
    try {
      await _channel!.deletePoll(pollId: id);
      return;
    } catch (e) {
      print('Failed Updating Poll');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialSetup(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Listener(
              onPointerDown: (_) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text("Delete Poll"),
                ),
                body: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Below Poll will be deleted with id: ${pollResult.id}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    //* Previous Poll Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        child: ListTile(
                          leading:
                              const FaIcon(FontAwesomeIcons.squarePollVertical),
                          title: Text(pollResult.title),
                          subtitle: Row(
                            children: [
                              const Text("Options: "),
                              for (var pollOption in pollResult.options)
                                Text("(${pollOption.text})  ")
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await deletePoll(pollResult.id);

                            Fluttertoast.showToast(
                              msg: "Poll Deleted!",
                            );
                            //TODO
                            //? Redirect to show Poll Result
                            Get.off(
                              PollResult(
                                poll: pollResult,
                                appBarTitle: "Poll Deleted",
                                title: "Below Poll has been deleted!",
                              ),
                            );
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: "Poll Failed Deleting!\n$e",
                            );
                          }

                          setState(() {
                            titleController.clear();
                            isLoading = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Delete Poll",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Failed Retrieving Group Channel List"),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Delete Poll"),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }));
  }
}
