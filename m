Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13A48AE16
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630193; cv=none; b=C8qwYLJou47D5JSKHuFPo1M7KZKWe72bWyNDNFyPtXZk7moVJoLjXu9+YFcUjO0B/6nD8nFlwiZy/31oe4xEtL9JQAqTB7M+Zl8/qwKeEJ3keB2I9IlomtIa2LHt5W8bf/CUiy2NfT8Be5r1DDGuWTYFr40OKha3FUj8M5tadjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630193; c=relaxed/simple;
	bh=zwjhhRwEKrUVba7K5Vs5akPhk3ruFuPU2zVzf6EQLmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCWARCuqdVS3h6vXo+mrwcF4jWUOkdxop6BtOhQGSc9TDxw3kPYZS/yJp6pFQTA8LqXATTITIcHYDMIhOdcZuhgpTBPtsY7hJWvFBsYHWdnyiGZcTvOzJWhBbKDiSQ5CbJCuFPbhwKjX6UHPw3Al5a/OYnQgmhlwT7/ZJLGfuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAmj2g1r; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAmj2g1r"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso86858495e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630188; x=1785234988; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFnRJSdtq0pC7EluIdIyn7oqOdGIzUl0l3gz+9na5tk=;
        b=rAmj2g1rHMngFPlLT1nx3wV2BBXICXzhu3E1GwVMgPIsWpCqJgEE1yAwx9swcUUr4I
         rABZ/YZrZDtIWMPkSuMhSEF81o5vXuMkBqTx/V69pmtcgLE7hzZUOdrJjXJ3Sl1LR9KL
         BElbQfacWDazaPn8h7p5kCaOhvDnSJelZX4xO1Y63Dd98T5XJuYkTkSHlgS7zr9j0ufZ
         XFX4514X2FGFg9hEm5ijcKluChPajd8fFVRlooj25Wsafpt4risxmpQEii4JHNwGQfF5
         04jTE+WVr2XRBU5kby+BT6hKrxP/f4HnBrwBON0XfWB1zT90SJ1tX9+EunFibuDgF0d/
         SSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630188; x=1785234988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFnRJSdtq0pC7EluIdIyn7oqOdGIzUl0l3gz+9na5tk=;
        b=P4paK87fIT20OspP4f65UWPdsukkXmxZKDnH3M/LrMT3SWrhEWFictfMg0a7mflr3U
         TKJ5wePUZqegZQWysuLT/oYgkcnLxcCv/72iXjK/Jk4HnmzZsIldhvv+qRgiYAitSIsW
         /u31wLRLIrHkY3PUi18OBzRBI5+jf7bmLnSSw4i6K9bfALHSqSrJscO2RNUxP0Jrs82g
         7ZExQjyZyLNJcXsWwFerQCalu8vFWjowUXR84/UeBTFmXlMvy1JaEGE61BVcF8nu6YhS
         xV+gUInrutDdjrTo2KZy42NXh2f5+RGyPneSOureAJCSLAD230JuNk5yr4Jrcqg6qRin
         /HBg==
X-Forwarded-Encrypted: i=1; AHgh+Rryf2ZhGhkCfWmW9U2Dgk2MT7ncCiFFeWMFloEsJWxdpb/MGBZ9Ip/ADf/Auk49nm4C02qJgZH24KBQljBX+sZFUC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRDW+rkf9IxNqZxtJd4B0Kp4dmoJdFFqLOcSjUFpaR4AAWFwQ
	DU2FRPcVG3mHBRbhj5fnCRTPz105NI9zk/w1tfWN4GpvAFaGyt+NwpgnGjcgNw8agtn/hrJCYnU
	MdRjP/nqVyeZPDyJ8ojz41g==
X-Received: from wrbdh11.prod.google.com ([2002:a05:6000:a8b:b0:46d:7673:77d9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3553:b0:495:3f28:3f19 with SMTP id 5b1f17b1804b1-4954a508a24mr202524045e9.37.1784630188199;
 Tue, 21 Jul 2026 03:36:28 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:52 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-8-vdonnefort@google.com>
Subject: [PATCH v3 07/18] tracing/remotes: selftests: Add a test for the dmesg
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

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
new file mode 100644
index 000000000000..aebeea9dbab6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dmesg redirection
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_dmesg()
+{
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
+    dmesg -c > /dev/null
+
+    echo 1 > tracing_on
+    assert_loaded
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
+
+    nr_events=128
+    for i in $(seq 1 $nr_events); do
+        echo $i > write_event
+    done
+
+    sleep 1
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+    dmesg | grep "selftest id=" | sed 's/^[^]]*] //'> $output
+
+    check_trace 1 $nr_events $output
+
+    rm $output
+
+    #
+    # Disable dmesg and Test events were not consumed by dmesg
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
index 05224fac3653..4a14aa72fdf0 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -8,6 +8,7 @@ setup_remote()
 
 	cd remotes/$name/
 	echo 0 > tracing_on
+	echo 0 > dmesg
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
new file mode 100644
index 000000000000..bf4a3c145e7a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test the hypervisor trace dmesg redirection
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dmesg.tc
+
+set -e
+setup_remote "hypervisor"
+test_dmesg
-- 
2.55.0.229.g6434b31f56-goog

