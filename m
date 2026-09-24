Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E48A8B1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261921; cv=none; b=iRzUbxTHAyFOz4jgFbMJE2jrIosGZwROTrdQ4oZxlSMuFHw7twSPBUEupgQJehT7NvyFBCtwWKOirCb/7Xynu9qgNjNrIvYrLN2hiw9GY46P9RRyDrkaZBHL4OfkFx9cr9hUBRHlidgURULBx50sBBgnQmKN2QNeF/Qu/6+jlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261921; c=relaxed/simple;
	bh=cp1AhYwgoyBcNpnaWfbKwCvMcNX5AAJTHBA6wE+dkpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a27Juc6RXimsw3/INv1jgGej9hbg8uS+Vi6S/cAcN9Bbpd5X5D946n0Rb7ffPn1lENnoibFaBnXiz5RUZYl8Facay9KOdRhTg18Bx5a8ae20FmyqsNCVK17i1vTg7K9wujrZhf5rIMe2h3axzZcVCv7q7GNNlQ8JodMqJMjyo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEQwkkvV; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEQwkkvV"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso15272605e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261914; x=1790866714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APC2vzzEaWI0IfcuCj+IJ6SBWsVQXpmXfTBg9jSKKIw=;
        b=gEQwkkvVD8VBv5z+N96rH5kPHhCX4WVZpLBAze0ArowGCu/x0RpeYRSXFQDqFi154B
         Usoaz7wFZpfubXxx2io2id3hD56FDeBU1BHExqkt+dCsShXS4zkJPnLDgiCBPGmaGiHo
         A6sPFU15+BYOl/1jDBzUX1LN5p8V2uubyTur7W7ko8ul1Lj6RhaunEtRRNwaI/9T/5Zs
         s6GDDknV7Y869KhYRYYKbu6dSNtDdFXpDEtAGCaC+IzeX4ztvSA//bY4dU3JeFHSMTAk
         YS6TNaC3++3dyPN+MqCf3xvfh+x3zxF+vFlrmL7S1R4oy8cCswFvwsb+XPgkN8ybNmPI
         VDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261914; x=1790866714;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APC2vzzEaWI0IfcuCj+IJ6SBWsVQXpmXfTBg9jSKKIw=;
        b=Uo1oRnL9ag7LtvnhWp9g/oWXmAPuwBI7YlrWdV/h6TMrBSf8AJBsukn+Mh29NBC0am
         3Ysg4B18njH9MBtdYUqw2aZFMXGE6pnD6x21FNvVpb++RqqlRSXH/SKyXbK3bOQ6xCTm
         6SkAkT/DylmLNBNM3oje58DrKEFuSjk0AxolZfAtFMGzrAQq1JGTdhRSISKDKwJlxW2K
         LbAO0tu33VMUG9wJPIwHuwk1lnRqMwoIDuW7DOsopFYtaH2jvUzOzoqPOPGlgsfS+Ms8
         vrhrwXfNX8f1NHc4jADC/IQVjFCGC8Ub8qSyHcffOlC3BSVude18UWrRPEEqLuIMOfgJ
         tVTw==
X-Forwarded-Encrypted: i=1; AKwUvBw8U2JgwzGBxLIczPcngQ16ON29d5eQAQSFjWlxet9rSR69Yi8ap9vvzEQ1EV2P3wwDnhiRc7R2vCiNAt3tHuUNjac=@vger.kernel.org
X-Gm-Message-State: AFuF++kwHiohtBrCNZUj8ucoqtYDyZsGil8EjhsJTWjIAVjC515IS2u9
	UV/LclXHNGq0Qe9B1GotS3Au8YlwP7Nb4nL0wGJZjo38Vk2deBJwFUb8EDbTRbbTfSbtSw40wES
	Qsg/pb72ykLwgGusNQfPlEw==
X-Received: from wmpo33.prod.google.com ([2002:a05:600c:33a1:b0:49e:661c:77f4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c7:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49fe66c8e71mr45572405e9.2.1790261913911;
 Thu, 24 Sep 2026 07:58:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:43 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-10-vdonnefort@google.com>
Subject: [PATCH v7 09/20] tracing/remotes: selftests: Add a test for the dmesg
 tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced dmesg tracefs file that turns on and off
the dmesg redirection.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../selftests/ftrace/test.d/remotes/dmesg.tc  | 86 +++++++++++++++++++
 .../selftests/ftrace/test.d/remotes/functions |  1 +
 .../ftrace/test.d/remotes/hypervisor/dmesg.tc | 11 +++
 3 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
new file mode 100644
index 000000000000..a5dcdd91e516
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dmesg redirection
+# requires: remotes/test remotes/test/dmesg
+
+. $TEST_DIR/remotes/functions
+
+test_dmesg()
+{
+    if [ ! -f /sys/module/printk/parameters/time ] || [ "$(cat /sys/module/printk/parameters/time)" != "Y" ]; then
+        echo "printk timestamps are disabled - please enable CONFIG_PRINTK_TIME"
+        exit_unsupported
+    fi
+
+    echo 0 > tracing_on
+    assert_unloaded
+
+    #
+    # Test dmesg on/off when tracing is disabled
+    #
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
+    assert_loaded
+
+    echo 0 > dmesg
+    test $(cat dmesg) -eq 0
+    assert_unloaded
+
+    #
+    # Test events are logged to dmesg
+    #
+
+    echo 1 > tracing_on
+    assert_loaded
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
+
+    # Timestamp format is '[    XXXX.YYYY]'
+    last_ts=$(dmesg | tail -1 | sed -n 's/^\[ *\([0-9]*.[0-9]*\)\].*/\1/p')
+    if [ -z "$last_ts" ]; then
+        last_ts=0
+    fi
+
+    nr_events=128
+    for i in $(seq 1 $nr_events); do
+        echo $i > write_event
+    done
+
+    sleep 1
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+    dmesg | awk -v ts=$last_ts '
+    /^\[ *[0-9]+\.[0-9]+\]/ {
+        t=$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
+        if (t+0 > ts+0) print $0
+    }' | grep "selftest id=" | sed 's/^[^]]*] //'> $output
+
+    check_trace 1 $nr_events $output
+
+    rm $output
+
+    #
+    # Disable dmesg and verify events were not consumed by dmesg
+    #
+    echo 0 > dmesg
+    test $(cat dmesg) -eq 0
+
+    start_id=$(($nr_events + 1))
+    end_id=$(($start_id + $nr_events))
+
+    for i in $(seq $start_id $end_id); do
+        echo $i > write_event
+    done
+
+    sleep 1
+
+    output=$(dump_trace_pipe)
+    check_trace $start_id $end_id $output
+    rm $output
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_dmesg
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 05224fac3653..c368dea2ac4e 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -8,6 +8,7 @@ setup_remote()
 
 	cd remotes/$name/
 	echo 0 > tracing_on
+	[ -f dmesg ] && echo 0 > dmesg
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
new file mode 100644
index 000000000000..4d6ce8fed3cb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dmesg redirection
+# requires: remotes/hypervisor/write_event remotes/hypervisor/dmesg
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dmesg.tc
+
+set -e
+setup_remote "hypervisor"
+test_dmesg
-- 
2.56.0.rc1.310.g51773c2048-goog

