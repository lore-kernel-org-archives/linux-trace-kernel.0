Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6D3446A5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513420; cv=none; b=SXbpRnHgvR2CCI3IaFf0cLAFYiSGtLDubyH5j65p5zwCU6UqbmkiA36uQ0K8P1iTrt+jurqvLCLOiR+vyPPpqOc49QKPTZiuYIrEdK6NL/+iB675nmF0fF2VYzCFXkYC4SvcPtyK89zk+bnJyQBiSbP7kEQ8/Z5Q1zjrctwg0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513420; c=relaxed/simple;
	bh=I+pJGIs0Epojic7l7vjIxFwm13eg3s/jxJWStIzBqmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJEW9rL8hPunsI1SSo+ZQXkkl1XG/5EbONW5Z+IcCUjICBVy7ZqyY+Vm4pR5CEgACFF+p3o4el3ErjIVBeIi7KBMFUXlaKvvl6SCov8wo5Yv844eIe01IOLa8TPJaf3tBK7mtfa2cCaQGGMpymnp1Fy9hzJLoWZ5T7zYORJn/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N95R+zz2; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N95R+zz2"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8fa71b83a0so112584366b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513418; x=1772118218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPhLrsaL6GHqnFz8k7XCh7wMYB+F4ptERk94umByGuM=;
        b=N95R+zz2YdPXGKFcOXK6XGyaZrPBiHzCxG4lndIxtpceyuvZWCNqy5Ku5KUi7sg5ZQ
         SqqAn8XvZ18RprFQN/qj37iAc1xY/Cn/EccKn/NCFlVmI5JuhSj+HRkCV2RY1wcX8rG0
         +JdgBU/KBkKRXkTLDLTzEjWYSjfP308SC4QccW6yOJ6KFxEQBMedoVxF+0AN2IO40+0t
         IvOR2COgiwMvAySYx6970gSs2CYYlocGc2qPCOnOV4j29WjLfbFWPcA5O775LffbRru7
         5rWFq13d/+fQvvi5nSFOyUKc2PEB11qruJnka66X81sDMtKfVxEIiCvBPJxRir6jQi3Z
         3Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513418; x=1772118218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPhLrsaL6GHqnFz8k7XCh7wMYB+F4ptERk94umByGuM=;
        b=XlHG6EcMR1/nWh1zCPfD65UknOyXZqLtGsaFbYfubx/nPIOOFv8clTAuSqIXJ5jKT3
         0XzxwwI4upK69C/1qgMPcCOXpeg6F0rtEz/eL/Z/G7ve+yGvQcRtFfZXx1PvuYuo8tAW
         81s2Vrpt7H+6gxsRH62fErLKmHKcjxegZ85T3KvhkKIf9tcjoxmNi+BXOQUb7waoWEIA
         1bGg6+fFK5GcDnFnxEc6hWdwQqHuIepzh3OaiXqoeTZJyYC8eoWgwN8ekrsVA/gtluzV
         XFc1Q5ZB/o+McJAg79pe0pvNr3G4SouS1Zox65umGKGMdAhLws5eJpOdDxjAO908mHmV
         KELw==
X-Forwarded-Encrypted: i=1; AJvYcCWPeNrUSd+7lLdM3E6iYLBN5LGJAsuvJkxlMiRaSvuPZaj/AS27jk9tQWfrDKhSba8+TVpw8LT11CsMdDFMK2udAi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbEEPa5761bLQPRC7gnkMx1Kk1j+4iOhoumbuMBCsjJ+qx18X
	SGt6oDsVnhpxpl3yCpqnlLJS6XNy8g70OvOwk6JrZHVFJJw76MLLtE9nLQl2ANLYNWeIsS/CUgy
	MTyx3qL+mY/Zu2jnu+WnXHw==
X-Received: from ejcyl14.prod.google.com ([2002:a17:907:bc8e:b0:b8f:943e:13b9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c82:b0:b88:16dd:d835 with SMTP id a640c23a62f3a-b903da49047mr298923766b.1.1771513417420;
 Thu, 19 Feb 2026 07:03:37 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:53 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-17-vdonnefort@google.com>
Subject: [PATCH v12 16/30] Documentation: tracing: Add tracing remotes
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
2.53.0.335.g19a08e0c02-goog

