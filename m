Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534177;
	b=u1zLAEkCWnDDLdKPYnts9CRVap/IBemPg74tpm3IDDxOUPQDv07TGxRBpVmaSvB5xM3K
	 BPL701aQmgDvrS9rLo1MZD1gAuv7XEKt8qnXBdV3maxxqSfkicJPOt3aUHp6QEp+lQm0a
	 kJttMK1Sq3L3lA9rMWxdenV4NQiqOj5t1FI7ej+bS3BTy93aafk5h+126X/8+Me6FDyRu
	 5YjqlCEIaCXvWKs9u9HHnOQ814W8gr6zTHq6FYejzIlYxcHay3JYrNT2PnxAkpuTQyZCb
	 zwrVqHANTZloyNqnQQOehDldrmAETFNGML/1H2RsNOpBfu0AQczoz7X1uBqiyjxe8qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=96oumjC/jkMss3EPeYKU5AeAWESEy4tQj1abmw7mJRI=;
	b=Q2hSCPIEd58OPCFxtKWTr6K0t+XEg3zTjAM713yxMxBmyE0L1fVRiKv/flhAsZFZu6w1
	 nubxurb1tLtqA5Ny82IXddtHnjmruRA0X4vqaoq7VLSWtuDrXaM26jRAuF3fxbB/6OA8W
	 iYkMB4YRYFBnxsTYjIsSr8nuNXgZi6XcCFsVSNNy9/4XGobQ9L30CV19wg8YCIb4C5/Pi
	 ZmvBYEa7qoas9vsBYtaA/WSVK2nJ3nkWsPNTYNSlxBb7edWCMXjm97IfFxk28YKogoSNb
	 k6t3/AsxvxZBEtHww6v1DMJkWiPL19IJ73H3ucsyb0+89J6c/K9knc84RLOtLm5e0Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i5kl28xq;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96255606A68F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96255606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i5kl28xq
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so31706165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534175; x=1796138975; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96oumjC/jkMss3EPeYKU5AeAWESEy4tQj1abmw7mJRI=;
        b=i5kl28xqEw6zwQ1J/meV5htbD/MMiPZrQynAwdxj0lK5uUppoSvXns+qZf/s7+1tI9
         Iq9xwh2ZuFaR16WY9RRPL7DnCP30+x9FTgITcbtcCzJgTjD7t9L48QnDWhsrnjbIlyHs
         /uncs55BAvuEm8vziLuYkfjyskfAwa71Qfl3D39mepmWfYVH/p/DjSWItp42WT3v6wui
         dPdnWiRlV0eec0lJPX5Zy97iqmdHKTilk+lhCcfH7SU7K+XwzfjYRKu12JIYS2wCOmUx
         m3J6aa3iMDQXn8SMHUbmdCZs50xEjOVEI5A2g6eyaCKBX9Oqe1os7fp+ioIYmUB7zKwx
         wnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534175; x=1796138975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96oumjC/jkMss3EPeYKU5AeAWESEy4tQj1abmw7mJRI=;
        b=1EFjlxTQrN25MQLZCoLlZgMgdipGHG4jj6M244ybiLL+n4DJ4SpJ3NNiWJgyxkDbo/
         v1XsflnTxGB2ngJLQNanE/t1+nXN4klat7qUD3k+k6bu9kH8vSbyX3n1bksRAazkYVWz
         kp13XVAtAevHLeE3byG9RmJ7bFVKUUzQKCAhmNYUoUbOJXWWTp+tpXHAd6/ExEDvjLxY
         81J2xSJ494LiZflJK9ug0LKypO1okSh6OiPDd8Gn98obIuR7/5VZM4HJu1eZ2I/FIorw
         vfLy2xRk5QazjENxogKWnLkgr9UkWAXb7E6PzBBIdlrEGZqX/DIBgJMt4AxUa82eQFDK
         bipQ==
X-Forwarded-Encrypted: i=1; AL+hErGgQM72FCCeeh96S0K4H7f0O4k0goyCkutoSpIdHi+XBfmAZEVR3bCK2Lmc0y6oL37Xf/xQdLU9OqFgAapGY76Upvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z80+MWD+D91PG9jyHbZxpUv1TYZ1hpM3YxQfGN5d96mM9zRLMl0
	6knFVc5cfhtEwfaKYlgfHk8+G8NJtSvQRhOq6lM10L53Wc6uFzqVH/3L2L3A7Y7ti/8EcfhAum1
	p7bcjqfPmvdiwnvDV81eOwQ==
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:4a5:9877:cd58])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr312840635e9.2.1795534174966;
 Tue, 24 Nov 2026 07:29:34 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:41 +0000
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
Message-ID: <20261124152845.2233401-18-vdonnefort@google.com>
Subject: [PATCH v9 17/21] tracing/remotes: selftests: Add a test for the
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
2.56.1.809.ga0b61035b5-goog

