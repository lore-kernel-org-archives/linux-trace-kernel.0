Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA21313284
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668212; cv=none; b=d4TCwh48GaQSKvoWkpAnKx45vm65uz8l09nQymoiRxXf9jMVUfuOY6iHv0VK5mMeCqxlS/GtBAJusTMQO5FFbZSyM2y3jYyBG6FKU7invdWn4TKZAeNzYrypR1vdYsnwPlcNPYvflSp3jhYbscSwJLONe6jBemFogl5BhYzCAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668212; c=relaxed/simple;
	bh=6F+v6J+CWN//r6wGF64D0I/BsKCCCENIMewP2BSYDLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ix4+EqCXsPBWtd6gs3k/PfUKdiqZQNTI7QdMN0nfxR+7Ha+FD/pGHnf8Jny9IZnkf5hPWY75ja8ziZQPGdLOiWKGtZocbXoqPFWJGjX00MInVipF1QVngD5kD4c1I66smjKos9m4cVLaPuNXqnyoXG8Ad5I77C+2jvEJ/2/xtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdWqjEbb; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdWqjEbb"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b771bfe9802so173320166b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668207; x=1765273007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1k9lnCa35g0aTUreNVQa2rVX+IRvV+YbWj70G3JIso4=;
        b=FdWqjEbbttq9XDRoWaZEkGWCgUdk2+7AQ8G1jVz9OxDrlHaYxU1S6XiUUu9J1ioDl+
         AGusPGhpE+9xm292+qvcuTYUKwyw7kvY7TS4PbZL9ZhdoNMgUr8AsqP1RRvOg0xhHf5y
         /l0goyhdNwSC2JSeJvHRBiwRAvp+ZNab3CB+ygz5L8VlHvDBK8wGpD6HVoZDlhUEYoAy
         BWUDK/H3Pzr3YBI19jgMQ49qhdaS4DcToXfpS+2S8V9jgkEoO3FJV1rKbGsdifEFH+W2
         iMD+GUL6qekFWKIbEHO5J0MOP+IuhmcQuOB77162SFP5dfMnPq97kwlTF000TswSA1JD
         Kwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668207; x=1765273007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k9lnCa35g0aTUreNVQa2rVX+IRvV+YbWj70G3JIso4=;
        b=WVKKo/GBi9hk/KcxNuNHhJcNmgQeShF8L1Nbui/JrpsoBXiDRGI7DerTXBcoJgSeUJ
         rHv3LIpQ4NTkUCr4D1snf76xNf/yzOyH0DECe0cHF5T0ouB+fpe/g2p90KiuEQPFTeDd
         kbH5n71Hv4h9XgZ9xu9LmBoxDJ+rNmCEb5yXccsDxRXgBYjnGbGCT7hqzk1TbdL7Sidr
         3Ri+JXnPVYPRhN4qe7ooGa2w0yfER7UJyLERhyFXu92JKbRW8vQx/9lJBgp/qfyEAtPq
         aNHxBbdc3MOo6ca303+ont9XGBdalZEyS+ARxSc31sEt64pCDL0qeyFkkN8DFBulUs0M
         eyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT3HzLhB0GFcmhx6PUH8IV9qvmPIZajDUOtad2FlKo32RzKL1cqcdO/uEMMtlVEGaWwxdLenl9AV2PEi1AXZodosg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKFQyUIOeA63HxMbWqaKEHxDv8cgFbTtSPk2WjySRiKkvFEIt
	HAGJAmgeLH20R15Z0xvfLm94npeMxiDv6+kOV27A22PGt93MJhbBX3FvlhYFNt13Skqi4Hxj+Eu
	cX5hgHBBd4nmEE9GeCaXLYA==
X-Google-Smtp-Source: AGHT+IH6ccFpR0WrW+/F3kealA6pNGmuZbYCFARi/n7zyIqU+hpmNdIgKjNmor9NcQZqnGFg0KMHEyXXFtwtLCUK
X-Received: from ejcse13.prod.google.com ([2002:a17:907:a38d:b0:b73:580c:b277])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:eec2:b0:b76:69d6:f9fe with SMTP id a640c23a62f3a-b76c566bfaemr3010632366b.60.1764668207371;
 Tue, 02 Dec 2025 01:36:47 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:09 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-17-vdonnefort@google.com>
Subject: [PATCH v9 16/30] Documentation: tracing: Add tracing remotes
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
2.52.0.107.ga0afd4fd5b-goog

