import 'package:flutter/material.dart';
import '../../../../app/enums/emuns.dart';
import 'package:stacked/stacked.dart';

import '../all_shared_viewModel.dart';

class AllSharedSecretsScreen extends StatefulWidget {
  @override
  _AllSharedSecretsScreenState createState() => _AllSharedSecretsScreenState();
}

class _AllSharedSecretsScreenState extends State<AllSharedSecretsScreen> {
  Widget body(SharedViewModel model) {
    if (model.dataLoadInfo == DataLoadInfoState.Loading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      );
    } else if (model.exceptions != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.exceptions.toString()),
            FlatButton(
                onPressed: () {
                  model.sharedSecrets();
                },
                child: Text("Try Again"))
          ],
        ),
      );
    } else if (model.secrets != null) {
      return ListView.builder(
        itemCount: model.secrets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(model.secrets[index].secret),
            subtitle: Text(model.secrets[index].ownerID),
            trailing: Text(
                "Shared on: " + model.secrets[index].sharedOn.substring(0, 10)),
          );
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SharedViewModel>.reactive(
      viewModelBuilder: () => SharedViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              FlatButton(
                  onPressed: () {
                    model.navigateTo();
                  },
                  child: Center(
                    child: Text(
                      "My Shared Secrets",
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ))
            ],
          ),
          body: body(model),
        );
      },
    );
  }
}
