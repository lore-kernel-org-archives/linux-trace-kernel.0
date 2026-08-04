Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D346EF75
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852259; cv=none; b=EpHp/xnRN6+2nIUhVbfa2VK0F/opOl9XIldw1h41HE2aidqkJVo0MM35gfkz2rj2INmJwVtaesfW7oRh9Ax5sCwlotleCj4AAypasu9+ecew3RG94/XeR0KRfn00x0Ny0GXOm9ofgauiXtRnwzW3kD2gmhnfY5XpFKQQ5RYQjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852259; c=relaxed/simple;
	bh=+waWS+LuGlQv0fRPmL/LtW30MnQtW2cBAI87X2O7Jrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmV3UE0x54U2lPm6ighPw8ksxGsjRbEIEajGxtTcaOhoMX1xpanAh604jHZoe7kM8WZwBAVMq+qHUYxUUeH4u7lFIW1eq8t7bqS2tmrIXXeXIgUxzahuJcrPDc0wYlZDjV9SFVgNAO9O+OJ4c/H4xh/q7aNUlEZGgz56h2oZN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSF7ZuVN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSF7ZuVN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso29514885e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852256; x=1786457056; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsOIk6tEri1zvwh86V3qrpHjZW7o/k3J5WhzY5duLPE=;
        b=FSF7ZuVN0YFsg0bCMEI8bMfFwTk9R6PTlMBikU8oFMpD8b0dVl5h615BwhLMiuu0xX
         2JUNooHUzT1kEpz6ie2J1xeQHW1iP8t2+oDlUOcG3lrpq6snyfjlGdRL3hyER9ZjjOmV
         7QC9d24zWqgu3lGEX4y31SjHF4ev6MPizZjLnRwYRBQ09okM6949a2qSgDFTNEAyUar4
         x6sjDwrWyHs3S0i7YE/3xzqb+26Guhrjfa8fhvtuHP6I+L6QfTU0bI2cioedzHe2foMD
         tB3aszqVi3KAQD2++aeAQWol8KMgHwM485ukvZoKAefoOKoGKssUxa2ehsS6INhjBWw8
         nLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852256; x=1786457056;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsOIk6tEri1zvwh86V3qrpHjZW7o/k3J5WhzY5duLPE=;
        b=L/5SfxyB+/mXnI38DpPOZXsezmjAGQOXKAx1uuAzTCEv+U02kzP0NCYNAL1Xm/SPG2
         78JzMyNWIaOVcP6dHmDHehZgyYciF+fXmWRnzCXC5EksctzS+zuVdW1Uq0nVeV6I1S5B
         Te3XfGLJfCDdM+Vh6O71cNJckSvaDUe52AWtUDcv28XBq0l8LuUIKgEDA/aYpK88WBhQ
         bOgcwVpgYHZdjfp67sneeLr5R8BGNmqrG2y5yB51BbI7MwIytLZhNECJUZb1Z/r3KdVl
         z3j5bTenLwvFkpwXdqA5qRb1dcX0xEzNamyyAeT+jqcAB6DC6jsabokJu05GAmo0+J2O
         7VMg==
X-Forwarded-Encrypted: i=1; AHgh+RqmSk+DBScVHpS3lvb9qXc+n9JITyvRnv0bBE3SWdrCK4kWK518pISQ6UB5cbFtUXoovArvngZbhq5s49AsF5iHJzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MZ9t6rlCHApSCLxHnXaxjtjU29dLE0PLtb9bAzBBCzhf8Tw1
	p05VnOwhEA2w4Ii9dHHydmHIZPWj2Hu1Fzo/R0b3vSTaluhGeYFAcreC3I2lDPDL5h7fB09WFfP
	1zqb3jejWWYvrOWj3BOQmNw==
X-Received: from wmrk16.prod.google.com ([2002:a05:600c:b50:b0:493:f7d7:4b2d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470d:b0:498:490:3bbe with SMTP id 5b1f17b1804b1-4980c679d1fmr352883565e9.16.1785852252115;
 Tue, 04 Aug 2026 07:04:12 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:32 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-18-vdonnefort@google.com>
Subject: [PATCH v4 17/18] Documentation: tracing/remotes: Add detailed tracefs layout
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
2.55.0.571.g244d577d93-goog

