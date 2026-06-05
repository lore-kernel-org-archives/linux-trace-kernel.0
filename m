Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C76386C0D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677587; cv=none; b=pOA3ldQ8nqwrnztwJLx14lMRlygH15Ly/RENr9h4pwmpD3XmZyCaRLXETLZIjxau7uhCMp5qETGIBqalf2HkIa0lSwPNhzD6qUTp5rT5XeqvDiy5HzbAvF3LvxsBnNNstRjbotknFriVWmjhgLcRHDrZgEDgT8oeMrKJinhc+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677587; c=relaxed/simple;
	bh=G0coUN50E2dd852d5JwpogpAAB7u0hpNn2b6OkcB98U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XHETWMSrs8z95AlZhTIdlgaesdpPuDQzgFsHDdvtXg5Uq54WQvQCkNMBxDrszdjZkXWaB5A/ygZofX+GuFzSI0GbugujoyNEyAIDACZCm9hyrZWOqR+YJtnFy3O4AvUQnQG0K3oU13ybfFGNBjVrAUuBYQZO5eH7tLqtB6MvZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evZA8fq4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evZA8fq4"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso10504415e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677583; x=1781282383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wpkGTTaRF4856SZ5tXv7qD1WOhvRoRHGBw3GToMhq60=;
        b=evZA8fq4Dv7YZSUlnRs8qAg5w/nBPzXai8p0dRlRRrY4AF55y0ocijkoitn7afgI/D
         TQsjTskNXHE1XUFMW2ilgEJQReM2IjSIcS4cYZo41q1/WqzV9wN+pEHiDtOq5sgkIYCQ
         O6bjQdURPvb3DvScAnI3cl8h187h2+eGLnAF5W0/hrOyyrB23HuqT2u5jRzlUjFwRBaq
         MK37wVQrgjJQfn8x51kCbbO7EgP++ya+1eF90L7rnAZBVZV4EN/oqFBDpIKBsIWQuVCZ
         zKV1e4GhwGodHA3V29JSTzMGzSn0Ly8S0ZpHusvD6GHGpEtBu2uYIChpcwQISNwcK8uf
         BdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677583; x=1781282383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpkGTTaRF4856SZ5tXv7qD1WOhvRoRHGBw3GToMhq60=;
        b=UuZAz7sdITHlT3lpDZwKPAC/Bxkzd+U4K6fejwgI8EAvCFu8YTjlWsncPhYX2k6Tpp
         Yqs6kCwRqoxAK2tyge4T+0zbQEnmlbl9690x+C/wqCqEBc5SnwOuHX2AaEgnNCMDWLpv
         T4mAFFIzrAyDIEWrd9aYuNU+SpojLmxYABX8Ebat2LzUlhaxiYOMuBQMYo18hPRWKmMI
         vs/Hi65KpmxQp7rqDK7t45QzJ10du4QXaPJCnMArIv0mZHlpd7ZS1mUJ0b874r2NZwyY
         fsKPb14L5cHor8lXg/p7rUlPNwmcscY2VtQ9YP2vNACGae9meXhnT/KU5EG+xbWMk+Ks
         1R4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/J+T0uITNPjg1Yn1x7SvNKoV33XjIdAw8aAcOb/uH8vB1+hTS2AKJc4BDYrQnjYKuHDU0hg5c/x0hrLgFJ2oDQgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BO3/7BKu/WN96ah9+ty/EXHE+3Cel7gb7pcrYyP7HvkYLqVC
	ZxpIZx8lzdGq9GiZAJ2nVK9YsBA2dzqvaVtCVki8jozMUoViqkQ99G5go3/LZt//Mfykz3hopps
	SRMWImBQBrthVFMe49LBWVg==
X-Received: from wmbb13.prod.google.com ([2002:a05:600c:588d:b0:48a:5345:d730])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0d:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-490c25afe6bmr73972665e9.6.1780677582594;
 Fri, 05 Jun 2026 09:39:42 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:14 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-8-vdonnefort@google.com>
Subject: [PATCH v2 07/18] tracing/remotes: selftests: Add a test for the dmesg
 tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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
2.54.0.1032.g2f8565e1d1-goog

