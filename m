Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDADC4167B
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Dec 2022 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiLLSep (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiLLSeO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:34:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7E13CC6
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:33:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D57FDB80D57
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2719AC433EF;
        Mon, 12 Dec 2022 18:33:25 +0000 (UTC)
Date:   Mon, 12 Dec 2022 13:33:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] trace-tests: Allow tests to be run in separate directory
Message-ID: <20221212133323.5007ebe5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Make it so that all the tests can be run in a separate directory, as well as
update them to use a single "functions" file to get the tracing directory.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 ftrace-test-clocks              | 13 ++++--
 ftrace-test-counter             | 24 ++---------
 ftrace-test-cpumask             | 42 ++++++------------
 ftrace-test-event-stacktrace    | 31 +++-----------
 ftrace-test-event-traceon-off   | 49 +++++++--------------
 ftrace-test-event-trigger-event | 31 +++-----------
 ftrace-test-fail-rb-alloc       | 24 ++---------
 ftrace-test-fgraph-depth        |  5 ++-
 ftrace-test-fgraph-filter       | 23 ++--------
 ftrace-test-func-profiler       | 24 ++---------
 ftrace-test-instance-tracers    | 34 ++++-----------
 ftrace-test-irqsoff             |  7 ++-
 ftrace-test-irqsoff-stop-trace  |  5 ++-
 ftrace-test-kprobes             |  5 ++-
 ftrace-test-latency-function    | 17 ++++----
 ftrace-test-latency-overwrite   |  5 ++-
 ftrace-test-mcount              | 24 ++---------
 ftrace-test-mkinstances         | 12 ++----
 ftrace-test-mkinstances-2       | 12 ++----
 ftrace-test-module-load         | 53 +++++++----------------
 ftrace-test-options             | 26 +++---------
 ftrace-test-pipe                | 22 ++--------
 ftrace-test-saved_cmdlines      | 31 ++++----------
 ftrace-test-snapshot            | 22 ++--------
 ftrace-test-stats               | 40 +++++-------------
 ftrace-test-system-names        |  5 ++-
 ftrace-test-traceon-off         | 75 +++++++++++++--------------------
 ftrace-test-tracers             | 34 ++++-----------
 ftrace-test-tramp-count         | 22 ++--------
 functions                       | 20 +++++++++
 run-ftrace-tests                |  5 +--
 test-mod-event                  |  5 ++-
 test-tracecmd-record-plugins    | 26 ++----------
 trace-cmd-filter-stress         |  2 +-
 34 files changed, 235 insertions(+), 540 deletions(-)
 create mode 100644 functions

diff --git a/ftrace-test-clocks b/ftrace-test-clocks
index 406955a..cdb0841 100755
--- a/ftrace-test-clocks
+++ b/ftrace-test-clocks
@@ -1,7 +1,12 @@
-current=`cut -d'[' -f2 /sys/kernel/tracing/trace_clock | cut -d']' -f1`
-for clock in `cat /sys/kernel/tracing/trace_clock | sed -e 's/[][]//g'`; do
+DIR=`dirname $0`
+. $DIR/functions
+
+TRACE_CLOCK="$TRACING_DIR/trace_clock"
+
+current=`cut -d'[' -f2 $TRACE_CLOCK | cut -d']' -f1`
+for clock in `cat $TRACE_CLOCK | sed -e 's/[][]//g'`; do
 	echo "  TESTING $clock"
-	echo $clock > /sys/kernel/tracing/trace_clock
-	./ftrace-test-tracers sleep 1 || exit 1
+	echo $clock > $TRACE_CLOCK
+	$DIR/ftrace-test-tracers sleep 1 || exit 1
 done
 exit 0
diff --git a/ftrace-test-counter b/ftrace-test-counter
index a27121e..1ce15c8 100755
--- a/ftrace-test-counter
+++ b/ftrace-test-counter
@@ -2,27 +2,9 @@
 
 # fixed by "ring-buffer: Fix first commit on sub-buffer having non-zero delta"
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-DEBUGFS="$debugfs/tracing"
-trace_clock=$DEBUGFS/trace_clock
+DIR=`dirname $0`
+. $DIR/functions
+trace_clock=$TRACING_DIR/trace_clock
 if ! grep -q counter $trace_clock ; then
 	echo "counter clock is not defined in this kernel"
 	exit 0
diff --git a/ftrace-test-cpumask b/ftrace-test-cpumask
index 5719912..fad85f4 100755
--- a/ftrace-test-cpumask
+++ b/ftrace-test-cpumask
@@ -1,27 +1,9 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-DEBUGFS="$debugfs/tracing"
+DIR=`dirname $0`
+. $DIR/functions
 
-save_cpumask=`cat $DEBUGFS/tracing_cpumask`
+save_cpumask=`cat $TRACING_DIR/tracing_cpumask`
 
 MAXCPUS=6
 
@@ -106,27 +88,27 @@ let MSKCNT=$MSKCNT-1
 for i in `seq $MSKCNT`; do
     echo "get_bits $i"
     bits=`get_bits $i`
-    run_cmd "" $DEBUGFS $i $bits
+    run_cmd "" $TRACING_DIR $i $bits
 done
 
 trace-cmd start -p nop -M $save_cpumask
 
-if [ ! -d $DEBUGFS/instances ]; then
+if [ ! -d $TRACING_DIR/instances ]; then
 	exit 0
 fi
 
-rmdir $DEBUGFS/instances/foo
-mkdir $DEBUGFS/instances/foo
-if [ ! -f $DEBUGFS/instances/foo/tracing_cpumask ]; then
+rmdir $TRACING_DIR/instances/foo
+mkdir $TRACING_DIR/instances/foo
+if [ ! -f $TRACING_DIR/instances/foo/tracing_cpumask ]; then
 	echo "instances do not have cpumask"
-	rmdir $DEBUGFS/instances/foo
+	rmdir $TRACING_DIR/instances/foo
 	exit 0
 fi
-rmdir $DEBUGFS/instances/foo
+rmdir $TRACING_DIR/instances/foo
 
 for i in `seq $MSKCNT`; do
     bits=`get_bits $i`
-    run_cmd "-B foo" $DEBUGFS/instances/foo $i $bits
+    run_cmd "-B foo" $TRACING_DIR/instances/foo $i $bits
 done
-rmdir $DEBUGFS/instances/foo
+rmdir $TRACING_DIR/instances/foo
 exit 0
diff --git a/ftrace-test-event-stacktrace b/ftrace-test-event-stacktrace
index 2c204a5..b649435 100755
--- a/ftrace-test-event-stacktrace
+++ b/ftrace-test-event-stacktrace
@@ -1,31 +1,14 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debugfs=`find_debugfs`
-TRACEDIR="$debugfs/tracing"
-EVENTDIR=$TRACEDIR/events
+EVENTDIR=$TRACING_DIR/events
 EVENT=$EVENTDIR/sched/sched_switch
 EVENT_ENABLE=$EVENT/enable
 TRIGGER_FILE=$EVENT/trigger
-TRACE_FILE=$TRACEDIR/trace
-TRACING_ON=$TRACEDIR/tracing_on
+TRACE_FILE=$TRACING_DIR/trace
+TRACING_ON=$TRACING_DIR/tracing_on
 
 # set -x
 
@@ -92,8 +75,8 @@ function check_events() {
 
 function do_reset() {
     clear_triggers
-    echo nop > $TRACEDIR/current_tracer || exit -1
-    echo 0 > $TRACEDIR/events/enable || exit -1
+    echo nop > $TRACING_DIR/current_tracer || exit -1
+    echo 0 > $TRACING_DIR/events/enable || exit -1
     echo > $TRACE_FILE || exit -1
     echo 1 > $TRACING_ON || exit -1
 }
diff --git a/ftrace-test-event-traceon-off b/ftrace-test-event-traceon-off
index ff4690d..f1251a6 100755
--- a/ftrace-test-event-traceon-off
+++ b/ftrace-test-event-traceon-off
@@ -1,26 +1,9 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debugfs=`find_debugfs`
-TRACEDIR="$debugfs/tracing"
-EVENTDIR=$TRACEDIR/events
+EVENTDIR=$TRACING_DIR/events
 
 if [ ! -f $EVENTDIR/sched/sched_switch/trigger ]; then
     echo "triggers are not set for this kernel"
@@ -28,12 +11,12 @@ if [ ! -f $EVENTDIR/sched/sched_switch/trigger ]; then
 fi
 
 function cnt_trace() {
-	    grep -v '^#' $TRACEDIR/trace | head -10000|  wc -l
+	    grep -v '^#' $TRACING_DIR/trace | head -10000|  wc -l
 }
 
 function check_traceon() {
     val=$1
-    cur=`cat $TRACEDIR/tracing_on`
+    cur=`cat $TRACING_DIR/tracing_on`
     if [ $val -ne $cur ]; then
 	echo "traceon expected to be $val but was $cur"
 	exit 1
@@ -43,8 +26,8 @@ function check_traceon() {
 set -x
 
 echo '** DISABLE TRACING'
-echo 0 > $TRACEDIR/tracing_on || exit -1
-echo > $TRACEDIR/trace || exit -1
+echo 0 > $TRACING_DIR/tracing_on || exit -1
+echo > $TRACING_DIR/trace || exit -1
 
 check_traceon 0
 
@@ -56,10 +39,10 @@ fi
 
 echo '** ENABLE FUNCTION TRACING'
 
-echo function > $TRACEDIR/current_tracer || exit -1
+echo function > $TRACING_DIR/current_tracer || exit -1
 
 echo '** ENABLE TRACING'
-echo 1 > $TRACEDIR/tracing_on || exit -1
+echo 1 > $TRACING_DIR/tracing_on || exit -1
 
 cnt=`cnt_trace`
 if [ $cnt -eq 0 ]; then
@@ -81,15 +64,15 @@ if [ $cnt -ne $cnt2 ]; then
    exit -1;
 fi
 
-line1=`cat $TRACEDIR/trace | tail -1`
+line1=`cat $TRACING_DIR/trace | tail -1`
 sleep 1
-line2=`cat $TRACEDIR/trace | tail -1`
+line2=`cat $TRACING_DIR/trace | tail -1`
 
 if [ $line1 != $line2 ]; then
    exit -1
 fi
 
-echo > $TRACEDIR/trace || exit -1
+echo > $TRACING_DIR/trace || exit -1
 
 check_traceon 0
 
@@ -122,17 +105,17 @@ echo '** TEST COUNT traceoff (3)'
 echo "traceoff:3" >> $EVENTDIR/sched/sched_switch/trigger
 check_sleep "0"
 echo '** TEST COUNT traceoff (2)'
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "0"
 echo '** TEST COUNT traceoff (1)'
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "0"
 echo '** TEST COUNT traceoff (0)'
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "1"
 echo "!traceoff:0" >> $EVENTDIR/sched/sched_switch/trigger
 
-echo nop > $TRACEDIR/current_tracer
+echo nop > $TRACING_DIR/current_tracer
 
 echo '** SUCCESS'
 
diff --git a/ftrace-test-event-trigger-event b/ftrace-test-event-trigger-event
index 6bb8333..6373418 100755
--- a/ftrace-test-event-trigger-event
+++ b/ftrace-test-event-trigger-event
@@ -1,31 +1,14 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debugfs=`find_debugfs`
-TRACEDIR="$debugfs/tracing"
-EVENTDIR=$TRACEDIR/events
+EVENTDIR=$TRACING_DIR/events
 EVENT=$EVENTDIR/sched/sched_wakeup
 EVENT_ENABLE=$EVENT/enable
 TRIGGER_FILE=$EVENT/trigger
-TRACE_FILE=$TRACEDIR/trace
-TRACING_ON=$TRACEDIR/tracing_on
+TRACE_FILE=$TRACING_DIR/trace
+TRACING_ON=$TRACING_DIR/tracing_on
 
 OTHER="sched:sched_switch"
 OTHER_EVENT=$EVENTDIR/sched/sched_switch
@@ -102,8 +85,8 @@ function test_other_enabled() {
 
 function do_reset() {
     clear_triggers
-    echo nop > $TRACEDIR/current_tracer || exit -1
-    echo 0 > $TRACEDIR/events/enable || exit -1
+    echo nop > $TRACING_DIR/current_tracer || exit -1
+    echo 0 > $TRACING_DIR/events/enable || exit -1
     echo > $TRACE_FILE || exit -1
     echo 1 > $TRACING_ON || exit -1
 }
diff --git a/ftrace-test-fail-rb-alloc b/ftrace-test-fail-rb-alloc
index 4de1d0f..6a5089c 100755
--- a/ftrace-test-fail-rb-alloc
+++ b/ftrace-test-fail-rb-alloc
@@ -1,27 +1,9 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debugfs=`find_debugfs`
-tracedir="$debugfs/tracing"
-
-echo 99999999 > $tracedir/buffer_size_kb&
+echo 99999999 > $TRACING_DIR/buffer_size_kb&
 sleep 10
 if dmesg | grep "unable to handle kernel NULL"; then
 	exit 1
diff --git a/ftrace-test-fgraph-depth b/ftrace-test-fgraph-depth
index 884c1cd..ffcf882 100755
--- a/ftrace-test-fgraph-depth
+++ b/ftrace-test-fgraph-depth
@@ -1,6 +1,9 @@
 #!/bin/bash
 
-cd /sys/kernel/tracing
+DIR=`dirname $0`
+. $DIR/functions
+
+cd $TRACING_DIR
 
 if [ ! -f max_graph_depth ]; then
 	# only test if graph depth exists
diff --git a/ftrace-test-fgraph-filter b/ftrace-test-fgraph-filter
index ef619a1..b5ac2fd 100755
--- a/ftrace-test-fgraph-filter
+++ b/ftrace-test-fgraph-filter
@@ -1,26 +1,11 @@
 #!/bin/bash
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`
+
+DIR=`dirname $0`
+. $DIR/functions
 
 #set -x
 
-cd $debug/tracing || exit 1
+cd $TRACING_DIR || exit 1
 
 if ! grep -q function_graph available_tracers; then
     echo "no function graph tracer configured"
diff --git a/ftrace-test-func-profiler b/ftrace-test-func-profiler
index f910d12..6dd8f88 100755
--- a/ftrace-test-func-profiler
+++ b/ftrace-test-func-profiler
@@ -10,26 +10,10 @@
 #
 # This test triggers those bugs on those kernels.
 #
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`
-
-cd $debug/tracing || exit 1
+DIR=`dirname $0`
+. $DIR/functions
+
+cd $TRACING_DIR || exit 1
 
 # We need function_graph and profiling to to run this test
 if ! grep -q function_graph available_tracers; then
diff --git a/ftrace-test-instance-tracers b/ftrace-test-instance-tracers
index 4f1e0e1..a7db963 100755
--- a/ftrace-test-instance-tracers
+++ b/ftrace-test-instance-tracers
@@ -1,33 +1,15 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-tracedir="$debugfs/tracing"
+DIR=`dirname $0`
+. $DIR/functions
 tmpfile="/tmp/tmp.$$"
 
-if [ ! -d $tracedir/instances ]; then
+if [ ! -d $TRACING_DIR/instances ]; then
     echo "instances not configured in this kernel"
     exit 0
 fi
 
-cd $tracedir/instances || exit -1
+cd $TRACING_DIR/instances || exit -1
 
 # clear out instances
 ls | while read t; do
@@ -166,14 +148,14 @@ if [ $# -gt 0 ]; then
 	arg="$@"
 fi
 
-for tracer in `cat $tracedir/available_tracers`; do
+for tracer in `cat $TRACING_DIR/available_tracers`; do
 	if [ $tracer == "nop" ]; then
 		continue;
 	fi
 	echo "Testing tracer $tracer"
-	echo $tracer > $tracedir/current_tracer
+	echo $tracer > $TRACING_DIR/current_tracer
 	echo "running $arg"
 	$arg
-	cat $tracedir/trace
-	echo nop > $tracedir/current_tracer
+	cat $TRACING_DIR/trace
+	echo nop > $TRACING_DIR/current_tracer
 done
diff --git a/ftrace-test-irqsoff b/ftrace-test-irqsoff
index d6f3678..62cd9e6 100755
--- a/ftrace-test-irqsoff
+++ b/ftrace-test-irqsoff
@@ -1,10 +1,13 @@
 
+DIR=`dirname $0`
+. $DIR/functions
+
 test_tracer() {
 	tracer=$1
 
-	if grep -q $tracer /sys/kernel/tracing/available_tracers; then
+	if grep -q $tracer $TRACING_DIR/available_tracers; then
 		trace-cmd start -p $tracer
-		x=`wc -l /sys/kernel/tracing/trace | cut -d' ' -f1`
+		x=`wc -l $TRACING_DIR/trace | cut -d' ' -f1`
 		echo $x
 		if [ "$x" -lt 30 ]; then
 			exit 1
diff --git a/ftrace-test-irqsoff-stop-trace b/ftrace-test-irqsoff-stop-trace
index 786925b..f92ff54 100755
--- a/ftrace-test-irqsoff-stop-trace
+++ b/ftrace-test-irqsoff-stop-trace
@@ -1,4 +1,7 @@
-cd /sys/kernel/tracing
+DIR=`dirname $0`
+. $DIR/functions
+
+cd $TRACING_DIR
 if ! grep -q irqsoff available_tracers; then
 	echo irqsoff not configured
 	exit 0
diff --git a/ftrace-test-kprobes b/ftrace-test-kprobes
index 3b33316..840aa75 100755
--- a/ftrace-test-kprobes
+++ b/ftrace-test-kprobes
@@ -1,6 +1,9 @@
 #!/bin/bash
 
-cd /sys/kernel/tracing
+DIR=`dirname $0`
+. $DIR/functions
+
+cd $TRACING_DIR
 
 if [ ! -f kprobe_events ]; then
 	echo "kprobe_events not defined"
diff --git a/ftrace-test-latency-function b/ftrace-test-latency-function
index 4cedd96..bc4097d 100755
--- a/ftrace-test-latency-function
+++ b/ftrace-test-latency-function
@@ -1,12 +1,13 @@
 
-dir=/sys/kernel/tracing
-
-function=$dir/options/function-trace
-max=$dir/tracing_max_latency
-current=$dir/current_tracer
-trace=$dir/trace
-traceon=$dir/tracing_on
-available=$dir/available_tracers
+DIR=`dirname $0`
+. $DIR/functions
+
+function=$TRACING_DIR/options/function-trace
+max=$TRACING_DIR/tracing_max_latency
+current=$TRACING_DIR/current_tracer
+trace=$TRACING_DIR/trace
+traceon=$TRACING_DIR/tracing_on
+available=$TRACING_DIR/available_tracers
 
 
 if [ ! -f $function ]; then
diff --git a/ftrace-test-latency-overwrite b/ftrace-test-latency-overwrite
index 6fc9d54..ff6934d 100755
--- a/ftrace-test-latency-overwrite
+++ b/ftrace-test-latency-overwrite
@@ -1,4 +1,7 @@
-overwrite=/sys/kernel/tracing/options/overwrite
+DIR=`dirname $0`
+. $DIR/functions
+
+overwrite=$TRACING_DIR/options/overwrite
 if [ ! -f $overwrite ]; then
 	echo "overwrite option not defined"
 	exit 0
diff --git a/ftrace-test-mcount b/ftrace-test-mcount
index c90f6d6..47c6168 100755
--- a/ftrace-test-mcount
+++ b/ftrace-test-mcount
@@ -1,25 +1,7 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-tracedir="$debugfs/tracing"
+DIR=`dirname $0`
+. $DIR/functions
 
 mcount=0
 
@@ -33,7 +15,7 @@ else
 	exit 1
 fi
 
-cd $tracedir
+cd $TRACING_DIR
 echo > trace
 
 echo nop > current_tracer
diff --git a/ftrace-test-mkinstances b/ftrace-test-mkinstances
index b0a9739..5e57b40 100755
--- a/ftrace-test-mkinstances
+++ b/ftrace-test-mkinstances
@@ -1,18 +1,14 @@
 #!/bin/bash
 
-tracefs=`cat /proc/mounts  |grep tracefs| head -1 | cut -d' ' -f2`
+DIR=`dirname $0`
+. $DIR/functions
 
-if [ -z "$tracefs" ]; then
-	echo "tracefs not mounted"
-	exit 0
-fi
-
-if [ ! -d $tracefs/instances ]; then
+if [ ! -d $TRACING_DIR/instances ]; then
 	echo "No instances directory"
 	exit 0
 fi
 
-cd $tracefs/instances
+cd $TRACING_DIR/instances
 
 mkdir x
 rmdir x
diff --git a/ftrace-test-mkinstances-2 b/ftrace-test-mkinstances-2
index 743a478..442273f 100755
--- a/ftrace-test-mkinstances-2
+++ b/ftrace-test-mkinstances-2
@@ -1,18 +1,14 @@
 #!/bin/bash
 
-tracefs=`cat /proc/mounts  |grep tracefs| head -1 | cut -d' ' -f2`
+DIR=`dirname $0`
+. $DIR/functions
 
-if [ -z "$tracefs" ]; then
-	echo "tracefs not mounted"
-	exit 0
-fi
-
-if [ ! -d $tracefs/instances ]; then
+if [ ! -d $TRACING_DIR/instances ]; then
 	echo "No instances directory"
 	exit 0
 fi
 
-cd $tracefs/instances
+cd $TRACING_DIR/instances
 
 instance_slam() {
 	while :; do
diff --git a/ftrace-test-module-load b/ftrace-test-module-load
index 2407a36..b7a39e7 100755
--- a/ftrace-test-module-load
+++ b/ftrace-test-module-load
@@ -1,31 +1,8 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-if [ ! -f /proc/modules ]; then
-	echo CONFIG_MODULES not enabled
-	exit 0
-fi
-
-set -x
-debug=`find_debugfs`
+DIR=`dirname $0`
+. $DIR/functions
 
-tracing=$debug/tracing
 version=`uname -r`
 modules=`find /lib/modules/$version -name '*.ko' | sed -e 's,^.*/\([^/]*\)\.ko,\1,' -e 's/-/_/g'`
 loaded=`lsmod | cut -d' ' -f1`
@@ -39,7 +16,7 @@ for mod in $modules; do
 			continue;
 		fi
 		# make sure there's functions to trace.
-		func=`grep "\\[$mod\\]" $tracing/available_filter_functions | head -1 | cut -d' ' -f1`
+		func=`grep "\\[$mod\\]" $TRACING_DIR/available_filter_functions | head -1 | cut -d' ' -f1`
 		rmmod $mod
 		if [ -z "$func" ]; then
 			continue
@@ -54,13 +31,13 @@ module=$mod
 modprobe $module
 rmmod $module
 
-set_ftrace_filter=$tracing/set_ftrace_filter
-set_ftrace_notrace=$tracing/set_ftrace_notrace
+set_ftrace_filter=$TRACING_DIR/set_ftrace_filter
+set_ftrace_notrace=$TRACING_DIR/set_ftrace_notrace
 
 > $set_ftrace_filter
 > $set_ftrace_notrace
 
-echo function > $tracing/current_tracer || exit 1
+echo function > $TRACING_DIR/current_tracer || exit 1
 
 echo "Testing function enabled"
 found=0
@@ -69,7 +46,7 @@ modprobe $module
 while :; do
     loc=`grep "^$module " /proc/modules | cut -d' ' -f6`
     if echo $locs | grep -q $loc ; then
-	echo nop > $tracing/current_tracer || exit 1
+	echo nop > $TRACING_DIR/current_tracer || exit 1
 	> $set_ftrace_filter || exit 1
 	break
     fi
@@ -87,20 +64,20 @@ modprobe $module
 while :; do
     loc=`grep "^$module " /proc/modules | cut -d' ' -f6`
     if echo $locs | grep -q $loc ; then
-	echo nop  > $tracing/current_tracer || exit 1
+	echo nop  > $TRACING_DIR/current_tracer || exit 1
 	> $set_ftrace_filter || exit 1
 	break
     fi
     locs="$locs $loc"
-    echo nop  > $tracing/current_tracer || exit 1
+    echo nop  > $TRACING_DIR/current_tracer || exit 1
     echo $func >> $set_ftrace_filter || exit 1
     rmmod $module
-    echo function > $tracing/current_tracer
+    echo function > $TRACING_DIR/current_tracer
     modprobe $module
 done
 rmmod $module
 echo "  Success"
-echo nop  > $tracing/current_tracer || exit 1
+echo nop  > $TRACING_DIR/current_tracer || exit 1
 
 locs=''
 echo "Testing notrace set"
@@ -110,18 +87,18 @@ while :; do
     if echo $locs | grep -q $loc ; then
 #echo "  done"
 #	exit 0
-	echo nop  > $tracing/current_tracer || exit 1
+	echo nop  > $TRACING_DIR/current_tracer || exit 1
 	> $set_ftrace_filter || exit 1
 	break
     fi
     locs="$locs $loc"
-    echo nop  > $tracing/current_tracer || exit 1
+    echo nop  > $TRACING_DIR/current_tracer || exit 1
     echo $func >> $set_ftrace_notrace || exit 1
     rmmod $module
-    echo function > $tracing/current_tracer
+    echo function > $TRACING_DIR/current_tracer
     modprobe $module
 done
 rmmod $module
 echo "  Success"
-echo nop  > $tracing/current_tracer || exit 1
+echo nop  > $TRACING_DIR/current_tracer || exit 1
 exit 0
diff --git a/ftrace-test-options b/ftrace-test-options
index ca73e68..b2bc610 100755
--- a/ftrace-test-options
+++ b/ftrace-test-options
@@ -1,27 +1,13 @@
 #!/bin/bash
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`
-x=`trace-cmd record -p function -l '*account_user_time' --func-stack cat $debug/tracing/options/func_stack_trace  | head -1`
+
+DIR=`dirname $0`
+. $DIR/functions
+
+x=`trace-cmd record -p function -l '*account_user_time' --func-stack cat $TRACING_DIR/options/func_stack_trace  | head -1`
 # disable function stack trace option (trace-cmd should have done it itself)
 trace-cmd start -p function -l '*account_user_time'
 trace-cmd start -p nop
-echo > $debug/tracing/set_ftrace_filter
+echo > $TRACING_DIR/set_ftrace_filter
 if [ "$x" -eq 1 ]; then
 	exit 0
 fi
diff --git a/ftrace-test-pipe b/ftrace-test-pipe
index aa85cf1..48db2c5 100755
--- a/ftrace-test-pipe
+++ b/ftrace-test-pipe
@@ -1,25 +1,9 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debug=`find_debugfs`
-cd $debug/tracing/
+cd $TRACING_DIR
 
 if [ -f tracing_enabled ]; then
     enable="tracing_enabled"
diff --git a/ftrace-test-saved_cmdlines b/ftrace-test-saved_cmdlines
index c60922e..aa9e2f2 100755
--- a/ftrace-test-saved_cmdlines
+++ b/ftrace-test-saved_cmdlines
@@ -1,30 +1,15 @@
 #!/bin/bash
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`
-TRACE_DIR=$debug/tracing
+
+DIR=`dirname $0`
+. $DIR/functions
+
 file_name=saved_cmdlines_size
-SIZE_FILE=$TRACE_DIR/$file_name
+SIZE_FILE=$TRACING_DIR/$file_name
 HIGHEST_PID=32768
 let TOO_HIGH=$HIGHEST_PID+1
-TRACE_FILE=$TRACE_DIR/trace
-TRACING_ON=$TRACE_DIR/tracing_on
-EVENT_ENABLE=$TRACE_DIR/events/enable
+TRACE_FILE=$TRACING_DIR/trace
+TRACING_ON=$TRACING_DIR/tracing_on
+EVENT_ENABLE=$TRACING_DIR/events/enable
 
 if [ ! -f $SIZE_FILE ]; then
 	echo "$file_name does not exist"
diff --git a/ftrace-test-snapshot b/ftrace-test-snapshot
index ecd5467..26b6a81 100755
--- a/ftrace-test-snapshot
+++ b/ftrace-test-snapshot
@@ -1,25 +1,9 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`/tracing
+DIR=`dirname $0`
+. $DIR/functions
 
-cd $debug || exit 1
+cd $TRACING_DIR || exit 1
 
 if [ ! -f snapshot ]; then
 	echo "No snapshot, not running test"
diff --git a/ftrace-test-stats b/ftrace-test-stats
index 74e37b2..4df2d48 100755
--- a/ftrace-test-stats
+++ b/ftrace-test-stats
@@ -1,32 +1,14 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-DEBUGFS="$debugfs/tracing"
+DIR=`dirname $0`
+. $DIR/functions
 
 #set -x
 
 trace-cmd start -b 1407 -p function || exit 1
 let x=0
 while [ $x -lt 1000 ]; do
-	c=`grep '^overrun' $DEBUGFS/per_cpu/cpu0/stats | cut -d' ' -f2`
+	c=`grep '^overrun' $TRACING_DIR/per_cpu/cpu0/stats | cut -d' ' -f2`
 	if [ $c -gt 0 ]; then
 		break
 	fi
@@ -39,7 +21,7 @@ fi
 
 trace-cmd stop
 
-c=`grep '^entries' $DEBUGFS/per_cpu/cpu0/stats | cut -d' ' -f2`
+c=`grep '^entries' $TRACING_DIR/per_cpu/cpu0/stats | cut -d' ' -f2`
 if [ $c -eq 0 ]; then
 	echo "FAILED: No entries found"
 	exit 1
@@ -47,15 +29,15 @@ fi
 
 echo set buffer to 1000kb
 
-echo 1000 > $DEBUGFS/buffer_size_kb || exit 1
+echo 1000 > $TRACING_DIR/buffer_size_kb || exit 1
 
 echo spawn cat trace_pipe
-cat $DEBUGFS/trace_pipe > /dev/null &
+cat $TRACING_DIR/trace_pipe > /dev/null &
 
 echo read trace
 let x=0
 while [ $x -lt 60 ]; do
-	c=`grep -v '#' $DEBUGFS/trace |wc -l`
+	c=`grep -v '#' $TRACING_DIR/trace |wc -l`
 	if [ $c -eq 0 ]; then
 		break
 	fi
@@ -64,7 +46,7 @@ done
 
 echo disable tracing
 
-echo 0 > $DEBUGFS/tracing_on
+echo 0 > $TRACING_DIR/tracing_on
 
 echo wait for trace to become empty
 
@@ -73,7 +55,7 @@ last_c=2
 
 while [ $c -gt 0 ]; do
 	sleep 1
-	c=`grep -v '#' $DEBUGFS/trace | wc -l`
+	c=`grep -v '#' $TRACING_DIR/trace | wc -l`
 	if [ $c -eq $last_c ]; then
 		echo "trace_pipe stopped updating c=$c last_c=$last_c"
 		exit
@@ -89,11 +71,11 @@ if [ $x -eq 1000 ]; then
 	exit 1
 fi
 
-c=`grep '^entries' $DEBUGFS/per_cpu/cpu0/stats | cut -d' ' -f2`
+c=`grep '^entries' $TRACING_DIR/per_cpu/cpu0/stats | cut -d' ' -f2`
 if [ $c -ne 0 ]; then
 	echo "FAILED: entries should be zero"
 	exit 1
 fi
 
-echo 1 > $DEBUGFS/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 echo 0
diff --git a/ftrace-test-system-names b/ftrace-test-system-names
index 2449311..dfe8e4a 100755
--- a/ftrace-test-system-names
+++ b/ftrace-test-system-names
@@ -1,4 +1,7 @@
-cd /sys/kernel/tracing
+DIR=`dirname $0`
+. $DIR/functions
+
+cd $TRACING_DIR
 if [ ! -f kprobe_events ]; then
 	echo "no kprobes in this kernel"
 	exit 0
diff --git a/ftrace-test-traceon-off b/ftrace-test-traceon-off
index e4fa7ed..fe1b598 100755
--- a/ftrace-test-traceon-off
+++ b/ftrace-test-traceon-off
@@ -1,36 +1,19 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
+DIR=`dirname $0`
+. $DIR/functions
 
-debugfs=`find_debugfs`
-TRACEDIR="$debugfs/tracing"
-EVENTDIR=$TRACEDIR/events
+EVENTDIR=$TRACING_DIR/events
 
 function cnt_trace() {
-	    grep -v '^#' $TRACEDIR/trace | head -10000 | wc -l
+	    grep -v '^#' $TRACING_DIR/trace | head -10000 | wc -l
 }
 
 #set -x
 
 echo '** DISABLE TRACING'
-echo 0 > $TRACEDIR/tracing_on || exit -1
-echo > $TRACEDIR/trace || exit -1
+echo 0 > $TRACING_DIR/tracing_on || exit -1
+echo > $TRACING_DIR/trace || exit -1
 
 cnt=`cnt_trace`
 if [ $cnt -ne 0 ]; then
@@ -43,7 +26,7 @@ echo '** ENABLE EVENTS'
 echo 1 > $EVENTDIR/enable || exit -1
 
 echo '** ENABLE TRACING'
-echo 1 > $TRACEDIR/tracing_on || exit -1
+echo 1 > $TRACING_DIR/tracing_on || exit -1
 
 cnt=`cnt_trace`
 if [ $cnt -eq 0 ]; then
@@ -59,9 +42,9 @@ fi
 
 echo '** SET TRACEOFF'
 
-echo "$func:traceoff" > $TRACEDIR/set_ftrace_filter
+echo "$func:traceoff" > $TRACING_DIR/set_ftrace_filter
 
-cnt=`grep schedule $TRACEDIR/set_ftrace_filter | wc -l`
+cnt=`grep schedule $TRACING_DIR/set_ftrace_filter | wc -l`
 if [ $cnt -ne 1 ]; then
    exit -1
 fi
@@ -74,41 +57,41 @@ if [ $cnt -ne $cnt2 ]; then
    exit -1;
 fi
 
-on=`cat $TRACEDIR/tracing_on`
+on=`cat $TRACING_DIR/tracing_on`
 if [ $on != "0" ]; then
 	exit -1
 fi
 
-line1=`cat $TRACEDIR/trace | tail -1`
+line1=`cat $TRACING_DIR/trace | tail -1`
 sleep 1
-line2=`cat $TRACEDIR/trace | tail -1`
+line2=`cat $TRACING_DIR/trace | tail -1`
 
 if [ "$line1" != "$line2" ]; then
    exit -1
 fi
 
-echo > $TRACEDIR/trace || exit -1
+echo > $TRACING_DIR/trace || exit -1
 
 cnt=`cnt_trace`
 if [ $cnt -ne 0 ]; then
    exit -1
 fi
 
-echo "!$func:traceoff" >> $TRACEDIR/set_ftrace_filter
+echo "!$func:traceoff" >> $TRACING_DIR/set_ftrace_filter
 
-cnt=`grep schedule $TRACEDIR/set_ftrace_filter | wc -l`
+cnt=`grep schedule $TRACING_DIR/set_ftrace_filter | wc -l`
 if [ $cnt -ne 0 ]; then
    exit -1
 fi
 
-on=`cat $TRACEDIR/tracing_on`
+on=`cat $TRACING_DIR/tracing_on`
 if [ $on != "0" ]; then
 	exit -1
 fi
 
-echo "$func:traceon" > $TRACEDIR/set_ftrace_filter
+echo "$func:traceon" > $TRACING_DIR/set_ftrace_filter
 
-cnt=`grep schedule $TRACEDIR/set_ftrace_filter | wc -l`
+cnt=`grep schedule $TRACING_DIR/set_ftrace_filter | wc -l`
 if [ $cnt -ne 1 ]; then
    exit -1
 fi
@@ -118,15 +101,15 @@ if [ $cnt -eq 0 ]; then
    exit -1
 fi
 
-on=`cat $TRACEDIR/tracing_on`
+on=`cat $TRACING_DIR/tracing_on`
 if [ $on != "1" ]; then
 	exit -1
 fi
 
 
-echo "!$func:traceon" >> $TRACEDIR/set_ftrace_filter
+echo "!$func:traceon" >> $TRACING_DIR/set_ftrace_filter
 
-cnt=`grep schedule $TRACEDIR/set_ftrace_filter | wc -l`
+cnt=`grep schedule $TRACING_DIR/set_ftrace_filter | wc -l`
 if [ $cnt -ne 0 ]; then
    exit -1
 fi
@@ -134,25 +117,25 @@ fi
 check_sleep() {
     val=$1
     sleep 1
-    cat $TRACEDIR/set_ftrace_filter
-    on=`cat $TRACEDIR/tracing_on`
+    cat $TRACING_DIR/set_ftrace_filter
+    on=`cat $TRACING_DIR/tracing_on`
     if [ $on != "$val" ]; then
 	exit -1
     fi
 }
 
 
-echo "$func:traceoff:3" > $TRACEDIR/set_ftrace_filter
+echo "$func:traceoff:3" > $TRACING_DIR/set_ftrace_filter
 check_sleep "0"
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "0"
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "0"
-echo 1 > $TRACEDIR/tracing_on
+echo 1 > $TRACING_DIR/tracing_on
 check_sleep "1"
-echo "!$func:traceoff:0" > $TRACEDIR/set_ftrace_filter
+echo "!$func:traceoff:0" > $TRACING_DIR/set_ftrace_filter
 
-if grep -e traceon -e traceoff $TRACEDIR/set_ftrace_filter; then
+if grep -e traceon -e traceoff $TRACING_DIR/set_ftrace_filter; then
     exit -1
 fi
 
diff --git a/ftrace-test-tracers b/ftrace-test-tracers
index 7dd6fac..cb2c705 100755
--- a/ftrace-test-tracers
+++ b/ftrace-test-tracers
@@ -1,25 +1,7 @@
 #!/bin/bash
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-tracedir="$debugfs/tracing"
+DIR=`dirname $0`
+. $DIR/functions
 
 arg="sleep 10"
 if [ $# -gt 0 ]; then
@@ -28,17 +10,17 @@ fi
 
 tmpfile=/tmp/tmpfile.$$
 
-for tracer in `cat $tracedir/available_tracers`; do
+for tracer in `cat $TRACING_DIR/available_tracers`; do
 	if [ $tracer == "nop" ]; then
 		continue;
 	fi
 	echo "Testing tracer $tracer"
-	echo $tracer > $tracedir/current_tracer
+	echo $tracer > $TRACING_DIR/current_tracer
 	echo "running $arg"
 	$arg
-	echo 0 > $tracedir/tracing_on
-	cat $tracedir/trace > $tmpfile
-	echo nop > $tracedir/current_tracer
+	echo 0 > $TRACING_DIR/tracing_on
+	cat $TRACING_DIR/trace > $tmpfile
+	echo nop > $TRACING_DIR/current_tracer
 	cnt=`wc -l $tmpfile | cut -d ' ' -f1`
 	if [ $cnt -gt 300 ]; then
 		head -100 $tmpfile
@@ -47,5 +29,5 @@ for tracer in `cat $tracedir/available_tracers`; do
 	else
 		cat $tmpfile
 	fi
-	echo 1 > $tracedir/tracing_on
+	echo 1 > $TRACING_DIR/tracing_on
 done
diff --git a/ftrace-test-tramp-count b/ftrace-test-tramp-count
index d4c305b..da04e02 100755
--- a/ftrace-test-tramp-count
+++ b/ftrace-test-tramp-count
@@ -8,26 +8,10 @@
 #
 # This test triggers that bug on those kernels.
 #
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $mount == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-debug=`find_debugfs`
+DIR=`dirname $0`
+. $DIR/functions
 
-cd $debug/tracing || exit 1
+cd $TRACING_DIR || exit 1
 
 # We need function_graph, instances that do function tracing and stack trace
 # to run this test
diff --git a/functions b/functions
new file mode 100644
index 0000000..198284b
--- /dev/null
+++ b/functions
@@ -0,0 +1,20 @@
+
+tracefs=`cat /proc/mounts  |grep tracefs| head -1 | cut -d' ' -f2`
+
+if [ -z "$tracefs" ]; then
+	if mount -t tracefs tracefs /sys/kernel/tracing; then
+		tracefs=/sys/kernel/tracing
+	elif mount -t debugfs tracefs /sys/kernel/debug; then
+		tracefs=/sys/kernel/debug/tracing
+	else
+		echo "Failed to find or mount tracefs"
+		exit 1
+	fi
+fi
+
+if [ ! -d $tracefs ]; then
+	echo "$tracefs is not a directory"
+	exit 1
+fi
+
+export TRACING_DIR=$tracefs
diff --git a/run-ftrace-tests b/run-ftrace-tests
index efbd68e..e349aff 100755
--- a/run-ftrace-tests
+++ b/run-ftrace-tests
@@ -1,6 +1,5 @@
-TRACE_DIR="/sys/kernel/tracing"
-
 DIR=`dirname $0`
+. $DIR/functions
 
 m=`uname -m`
 if [ "$m" == "x86_64" ]; then
@@ -26,7 +25,7 @@ run() {
 	sleep 1;
 }
 
-echo 1 > ${TRACE_DIR}/options/pause-on-trace
+echo 1 > ${TRACING_DIR}/options/pause-on-trace
 
 run "TESTING MCOUNT" ftrace-test-mcount
 
diff --git a/test-mod-event b/test-mod-event
index a5dd0b5..f178a97 100755
--- a/test-mod-event
+++ b/test-mod-event
@@ -1,9 +1,12 @@
+DIR=`dirname $0`
+$DIR/functions
+
 echo "insmod"
 insmod /lib/modules/`uname -r`/kernel/samples/trace_events/trace-events-sample.ko
 rm -f /tmp/fifo
 mkfifo /tmp/fifo
 echo "open filter"
-cat /tmp/fifo | /work/c/read-wait /sys/kernel/tracing/events/sample/filter &
+cat /tmp/fifo | /work/c/read-wait $TRACING_DIR/events/sample/filter &
 sleep 1
 echo "rmmod"
 rmmod trace-events-sample.ko
diff --git a/test-tracecmd-record-plugins b/test-tracecmd-record-plugins
index 3212e70..4f1b16a 100755
--- a/test-tracecmd-record-plugins
+++ b/test-tracecmd-record-plugins
@@ -1,5 +1,8 @@
 #!/bin/bash
 
+DIR=`dirname $0`
+$DIR/functions
+
 TRACECMD=trace-cmd
 
 TIME=2
@@ -10,27 +13,6 @@ if [ $nosplice -ne 0 ]; then
     echo " --nosplice not supported"
 fi
 
-find_debugfs() {
-    debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
-	if [ $type == "debugfs" ]; then
-	    echo $dir;
-	    break
-	fi
-    done`
-    if [ -z "$debugfs" ]; then
-	if ! mount -t debugfs nodev /sys/kernel/debug; then
-	    echo "FAILED to mount debugfs"
-	    exit -1
-	fi
-	echo "/sys/kernel/debug"
-    else
-	echo $debugfs
-    fi
-}
-
-debugfs=`find_debugfs`
-tracedir="$debugfs/tracing"
-
 # test plugins
 
 run_plugin_test() {
@@ -49,7 +31,7 @@ run_plugin_test() {
     head -500 /tmp/test-trace.out
 }
 
-plugins=`cat $tracedir/available_tracers`;
+plugins=`cat $TRACING_DIR/available_tracers`;
 for p in $plugins; do
     run_plugin_test $p || exit 1
     if [ $nosplice -eq 0 ]; then
diff --git a/trace-cmd-filter-stress b/trace-cmd-filter-stress
index ceb38bb..f5f1601 100755
--- a/trace-cmd-filter-stress
+++ b/trace-cmd-filter-stress
@@ -131,7 +131,7 @@ read_pids() {
 
 get_tracing_dir() {
 	debug=`grep debugfs /proc/mounts | awk '{ print $2 }'`
-	echo -n "$debug/tracing"
+	echo -n "$TRACING_DIR"
 }
 
 ors() {
-- 
2.35.1

