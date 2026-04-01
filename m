Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EA3603CA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011924; cv=none; b=iYGRIsttkJJkeVrWBPlIjs00I9KFwDrEbGOZHmrbkEMhVw44s8w7sBRuuUCn9NIxAxyvgxuRzpc2QEo+FHTZieb8uR5Y8AjW0sSydeEVJKwBo/4KAJik5JniAilY9y9GvF1qctLjTDE+9IyPj2ghv9r7/qJD2/69DIN1fLi+Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011924; c=relaxed/simple;
	bh=yMu7TwDCFAicnPOSC8XrvduiYSxhPfl1xo2L4vBOzsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8zSqf4rqUe0DMeExmpCBgOlRESag+OErOHAEQnRxW2S6rJdrzeg+oImPzdrWCxtmbn7tJMj5OboI06sTJowxrRkuHgotWstEYe1HLE910z7rn75x56URc8+cuW6QTv77m4Avs3xkdYftAyO8QupFOLp1odNDCerH0CTSmDPXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTYPcstZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTYPcstZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48881eac1f2so3843185e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 19:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775011916; x=1775616716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9mEmKXXXp5DUWLJ3YSbv4wAXPQyMGZDr6RS8OuOv5I=;
        b=iTYPcstZfCpzE+Q0FflIbD5TWHce9vugONcSSVYQrkKK2jU1bYRoHfeW7GJtg/5IJO
         a1f3WPmQZ5qhQJsgPhgKAoLPhUxOXWJ3/Yjr+Eck8pzwMylMr7ZYDgR5ssyPdOIub+Am
         OxKMZzgFm2qmyjlXwKcYkex2PJlEvJ1kFHjV3ffbqHRvDa15FLNm5FJjC/D+eDnZRGCa
         zfYaAqy4uqTrqnD9eMcrx2fbfeBexQFprFrLaWoC8I0+c2AkhBwcw/3lsQokh+duS8K2
         wOQTFZeEqAVBCnQg3t3VBB5TTcweyBN8kxBLJg2p38BIHFYTuekS5Oeygacee9EPdOq3
         mJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011916; x=1775616716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9mEmKXXXp5DUWLJ3YSbv4wAXPQyMGZDr6RS8OuOv5I=;
        b=PK+CPQ3IN37j0l2OET7j8MRq8X9m4HOkpyxUyRU0Zcr0o5AQg26Q89szADIu2IGEcN
         d8EM/VUMILSq2PPZYF7nuzpsiXLnQyBCqs92hONKcb848kfvC+KeCCHJ3kBDpcJJTkyJ
         EouLu/TxyMwgg5N5FEVqTOh8q+V7L2iOjoOEauU/IRNwXbL8ilzQJuUljaCMyS9Pds2X
         B19xCzdo626oNbhHAKTmDsZl4s70r1Acff3Ew8nFSf/DA35EiXsG8jri4HLCr8DsxvVV
         7LNKN2qj5jCBCINCBHWZq4oEUbIDC0IkE4szOtCA+mxG1PUHxLSBsgqSxh/Hu1Wi4gVr
         VS9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjEWra9yuYSY5vwQo9n+zdXXLoiCM5axMTFa/wXG5BuAeXyO12e2CMdHZ5yioIb9tXZ8CQ6yrYiIY4isDm59fGO44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NGXAlaN67/B2GeajO0UXaKLzSj41YX6gmJzS4umT3dNzmhb8
	fA0sxTJh1gwtFvRgXNUtke+4bYjg7D9NB1lu0UXSaK4FgPNqs/v+ORwCwCAe6JcX+nfMqZUJ4r4
	b8TOLxBUu0+aPlyd4Cdko/w==
X-Received: from wmgi18.prod.google.com ([2002:a05:600c:2d92:b0:487:3739:c5c4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e05:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-488832f6248mr30158105e9.0.1775011915777;
 Tue, 31 Mar 2026 19:51:55 -0700 (PDT)
Date: Wed,  1 Apr 2026 03:50:03 +0100
In-Reply-To: <20260401025003.3258729-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401025003.3258729-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401025003.3258729-3-vdonnefort@google.com>
Subject: [PATCH 2/2] tracing: selftests: Extend hotplug testing for trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The hotplug testing only tries reading a trace remote buffer, loaded
before a CPU is offline. Extend this testing to cover:

  * A trace remote buffer loaded after a CPU is offline.
  * A trace remote buffer loaded before a CPU is online.

Because of these added test cases, move the hotplug testing into a
separate hotplug.tc file.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 97a09d564a34..ca531a0336dc 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -32,6 +32,15 @@ assert_unloaded()
 	grep -q "(unloaded)" buffer_size_kb
 }
 
+reload_remote()
+{
+	echo 0 > tracing_on
+	clear_trace
+	assert_unloaded
+	echo 1 > tracing_on
+	assert_loaded
+}
+
 dump_trace_pipe()
 {
     output=$(mktemp $TMPDIR/remote_test.XXXXXX)
@@ -79,10 +88,12 @@ get_cpu_ids()
     sed -n 's/^processor\s*:\s*\([0-9]\+\).*/\1/p' /proc/cpuinfo
 }
 
-get_page_size() {
+get_page_size()
+{
     sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
 }
 
-get_selftest_event_size() {
+get_selftest_event_size()
+{
     sed -ne 's/^.*field:.*;.*size:\([0-9][0-9]*\);.*/\1/p' events/*/selftest/format | awk '{s+=$1} END {print s}'
 }
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
new file mode 100644
index 000000000000..86b55824d631
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote read with an offline CPU
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+hotunplug_one_cpu()
+{
+	[ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 1
+
+	for cpu in $(get_cpu_ids); do
+		echo 0 > /sys/devices/system/cpu/cpu$cpu/online || return 1
+		break
+	done
+
+	echo $cpu
+}
+
+# Check non-consuming and consuming read
+check_read()
+{
+    for i in $(seq 1 8); do
+        echo $i > write_event
+    done
+
+    check_trace 1 8 trace
+
+    output=$(dump_trace_pipe)
+    check_trace 1 8 $output
+    rm $output
+}
+
+test_hotplug()
+{
+    echo 0 > trace
+    assert_loaded
+
+    #
+    # Test a trace buffer containing an offline CPU
+    #
+
+    cpu=$(hotunplug_one_cpu) || exit_unsupported
+
+    check_read
+
+    #
+    # Test a trace buffer with a missing CPU
+    #
+
+    reload_remote
+
+    check_read
+
+    #
+    # Test a trace buffer with a CPU added later
+    #
+
+    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
+    assert_loaded
+
+    check_read
+
+    # Test if the ring-buffer for the newly added CPU is both writable and
+    # readable
+    for i in $(seq 1 8); do
+        taskset -c $cpu echo $i > write_event
+    done
+
+    cd per_cpu/cpu$cpu/
+
+    check_trace 1 8 trace
+
+    output=$(dump_trace_pipe)
+    check_trace 1 8 $output
+    rm $output
+
+    cd -
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_hotplug
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
new file mode 100644
index 000000000000..580ec32c8f81
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace read with an offline CPU
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/hotplug.tc
+
+set -e
+setup_remote "hypervisor"
+test_hotplug
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
index 170f7648732a..bc9377a70e8d 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
@@ -58,11 +58,7 @@ test_trace()
     #
 
     # Ensure the writer is not on the reader page by reloading the buffer
-    echo 0 > tracing_on
-    echo 0 > trace
-    assert_unloaded
-    echo 1 > tracing_on
-    assert_loaded
+    reload_remote
 
     # Ensure ring-buffer overflow by emitting events from the same CPU
     for cpu in $(get_cpu_ids); do
@@ -96,27 +92,6 @@ test_trace()
 
         cd - > /dev/null
     done
-
-    #
-    # Test with hotplug
-    #
-
-    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
-
-    echo 0 > trace
-
-    for cpu in $(get_cpu_ids); do
-        echo 0 > /sys/devices/system/cpu/cpu$cpu/online || return 0
-        break
-    done
-
-    for i in $(seq 1 8); do
-        echo $i > write_event
-    done
-
-    check_trace 1 8 trace
-
-    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
 }
 
 if [ -z "$SOURCE_REMOTE_TEST" ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
index 669a7288ed7c..7f7b7b79c490 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
+++ b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
@@ -92,31 +92,6 @@ test_trace_pipe()
         rm $output
         cd - > /dev/null
     done
-
-    #
-    # Test interaction with hotplug
-    #
-
-    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
-
-    echo 0 > trace
-
-    for cpu in $(get_cpu_ids); do
-        echo 0 > /sys/devices/system/cpu/cpu$cpu/online || return 0
-        break
-    done
-
-    for i in $(seq 1 8); do
-        echo $i > write_event
-    done
-
-    output=$(dump_trace_pipe)
-
-    check_trace 1 8 $output
-
-    rm $output
-
-    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
 }
 
 if [ -z "$SOURCE_REMOTE_TEST" ]; then
-- 
2.53.0.1118.gaef5881109-goog

