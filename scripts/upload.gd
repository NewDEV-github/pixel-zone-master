extends Node
func _make_post_request(url, data_to_send, use_ssl):
    # Convert data to json string:
    var query = JSON.print(data_to_send)
    # Add 'Content-Type' header:
    var headers = ["Content-Type: application/json"]
    $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
#	pass
