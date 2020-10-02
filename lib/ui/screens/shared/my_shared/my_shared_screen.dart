import 'package:flutter/material.dart';
import '../../../../app/enums/emuns.dart';
import 'package:stacked/stacked.dart';

import '../all_shared_viewModel.dart';

class MySharedScreen extends StatefulWidget {
  @override
  _MySharedScreenState createState() => _MySharedScreenState();
}

class _MySharedScreenState extends State<MySharedScreen> {
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
    } else if (model.mySharedSecretsList != null) {
      return ListView.builder(
        itemCount: model.mySharedSecretsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(model.mySharedSecretsList[index].secret),
            subtitle: Text(model.mySharedSecretsList[index].ownerEmail),
            trailing: Text("Shared on: " +
                model.mySharedSecretsList[index].sharedOn.substring(0, 10)),
          );
        },
      );
    } else {
      return Center(
        child: Text("You have not shared any secret"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ViewModelBuilder<SharedViewModel>.reactive(
        viewModelBuilder: () => SharedViewModel(),
        builder: (context, model, child) => Container(
          child: body(model),
        ),
      ),
    );
  }
}
