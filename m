Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025A49DBA6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261930; cv=none; b=Woy5+l18xZ5hpkEOvwPaiwCrjcLXhwx+8FPSMDMHxjbRXOCyqegw43YA/DQnAP0Rmixb3E/Ja9K9ENxdkgszPjwzln9yyCkZVozzXUWjJ1+XFtsbe6VZm6q04GA9KxDWWgLECIq76wHsiJ/5rARhuTmv3m8m+xonzOLeJKf3wos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261930; c=relaxed/simple;
	bh=TbFOs9zt00KhvKUvxUFIuV2Gmx+KhcVjVQo5GM8TGZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LNheMRf4guMjoInCMUfGaMmwuVDOVG4sYGW3Eb9I1pQzEQsDGiStU42dANXzinizLqS5Jwj1r8jZPZj5Wd2/8ETQe6dMcOXqDUj3W5ACNp+SPs8/MeC5yRKZcMmeD/Q2hJC1WCkXnEiNhDLR54XmA9TrAuNu9VsWMMkdkSsJzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auAFAJJ/; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auAFAJJ/"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49febef74e3so2254075e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261926; x=1790866726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4k6Ha9rPmjVxi9itLklgWGlg9FSwku/SVehRY8VEz5Q=;
        b=auAFAJJ/0FsMq0p+d8hF7o28BK1Pt2OO472Zi5xX7FEufd+XbMR3c2EeXDiyjmO4aO
         Ct1gv6IUTJUMdjzJWwKEhUdpOxK6IJNvaeIYIpM5+He2QJ3zY3FoQ5oD7YanCeS5aVS6
         1QjZp/VnL5QNbePY4ZFX2W3N5pj6zJOa660YbV7gwrD9pnwDcT9/wUO6sJMJ+sIWUnh2
         VoeAWl/gc3u8p4JPP3seO1AVQs7lEGpn9FEFGfgtTN/7mQNxMkVpMLBBB3CRQCGu1Ccx
         tt+B50ecAsZJuriKWxR4hiyHqAxYIk+QThUtD5xu2iIAX7Z/xA0Imol4dJ5lnmdSa583
         9Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261926; x=1790866726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4k6Ha9rPmjVxi9itLklgWGlg9FSwku/SVehRY8VEz5Q=;
        b=Gmx1ZDBL6Jc7O7LGSBJMxFefZtMiLFv+IiAPEkLpiu4yyo0nvnhumqJ0GEgoXrFAT1
         U5GK8XNa0/gegEq+Nk4QNCa4JtLLl5iQqzh6SYNMbyKrYCt7ZwZny7HpcunPxWWGr6Tk
         rPTGo1n4iKBWEfjYb4x/LJFgrrseENh2STcK4l1sHm1GKKtm7XRpgDAoXt6kwa2KVMgp
         f6rRleGLiEyCdseHl718BDtg8hqD2IZKQklG8c3mGT1bLjxBgQ3KcOuZbqvF7hJJOTPh
         1sNxybawqi70S1EhQz7h61KRSdfKg8QGHwPYwkDJZxwAEl20Aq895EUBVHiC3oExE02G
         9qKw==
X-Forwarded-Encrypted: i=1; AKwUvBx/18hOQ58EQBQJoljcxvM5Dmr15nIfDqCbtqMBKYgryaY268RY6BpSKNul3l5VfhAEZJ4uCdIVHtfNmbgaXfbKwFU=@vger.kernel.org
X-Gm-Message-State: AFuF++muQTOhcUfc9XNBDq9csf7hDLH00wyGjXoXd+IAbt0+KxZss0uY
	WIBx6QuZm6g1/pLMxfL2zRxaqx5AmqRK4hwOZFQ+iOgnXXHRqhLBvScCcLCCvMD9AhzdVaWBckz
	cNQTY297gg7c+lURo0dxliA==
X-Received: from wmdp1.prod.google.com ([2002:a05:600c:5c1:b0:49d:f3f:1e8b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b5b:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fe66f17damr45644795e9.10.1790261925621;
 Thu, 24 Sep 2026 07:58:45 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:53 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-20-vdonnefort@google.com>
Subject: [PATCH v7 19/20] Documentation: tracing/remotes: Add detailed tracefs layout
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
2.56.0.rc1.310.g51773c2048-goog

