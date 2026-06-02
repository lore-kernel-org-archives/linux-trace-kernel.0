Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8B3FC5B4
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420334; cv=none; b=RlVynioqpMlJZ7GCg8sNt/TJX93yVd3RzNfUWuh99dkSYgDp/XdS7nG/cRKsOtRD3+5uvFuvvoVO24hYxSRxuNHSdn9qng5oau4zo7SlpdhChlEc3zMx0vydicHqkGju9qOshgxNBLpTm6l7bgQN4LcmJq5FFI2fgXBySdWJCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420334; c=relaxed/simple;
	bh=0x2W9QurVm001HlHwInuRteVdbHxjEzLOMZW04FELmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBV/u8kudjk521meM+Y5d9lQKM43VOFSVJTgkURK8L+kMUhjPnQAvoJiL5r8sHhHwgFj5KYNNyvDmkbmNMqnOzS8EL7n2jjZ1Sf+wGdLPd6zuNiWFVJNxeQzKZ0rKTAuzaIH9p1iiLNaTErNimHm/VQtGrBLHAIzKugWn20Jk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RD7JZAg5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RD7JZAg5"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b56bf7bcso560255e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420331; x=1781025131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRV/frTjb344YvONz96iAUcQwRDZJAvrz/JZf9R7wg4=;
        b=RD7JZAg5neIZg5IkAPUC4crGp/B7XL4iHkYSk7CWaEpKPak9ilogUaYeF8VHZ25v6z
         MkXAjrgEHXD1qz7MpKtMbFvGwigVAx/amjvAKYgKpzFxUadU29ThGNexYqYezpygAQ/0
         KfqvgFLfw0Rybj8wnPZtfPolHTpB3hK1saw7xvPXuAntsES5+YXcERK1PLHiuyphmMT+
         XjpVM48FC+zSf09Y9lK5ONpoj0YyWDrKM91rV2pNYz8qiliheOxbMlOqRBthFP+82Jaj
         APl0JoqmmXUVoRIwHykJ0WyYs0GRRIqf3EZznnRiMNWLxPRZJ9eKqxKUDzT9YhXVn1Tj
         BB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420331; x=1781025131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRV/frTjb344YvONz96iAUcQwRDZJAvrz/JZf9R7wg4=;
        b=PrM/o/8BKF0ubkGYbulJ1GWlxYaWe/p6k57XgVGRAyncfQ6fxPl6R5Zy5tO6vGh0kB
         I1OH+tuOVbWWzMqBxWGknLTdIRgYEiupvtm1zTsZA0Jbk+SsJ5C58U4fSDQyaRU8RUcP
         uBnYD6JLthXn3YVrtJSE8bIgXNSop00vDUA5ng/GuGpmN+hA6vR+Itho3LWgEP2WzExY
         qbC0EUmxH1ClaKJDugAYG1g6DeaIFZ/mh20hwD+ZIScp9OtNEJ0oxorWF1hQkgdZyIXt
         sTgBfgzmhj1EXLUPCpbR9metgSyFn+NN65gwhHA6MdC32fgeBX782/ZYxD62efRunIy9
         Wlwg==
X-Forwarded-Encrypted: i=1; AFNElJ/otK5CiWH84YtF0xndRWVujQxB9w5Z6ilGGsLn3T/82nqNYEi4Y0m+QdqxfYFFuffqNGqYDL+0mY+9qJQoPkpbbkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX/Jj3KRc75x9lbBrq8xdmRecbOc2LRh3t6KcN6vzR0lBNSTp
	SC1SxM3NFyY0nMZCWpHrsp7Urc710b+JGAjDEcNPWatPpDtXeEIflDZQkj3OwuDa2RJJ2hN2ZC0
	WmTQNBsaQOwH6CFhNA10N5g==
X-Received: from wmpe36.prod.google.com ([2002:a05:600c:4ba4:b0:490:ac12:119d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b19:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490b506cd39mr10449685e9.12.1780420331222;
 Tue, 02 Jun 2026 10:12:11 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:43 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-12-vdonnefort@google.com>
Subject: [PATCH 11/13] Documentation: tracing/remotes: Add detailed tracefs layout
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a description for each tracefs file available in a trace remote
instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/remotes.rst b/Documentation/trace/remotes.rst
index 1f9d764f69aa..bf63b929271e 100644
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
@@ -28,8 +28,63 @@ consuming reading.
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
+	when **printk** is on) and no events remain in the buffer.
+
+  trace
+	Display the human-readable content of the remote buffers. Reading this
+	file is non-consuming. Writing to this file clears the ring buffers.
+
+  trace_pipe
+	Similar to **trace** but reading it consumes the events from the ring
+	buffers (consuming read). It blocks if there are no new events.
+
+  printk
+	When enabled, all events from the remote are redirected to the kernel
+	dmesg. This is similar to the **tp_printk** option for in-kernel events.
+	It counts as a reader of the remote buffers and prevents unloading.
+
+  dump_on_oops
+	When enabled, the remote tracing buffer is dumped to the console when a
+	kernel panic occurs.
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
2.54.0.1032.g2f8565e1d1-goog

