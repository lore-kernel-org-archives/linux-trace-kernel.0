Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC4381AE9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019144; cv=none; b=p+jwO9MQT66K28zjDsGYSiNx3YIcmOChyHsoPpF2DmrvJzwCOeNKTH3hT9rgY4aDKQr3+UTn0rQselb0vhqDm1mgXFL6U5etNth+BtJOPSQTbCL/rhkJdmTFO4cGyWxJ/kO3ZBxXBvv4PIKoD9xQKV/xCeQTnoZkKTdA4reiMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019144; c=relaxed/simple;
	bh=LW18+NpzYrBxvjmlql75o7yvp1CeXooy51NbJveuitk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5PiJKUZvAg2m+2HXh0lFGTg11hslsba1BZne8Dxy5MlbW65SABaKrxEKp0bHfEzrGhH6RQQjK7VfzVJ032Xmg38osWlVOWdGrs042waPIwZNe3QqaV7LGMVK5HCGcsO03vDpwWXTCPWxu/UDlPb6VWfHIs8XGBgeuG67ymuES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHwUeYeC; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHwUeYeC"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d14a4bcd0so564645f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775019141; x=1775623941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lorCFtW6iLrswzeXANX4hHFPPPnND3TRCNrbzm4C2wU=;
        b=EHwUeYeCmdsyL+3WDb2ZiLZ1QHEhXNVd4+6F4HGY/OyEbuVtkcK4hsfLNOIOxWYbcD
         NjYGReyGWG0jdRAXP9J5w/Ad5IzOqQI8dakmWQVXeGIGy0lTuKQVuudUN9fZpAQCNiq2
         dTN46fHbVqvmO86eBe0QtVZuts51IX4DsUQyeRqk8L1dnLkOCgA0ZfsLioTwBtB7JiLq
         yS3D/YViSDD1/SZ15fqUs2mT0uWYRp+imgz5R5NC5ZnKbwzhun3wtMcPdnzmCYdYlGje
         nAUqMdBDS4D7mWCgUB9DMI++mGwpSCNwfXn+7wC06LhPWJVYNv1SQzXDXQFlQ+Uff0EF
         5ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019141; x=1775623941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lorCFtW6iLrswzeXANX4hHFPPPnND3TRCNrbzm4C2wU=;
        b=KfS4drosyv+uVjK+pJqyK+Z/zH461iGmOcGEjcYQyeCHKGT+RWF5USX3PI74t/ocx2
         p61DAAoBzL8WkC4G2wb7eiHy6qOCZyjxxG3/wWlfshnx5JZDzOOxghpYFMG0wz5XhXEC
         8EawTQfMNhrSP2SJcqwK+iW7cD/XffJ7l43thckNwajP2kF1Ig9WRHNtmbcbskV0OcbW
         d7qXR03EMqoGQ3Kzpfbck+aan1ZGrS4AXdIqKFah9MUEIzvBNrFPbBiP3bhm9d93b9O3
         5IFNPw9zEqZbrfMYn+jF3TeSalXHa2zB6/krUYHf/A3V1bHv+c7MqCpewmRVL+i19/it
         Oz4w==
X-Forwarded-Encrypted: i=1; AJvYcCXKW6RHFcpGTuVUxH8BP9jlQfv+5W+X7PzU4i6VfDgeMlk6bLtZMYpBqPAiWJVTGX0nkHKeBRqACqG6gF8VhCQIv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwxBIEatkGJpWTEAWvaiw9i5H+VpGFyknfcrY0BMKeBPqMr8Uu
	5GWkBKy932xkkuc9/Xx7HR1vSj/OcWTFRrmu+aa1TOkc+18rM2rLu35I1pgtaBdaF4PYqvgwdek
	oVMLl273D3lRLfVRec5dheA==
X-Received: from wmps7.prod.google.com ([2002:a05:600c:3187:b0:488:8019:449e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19d0:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-488835629ffmr30649845e9.7.1775019141201;
 Tue, 31 Mar 2026 21:52:21 -0700 (PDT)
Date: Wed,  1 Apr 2026 05:51:00 +0100
In-Reply-To: <20260401045100.3394299-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401045100.3394299-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401045100.3394299-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] tracing: selftests: Extend hotplug testing for trace remotes
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
index 97a09d564a34..05224fac3653 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -24,12 +24,21 @@ setup_remote_test()
 
 assert_loaded()
 {
-	grep -q "(loaded)" buffer_size_kb
+	grep -q "(loaded)" buffer_size_kb || return 1
 }
 
 assert_unloaded()
 {
-	grep -q "(unloaded)" buffer_size_kb
+	grep -q "(unloaded)" buffer_size_kb || return 1
+}
+
+reload_remote()
+{
+	echo 0 > tracing_on
+	clear_trace
+	assert_unloaded
+	echo 1 > tracing_on
+	assert_loaded
 }
 
 dump_trace_pipe()
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
index 000000000000..145617eb8061
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
@@ -0,0 +1,88 @@
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
+    trap "echo 1 > /sys/devices/system/cpu/cpu$cpu/online" EXIT
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
+    trap "" EXIT
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

