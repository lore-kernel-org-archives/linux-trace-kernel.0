Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988487;
	b=ECfEqj7RAhU/jVtyB4xYRHiEBEtM9S8/k7L/jV0qpK+Y9fsPIPTA8tKMA40p3AG0fFJd
	 dTLgV4ZpEeflrGl/JMIFdX10Ro2Np0GMe5F7K3cC+GR4GpMldGLqVo7hVcWf2w6bpsyZx
	 qqdrAf6N5w2RiWFazxxmhak1eGEKntG/3hIqB+pHlT1WhCE05mfgZONYxRLVOQaUMwUXD
	 4Uiinoj8yOVir0Fw45mXkyRMC9C3gCtP25Q5yFb1X9Dh1LoSNaqP12nXpudzZFH1KVkq5
	 IGJNjHFrUbuSltEV1fwThRj3JRbuKj6JIigsy2DcIQo+x0L4TN6vrwMAoWplSuGn36A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Zl+gpigK4TKPUO8RmVnclUlHJV6OJa+RYaWqA3VwTyI=;
	b=c/qrVOTyN9rhgTeRgz+Go49Mk3hIYqyO5y6/kervxDW3GzJBUcQywNHx4dfPrjN8yRe7
	 0yB51dRSS0x4JsLfK9as5eUn60/l+GfQc0pgai2V6+csrKqEWI9Hr1t/6DFexKaGZSBi/
	 HEJlglANzEaTbXID2T2uanGI2TJcmUGtUR8h6kZEvaO8/2w0vUpTYZ62iXl7tLJ/CoRxi
	 hsqyEQdM76T8tZ/hC+fq3xNA+Y2I9PvL6zjXgkqCPEIAsh/bzX7IzyhiWFtVfc/iGykux
	 M+fRvDp4q87eF3RR8xd5aDkrSNwbC37TaO11e240EJRZcwvLY8649SiQ21D6ChpV2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GjSIbfXz;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8C608361A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E8C608361A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GjSIbfXz
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso5679545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988486; x=1794593286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zl+gpigK4TKPUO8RmVnclUlHJV6OJa+RYaWqA3VwTyI=;
        b=GjSIbfXzJsMlSqklHKIlEk7DJAbpidd7UnU0yQ2bQbtlaYM8gCejJZ7k8XL6RIuczM
         YIfzUs2b9ptyLVY8W6cdud7J3EWOVjMmgGzVfQ9iH9y/QuPQQBzKb4xfoBlCp8+/xiMN
         BLLgRaZYNRjSCtRWjGmzQWss6p5p0tBRC9rZX1Y1bQ9701GqWJRcda+iwmaaxRETTgAU
         4+X+EahV9XcVy/tEuvFHSpZYRNbxopCitQ7KqCUodkH6opxMiUVPCGewE4VldQy6poKE
         TkLO5U1JfnZjPRnmRFulFEX9Tp9LZIT/h+5l86lLGYoy68e0N9Zme2qwcAEFlx0nlRnv
         kS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988486; x=1794593286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zl+gpigK4TKPUO8RmVnclUlHJV6OJa+RYaWqA3VwTyI=;
        b=ZoxuEtF4ys7RuFZhmADxeSAQS+KzZb3znLCbk6saDsIgZJ7EDOvzKu+lgFEPdTMlRP
         KhUGOgZy+bozX3Gkm+N8je3b4mi8/fdC0kNYrtON5yCWblj3yoFBQuztRcu3nBEoYTUQ
         yCpDvput0/8rALZcot7p0/V+mTByXKLFjkNNgwC4nK8HFurOSSh+O8ZbFrggEii7CmLA
         0Bcrkn1y/gVEhlpjnkA2Hl3pxpSc7+7FknqIJfvASENyVlBRxiWrJnKLZNS8H271LmyA
         YrBjU5/YUTi5ll0fHAhTOmoT/j6EiUepXktnShUlvFs/p8KN/VqdbrM5wz9ytwWo/GFs
         S8Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwIUGbQDBL1BAurz6hE5caRLEddng0bYGxekHc9LYgLl1VzCeRJk3HTTqLwdBqyIPFOArEVi0L3gNCSk4Ado95Dgh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+rF5DrXTVEOt9QSWiy4KPx7UU9Pa6Gf5h3eRkEYgxzUqk6GvT
	1KBGA9Ik1Bz5FgvjsxfK3grQGXxGyzkN1KlIPbh92mklCz7OOeJSz6z82lp6wg9RYOut/xvQZQL
	XWX1KLOu5KVtR8KfX3cbCLg==
X-Received: from wmql8.prod.google.com ([2002:a05:600c:4f08:b0:4b4:3bf9:e68])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b71:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4b6dfd98762mr51951225e9.32.1793988485812;
 Fri, 06 Nov 2026 10:08:05 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:56 +0000
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
Message-ID: <20261106180657.2460376-21-vdonnefort@google.com>
Subject: [PATCH v8 20/21] Documentation: tracing/remotes: Add detailed tracefs layout
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a description for each tracefs file available in a trace remote
instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 Documentation/trace/remotes.rst | 66 +++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

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
2.56.0.455.g6c5a503b38-goog

