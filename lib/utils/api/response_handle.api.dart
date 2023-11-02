isStatusCompleted(ApiResponse response) {
  return response.status == Status.complete;
}

isStatusLoading(ApiResponse response) {
  return response.status == Status.loading;
}

isStatusError(ApiResponse response) {
  return response.status == Status.error;
}

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  // final h;

  ApiResponse.initial(this.message) : status = Status.initial;

  ApiResponse.loading(this.message) : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.complete;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { initial, loading, complete, error }
