//  Copyright (c) 2017-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under both the GPLv2 (found in the
//  COPYING file in the root directory) and Apache 2.0 License
//  (found in the LICENSE.Apache file in the root directory).

package org.forstdb;

/**
 * CassandraValueMergeOperator is a merge operator that merges two cassandra wide column
 * values.
 */
public class CassandraValueMergeOperator extends MergeOperator {
  public CassandraValueMergeOperator(final int gcGracePeriodInSeconds) {
    super(newSharedCassandraValueMergeOperator(gcGracePeriodInSeconds, 0));
  }

  public CassandraValueMergeOperator(final int gcGracePeriodInSeconds, final int operandsLimit) {
    super(newSharedCassandraValueMergeOperator(gcGracePeriodInSeconds, operandsLimit));
  }

  private static native long newSharedCassandraValueMergeOperator(
      int gcGracePeriodInSeconds, int limit);

  @Override protected final native void disposeInternal(final long handle);
}
