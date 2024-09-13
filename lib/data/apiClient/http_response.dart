// Status
enum Status { success, error, loading }

// Api Response
class HttpResponse<T> {
  Status? status;
  T? data;
  String? message;

  HttpResponse(this.status, this.data, this.message);

  HttpResponse.loading(this.message) : status = Status.loading;
  HttpResponse.completed(this.data) : status = Status.success;
  HttpResponse.error(this.message) : status = Status.error;
  
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
