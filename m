Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995047F2F1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551247; cv=none; b=C5/7QipYFgA7pKTejxbzl8g70H/y7CRIONUv8OdAgje1NWqz/89wfYHRx0znh3uMcgCHTNDpCKp3Fr2zYSYB6mqDK5iiz2DSgTobnVWz10RVy6HtTyf2jphKXj4nQKyKc+B+gWAzSwjbhnBDZ62MnzUILB1T9roVXbUVrYB+yXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551247; c=relaxed/simple;
	bh=hnNTw2qatm79qODsgszSWfdN03d3G9Z8ONnvzCmX05A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mc8jj90yDgGzj00vC2zdQpnaUJp/lVojRSUvgplasFRIbbrX3NTKaJEVQdftWqzQEdjhus04y/VTrWh51M7R8jB9AdYMy2XIp6flAiDITI0gr4+8L+UFQ/CplznouGaKtNKIj1S+uOD2J5B/Gu+V0Y9my5nuXwud9bTfWrXRziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcJQwVN2; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcJQwVN2"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4997d718093so5129185e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551243; x=1787156043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf3GDEXCOTi5YGLrqENHCx6PSENZcg+BQDjs7+C49go=;
        b=TcJQwVN28nnyOWInaZ1jE9CHDJKNFCoXs3ZNOe4g+3itPE019jUECwGoTWX4oOKo5p
         NAabOWXDrOARH9WtnVpVYFKefvPslya57/QV7BmwTDlNtAnoQrT7Nc8idsJyE+agZIJ6
         V2f4kIQh3XHqYfxIsGJvMH6WCdI3iHCNuCDp5aP2TXVbtPUiDt23cBOw/1Z0qO0608ML
         hySBt1/jyA/OXJqB3YHWMpoMYOD10dewp9ihjtEUcDxnIwx18jCDTxXzZHXqJ494Rx7X
         IG3slBaXCEtrWAEaYCfPA7Kol5gIxE8yRrddII3HFQ/+8wWIFW63MyICWoG+S+54dp+d
         kGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551243; x=1787156043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xf3GDEXCOTi5YGLrqENHCx6PSENZcg+BQDjs7+C49go=;
        b=A9VhHUR0r2MWzvbs+fFJQKA1rm4mEgLH7vmK+PqAA6g41sLgSCRYsCkQuxYZ7kTOqo
         5V01mTEGsQBPU8ZiqePVAwjvWjG7rR7SKmWzF4YWiB8F9ZsogN66Nj79TfmnNDyRdYYM
         VmtL+yFl/IyFgFn1cDkOJmm5PVAJGmKpmJjtROGWGMW/qw+Av+J+VDRACiAiXzOJfZVX
         cxkg9AyF/aj+Sat6+jsYe5tdli2qIztN3lEzns/qmf4U20JkJTnIvrcNam5Are8y94Ad
         gelYS3xTLDCSly4lBD2MYNMScP7zpmfhH2HYyRnMBUoc5gZPS03OATm7ovwVjgFA75kh
         GoEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpvz9rSxmqYCKWFOlN+KizcQ19q83Y1g3GMWPrInd4Y1hz7unY7di+5CyZYYAAhDctg6y645+EUENdUhFK3K6Sgu6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqYQ082HO0xHIKvUfb8+90zOoVtGCe2nHXpvnnQ9jSEVQ7zJl
	6rndRG01qRVO03nUxv7rNa7BUoNNcadEG6OAZlm4HBem/ZixsSpTALJCDATTLBAOZRoz7P+JXuI
	2VUD0JL5VIJ4ph41M/NQbSA==
X-Received: from wmqy6.prod.google.com ([2002:a05:600c:3646:b0:493:d1b8:3df5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468f:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4997c14569amr67469745e9.11.1786551243305;
 Wed, 12 Aug 2026 09:14:03 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:39 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-18-vdonnefort@google.com>
Subject: [PATCH v5 17/18] Documentation: tracing/remotes: Add detailed tracefs layout
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

