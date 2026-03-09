Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5D3ED12D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073580; cv=none; b=C+GaCTcppeeUwWpDIDuYOSdeNd3ye7ab8/9WC/uM9BcnZVZddVZvoPIC26GCCUPVCnlePAT7ULCdAEGgjAKl+v2FXCtu8KAVxTdx5dQhh74DW+qr3+NU78LQLy2q4NlnT4FO6oPMkKKLPtZK0CjvOSp5MhaOy3A2L2TeGy9rkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073580; c=relaxed/simple;
	bh=7bMiRK0ShivdAJEqAqq8p+bSixyyMffBJzLzrorCG00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sh1b6nsVHgnS3cNU3H0SkYw7F2ok9uuTmOJJTNj/V58xW0Xh5lCajiT8vyj3tSD+u2ybLT0Oe8SoQHvYDP0dHyL51RPC+tI1+r53jh4cSA7uUISkW2eHg3xXYx0lNdierG+vK1CC9xAGnm+qeLPwRwnKAPLcna5joTNoDcE0aoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdenp2Mi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdenp2Mi"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso6725375e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073576; x=1773678376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6OW0CQFlfUo8gIs8zWJuy/R7hSbmdzTUEKNvWrAy54=;
        b=rdenp2Mi2F9tuDr3+sujTkP1myqg1QviDs4jR/S67Py1Ip5Fm+FZJL/KinuprOr7Gq
         w1nglGl4zXdSP8rdTPipo4NavbMyuSagIZjWHw1eTlLNuN6go/ahSS9DVfvznlbZGFEu
         bK9FBwyYjLbKIRdOSBiRFdCKT3v6EDPIBckigV9DobdFPfembcgzpZtf0ccDD+ha+zfG
         eEcZnYwG0f/Or8JZiZ5aMyrlqPU+YoWyIomp4oel3P9ubO/NtICwJwVx8M16gz5SUA5q
         L2Pz0ADrihUMksPugl3hKZgADaWJUwB64GuBizkWPGGMM85BNQz5x7FreXiU00h8o+kA
         tCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073576; x=1773678376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6OW0CQFlfUo8gIs8zWJuy/R7hSbmdzTUEKNvWrAy54=;
        b=Qicmxhx1jnunJ5xzA7wkNYCSfEM6XzVio+Efl+Q8AFDZENtW5an5Oe8X0H52ik4glF
         RGdrJXPSKSTRIjvfKEuy6pssPNyqmS7yMyv3Zr6hgynXYjVYejSE+QsaxIVpPNQx5fQ6
         TIy5fHiBHT4PcVOCi5fUNndArD5pQ6Srl0BtS906N3x2FtPkv1N2RmN51DvL+jLQPV6i
         ziDnVphkJHGV2Oj3O94ZDiQZKVwjA/Meil/EIm9MwQ75eHmrdpqIhtWxFfn4gPfHWyma
         MBEhcRhzpOgYLkyEjgyE9LWgBJT2iM017UwLHiBKeZKUCP9Gto5a8Qy9aV/3+xeIUKHj
         bd0A==
X-Forwarded-Encrypted: i=1; AJvYcCWKqbzQBhgo/j85Q4vmQdpQexosW7tftTiXWuzgJXG2fFXlz3mp3GMaY93aMl4k1lqvVMNcmfXVIAnjmOBYGNzLTAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlhJOiagyi/fhyzklTFRt7SXBs7MNTO2ZSEgaJ8fMFMPS6q3e
	5r91FBc40D/98+xxcSrd+X7VHRzB3gVEu74o2aO5qbLxXvvzqxT8ervdViL3WNcL/evcbfBlsQB
	h9GQY1eDXehsDSids8QEy9w==
X-Received: from wmmr21.prod.google.com ([2002:a05:600c:4255:b0:485:35d3:c8b9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id 5b1f17b1804b1-48541369c0cmr13223965e9.22.1773073576611;
 Mon, 09 Mar 2026 09:26:16 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:25:02 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-17-vdonnefort@google.com>
Subject: [PATCH v14 16/30] Documentation: tracing: Add tracing remotes
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

