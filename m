Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587C46C4BC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852251; cv=none; b=X5/DLroVxFs5N0PMj0HihUfn/ylkmG2hMPHYP2CcVnR5FLtUH3K6Tzg3UdAfmzaH5tg7mTDUBSLSW8n3XvebM3ZDupJrHfPZs2LpSjXWvogZzXhWzCw9GabWoS7i8/3DaV3RWbJEZA1vb7agMBHO1+plP3cw2kXz2+42tsPt28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852251; c=relaxed/simple;
	bh=vj5uLsBMqRHXFMgjRkaf/XFnATcyEcGhbnXMqaQWOKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wv7+uFfhq4zxqqGxqnwKiA1qqDkKZcHPquK7eswynEetivErGtQcWYobahQdIty5cg7q4fuIWf5FDNM0CX9Ttx8zXG9pbn+cwMx3/GQEumbBIrmi93d0s+VDVUgrTXebhn44QpuR6vqJgQPKYambDsa8s51hdt9fx7VODGXYjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fifAq1Rl; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fifAq1Rl"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a1188c8948so1964881a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852248; x=1786457048; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NUN+nKFEkHGltjdVncDINIABRGoCRu+BUGz2DcN36I=;
        b=fifAq1RlcKz0JABt4864K40IZpu08tDtv93TvwGNbPd4tGP4cv3a+BmlwQ1WXaHh6X
         /7Ja0fIvdhYvxnHvY++7fVbzEVih8JdGFHmwWbTIdrGE00ahmX3JIOIyWN7eVTVM5whb
         hSfq0jyxKia6w5lgpoACUPZi3CVefl+43Adge4RyTz8a5L/GNRIp/pyLdSBggvStMY54
         Gspcofp/5jeuBTeWTznl0yoSXirxIZf9K1CquZAmnwwSns2gNKvfRGPJxXQHWecS8SfD
         JWhcMcDah9vZRYDiaUA5k+rNILHMtuwIjT8bOW1fQetWQf9RGz8kteLJ+LXHoGvZz3dJ
         lyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852248; x=1786457048;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NUN+nKFEkHGltjdVncDINIABRGoCRu+BUGz2DcN36I=;
        b=Fzherl2qf8KdpCZORdZsGHoPbahl3uaxaE6uqqvpjCcDaC+Jj3DOTc9ymVt7v1sBwb
         ACyKfF8dC8wAos2ckh2X263wcpMMy/C/wCMBJ6OiNKCZMjhkGc3lWy16zXt8/4pM8CzX
         xOlc/+D6q7dv315qL4lFNr/YUB2hJUKaFYGQOydzqCT7eZg9yIlbM96AKpQZfoOQBNPZ
         Hn17whYUEV4MbKPCwoIuH/FqRxibkOWz/rO7BjdcItNzNvrNtw+gfd7cIjVd5AHDXCGZ
         7FTAGLRcveB208fEtfY8KUv79e1sDmOm53VswT0C5irZpQw+AoX03Bdv0PLGThyc7BOq
         XrXA==
X-Forwarded-Encrypted: i=1; AHgh+RrcyGj2o0H9MjQEMVGr4DDnVsFCb2yLKCmClUo8GYWdQBucldMqBVxXr2RLHYKR41pd5/wByufTS3vAo2bu87JlJ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tbWYOJnY1YqonyDRo584lQuTvXfcaCYTA4mf0jW5XClZw5hg
	fadCYqhhRQxmf7Piij3L8RerNs2MLxmYLnW46UixGmASwIiOwwd6mk4AL2ZScjfl6FfBaNfxyv7
	wFJRJzaCucnmc6OBwGw93QA==
X-Received: from edbbc16.prod.google.com ([2002:a05:6402:2050:b0:6a0:c325:d6e6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:44d5:b0:698:3ce6:767f with SMTP id 4fb4d7f45d1cf-6a0a7c9ee09mr10916777a12.12.1785852247727;
 Tue, 04 Aug 2026 07:04:07 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:29 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-15-vdonnefort@google.com>
Subject: [PATCH v4 14/18] tracing/remotes: selftests: Add a test for the
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
2.55.0.571.g244d577d93-goog

