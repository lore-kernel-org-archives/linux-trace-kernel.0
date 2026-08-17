Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEC442361
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974951; cv=none; b=kaGjJcaQMKdayO9G9KWOcylSm1vEMqRYf1PStCNDwxThoN7oOajshgyLh2IsfCRd1lai+EVYV+admryZC0rtd/0YvwhylRBVgugRqfzzHAQ5wOTNzdhSDkL+e+43x7C5Ml9yjNiUM0wwicfjK/5J+jXR9YeFFdbgapZAa11ytJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974951; c=relaxed/simple;
	bh=hnNTw2qatm79qODsgszSWfdN03d3G9Z8ONnvzCmX05A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bawDxsQrrRhf9pEewTfrIwCyR+EU4au2NomA7pwD/b9/e64XNtGgT0WHdtqDIK0uj+/+pR9tgRrQd5+sLIXITpTyUcRlk7E4xtNsjpthrD5xTXJTTmStdo9Mz0ClZI1My0OhkBC1ZFBPYpmQBoMQsRc+olt5daD7OLBtKWBmNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtvWST4X; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtvWST4X"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so23884355e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974940; x=1787579740; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf3GDEXCOTi5YGLrqENHCx6PSENZcg+BQDjs7+C49go=;
        b=qtvWST4X8nOkAPls6ybr/zn1GmBgnAt2GcN0H3s3mqmEm69RC7o7oDXaAfDYsN3OmF
         vUlR6gj1TvQd+jmBAkW/DfTMvOJLf/mz27BlSeu5R3mJAYnB1HkFKBmzm5e6Rg0S4HVR
         at9I/ZsJLIQ0LDEm45Ce2BLqmEOmwj8PUhFgbH3K1A1gZCS2Pq2StQ0g/5Orq6zHJKcw
         5Gj/z681+UOfkhw0sXYXei/lY8gVDn7q7fMorZGUvEszEiJASBZOIQYtpoDUDZQ7H4yw
         WciSpFXzzgiO+/Ut998DoqVG5YN8ZAk8kAMAeqgKKCzIBrQ9OcF+/4woowerxBZQnIoD
         zuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974940; x=1787579740;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xf3GDEXCOTi5YGLrqENHCx6PSENZcg+BQDjs7+C49go=;
        b=Spi/4fefd/Wx0q+lcS4cl2AODfGbFrUcLdmY7Tad7D58y8tXW1Nx2I9pGCTQpISagd
         zr/JsXsReK6TjYfWk76eoG6CBCtKKRmmy3nPAgQvb9sE444a6vJCtoaEGKHNAlsM0o+a
         mjBXMgyD+Ak1mAw6GD0YMhFdT0zxHO2Z0DGgy0Sb86kk4V9E0br0dIsAGP3rgavtCivN
         YJs+GCZ0mHuFy8N9pJM7WndQD4A10nAgVB0No7PFrXprIZ7z18GS7ayrlgdEkQka5Nyb
         2HESJxtwknWsbinV41aEVhxhxmH+yRCAK9AY8HewoUbVnu/oc9v7I4x/nOyYsg6IeIFi
         cu3A==
X-Forwarded-Encrypted: i=1; AHgh+RpV93wTEg71lDZRNKRF8MiNjelqvZxgHA+LhsYE+yRhR0uMX07Yk7kDBXvUIW6PHtfzdKyW1MU4SJwFhec01QU0a7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtiwZo5+Ye46ZL4BodoQrsVIuR24P+WvNtxhVyLWJPCSEkyDs
	681Rku2EFNtGaZvqQGOkFn+BG8CG+0PJA8mtDlRuPlpaN4byO1qsZJoyBw0SKHTO5Ohwhqv93Z3
	IxHUF48dOmltrdq57Mzwf7Q==
X-Received: from wrml11.prod.google.com ([2002:adf:e58b:0:b0:47f:69bd:a947])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c22:b0:499:9a29:583b with SMTP id 5b1f17b1804b1-4999a29588bmr102400245e9.19.1786974939667;
 Mon, 17 Aug 2026 06:55:39 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:16 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-18-vdonnefort@google.com>
Subject: [PATCH v6 17/18] Documentation: tracing/remotes: Add detailed tracefs layout
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a description for each tracefs file available in a trace remote
instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/remotes.rst b/Documentation/trace/remotes.rst
index 1f9d764f69aa..b02ebed4a03f 100644
--- a/Documentation/trace/remotes.rst
+++ b/Documentation/trace/remotes.rst
@@ -19,8 +19,8 @@ for which the host kernel can see and expose to user space.
 
 Register a remote
 =================
-A remote must provide a set of callbacks `struct trace_remote_callbacks` whom
-description can be found below. Those callbacks allows Tracefs to enable and
+A remote must provide a set of callbacks `struct trace_remote_callbacks` whose
+description can be found below. Those callbacks allow Tracefs to enable and
 disable tracing and events, to load and unload a tracing buffer (a set of
 ring-buffers) and to swap a reader page with the head page, which enables
 consuming reading.
@@ -28,8 +28,66 @@ consuming reading.
 .. kernel-doc:: include/linux/trace_remote.h
 
 Once registered, an instance will appear for this remote in the Tracefs
-directory **remotes/**. Buffers can then be read using the usual Tracefs files
-**trace_pipe** and **trace**.
+directory **remotes/**. The files within this directory allow configuring
+and reading the remote buffer (see `The File System` below).
+
+The File System
+===============
+A remote tracing instance is represented by a directory in Tracefs under
+**remotes/**. The layout and files within it are very similar to standard ftrace
+instances. Inside the remote directory, the following files and directories are
+available:
+
+  tracing_on
+	This file allows enabling or disabling the remote tracing.
+
+  buffer_size_kb
+	This file displays and allows changing the size of the per-CPU ring
+	buffers used by the remote. It also shows if the buffer is **loaded** or
+	**unloaded**. To change the size, the remote buffers must be unloaded
+	first. Remote buffers are automatically unloaded when **tracing_on** is
+	off, no one is reading the buffer (either by accessing **trace_pipe** or
+	when **dmesg** is on) and no events remain in the buffer.
+
+  trace
+	Display the human-readable content of the remote buffers. Reading this
+	file is non-consuming. Writing to this file clears the ring buffers.
+
+  trace_pipe
+	Similar to **trace** but reading it consumes the events from the ring
+	buffers (consuming read). It blocks if there are no new events.
+
+  dmesg
+	When enabled, all events from the remote are redirected to the kernel
+	dmesg. This is similar to the **tp_printk** option for in-kernel events.
+	It counts as a reader of the remote buffers and prevents unloading.
+
+  dump_on_panic
+	When enabled, the remote tracing buffer is dumped to the console when a
+	kernel panic occurs.
+
+  poll_ms
+	Modifies the polling interval for the trace_remote.
+
+  per_cpu/
+	This directory contains subdirectories for each possible CPU (e.g.,
+	**cpu0/**, **cpu1/** ...)
+
+  per_cpu/cpuX/trace
+	This is similar to the **trace** file, but it will only display the data
+	specific for the CPU. If written to, it only clears the specific CPU
+	buffer.
+
+  per_cpu/cpuX/trace_pipe
+	This is similar to the **trace_pipe** file, and is a consuming read, but
+	it will only display (and consume) the data specific to the CPU.
+
+  events/
+	This directory contains remote events that can be enabled or disabled.
+
+  events/enable
+	Allows enabling or disabling all the remote events.
+
 
 Declare a remote event
 ======================
-- 
2.55.0.691.gc56d675ccc-goog

