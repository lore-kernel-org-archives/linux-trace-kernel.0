Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C81439905
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974936; cv=none; b=sy7uoIlnfKsNlYLc+Co6qrw4oDL3o1rN2LRrAUhPZgkxcsWYhomENWJAgXp08Om9MwS2STW84JtVPMTvubaagkG5AUSsJjoACB7ov1dbmEU185nyA+GJ07rtKaOFV8tzz1Mlrw6E5krfh2hI0ftj3GEgun9C4Nn7SKE4kxOzh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974936; c=relaxed/simple;
	bh=Jx7xlLdpoWJhMoXgfqu6lxgjtTSgdi9QT+7edRFiAlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pRWWyxD2aHl/eWcXI9rEWubEqyaAyODD0p7tj06BonQlY1vIQAO+XxwQ096CUNzjH0HpKL9/csVokR97X+OneswQxNOCBz4q0eDk3tOXsE4de3IGEm1vqcDvL42waJXFjjhdCV/r/uDu00/mR8XiBfHz8QBOBjNm69/42kv0Zno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPfcodgG; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPfcodgG"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499913d1a79so15765815e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974928; x=1787579728; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8uz4zJj9P3BOE+rlckL4XqZjMwLqhcjRKuRxRGL1PM=;
        b=QPfcodgGv49eOQXVwfFxu+5Vxy9M72kIHs9M1htBPkdiooO5ErlLDEywgvpx+ApJ6k
         Exq5wHz/XYweESWWpmt7d5+UAU4nj6Xs0tZQh3ErXyBZF1GXvhQW5FAEK/yoM0txTawa
         DXaXch2+zQj4jRsUaI5VAAdMeuaL3SsNSlVVA31Temb7GCpUl349ElBF+YCjgpi+vaqk
         ee/0zi+oIP1nxbfK171d3Uc9ol2S4VZXixaunkDw8BWvj8uZS3jPVcrzUXSXdStFRmwT
         0mDzgfSe4erTIXQR2zQiDb3v8QTOKOczXgJBzN/t/zQ2rp4mV08BoFXbJ0nHEo7yRX4K
         Qb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974928; x=1787579728;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8uz4zJj9P3BOE+rlckL4XqZjMwLqhcjRKuRxRGL1PM=;
        b=b2gq3wBOOZW8ek6H/uq/3xHZUyHMSiV8es9v5ayDe/wLeRxzsefyl0D4CA3hoI2urQ
         2a+tVC5c1PI5Rf7upj6DQsRlRscVBdXYx5lXbN2wlRUTVCaV15oPt+xcMeVFk6enyhRB
         bV9S/CnTvydLrhu67zTBnCIdvDx+88Vrg8NcIcgKA+4qCaWJnj+n6wyI38z1PHWbOYzp
         oMzTu4kaTzKZz1UNrc9dWIM/2u2B6bjvJNt9nNgkSmY/4wXAy82uojMcQwKcEpPkKvc4
         Qba455cuU/qC4M/LSoYNqFxudGX0TdeCFhS2DNJ3/VghMpfs5oar5lNqm9ryCZxYsorv
         U1lQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyE391T2xmbW117UBNn8yIn7OwDFpvLlxx2fENNV0ay+IVA3j3t/p3rbjLctTcGtk0fvvj7PTCWd7yQKkpmr+VTHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ot2UdoY9UIGLLpjt7LEUzlnRZZl726fM6TKjFXicPtA4AWep
	1+Q1HnclHd4Kr5IiDZHgR1Ig78ZFVdoSoiN1qIpo1zc7UKAierI5msSRA8sQC5a4pGJygrrZFJk
	6zcWx03MCbn6hHrFSrU1v6w==
X-Received: from wrnc5.prod.google.com ([2002:adf:e745:0:b0:47f:4faa:d0fe])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cf:b0:499:8807:345f with SMTP id 5b1f17b1804b1-4999fb8a0f0mr3382605e9.13.1786974928045;
 Mon, 17 Aug 2026 06:55:28 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:06 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-8-vdonnefort@google.com>
Subject: [PATCH v6 07/18] tracing/remotes: selftests: Add a test for the dmesg
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
index 000000000000..74f801a5e39e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,81 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dmesg redirection
+# requires: remotes/test remotes/test/dmesg
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
2.55.0.691.gc56d675ccc-goog

