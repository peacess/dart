// This is a generated file - do not edit.
//
// Generated from rpc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'rpc.pb.dart' as $0;

export 'rpc.pb.dart';

@$pb.GrpcServiceName('Sample')
class SampleClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SampleClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Res> name(
    $0.Req request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$name, request, options: options);
  }

  // method descriptors

  static final _$name = $grpc.ClientMethod<$0.Req, $0.Res>('/Sample/name', ($0.Req value) => value.writeToBuffer(), $0.Res.fromBuffer);
}

@$pb.GrpcServiceName('Sample')
abstract class SampleServiceBase extends $grpc.Service {
  $core.String get $name => 'Sample';

  SampleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Req, $0.Res>(
        'name', name_Pre, false, false, ($core.List<$core.int> value) => $0.Req.fromBuffer(value), ($0.Res value) => value.writeToBuffer()));
  }

  $async.Future<$0.Res> name_Pre($grpc.ServiceCall $call, $async.Future<$0.Req> $request) async {
    return name($call, await $request);
  }

  $async.Future<$0.Res> name($grpc.ServiceCall call, $0.Req request);
}
