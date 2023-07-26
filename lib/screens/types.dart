class Result {
  DateTime? timestamp;
  String? cdnName;
  String? port;
  String? url;
  String? input;
  String? location;
  String? title;
  String? scheme;
  String? error;
  String? webServer;
  String? responseBody;
  String? contentType;
  String? method;
  String? host;
  String? path;
  String? favIconMMH3;
  String? faviconPath;
  String? finalURL;
  String? responseTime;
  String? jarm;
  int? statusCode;
  int? contentLength;
  bool? vHost;
  bool? webSocket;
  bool? cdn;
  bool? http2;
  bool? pipeline;
  String? headlessBody;
  String? screenshotBytes;
  Map<String, dynamic>? responseHeader;
  List<dynamic>? technologies;
  // List<ByteData> asn;
  // List<ByteData> cspData;
  // List<ByteData> tlsData;
  // Map<String, dynamic> hashes;
  // List<String> extractRegex;
  // String rawHeader;
  // String request;

  // List<int> chainStatusCodes;
  // List<String> a;
  // List<String> cnames;

  // Map<String, List<String>> extracts;
  // List<ByteData> chain;
  // int words;
  // int lines;

  // bool failed;

  // String storedResponsePath;
  // String screenshotPath;
  // Map<String, dynamic> knowledgeBase;

  Result({
    this.timestamp,
    this.cdnName,
    this.port,
    this.url,
    this.input,
    this.location,
    this.title,
    this.scheme,
    this.error,
    this.webServer,
    this.responseBody,
    this.contentType,
    this.method,
    this.host,
    this.path,
    this.favIconMMH3,
    this.faviconPath,
    this.finalURL,
    this.responseTime,
    this.jarm,
    this.statusCode,
    this.contentLength,
    this.vHost,
    this.webSocket,
    this.cdn,
    this.http2,
    this.pipeline,
    this.headlessBody,
    this.screenshotBytes,
    this.responseHeader,
    this.technologies,
    // this.asn,
    // this.cspData,
    // this.tlsData,
    // this.hashes,
    // this.extractRegex,
    // this.rawHeader,
    // this.request,
    // this.chainStatusCodes,
    // this.a,
    // this.cnames,
    // this.extracts,
    // this.chain,
    // this.words,
    // this.lines,
    // this.failed,
    // this.storedResponsePath,
    // this.screenshotPath,
    // this.knowledgeBase,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      cdnName: json['cdn_name'],
      port: json['port'],
      url: json['url'],
      input: json['input'],
      location: json['location'],
      title: json['title'],
      scheme: json['scheme'],
      error: json['error'],
      webServer: json['web_server'],
      responseBody: json['response_body'],
      contentType: json['content_type'],
      method: json['method'],
      host: json['host'],
      path: json['path'],
      favIconMMH3: json['fav_icon_mmh3'],
      faviconPath: json['favicon_path'],
      finalURL: json['final_url'],
      responseTime: json['response_time'],
      jarm: json['jarm'],
      statusCode: json['status_code'],
      contentLength: json['content_length'],
      vHost: json['vhost'],
      webSocket: json['web_socket'],
      cdn: json['cdn'],
      http2: json['http2'],
      pipeline: json['pipeline'],
      headlessBody: json['headless_body'],
      screenshotBytes: json['screenshot_bytes'],
      responseHeader: json['response_header'],
      technologies: json['tech'],
      // asn: json['asn'],
      // cspData: json['csp_data'],
      // tlsData: json['tls_data'],
      // hashes: json['hashes'],
      // extractRegex: json['extract_regex'],
      // rawHeader: json['raw_header'],
      // request: json['request'],
      // chainStatusCodes: json['chain_status_codes'],
      // a: json['a'],
      // cnames: json['cnames'],
      // extracts: json['extracts'],
      // chain: json['chain'],
      // words: json['words'],
      // lines: json['lines'],
      // failed: json['failed'],
      // storedResponsePath: json['stored_response_path'],
      // screenshotPath: json['screenshot_path'],
      // knowledgeBase: json['knowledge_base'],
    );
  }
}
