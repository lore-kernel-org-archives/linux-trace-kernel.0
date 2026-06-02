Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E913FBEBD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420333; cv=none; b=bx5dpTzJoglIzEO0uc/os6/kcq7QK25+3dRf7sT4rWlDDcw6gnQ+a4f3ZoljKPHdaWVQ5t9qc7JSQ3plRr0Szypqac1TEBQRsEfff54agvHsWeiD15uNTdmktzd0RoYS2uGlCSmE8Lq3IaGZ8hDqQ4Yy/7BxzQ9FXG8JcX3hwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420333; c=relaxed/simple;
	bh=hQ6K7pg5mKo+tnf1qeETDb8NdPKxPK7fHARxGpTGbFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3G0ZFVSpzQRSIOquSXmrEnicvAqRCAsD608t5ii2ZJHUBXn+ozRkWtfaS+3qCUqvJUaalwYPphMl55l2GNjjqn/l1mryA3lNrLRQtvDb9sd2fr36wmP4MVus6ZFda+8bkjNxkx1L+tJHXrAcpmo2ndemqalxc67GDmFRAXyedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnj33wHU; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnj33wHU"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso2572837f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420330; x=1781025130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+WBHOAgBidLIxvIeyt1H7WAaxAGtw1YOgsJYRmOcw8=;
        b=pnj33wHUFffMsUaZIh0UukuXU5/1MW2A9y3IXXuVylIcQ5q9wRbaWN7T75t4UL1aal
         gE5fwn46sQJaLzz1x74MOa57kPtXs/+RrTpUPI86iCpDkML2HubWCWVywwQazMHhHzYn
         lhkBlP5ro/2AV58WaTGnHLIeLRYUd2pEeOAgtAJFhm/ZJBDGDOQCWndobaMxm9xxcmIW
         q0EHKsVwv77sgMTVlxpytOD3ADr/F7Nq8XdBFEyedOGtGcp4M4FXBwsjwjp621rQZMh6
         Agy4xZE1zlUQCcsT3W3vSSuB9uhgKW93vybf+uP5+OontYNQI4i8ROKPrGXNi6ijKxnK
         GOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420330; x=1781025130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+WBHOAgBidLIxvIeyt1H7WAaxAGtw1YOgsJYRmOcw8=;
        b=FFM2WnqD1oo5/zUQX6biquIpFjhcgxoYdzAAlP+2PryxLMps3iDNIIPSbjjHt0cEf7
         3frKWabr/zTITuHSe+HVEZhDYUaXgR0Tl93XiFICIb4tgnFlNrj+n8Tk4nRZklUfxAr5
         k86BfeHkmEhowDYrv1ZvwQXqVLR/dEqfg/XmZxxFb9o1KtWZpuyNvRXSNRQomssLCnLc
         es5rl021IskxaUw5H2RuwMZ0a83QUAsyKj3b2roDUFwmtAVTFMhhCUXDz9Y59xH0Lq7L
         aAun3/Nmu5oGPSJ3gGhoxLgMJJtP4N235SO/QMqj6LB7YNzY8m3W7M6lMc4BcjONmmwM
         +JPA==
X-Forwarded-Encrypted: i=1; AFNElJ9VfdKPXm9D2zZZdi05z7wBG6jsV2HEP2FnQQ2CztY7ud9ASfLHpA2GbclJuB7cJXoK/HBjLDdJwBWxzP3LUG4gIaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwpG8iLVP4tXllFBT+zVDuJSpD35NQ46B+gTt2/zzf7lmZOQN
	G7Nb7ZnYqJaWnmCQ0cW6A6NiXwHHQUqEzDzTZuNuhkcRgVtqZ9KvMWRZHxR7Uswowuk9dz/T0fW
	yCX51D+yMAbkoaKVTpb9tXQ==
X-Received: from wrou11.prod.google.com ([2002:adf:ed4b:0:b0:43c:fe6b:f318])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:4352:0:b0:460:e00:1213 with SMTP id ffacd0b85a97d-4601f62fb8bmr241409f8f.23.1780420330169;
 Tue, 02 Jun 2026 10:12:10 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:42 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-11-vdonnefort@google.com>
Subject: [PATCH 10/13] tracing/remotes: selftests: Add a test for the
 dump_on_oops tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced dump_on_oops tracefs file that turns on
or off the trace remote buffer dump on system panic.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_oops.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_oops.tc
new file mode 100644
index 000000000000..6c3f93ab922d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_oops.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dump_on_oops
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dump_on_oops.tc
+
+set -e
+setup_remote "hypervisor"
+test_dump_on_oops
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_oops.tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_oops.tc
new file mode 100644
index 000000000000..4f5f26cb3291
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_oops.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dump_on_oops
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_dump_on_oops()
+{
+    #
+    # Toggle when the buffer is unloaded
+    #
+    echo 1 > dump_on_oops
+    echo 0 > dump_on_oops
+
+    #
+    # Toggle when the buffer is loaded
+    #
+    echo 1 > tracing_on
+    assert_loaded
+
+    echo 1 > dump_on_oops
+    echo 0 > dump_on_oops
+
+    #
+    # Load and unload buffer while dump_on_oops is enabled
+    #
+    echo 0 > tracing_on
+    assert_unloaded
+
+    echo 1 > dump_on_oops
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
+    test_dump_on_oops
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 8dd9c961977b..887b9296d0a7 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -9,6 +9,7 @@ setup_remote()
 	cd remotes/$name/
 	echo 0 > tracing_on
 	echo 0 > printk
+	echo 0 > dump_on_oops
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
-- 
2.54.0.1032.g2f8565e1d1-goog

