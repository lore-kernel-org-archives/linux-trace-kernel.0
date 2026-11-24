Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534181;
	b=Q8XI6DN3M1vPhf+yklI9GzdRgE4Ir3Zx8OZkJWWNhfAl4LY1WDcB60OowEcWdOoEdKeR
	 K1iL//DJxEiyiz6+b55b2xT5ZLdghrVDXpPcgcmo/cFwVRYaIqUPj5zuI8WPo0QDjvMvi
	 mPc0iSy9QCbvW+/Mhav4+yOWMmtMiBpAXfwEu5O0dzw8JvQXocdmOUBflLIOa8PHEB+vP
	 sj03XzO+pRnpcP2MX3OIw25SgDJp0nT1aqqurSQh4DW9Crt6A/nf/LcQXno5nGdDthyp4
	 7b4a9m1zcVHSnrKRppEXD4ma0bFbum4Mz3eJPOF5epfzsRPrBNsKnCHvNLougcUeUFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TSEZMfxOLFCjZ2pTZlRgmUJ/uywE/FfuQfRBfLgNG8o=;
	b=RF362eRnIrbd4C/VTAOXcV0CFbcviTmxhCnKuiLbrIDmaHtfYhui4Pa9rkyZhq75KF2F
	 ITa9xJhlhChdULIeW+QvOb0871tEMD5yV515GeUaxkXSJrUpF6tFFKAUcU+AIFQFY07QK
	 FMxJ9CP/iquX8Uh3P2TZQlvZ9msrTv0NsU+758LUW/UnHkYL0Cxnn9bzypTMjcM2F9SzO
	 zK+ZHQfqNl4W62rxOoQDNlpN/4leT8jmlPQgvP3YWPVJYbDfTbJfJb4lXdqRmW28de0Nj
	 KsNQ7foyvhcNegTgz+LfGnQFNqylMtHi0NqYJi+GB6D57yj+h7pilFEgPkc5XzEN9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HvhJ4axR;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095C60A5BFC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A095C60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HvhJ4axR
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0461e040so3640057f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534179; x=1796138979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSEZMfxOLFCjZ2pTZlRgmUJ/uywE/FfuQfRBfLgNG8o=;
        b=HvhJ4axRqUDPYwxmsR8FhIWQMz9ei8GkNnkFc+KfGZ6qldg9DvdNN8LFx9yrjMjZB3
         msI1ZxHIraNHUyH/tvzDhopRiE9vlc2DgIuXUJNcYMuCezUolx7+P7LhPfYT9USeh06e
         eD9yBoZyFCWxs8WwJ15+5HYwPRayzaeImo5+1+g11O6eJN2L9QdVCGXVDoxzJyRRsCyX
         8ojMJO3USNVtfo8Ctkt40uPU1jDhsP+W3FeXxRWf6aI8mQpZ+Butd65ATVUVjp1UNL72
         aJSPPF0gclAZcf1apPP9rZ2zF9Vr5IcWNuYxxcB1EHwvLTGF4wJXpVKWDE/nWtxTybiJ
         jrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534179; x=1796138979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSEZMfxOLFCjZ2pTZlRgmUJ/uywE/FfuQfRBfLgNG8o=;
        b=Jukq+ernkapgKeppx7bnd5J7LI+xzKWz9tB52E5Dw9MoWqlmJQMrKlZp+3geiWwjdU
         Rz78xI+fANY3kgGUx9Gsc5s/3uw+BCBGqv3LZ79MbAHPRN+UZUjsyggaiRAxmh5E3jQF
         x+t/VmPu/p6WoG9L1xlOpo77HSb7/+zaw5JsW0ZqnxCdOqFczrsG/VFyFo7kr5M4ix+4
         YGUcFnYtR3oabYefv7TTxVzq0keyGU4KnuWGMBBt43V+/0yuJwWIxc6JQlZTqJbBx+C6
         9WNjiUBGwgI/us5LuVNRk6bqM+5Q1V/lolDUEQ4chUv9aaPTHqApVZlJ7Rv8FhHrOGQd
         Mp5w==
X-Forwarded-Encrypted: i=1; AL+hErGCh8oFunHzMOg1xGMHJ29s43ISW6Yi1xlObHb0K4hOe8PVRx7RC5OS4LrcNNUVpKxi4EZPxXSbpq4MqHJqhpcdhJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OaLprV6YAIgZyo/uMNNu3l97w2GYiMnI44wLt9+xg/yfhr7Ya
	8BJNf3pCxQBGuFthxNUTEW2OvEGrI/WeVZnSkDZu/pmAJoWkQPunUURXwzccKJ9QjJOLcDAG114
	UWmDeXwOqMajq8/hOq5Odow==
X-Received: from wrxk7.prod.google.com ([2002:a05:6000:47:b0:4b8:22cf:5b06])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d03:0:b0:492:cd78:7137 with SMTP id ffacd0b85a97d-4abaa9764d3mr29902854f8f.8.1795534178633;
 Tue, 24 Nov 2026 07:29:38 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:44 +0000
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
Message-ID: <20261124152845.2233401-21-vdonnefort@google.com>
Subject: [PATCH v9 20/21] Documentation: tracing/remotes: Add detailed tracefs layout
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
2.56.1.809.ga0b61035b5-goog

