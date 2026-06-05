Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD53ED5D9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677593; cv=none; b=oAT56ezGG662Zwj06c3tjPo5T7E/7VzKKwOzXzSqex+9m9hkkNY67fSEM1W4r883dTpn+wJr5j5k3R9o1wTaK4VHxPcErLJ/o3A/5Hr9+Ln0SbNaRTmHlO9oxMljtIC2/Dgvzcst33LEuadyJDnSAI1jd3Ra+ffGL0iliqMjuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677593; c=relaxed/simple;
	bh=CtPA2xn0XNDz7CeJ4oit0Em4VeFVio/9GBPZBBIqOwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PV2meF/gaQWFmraXW2bcLOrtZ4wGC9UKVotiBtFcxs+qD0qtUGkJVtOeaEmM92Nk+7VrAAQLfAgHCQXemU0TIDzdcqaUE/S3Y7JpzutiaEEK5rN1fGMs8U6MLkH86gSmuJ596XPiZSfjDB66qEvJW7feQ+5+dhH18elSIm9Md7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUNnTnR9; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUNnTnR9"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68f9ee927fcso1090804a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677590; x=1781282390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4q9REbVkUTgliZczbwqx/AHTvVhzWRFhHEC4wqCXL8=;
        b=NUNnTnR9M39C2j5dayM+UU5u3dsWoxv83BSpw573Zg/MMUU4b75SDCrq9j/o8kkKtz
         NrURwL1vKEIfVWD0m7P9VdI/yUa55OnsXYm4Jcx9Mr0p34GROPcHE9eIntaeyF5aH3Nz
         bdSs8P1zxItbShn8kObXPZ3Y4TPolevP8hSWw5XHQM2l2ZoPV6RoQbiaT0jLgIePcHfX
         grxaS3emQX+T0TwZMIzOlmEq9Zf0lAG2hp0fPayapRm9c72jmhOTWga0/pROEoZxFQhU
         Pmh1+s5LXs33CYYjHWxwN1ZCn/niwNPb0ojuv8SYUm/695Mbism7To1UHnMmwdta5inl
         Ilcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677590; x=1781282390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4q9REbVkUTgliZczbwqx/AHTvVhzWRFhHEC4wqCXL8=;
        b=oN4UKBW3fFNPVndTtxiqClLwCcylLlCgz8AuhYRUkek898NbO3E8MIdm5LTsZIb/t9
         B5715JLg+5AqahslskkBEuac/7E+W9DjdVZdRhWtcAORtyatTbIc11B29KH30PeCLXjX
         oRSYtNDdBJvOxw+p7ISKeScHy87ZFHZ38nsZUWnqsD6Utr0q03Jac9B8xQjrFyxzzQaT
         BCx7OKy+hF65phvXJVhAfxqD6z6Mn4E5dZUxw/TEnkBzDGm869KWkeh/33wbCyotZuuo
         XZDUkcXTVzKlhwc4MCbiplu2SJAJhKcAgRgILb3sNljVyKJUxoXnH5Q/Ani0wqtScIKY
         NttA==
X-Forwarded-Encrypted: i=1; AFNElJ9PXf8SWpTR9PsWBB5OlmZdCdowTvtCeniLaTWO0mIRnh7gXj1d0MFReGJyPl1xC0L9NvT9VfjWty7hBee/5eRdfO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcXTEU/QfKWNKgJRsk5oIJKK51iyBnXEzl80/Ez06Dzgp4LQY
	gq3zDobHhTye51mv75+T8jl8h5fmRLfUV0wRtSmwUv4Up2B2LUkGPUm2XP83byTTX6Izd6xLLqc
	1hgH/6l1/U3Rv7B6uaU/AoQ==
X-Received: from edew26-n2.prod.google.com ([2002:a05:6402:a21a:20b0:672:3727:bc84])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3905:b0:68b:f026:f381 with SMTP id 4fb4d7f45d1cf-68fa4e3140bmr2347329a12.8.1780677590367;
 Fri, 05 Jun 2026 09:39:50 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:21 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-15-vdonnefort@google.com>
Subject: [PATCH v2 14/18] tracing/remotes: selftests: Add a test for the
 dump_on_panic tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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
index 000000000000..defc6f3a07ca
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
+    # Toggle when the buffer is unloaded
+    #
+    echo 1 > dump_on_panic
+    echo 0 > dump_on_panic
+
+    #
+    # Toggle when the buffer is loaded
+    #
+    echo 1 > tracing_on
+    assert_loaded
+
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
2.54.0.1032.g2f8565e1d1-goog

