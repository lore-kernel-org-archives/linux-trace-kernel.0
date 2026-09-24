Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290E4A092D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261928; cv=none; b=aTNV2/QytFKth46Isoqiut0FIVrlIghufLC7M4lpkK5p5F2xtLwP8/cBLvFzaaY7NgMCu+l/7YOXz6fZiPXiBcx6PXRrL3hTBGnntnossenVR89c+ZEGMcMKTBRY9RybWq9d2LaUTbb6zM+PZW9xWkKTAe3RFJI+lxpKDiCrCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261928; c=relaxed/simple;
	bh=x7ZsEPn+08PivkGNNY7yMioERj5C50CMJucDPlVw1Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUMjr4w1JfuZRPwInI/VznDWsdCJ79mBhKwjlUZUtS1MtQZyXlzzVSXHckYmUKXEw1Wo4QOIf/U1Aox3XDGwg9HNStqPRIRD+NkRnnP6IdK8khWlTluUoLjBRUxHaw80xevbYfvAqrV7S3p54Gq+keXH0vTK79D22wXSHnvLcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKtF21sf; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKtF21sf"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e635a6002so27115735e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261922; x=1790866722; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uku/5cGCHX3mD6RwBtTFznDSRiqK3GB3+4Rvtb284U8=;
        b=XKtF21sfBfTzuICOUn3I2PpsJwnqsNzMRL3s7FB/9YLfs0NKZ80KGWwQ5uMbkFDa0T
         4UB5IRYh+Nj6atrfvtqEARjUzGfnAYLa+3gPF8wnMntd+C0K/fsfpuz9KGLnQFacSCuw
         1c/KX5ensylQI46ytXJ0RIZxItXXJ+7hvluRsJRTg4AF+6oW9/qDhFs0byTp7FpdtARf
         anPw671gXrXPpTKW+mPcFYha4oZo+m848zT9PncHxnyUfWMRrNmfrU/KpZAOHvVDy364
         5KHUAfFhgHHNwBEGUjTQCZMnB0yKq4VR2DqmQfFG4WECICHL4uvlxCcwqdU8QB2NUM3g
         kb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261922; x=1790866722;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uku/5cGCHX3mD6RwBtTFznDSRiqK3GB3+4Rvtb284U8=;
        b=rKoWYqoSCQqNF6KfeBKLb+BDCfBl64ZkZ8B0n3ak0tw37gnVbAuHlWm+AQ/gWWi9qG
         S3Ilkv5ybEJmMLMiJg26obFhoj1JPl9OvqlliTbJceEMP+R8BB89hoD6K8mqAflQlOVP
         nNyrYxAMKufPdpuJyJXgSeq3BkgcESOtaVbOmsLVrks4bbP8DNZuLQTxe0pEC0U7MtcQ
         fiptpAhLhv5bm8uvBCzD2+VEYIX0iNd1O3pnmGNCyMaXDrj4np01hlbi/w8zaqo1iMVT
         8wOgBwSRhkZAj/CVzRi1kug5NRfqJcICAuaAS6v1YnCQiyacrRBKBwKpX7eKXUHtMLQ8
         dpoA==
X-Forwarded-Encrypted: i=1; AKwUvByH0rwBPTfeNhyJ1svAAamOj4N15jjx0VWhuq/yCZOP3kmA5HApoNiPjg5b23p3Wc4U52EFKRxthH8ZCxxjnVEqxAw=@vger.kernel.org
X-Gm-Message-State: AFuF++k+f+cufsgJXCS0wtGb2flCI4UruuSwFIuEqRuhB4jwpZ1y9QDl
	9juuTbsRqZR9ZOwb6p2xngl1/r+ZhBm+yGKX5K6m5Tp1XV717or6+p4AIBH3jw9wnPF2hhpfaXR
	S/XB087mstlL7/rtFmm3GeQ==
X-Received: from wmin24.prod.google.com ([2002:a7b:cbd8:0:b0:49f:e42a:bc6a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c48e:b0:49f:ce72:dfe7 with SMTP id 5b1f17b1804b1-49fe6710a41mr43535605e9.35.1790261921755;
 Thu, 24 Sep 2026 07:58:41 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:50 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-17-vdonnefort@google.com>
Subject: [PATCH v7 16/20] tracing/remotes: selftests: Add a test for the
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
2.56.0.rc1.310.g51773c2048-goog

