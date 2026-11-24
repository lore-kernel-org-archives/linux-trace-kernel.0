Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534168;
	b=CUS93drOo9ceNfm0dPQXNckKO5i1ZujUlTzWny8A43uX0fjKE0WTGTw08JeA+fT2B+fg
	 3mulkwzepsUdpn4f1OfzQcr069UtF81Y8uzTII7q2ha2C5kmrKjiy+ZHpcMJrcLDZe3tW
	 TjCPwPGKKgR0rV7hmgck5v/3Fn1PF3ZAfUvkyqG8MuDjsatZ/sm07jzawVJmPjLHfNxRI
	 K657AZeGWZyWVlbb9hrzI7Lixm+5DSuCcFLEdjSXLiuR1DBmTnXJRMZWpBXkMvoYZeVvi
	 nC01XHqRb4kuQxPEP6yzuJC8rZKSSHPhWAKh1YyKOvoHDV0bcveGhGbI+2XvfpF24LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oPYjbeeHGG2D3Ntd6JqcgywPDwEYGfpy9AMU8po8DQM=;
	b=GcpMi/kGjuEVziw3Q39jTa/qm9F1tbNCeNRmbCangiKs9XGCISy9l0NI77wpzzT7RuFM
	 xrn5MUh0lp01YTA0RIZQ1m/h5iZR84Y4vigFKl/6gT6BFImytRfvajo4u8TmaO4XDe2Up
	 zwUtlvj97/hVGpbKJx6/Q3DemvcWbteESiyM+lo6JPto4sEgYyfSy/kr0oydKW2m1HqbW
	 17UkfwmEdH5vdr0kS+J8QnRP+ZfdM+0+4rBo6g+lZfbNGWyXA+anYKoiiSr7gT2yniLyi
	 7NkGJQ6He4+kH2KFcp2vaLggqwYLIcp5/IZ2b2IBRMud6x/RUHt/NyVZdh+pdN5T2LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lfh5Nc6l;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B0606A6A2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38B0606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lfh5Nc6l
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso22126955e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534166; x=1796138966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPYjbeeHGG2D3Ntd6JqcgywPDwEYGfpy9AMU8po8DQM=;
        b=Lfh5Nc6lB3eGSGhgdc11TNuXEZYLjg919UN9pvG1cQxibDsxpQHRUIahnF8cUw0WXE
         sfo6ALDEj8exCG2/JS0POq3k0wqTfjf78ljUmmeR8bsiNTlHWv8lvYfhryvf1Q8EnPan
         0j9/7J9XzxBRsC5SH5o3PPmAM/lxCfjWfXG/+UWx2HLcP/D/EqFVI5f3DBX04Bw/5YfX
         fVPSrjOFZGKzaCxQFNJikR3WPyr9cxD69LU/Mv/Q9DLp1j46896sFAc2iGCKL0+pqfB/
         BUyqsUzLpZxIXC7mpSZFDBIf+2ePZijkTeDFwNCtz9hml4I26epn20CWQcM7SuMKwtrY
         x+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534166; x=1796138966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPYjbeeHGG2D3Ntd6JqcgywPDwEYGfpy9AMU8po8DQM=;
        b=dJ++JmAxlQ6809Q5Plx4xFcr8Ss6RhLG0wgwHyvHAqH6bfZhGK0fimmLCDMonN9/GK
         utry7J4JGotzSHj+7/8qbzh3VW46DauZ9Ur4KxJlpVxgv/8CvkO5u4GcngAatoVaAC08
         Oznrlxd7Huo6cucA7F2Fl1YDWCQcXzxfJrhVwWeA60w9v4eE2nTUeFf/MmHkD+YDgJxB
         nS/r9tgm/0B+P15flaa/Hi/yHqrh/76SzkY+S57xSiRE292QhHu417j/EULQxvKwS9HB
         ++XbBR9ToJoDvNuQirWkXAOR17RpfJrWu85XQgTNMG/qZ8CeVWAcCNn8InT0ZwJbZe2w
         +zXw==
X-Forwarded-Encrypted: i=1; AL+hErHT3SQJTT8wwVSw3ib5/KUbcIJRcUhkIwbji6C37p86wBmTWVJG8a4ZEiBKhZ3JkulkE3cY6kd6YIdtiw5VHMEd4yc=@vger.kernel.org
X-Gm-Message-State: APuU4Z91+XvcOKYOYbIql7GGy+OnwM6ALZVutYZbefnQ7or/b8IqVH1X
	+hkb1IANKrdvLifVa/FXMtbpf+rEKlPf0oDyqHXA8eUfS5AQX9/f8b1AZ0P9h0LS+0kgA3Tmd2P
	aaeBW9358d1EnLBVYjsnOpw==
X-Received: from wmbef18.prod.google.com ([2002:a05:600c:6612:b0:4a1:dfb3:2e66])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1389:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb88826937mr282064435e9.9.1795534166204;
 Tue, 24 Nov 2026 07:29:26 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:33 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-10-vdonnefort@google.com>
Subject: [PATCH v9 09/21] tracing/remotes: selftests: Add a test for the dmesg
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
 .../selftests/ftrace/test.d/remotes/dmesg.tc  | 91 +++++++++++++++++++
 .../selftests/ftrace/test.d/remotes/functions |  1 +
 .../ftrace/test.d/remotes/hypervisor/dmesg.tc | 11 +++
 3 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
new file mode 100644
index 000000000000..f667b14556b6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,91 @@
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
+    # Emit events from the same CPU
+    for cpu in $(get_cpu_ids); do
+        break
+    done
+
+    nr_events=128
+    for i in $(seq 1 $nr_events); do
+        taskset -c $cpu echo $i > write_event
+    done
+
+    sleep 1
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+    dmesg | awk -v ts=$last_ts '
+    /^\[ *[0-9]+\.[0-9]+\]/ {
+        t=$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
+        if (t+0 > ts+0) print $0
+    }' | grep "selftest id=" | sed 's/^.*\(\[[0-9]*\]\s*[0-9]*\.[0-9]*: \)/\1/' > $output
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
2.56.1.809.ga0b61035b5-goog

