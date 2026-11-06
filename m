Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988475;
	b=zXuhbsXdMrrnWUMms1sCTDyyN/68hjiY/r3lEknIuW/OFbECMRWzxj16icn57MuNjl4i
	 cpNOJflwdB5cbgD12orgUlty4I4X4nA1hBCKbKRy73OlpKzK93hpA52SzlnxEG/mkMCyw
	 /RHwb+cQ7fJ25eVrb5rOudlBfD2XrAeRY7FM2vSOUSwy2lge/UkwoDQjNnM8Czav5yegd
	 UoN5a9SvwVzXpYQ65KauQx01wmASOjnNQ6vknQuEXxzBZogtKY6f87JBZZMROnsy1r/uv
	 dv2eCIkyDSaR/rApO44KjJwrmrMdetvDyWe4VK/dPdBJ/Wvwj1lm8tdCqKDWIqX2M8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bNP0cGXOHenDMUkHAvBk8RqWahoi+t4WRJf7nDMcLHo=;
	b=5RTk9XkZRidY2XAhoisQCzDipYtbNdznIIShkmUvy46NzKj4CLHEbvGPgpL4bb5ix2ha
	 WGtk+CJo31SBMFddh4KmrWbc/gYqo3kgFvb/SlGNo9uE8bR8Lber7MbeT8CQs+TGAWt2I
	 X9RwK3npEeZeASDaSeK9kRj+hpoCNziPyKhT23kjT1rb2cIOD00V/iM54S6AuF5seXxsX
	 20Cne6W8xIKGzuYIQitFY7rGj51InCzRrarVYa1DsExDVkbbtzi0Mc0UqgLNZaeVO14om
	 iRm0QvPXf47a8nXcVGRSwYjsur5xTjVgbFZ4jroEAJ0smG2NkJ0d+7shRMmsfGBqGPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ZJY5/cYO";
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BE606EE83
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50BE606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJY5/cYO
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so7710115e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988473; x=1794593273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bNP0cGXOHenDMUkHAvBk8RqWahoi+t4WRJf7nDMcLHo=;
        b=ZJY5/cYOXLhhdEKhblqsv+D30Qt0aUMmnALGl9sUVy1XKgfRw/cEinZtLCGIABAESe
         UX4kVn0ouAsKe+JBO2itANQoqunJ/o2Sr4Er4kJzDzz1EqkgbqUXb77ZFlrVx0899BHE
         QLOIMtqAUb+NQPf8ZzDZGFeI2mZ2/BQTymeZdqWNTJTU68S75lv/RGnxVbSl/ie24RWP
         3+HNEpMdtGB5WXoJ6dMa2tm4hW0tsHoTnSTaCs+siUv1xKW63SAXk7A6v4jk+caNuf/8
         VjFvGjiMcTqd10aniAVZGvLSveI6vd247NOp3VKgCTsQky7sf9YCutHjcRLsrbsE9NTe
         cplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988473; x=1794593273;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNP0cGXOHenDMUkHAvBk8RqWahoi+t4WRJf7nDMcLHo=;
        b=eF/1+NPuAQyW1d2TKc2ePzgJMXPOAulTe5EMtPTFmsJM4PDNsFlpXGHCYYtry18xTs
         qY1TkD7Es6X+Up+kbkuSgOLnRWPzXGaC7+6tUzTA94uqQlf8Eh+rSkRVMLQpuw1Wyegz
         CQHlX/rOJEk2lbaA3DZiXRsCNAoS1/UZJvIW51x3ChheRI9UshAvQpFxkLob4HonyfoG
         G6b3bi9ignj/AgZfofgZx8GaFvD8DGsnswe/6URD18m84+CDPYkD6pgCxuV7op+tsa9R
         1ox/LI6RvPrFp2BCa1ZYTME36wS7cKeYc8/mieSj+6l/iGUSmRVyUFTja7rejRPinuav
         IPKw==
X-Forwarded-Encrypted: i=1; AKwUvBwwqPnIeDBA1wih3Nu30p5j3+jDUKznIZsJ9XlyThBHBGBxCGLAHl0pV7nlrWDUZw5tNXK7iMb454VfDEfPXKMFIow=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RLiLWuUk7tdlmSW39vYVmcdbUBCL8X9tWow297NBIyKmA038E
	i6okeX2iCUv3TKi4d5R8PQ9i3odxLDxquDdbKlVqFAek7hjFL06h7euDU8XzAyavy7ZRO8z2l4M
	6OLTp0KR9QdmXHRaEPDkTtw==
X-Received: from wmwz19-n1.prod.google.com ([2002:a05:600d:6413:10b0:4a1:f4c2:f6c7])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5294:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4b6dc40027cmr59015825e9.3.1793988473177;
 Fri, 06 Nov 2026 10:07:53 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:45 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-10-vdonnefort@google.com>
Subject: [PATCH v8 09/21] tracing/remotes: selftests: Add a test for the dmesg
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
2.56.0.455.g6c5a503b38-goog

