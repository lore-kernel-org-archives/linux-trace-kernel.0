Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F93F7A9B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974942; cv=none; b=l7sYQRnlmqDAII96mZdeZORcwjYXCxzdCwRPIS7Z6wxy238yz7+L0EaCX4nv0c75oiM6W56iFC+rgqaejKx+K1wYavAiGEA+374S35qArw8Cpz1dAAR4ny0YxPXxwN2BogfEfjM+T0yEXVF+LA6NoyX9OLcVkLNb+pvjv78Qi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974942; c=relaxed/simple;
	bh=ofdVSE82TMFbx3jJE5g6Pct0CPvte/TLRyIX5pzhV/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XtYabbQphAbdxtd84Tp2rd9RtC8Ti6VYfs7BdFH6V9IfJ+EbErRQ9fD4A1O7l+N20rrzrIsCFsD7AVCB5DGLdzy41K8LZ69lsVGvx3Nnq521aljY81JQhpnykTpjfNEn0S3pT7Rcox6gORepvrbGvNrWUOwouTzyy7JIwk8WKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g18X7pHU; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g18X7pHU"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15fed5653eso238036366b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974936; x=1787579736; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDlYuc5KHp4LnGhRaLm9vWGocb2SdOTQMYiLu/GgGe4=;
        b=g18X7pHUrXXO8/D0fXZY+hkrj8wEzfJlpXiu7WPdGkFxCZOLRkuk0OpF57XhtBzy9A
         hTXZDEhC9s9zqbVXbaMpEY1rc8MOCiFRFClwCHD6hcUONIlSkW2nJf7wsdrhOeriFpFe
         iaMbiR8SbFtGGx47xMWDG1QXLl8ixS0OM4sAfNUQnibGy9htMLAsRaglZPBHiDIyjYxz
         t480u7IYMLtn6jj9PYsf6UxjuHMoqrqsfdPe5q52BSx5QhBKIxPBqRmwS2+S+SoNzeeQ
         FcZLRSMOc9X6N++fL3u0WOlZHJqxbbVERZ3vWBkl7T5cdKkk7/++THXH/IzGasisWubQ
         p4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974936; x=1787579736;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDlYuc5KHp4LnGhRaLm9vWGocb2SdOTQMYiLu/GgGe4=;
        b=nUDSDONQhrnmqFqRkwQssXwzReJ1aDak5FARGY3CXDLfkzJLsOTur9Q1s3CAlIzsul
         D/y+0qnrCZjyf8+tisjX3B+lTJii2B1/eP0ti0JOCC5pWYnjjOgbjMv367rwYKGQEKEo
         8djnT9jbEAdDuZc7Kl9q3WqRleePJoGTqfALtRg/8PaDUqA4lvUhsBlnkxZioZ2q/3EC
         LJJClOQF+CWxtBpWfhRjmUPj4D1VeSu+6/s7ueptfdYXhp22Cp2mexLcIic0ovR0piWS
         DbzHoYiZhCPe3q8L0yUvpOfjNu5Xb/tish6TLR8FMGXzro/7KeT1OU57ayQ97wOz8xyA
         Rn1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrOKv+3cdZRBCC+1p9tiYm9f5+yvZOb7eqX880TEbXUYT0o3zVaXE/M3HTqgst9IR0WTrYcJb1KCMAAaMF395rQJMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuDvsBINnd0IMmQ9iFS+vc2kH9fLwLKQv8Er7ImFwTazBsmLS
	F8pUZRp7fNA4F07e2qPjR4Dg0j5X9TuGA7C1YCU7ajGF8HwfFaLUsyExlM+piszaTIO1tAa60Gj
	4Wqv50l5u0JaioN54rdw+tg==
X-Received: from ejcht14.prod.google.com ([2002:a17:907:608e:b0:c21:31a3:29f7])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:842:b0:c16:6a42:c7d6 with SMTP id a640c23a62f3a-c2129b5a601mr1144649266b.9.1786974935564;
 Mon, 17 Aug 2026 06:55:35 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:13 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-15-vdonnefort@google.com>
Subject: [PATCH v6 14/18] tracing/remotes: selftests: Add a test for the
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
index 000000000000..1ba025ff9838
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
@@ -0,0 +1,51 @@
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
index 4a14aa72fdf0..f0225af23714 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -8,7 +8,8 @@ setup_remote()
 
 	cd remotes/$name/
 	echo 0 > tracing_on
-	echo 0 > dmesg
+	[ -f dmesg ] && echo 0 > dmesg
+	[ -f dump_on_panic ] && echo 0 > dump_on_panic
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
-- 
2.55.0.691.gc56d675ccc-goog

