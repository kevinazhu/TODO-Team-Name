//
// request_handler.cpp
// ~~~~~~~~~~~~~~~~~~~
//
// Copyright (c) 2003-2012 Christopher M. Kohlhoff (chris at kohlhoff dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include "request_handler.hpp"
#include <fstream>
#include <sstream>
#include <string>
#include <boost/lexical_cast.hpp>
#include "reply.hpp"
#include "request.hpp"
#define BUFFER_SIZE 8192

namespace http {
namespace server {

// Simple 'echo' response
void request_handler::handle_request(const char buffer_[BUFFER_SIZE], reply& rep) {

  // Fill out the reply to be sent to the client.
  rep.status = reply::ok; // 200 OK response
  for (int i = 0; i< BUFFER_SIZE && buffer_[i] != '\0'; i++)
    rep.content.append(1, buffer_[i]);

  rep.headers.resize(2);
  rep.headers[0].name = "Content-Length";
  rep.headers[0].value = boost::lexical_cast<std::string>(rep.content.size());
  rep.headers[1].name = "Content-Type";
  rep.headers[1].value = "text/plain";
}

} // namespace server
} // namespace http