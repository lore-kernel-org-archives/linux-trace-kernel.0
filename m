Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988485;
	b=d/mQ1DSwZ5OSMD89AlM0ZO5EM+sREa3yxHTxBS9lUslC6JXRBgzZf27fbFYReQILeKHr
	 SVAfZXEFWqbavuSrhiSpyGoOV/lix1jBIlVt4gF8m9u3OwnuYzlTYZHc7umuZk8qMQUdT
	 aiv4p6H4ay7KXRhcVEAZSYsDJySrVz8+aH6iLr/1wFKSh5hvJJ3O1KmAQRyERl12P/6yn
	 sy8Xb+Zd89y5IRpSRWS/N887dGwgNqOA2GPakXRLr2/6r3KmGMljbVt21kxz2AC3CVvng
	 RO3mE5KNdNV3d1Rrq3xRAgIc+7dqyA8Qu4n7QU4V+MJ8q2z4MzfyW3nyeG26r03vBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4vKIezds5HgToeKN7rpTMi6dAL5ph8OiV9mNm2KF8oo=;
	b=aPORy2YUqvxn0Kp4Lj11VvAcgjC9RpDd+HpPPzfVdxRT89LGARnA0quCye6/xLzqKJIT
	 N6KU4MnOanGtGOm1WSJeu75f+BwueyZxw+iqG+qW/jmLGsaIIhU/wvlEKg8TjFIBVVb2e
	 v7rjIPpzl/u+LzIMKUD+CB8xsmb0BEPAlyjLy1AHHcMvWStvMn7tAcRmUKUdFlnexNzYu
	 ymgsLM5xWINXAFw8fOs2Xhdz9TscwLnfjqL2yUCR+Hr6IzUguL5VOpffkKevpc0kN3DtD
	 FS06wpxUQdKN1mn/sz3KrRyjPoh5LxPdgUTSVDVHIF3WT23fCKDLZubrulRoi3a3FUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SEBbxGvb;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D56082BFE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593D56082BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SEBbxGvb
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b1c6f567caso1122028a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988483; x=1794593283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vKIezds5HgToeKN7rpTMi6dAL5ph8OiV9mNm2KF8oo=;
        b=SEBbxGvbbsmeDjz67kNskQJOS+p3q8eJHU1Hht91BVDFnfp+MD3KezwfzvMMh7fGeT
         cpnfAUnYzaBvihk9J9GSwr7dEkiQhTrIMF2z2Xg1b/fB/PiDaDTtUMATet53nNnqp5N3
         sD+B3SL81XHZa4zG+Pqbvcj9f/6j7Qp/3LAERbrmLMXH7/4vtLtWYUECAOmev/Cy+PiO
         wAjbkKBunNuaNTpfABi9Ha19peLXsfwGkr+1oa5DlJXoLPcviuWbOFKF9MQPpLtFk9qE
         gZxClq1/RFzAMYCzmi7tl78T4FBrNXvi5luyka90n/mLKfhgNChq1r4mWlLfohVHgZao
         FBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988483; x=1794593283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vKIezds5HgToeKN7rpTMi6dAL5ph8OiV9mNm2KF8oo=;
        b=kAwfI2bvYq+cvXGq/Lqy5BHtmidtttX4vvQF8Ka5PUOniw45E4vWjiucQdKna6EKYH
         JIaEtmWtKZOMuzB9KfiSs1WO3mpsCGJ7vGpdE2h4cAgW2vsxI+PWg7hyWQkjc3Gz1UG8
         U3jK+jGgeN+KcPUqlTcc+lTDBVo8F/SxR3KMOlaV86gExMSZSSePcYvYumRNysu18aac
         nAJkO09QHG7nJOjxF2TO9FtIIyzr8utvDbmayE17jTFBRQJjuNgbrN1aYM1Yi7JQ9bbS
         LNShOMfukLNfIGZisRfxcyIKNRE4XADrk4LAcg5egZxq6pU7gz1SFoQ4xO4q0XWCq/a6
         GooQ==
X-Forwarded-Encrypted: i=1; AL+hErHRDWZUf3yX+AhfflWup9VjyBYdHnsSu+SCD6xghUAt9jjNNtR2sx6QOr8gsyoaUq572gcVMc0W1c7ALfWzXUlJMc8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vrj1nX+JIQspcJOy76Vo1lOALSGrXx1YrmHqPPkJF8SthVz3A
	d4+6bLp78inYEt/6LjFTJ4HrxEczwMl+9lxniMBldfyarvt9IsgmQHCUBkCr+t/DTazv/gySxS9
	Rdbd6Q/LKZxi+YugWoBMEqQ==
X-Received: from edsy25.prod.google.com ([2002:aa7:c4f9:0:b0:6b5:6e54:b86d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2743:b0:6b1:c1e5:a85b with SMTP id 4fb4d7f45d1cf-6b59752807amr2467339a12.3.1793988482623;
 Fri, 06 Nov 2026 10:08:02 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:53 +0000
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
Message-ID: <20261106180657.2460376-18-vdonnefort@google.com>
Subject: [PATCH v8 17/21] tracing/remotes: selftests: Add a test for the
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
---
 .../remotes/00hypervisor/dump_on_panic.tc     | 11 ++++
 .../ftrace/test.d/remotes/dump_on_panic.tc    | 50 +++++++++++++++++++
 .../selftests/ftrace/test.d/remotes/functions |  1 +
 3 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
new file mode 100644
index 000000000000..1b6bf21c5d9c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dump_on_panic
+# requires: remotes/hypervisor/write_event remotes/hypervisor/dump_on_panic
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dump_on_panic.tc
+
+set -e
+setup_remote "hypervisor"
+test_dump_on_panic
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
new file mode 100644
index 000000000000..ff5ca29fb1b5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dump_on_panic
+# requires: remotes/test remotes/test/dump_on_panic
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
+    [ -z "$TRIGGER_PANIC" ] && return
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
index c368dea2ac4e..f0225af23714 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -9,6 +9,7 @@ setup_remote()
 	cd remotes/$name/
 	echo 0 > tracing_on
 	[ -f dmesg ] && echo 0 > dmesg
+	[ -f dump_on_panic ] && echo 0 > dump_on_panic
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
-- 
2.56.0.455.g6c5a503b38-goog

