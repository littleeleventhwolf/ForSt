// Copyright (c) 2011-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under both the GPLv2 (found in the
//  COPYING file in the root directory) and Apache 2.0 License
//  (found in the LICENSE.Apache file in the root directory).

#pragma once

// For testing purposes
#if ROCKSDB_NAMESPACE == 42
#undef ROCKSDB_NAMESPACE
#endif

// Normal logic
#ifndef ROCKSDB_NAMESPACE
#define ROCKSDB_NAMESPACE forstdb
#endif
