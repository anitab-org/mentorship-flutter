/// This class represents statistics of the user actions on the app.
/// [name] the name of the user
/// [pendingRequests] number of pending requests
/// [acceptedRequests] number of accepted requests
/// [completedRelations] number of completed relations
/// [cancelledRelations] number of cancelled relations
/// [rejectedRequests] number of rejected requests
/// achievements a list of up-to 3 completed tasks
class HomeStats {
  final String name;
  final int pendingRequests;
  final int acceptedRequests;
  final int completedRelations;
  final int cancelledRelations;
  final int rejectedRequests;

  HomeStats(
      {this.name,
      this.pendingRequests,
      this.acceptedRequests,
      this.completedRelations,
      this.cancelledRelations,
      this.rejectedRequests})
      : assert(name != null),
        assert(pendingRequests != null),
        assert(acceptedRequests != null),
        assert(completedRelations != null) ,
        assert(cancelledRelations != null),
        assert(rejectedRequests != null);

  factory HomeStats.fromJson(Map<String, dynamic> json) => HomeStats(
      name: json["name"],
      pendingRequests: json["pending_requests"],
      acceptedRequests: json["accepted_requests"],
      completedRelations: json["completed_relations"],
      cancelledRelations: json["cancelled_relations"],
      rejectedRequests: json["rejected_requests"]);
}
