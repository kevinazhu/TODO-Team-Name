//
// request_handler_echo.hpp
// ~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2003-2012 Christopher M. Kohlhoff (chris at kohlhoff dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#ifndef HTTP_REQUEST_HANDLER_ECHO_HPP
#define HTTP_REQUEST_HANDLER_ECHO_HPP

#include "request_handler.hpp"
#include <string>

namespace http {
namespace server {

/// Handler for echo requests.
class RequestHandlerEcho : public http::server::RequestHandler {
public:
  Status Init(const std::string& uri_prefix, const NginxConfig& config) override;

  Status HandleRequest(const Request& request, Response* response) override;
};

} // namespace server
} // namespace http

#endif // HTTP_REQUEST_HANDLER_ECHO_HPP