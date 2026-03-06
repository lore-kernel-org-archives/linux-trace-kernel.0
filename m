Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F343B9614
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807773; cv=none; b=TDkVByHDKde5ouEMeaUdA/Pqr9r4JTRsiRK38CZPeCj73L4Rfft2Scg5gLEwzzCZoeq+WxFBEENFosnAAzG48kngNlsmRvWEkL7Kwiy4YqSEYwHf8FHmGH2xrtHtpCOdaMLUQOYz+ZxqqeH2h3EFH11cg44M/XSQQIS/av2gV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807773; c=relaxed/simple;
	bh=7bMiRK0ShivdAJEqAqq8p+bSixyyMffBJzLzrorCG00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrTXlVz+kb5DZoNd6SJt5TIjssR6JimcP00sqUREJPSIyRjT5aaS2NXCrDEIM0yf2y9ctA/K97cBffOD08L8LRHqv8A30c1jL2HWiSdZ6EdcYZT5vNE6FyhG6h6Vv7Fk/SDTbHeUMe4VxIPfuTmweahFj+6pjbH4qvR4AEh0Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTHWL3n5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTHWL3n5"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4830e7c6131so97093495e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807769; x=1773412569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6OW0CQFlfUo8gIs8zWJuy/R7hSbmdzTUEKNvWrAy54=;
        b=hTHWL3n5dqWaLK6E4Y0RAg2V2tS1MgAaNLnhGzERTe76vsBQGn8yx+6ZkMDi7e5so0
         aKtZSw7tK3zJ5uHYEFePTKZ5pdlB/yODX7otGJItggYU71+Ej6UCE8ROuYhGYAm1Uaqd
         34zwLwAVrLAoFIFIu7WmnRWIhOs9NCy5I/KZ3vQq13ZaPFQMoW28SsGBV0QTzyCQertN
         NEHuee4sUGJCPGAwz4grGKVr1AXfmsMpTytHXuAPnnBKopF/PLmwmFNaafIIDPYgAJKp
         kZxecYgiO0wGOvc2Wpih18EDsGnXAYCkByQTE3JDFcR6f1JYRSdYA/gzCpqBAfNWArCW
         KeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807769; x=1773412569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6OW0CQFlfUo8gIs8zWJuy/R7hSbmdzTUEKNvWrAy54=;
        b=l4+dHuoRYgfME1QxuSm/RWpLV78IB4AmVHP6G2OhLJQd6R7Ck63jRHaIBPxWEPcnwD
         iQ/yftdq7DB9x1yucjYItCfeDyJp2ucP7XS7PRtuQGkI6SX9zzGIt1Pj9fu1o3oM0pno
         88czJncZLQsOES6g6hwbOyEJYwXsWBaxlcxs1RtT3CHHHGXjSnSoxZTUI0uo6AVxHCRO
         QK6JGcdat3s7voJUtADcrrd2LrfcjZvO7NeoXcNLw0NeMI8OxI03SqEBoDbcnNzAb1j1
         WmNr7MQaGS0tkVzfNM09i138kym+nbzMHx9JzcqzfyXFXMwetsr8m5VhgTUaasX6NRJB
         oBdA==
X-Forwarded-Encrypted: i=1; AJvYcCViuoy8ID4uQHhYNuIwLUzb/+YBwcD5Fmraze6wrn3d7adwSzxxWJaFP7AhDxuazpOn9nO0Br/7QIIoV44dWHhdjY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkuakUdvuWtAAj43b/pTJL9IKcN0NEk7rd8Qtmkys57GHSEoL
	YO6p1Vj9xHxeYyGw0XyvdjFylirNLGUbdpDTMzzcqDXebJ5D9UFICnAcX5wNKWb68q4Kv2TxLUo
	6nUDwvOlMwRr7YKNIicWjew==
X-Received: from wmlu14.prod.google.com ([2002:a05:600c:210e:b0:480:6c6f:8c06])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4451:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-4852692427cmr37315825e9.10.1772807768794;
 Fri, 06 Mar 2026 06:36:08 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:20 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-17-vdonnefort@google.com>
Subject: [PATCH v13 16/32] Documentation: tracing: Add tracing remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation about the newly introduced tracing remotes framework.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 338bc4d7cfab..036db96864d2 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -91,6 +91,17 @@ interactions.
    user_events
    uprobetracer
 
+Remote Tracing
+--------------
+
+This section covers the framework to read compatible ring-buffers, written by
+entities outside of the kernel (most likely firmware or hypervisor)
+
+.. toctree::
+   :maxdepth: 1
+
+   remotes
+
 Additional Resources
 --------------------
 
diff --git a/Documentation/trace/remotes.rst b/Documentation/trace/remotes.rst
new file mode 100644
index 000000000000..1f9d764f69aa
--- /dev/null
+++ b/Documentation/trace/remotes.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Tracing Remotes
+===============
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+Firmware and hypervisors are black boxes to the kernel. Having a way to see what
+they are doing can be useful to debug both. This is where remote tracing buffers
+come in. A remote tracing buffer is a ring buffer executed by the firmware or
+hypervisor into memory that is memory mapped to the host kernel. This is similar
+to how user space memory maps the kernel ring buffer but in this case the kernel
+is acting like user space and the firmware or hypervisor is the "kernel" side.
+With a trace remote ring buffer, the firmware and hypervisor can record events
+for which the host kernel can see and expose to user space.
+
+Register a remote
+=================
+A remote must provide a set of callbacks `struct trace_remote_callbacks` whom
+description can be found below. Those callbacks allows Tracefs to enable and
+disable tracing and events, to load and unload a tracing buffer (a set of
+ring-buffers) and to swap a reader page with the head page, which enables
+consuming reading.
+
+.. kernel-doc:: include/linux/trace_remote.h
+
+Once registered, an instance will appear for this remote in the Tracefs
+directory **remotes/**. Buffers can then be read using the usual Tracefs files
+**trace_pipe** and **trace**.
+
+Declare a remote event
+======================
+Macros are provided to ease the declaration of remote events, in a similar
+fashion to in-kernel events. A declaration must provide an ID, a description of
+the event arguments and how to print the event:
+
+.. code-block:: c
+
+	REMOTE_EVENT(foo, EVENT_FOO_ID,
+		RE_STRUCT(
+			re_field(u64, bar)
+		),
+		RE_PRINTK("bar=%lld", __entry->bar)
+	);
+
+Then those events must be declared in a C file with the following:
+
+.. code-block:: c
+
+	#define REMOTE_EVENT_INCLUDE_FILE foo_events.h
+	#include <trace/define_remote_events.h>
+
+This will provide a `struct remote_event remote_event_foo` that can be given to
+`trace_remote_register`.
+
+Registered events appear in the remote directory under **events/**.
+
+Simple ring-buffer
+==================
+A simple implementation for a ring-buffer writer can be found in
+kernel/trace/simple_ring_buffer.c.
+
+.. kernel-doc:: include/linux/simple_ring_buffer.h
-- 
2.53.0.473.g4a7958ca14-goog

