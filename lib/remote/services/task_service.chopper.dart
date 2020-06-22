// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TaskService extends TaskService {
  _$TaskService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TaskService;

  @override
  Future<Response<List<dynamic>>> getAllTasksFromMentorshipRelation(
      int relationId) {
    final $url = 'mentorship_relation/$relationId/tasks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<dynamic>, List<dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createTask(
      int requestId, TaskRequest taskRequest) {
    final $url = 'mentorship_relation/$requestId/task';
    final $body = taskRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> completeTask(
      int requestId, int taskId) {
    final $url = 'mentorship_relation/$requestId/task/$taskId/complete';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> deleteTask(int requestId, int taskId) {
    final $url = 'mentorship_relation/$requestId/task/$taskId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
