// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$TaskService extends TaskService {
  _$TaskService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TaskService;

  @override
  Future<Response<List>> getAllTasksFromMentorshipRelation(int relationId) {
    final $url = 'mentorship_relation/$relationId/tasks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List, List>($request);
  }
}
