Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9F3FF1C5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677597; cv=none; b=npUG1AHEY+o48qp3+y0NVgwOgV/RZwt+VXYTARbLJ/xBK3InyJMoKEibSrEHYPQBQwJXwDSm5NwD0LMFtiN3IjL6DKPanJBg+T6fluKXvh3FhsS2VbBdzs1+AsY23vnzizuHfT/TA9C0t3trRGE9DAKDOFajrC32usUnovieoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677597; c=relaxed/simple;
	bh=nRphCOol+8aqjQmX1Ai0zv4BKUW/PgygdzvU3jVmHDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsmvrIjXucZb3/bThlB9qyjX2/zxhUV+LJZo8Kjz+Tkv18UB6SyzRkDMWUCaBfXg3bw0uICeTuqnPeYlXGxOxPxD9zPuMeYaTbASTSgX8BB6afSMVQGfcIIA6hs77YFd4/pVSWGromqJGTS5M0pLR/OvtV981VJCEmMjdW8KSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLUiK5yK; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLUiK5yK"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bee286c166fso17811966b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677594; x=1781282394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cd+ljwylV4rrTqeXfsprSsciwKe168csKaaa/kzWDE=;
        b=eLUiK5yKrFQiInrSpqj3HL19NmRnvlb34O+nIjDCPB5fWPktJczIaYHjDnt32+y/X9
         E10R3goyE1u4TMDvdpnPmkOr2d/qN7db76UI5uBBFTpoCUQFJ8AValu+lkMWuxSpJ5t0
         vN8I9lfamnEfUn69IbhSAbrffWNqiupUBQsR1HM/NomsLUBNCIsmiTEPaSQ/E+S/Xih6
         lTAFxK+a/0WlTC9kdY8zs6lWJQVeYiWgPvJVIaGj5nsecUmazwY5G+VQHDTeFhp4LESN
         aE4f+0u3esKHSbTkT/sG/ZPolB7eM8yKylUR4iIGlcyd5+AQL/BQ9sLkxhIDygrN++Sm
         Fe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677594; x=1781282394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cd+ljwylV4rrTqeXfsprSsciwKe168csKaaa/kzWDE=;
        b=AXvOIj5hEqoZK+0+fLbXagiKk34mOUpk0FCkiSYMvhHtmcaqSvbk2J5d7G7Z3/uRQc
         V7I3sh0T6Ii+WHAjdkTnYdisoHb70DXZQZL0K4WupfHXt+JXqHHHuoi1rGc3m+OOIPph
         aZoBp6lqFY9VZzp0NQZNzYddgTP9SrFumgjLt2IMtgZK5hpEo5nGZhGRW4vZsm0q8XiB
         wPAsWVhr+eMQby1bcDt4047Vi6ZkKSGKOI/49Mx7d1Uec15UXW6uclCkL+nkhx2TfsAj
         wfsjHaJDV6X0aMnaGwXmF0iQOVD83aYbnZMshFrAsN1xKZ3/NF02MmUp64xvGcS7KIYQ
         +/9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Zun+3lHp2W1qpaJYmZ3NJ/Zle3NolMLpU1fNswY6q38DtddjJ0QhkqP+IAm8QTe7Y+eWATa6ugoOkJ2rFd5zejAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxega52WEeC+LnjLfEsoqb2BtM9EaUkqBtYrzHctCbS9A8CSke8
	HWN1p2RxjlMkSIYNC28SMEJ3xqSFZEP5AvqjfIz1zi3I00/qbHG26TTp9TJmCcDrZH8wpyXeQr0
	25IkOcC7BEsLQRFuLnflR0Q==
X-Received: from ejckw11.prod.google.com ([2002:a17:907:770b:b0:bc1:7da0:1d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:971b:b0:bee:b5f2:6385 with SMTP id a640c23a62f3a-bf37076fe79mr236553866b.11.1780677593324;
 Fri, 05 Jun 2026 09:39:53 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:24 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-18-vdonnefort@google.com>
Subject: [PATCH v2 17/18] Documentation: tracing/remotes: Add detailed tracefs layout
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
2.54.0.1032.g2f8565e1d1-goog

