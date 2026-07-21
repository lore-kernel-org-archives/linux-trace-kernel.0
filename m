Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2574D9911
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630200; cv=none; b=rU4Z+FZ65NCLsLgSaWqvbp3DCOJ9hlfom0HjCZadiH28y5GzXugD9ERmDt5apciwTV9nI8yPPH5bXmX6v9F96QVZUpGqTP+PyqHAafs2w4woH/TH+bBSEn1X4+URi1Y5LT/EjAoBKC/3SrIe3JnpOvp8N2VCv35/vO/9/Mplh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630200; c=relaxed/simple;
	bh=79quW77+eG9KGNP0rUUQZKxOiZkjCWVWnD8P7UfGD9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nh1iV9Nx+UdamxF4T/3F8SKHXgJckm1+jjiU8Nt3yugGjigZgu4oEOTUliOHcfmZaSZRDN96FYHcdIv2q9p8DbuL7hTlkOuGap00WiIO5L2S6Dy8hiP6OgesDo6VlF2ZWgWjkcHr6NuoTDXwG4vrRl6y7bcGyJgROEXfQd4D9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlMmAKZs; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlMmAKZs"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so100174075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630196; x=1785234996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWMQfKAdLeahyO0e1rMDF6QLENVkX2iH4YUwGfH7khE=;
        b=mlMmAKZsz0OYCZJyB8zLrXeA6jFbv+gFJTEqnA4KthNEiUQAPFAUB9Nc8ooQ1WtSpV
         sNOcydkol4d2g30RzhWdud7sl1IXMtz2lGBab21v4NA/Ibgt+KuFbbnF4IdLkDP+NJOU
         Oj0pRiyjLKb84xMdcM4ebVROK1Mtt2MY7r6PMZtS8lYJAkh2R6lWwJWZwrZ9YKv9XYJO
         2dXOL+ocm6oddpgfuST3jjuB8Ngn47z5fcdXmS1ligOgQ3I+bP8wJL/ILFQ0u5eKjQEM
         0MocCB0OKTFBmzoKNImuV+GHjEDSKWcRwvvXhShaFwjCvT5T0HPW52JD1Gc3V5NF+8Uh
         7AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630196; x=1785234996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWMQfKAdLeahyO0e1rMDF6QLENVkX2iH4YUwGfH7khE=;
        b=S8PYHZvwmWEt67bOmswWq0z25VuFxz7FrXvzv1MYY8VjbLGycx85QU1C4L0Tw1zxk/
         tJh7eBuMeTcDHAMIR4k1uvd0C7YasCWXc6wQmgwQa2O7tYJYk0mW/72whASmM9mg+O+U
         cRHNxAvwn2PByGiJTJRQKOe33fhPYuEFEXYvVdQJYeW7Ap9fqq/DVPDZ7eq4a4HZwdR5
         /2Jfsm5jmJqgKV+9nFRpiuYyOp9S9SpYVFG3LFqobcdvxxCxW1GE/hgdoPp4F5sFlMq0
         TZ4W3WEgLi1+gBatjUuIJPTcQFUKS+6VTwhZDhaklnEgTsbFx3iNVPVqcz0kuxo65s7n
         ToIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyiLZmZLgBmV2EfLiO8jpVLheIPfUwAtfjTSzskJHytWJDpcAOWlNn/u3ldQSP9k1ZgxVb5OXBlgDFAwrUZWK3bsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxffPX+Fx89qONKmjFZ4xSIyyOYbG3jxm++8APUM4BSoJ1gH5pJ
	x57cn2UZkqf16x5dAB4Lltb3FcpDm0/22ODIwfcENNvTtpwnlr3r7Z40fTpfRsRq4F74/8pZd7A
	pokZ8ESYjdGvTsV/oJq98Hw==
X-Received: from wmej5.prod.google.com ([2002:a05:600c:42c5:b0:493:f781:b52f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e94:b0:495:571e:e5d3 with SMTP id 5b1f17b1804b1-495571ee75fmr126799165e9.36.1784630196081;
 Tue, 21 Jul 2026 03:36:36 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:59 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-15-vdonnefort@google.com>
Subject: [PATCH v3 14/18] tracing/remotes: selftests: Add a test for the
 dump_on_panic tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced dump_on_panic tracefs file that turns on
or off the trace remote buffer dump on system panic.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
new file mode 100644
index 000000000000..5e3d3c412ecd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dump_on_panic
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dump_on_panic.tc
+
+set -e
+setup_remote "hypervisor"
+test_dump_on_panic
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
new file mode 100644
index 000000000000..cb9b4c6dc86c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dump_on_panic
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_dump_on_panic()
+{
+    #
+    # Toggle when the buffer is loaded
+    #
+    assert_loaded
+    echo 1 > dump_on_panic
+    echo 0 > dump_on_panic
+
+    #
+    # Toggle when the buffer is unloaded
+    #
+    echo 0 > tracing_on
+    assert_unloaded
+    echo 1 > dump_on_panic
+    echo 0 > dump_on_panic
+
+    #
+    # Load and unload buffer while dump_on_panic is enabled
+    #
+    echo 0 > tracing_on
+    assert_unloaded
+
+    echo 1 > dump_on_panic
+    echo 1 > tracing_on
+    echo 0 > tracing_on
+
+    # REMOVE ME FOR A PROPER OOPS TEST
+    return
+
+    echo 1 > tracing_on
+
+    for i in $(seq 1 32); do
+        echo $i > write_event
+    done
+
+    echo c > /proc/sysrq-trigger
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+    setup_remote_test
+    test_dump_on_panic
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 4a14aa72fdf0..bdd28b5b8596 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -9,6 +9,7 @@ setup_remote()
 	cd remotes/$name/
 	echo 0 > tracing_on
 	echo 0 > dmesg
+	echo 0 > dump_on_panic
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
-- 
2.55.0.229.g6434b31f56-goog

