import 'package:flutter/widgets.dart';
import 'package:relay/relay.dart';
import 'package:moments/models/models.dart';

enum MomentUpdate {
  NEW_ADDED,
  CURRENT_MOMENT_FETCHED,
}

class MomentStore extends Store<MomentUpdate> {
  List<Moment> moments;
  Moment currentMoment;

  Future fetchMoments() async {
    moments = await Moment.getAll();
    relay(MomentUpdate.NEW_ADDED);
  }

  Future fetchCurrentMoment() async {
    currentMoment = Moment();
  }

  Future add(Moment moment, {Function onSuccess}) async {
    await moment.save();
    moments.add(moment);
    if (onSuccess != null) onSuccess();
    relay(MomentUpdate.NEW_ADDED);
  }

  Future remove(int index) async {
    final moment = moments[index];
    await moment.delete();
    moments.removeAt(index);
    relay(MomentUpdate.NEW_ADDED);
  }

  Future addCurrentMoment(Function onSuccess) => add(currentMoment,onSuccess: onSuccess);
}
