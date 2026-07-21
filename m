Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FB4B8DE9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630203; cv=none; b=rIHzCLeIdMFRJDZ5h2NwjtTL6NWoJC4lcAaylV8JAXgU5eUdIz0mteofbxjxnrrlcmrut7oZuWk6P61SXlkTmEXPfc+4/eX+hyxLGnzdggoqCF9lqL19acSt6Af5SYHsvEvPKAKv5RGemFGVSp4V0mAD6cmDt6dNzBl2rXu5Q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630203; c=relaxed/simple;
	bh=CCHqNFrfoKD9S3EhUlmwlsh16yuxS55DmnG3E5pBcR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJMTRHKfjMiia2y8F2KS3xgZTxiE/2NzxdvsVmudLNzMbCgczT7pF9fcOoh2NgX0vtxlBjr9vILTtMd7TQol84jyhX/P5RH7Sw29Jr3rL2vdN+VD7P6d2Howd79E7dCchVUGy/VAn4ogKmt06LZpLGg9Hq5TZUC1imRmOQ2V8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdENdLp7; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdENdLp7"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-476608a9fefso4533616f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630199; x=1785234999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMLl/a7gRFykORVWd8FeSzrxPvAhfDrK5t+wUDhmWz4=;
        b=LdENdLp7m/NO9CrC5Sc2CPL059wyI5JyftV/HR32DitRVU7vq/3zVKdpwUdt+W1PfH
         iv8OKG48hbuaZSTO0XNa7v0RSo9ijQcSqis7eUqmgmYsG0oSXukNt9tBAzMxK0qpg+Gr
         1N4+mmPTHjPt6LWzeAt5Xi8W9UaCDLiYGaAX7Yl/Nzo75KD1ani8oHmoCWQi9vd7BOSK
         nexB+dxphU7ZPR62BhX2Ri08d/SD0Ihf1kRt+dl9MmeeJj7mgXiQN/7pAIz2N7iJPILA
         dZrJvdJgbh3+7OPRjKYf0Nft5Dt+k1RjizT+pQk7JMDTswngYx2CIXvZQWd6z1e/RugS
         7+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630199; x=1785234999;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMLl/a7gRFykORVWd8FeSzrxPvAhfDrK5t+wUDhmWz4=;
        b=hHg+I88QTOC9Ldhya4y5ZdmOVw+amURg4Dfm4X2B/68s4kV094LNmxv8nfS4xMRWFI
         TdsubApGsRnCeu0cBxFmw+di9UT6Nc21yIDCLghoiHlc7moHRMbzvklEJRKARMYLfOC0
         W3oMF65zlFGLZdxy0IYm4Swxs8+Jz0dyDMu1gSFeAaGfd8Nzj8ryhesvWHHHI2WB9eHZ
         h5OjpNdJQEgdeEMxn20HRHlrNug4rD28SsIssUNDBY5EdV2vzgVTatKKbHCnt6IGYxSK
         iJdfbrCcjx0T5oD5LDhS6GYHHp1lQkVCUizV1xzjnen84oLk5kQLIMe9Jr3os2aR/GF0
         W0Sg==
X-Forwarded-Encrypted: i=1; AHgh+RorjeaOF1ic54ubnNm3WZXHTOjRt8c5zlkyP4YkNH7PcUxaVAxQcIuTjctuTVa1AlVQ+wtM3PAlHjkjDw8trQGlLaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K/KVzF78zypE0l4r2LTj223uhfec7GSk0lJC/D6KTD82lbtb
	vB9HiO9mtu3is+7LFzZRhlfRmKGYrfRl4T+JJ020wJJAtvM3mu2VkO9hfHNuwlFFtYcIxvOB1Pu
	hVeZKTIUagW4J9DhyweG5IQ==
X-Received: from wrtj6.prod.google.com ([2002:a5d:6046:0:b0:47f:6b80:dd8e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f91:0:b0:474:a0a3:df0c with SMTP id ffacd0b85a97d-47f623b5517mr21447270f8f.10.1784630199054;
 Tue, 21 Jul 2026 03:36:39 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:36:02 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-18-vdonnefort@google.com>
Subject: [PATCH v3 17/18] Documentation: tracing/remotes: Add detailed tracefs layout
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
2.55.0.229.g6434b31f56-goog

