Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F443358C9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424285; cv=none; b=G3eAObZWDYeB6FWHYSTValx5e1fvV/5jECK/YdWUDHdIp7qnuQo+Rbtkazfd1hLVOEkM+3OJHr4fW9q6nsyp7cPliMVyb/jnrCP/SYoDjVySddHiTFob1xID1AdoUjBmLIRHU6fGLVfW3VDwcFgX7TOHh46HV2et8HN9/hGFYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424285; c=relaxed/simple;
	bh=EpZK/BzfjQaUyxEz514oZ/jLm3vGGjz0nMsmnHSNIkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDi6Tz7QwimLujTrg8t1PjS+LcB/e48xZqeMeyw/QErHuYa97ZMVOda2WvxRkjg3Wkqu9vvGhQA4338ZlfpDcCfVYVFQ1ND9zE8MrmiblxrKNcDR7sbFur0PSdycPVrWWZQFw+kxlaFQYVwgkamr9/ZD7nQTjo0+sxRW3PaMDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxiOrG7p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxiOrG7p"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee432070aso39429515e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424280; x=1770029080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUro18mbSKiw5/VA7IRp/lLCcUE0ruHzOjVvSoVnLbM=;
        b=qxiOrG7pmM3te3gdYuIrFXZVC9l+HVAlrVLqdD7RY8KfuTWvt9++PATdu++iQ4nGr2
         i1joQtz+QewOr1UUoSlavxrmfGxQramxsHvP55oiHhaY4yP94k79e6/8yTX+U41TJvoA
         Ea1A5YtfQH2++p09TbLU+POHOMwR5Fbq07v0GXpJXixN+zkLEbRiTQnQiR5+qu4xdahn
         mKb57P9CqPtBsMDUwxBLqa9E2NjRy3/Y3jrhmwPrJPcj3sXfLToSTkT/Gf8nyB9J2Umg
         XniXL+GLaz+8cIiISWk/kM2fp1Se8sPYqMd3qxMBoYN/iPXEJfv6140cd+BHnXrrok76
         ZeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424280; x=1770029080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUro18mbSKiw5/VA7IRp/lLCcUE0ruHzOjVvSoVnLbM=;
        b=mWzpp9ngYJ6+vggUOwQ40rps1A34uki3Z5gccer/FIX1dE1yR8n96VG5dBk1XunwhF
         vk/R4LZOTzzctU10M0Nw2nZ/8MMOyMH7P6qlwxaBroBtdMQYvMJhf9TCc952tSguB/GC
         I0O5j3+ntX8C4+Mz184C6gBdPgOcTFi6qa9wl9yCR5Ltj/KLuZGI2HRtCnpXU4nzFZqx
         Fw0AS4mFj7g7hB5OoL69A8z4ey/akVl5woyJinbHIcb+0SyMmU89b+O/3P3VB7sLel4p
         8xUHXgLHzMSx5p8DEp26bSyp7q3b+rcYL+BX1J8L0CHi+PmHnvfRfMG6rx4aDbQHdd7s
         WntQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTLS+5l09pLMnMYEDejm5j6mim0d8Nshs0GMUZc4jKmpfuCivRWif0z2/ePT4RgAAq3CmF6epoC+r5RtoyUCHOLZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/H46p+hor846lkCp/SxFGZ4oEmmubZj5WRw0m2uzbJeF5JOua
	RFFw+NVh9cl+QFgatzz+Ne5U2FheamsW/+1szmIZQQJbw9yJc16lZkgf0Ptl3YFo15tMZWIt2ke
	23XdVvZPwDP+SVMyCv+0ZWQ==
X-Received: from wmom18.prod.google.com ([2002:a05:600c:4612:b0:480:4a03:7b80])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c7:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-4805cf5ec2cmr63608005e9.22.1769424280511;
 Mon, 26 Jan 2026 02:44:40 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:05 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-17-vdonnefort@google.com>
Subject: [PATCH v10 16/30] Documentation: tracing: Add tracing remotes
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b4a429dc4f7a..d77ffb7e2d08 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -90,6 +90,17 @@ interactions.
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
index 000000000000..e7fb3ee96c30
--- /dev/null
+++ b/Documentation/trace/remotes.rst
@@ -0,0 +1,59 @@
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
+A trace remote relies on ring-buffer remotes to read and control compatible
+tracing buffers, written by entity such as firmware or hypervisor.
+
+Once registered, a tracefs instance will appear for this remote in the Tracefs
+directory **remotes/**. This remote can be read and controlled using the same
+files as regular Tracefs instances such as **trace_pipe**, **tracing_on** or
+**trace**.
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
+Simple ring-buffer
+==================
+A simple implementation for a ring-buffer writer can be found in
+kernel/trace/simple_ring_buffer.c.
+
+.. kernel-doc:: include/linux/simple_ring_buffer.h
-- 
2.52.0.457.g6b5491de43-goog

