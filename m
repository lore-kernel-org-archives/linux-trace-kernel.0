Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45C12BF15
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538505; cv=none; b=fo56UhXQETVM1cVQzxtT3Turu9htmaCuAuqxWMnCeTJ12PASMIKcx2T0MhZpbeWQpOGQ+8P1Fyv64aKgjmbbi+4XfVwWImXly4LWBa1ns4uWD34fCCfDsNrzf5ZhJwZhOx6jNki1BEuKvVcOItyFaBeiwrLGxY8Y5iwVh4qNeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538505; c=relaxed/simple;
	bh=YblHfJ3M/JrJf9iYDXRUo2YdNQnwLH+/GIs3bb4ORz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hv2m9k6nfKlPMq2Bbf3920enRbWscG3AL/a8Df1Q3tPDJwINzXVEv3voLcYRIwih/rBYAzOQxwMnw07zgbqfpA7pT8OtJVEMySczpXV6qyLJmhMplpZql/DTq1P0WH0pJjP13XkmliRh4+V3QUP4Pz4WhWwkZVeWisSKR+gXY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lm6NGiP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lm6NGiP"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e5f548313so24769425e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538502; x=1707143302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjOgbZd7O2uNB62/0XeQH/S8Gkl55RM7l7WUxXBvFwY=;
        b=2lm6NGiPCM13+AFsH9VVJF5xhx8d0cEVTjEQAI5riITQsb/NhpeGsaDX4JP3em1V5W
         KuSb3Z80jfIF1UOoL5r5Xl/hYspJlZB7d9Iq43nZMpWs9suCogWkkeyMHmaxozF4rC9F
         ZcpMHIts/CWMkf1Ed9mO2GeCbr7WgQjK4J9UUcYeoddnTzUiI3EseRLuQg7a4cUwlxsp
         0y5/ujrJqBoZfXc806GuRwXg9JLzxFf4M7Kr9tBzJ4znw1BtdRV3+vdwstunamo4OwMd
         P1nQy38vQcUBh/mgfoWB7lkV+c+lVJk/kTV8r+W5ZCoZ3dfryElGlx3lLc+vBzBWTeVN
         b3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538502; x=1707143302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjOgbZd7O2uNB62/0XeQH/S8Gkl55RM7l7WUxXBvFwY=;
        b=Pxx/oOJ37xHlAFfu1eAMs8JHCjGO2vuqQeercK1ixsiY3jFRuVLMmU1qSL3vBq4KL9
         RTYlrlVofAx9ehDC8EC3Yo8/kqFOylpbkGUUSuYgmSZL4DCaBsh/3JkJUcQTuv7exw0D
         ArxyMiHzK0h1Ssdvqr05bFC9kRg7ZpYBDloqIxyjcnSrmcSNWr+Ve+BQ1emBl9Kjaiyt
         1wV3OIhZ3rwnJsB0SshCZ8VTSyTPBAi3MSa+Vc6jDMmZz+CEIxiTNE2NT+Kbf0l05C38
         b5HsP2xivyrsZjq98izDgW60rM0XGmkDsetM1Mls6ZJL+T26FHU6F9j8m3OxknwMp5DW
         V/0A==
X-Gm-Message-State: AOJu0YwQjB9MQm9I6FtRc171aissi7TiO1TTdQLaSSXGAAMh+XuVTPLX
	1j4fQMFxWcF1ALq3Hz4Ovfka5QH2om/sl7ORI57Je4v0cknWIXSPUd0Tl4fLOCeZ1MUSp3Pg5kZ
	+n+9F+2Zk+twWIjK98A==
X-Google-Smtp-Source: AGHT+IGt5kmwQnjlcwjJQrN6BwzRxHTZ56mdRpquTuZas1fv6cw9q59q8AGqGw9UdLm/FBc0k5uTfl9zGj28OWNo
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3d10:b0:40e:e994:eb79 with
 SMTP id bh16-20020a05600c3d1000b0040ee994eb79mr26477wmb.0.1706538501926; Mon,
 29 Jan 2024 06:28:21 -0800 (PST)
Date: Mon, 29 Jan 2024 14:28:01 +0000
In-Reply-To: <20240129142802.2145305-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129142802.2145305-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-6-vdonnefort@google.com>
Subject: [PATCH v13 5/6] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

It is now possible to mmap() a ring-buffer to stream its content. Add
some documentation and a code example.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5092d6c13af5..0b300901fd75 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -29,6 +29,7 @@ Linux Tracing Technologies
    timerlat-tracer
    intel_th
    ring-buffer-design
+   ring-buffer-map
    stm
    sys-t
    coresight/index
diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
new file mode 100644
index 000000000000..628254e63830
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Tracefs ring-buffer memory mapping
+==================================
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+Tracefs ring-buffer memory map provides an efficient method to stream data
+as no memory copy is necessary. The application mapping the ring-buffer becomes
+then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
+
+Memory mapping setup
+====================
+The mapping works with a mmap() of the trace_pipe_raw interface.
+
+The first system page of the mapping contains ring-buffer statistics and
+description. It is referred as the meta-page. One of the most important field of
+the meta-page is the reader. It contains the sub-buffer ID which can be safely
+read by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the sub-buffers, ordered by ascendant ID. It is
+therefore effortless to know where the reader starts in the mapping:
+
+.. code-block:: c
+
+        reader_id = meta->reader->id;
+        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
+
+When the application is done with the current reader, it can get a new one using
+the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
+the meta-page fields.
+
+Limitations
+===========
+When a mapping is in place on a Tracefs ring-buffer, it is not possible to
+either resize it (either by increasing the entire size of the ring-buffer or
+each subbuf). It is also not possible to use snapshot or splice.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable.
+
+Example
+=======
+
+.. code-block:: c
+
+        #include <fcntl.h>
+        #include <stdio.h>
+        #include <stdlib.h>
+        #include <unistd.h>
+
+        #include <linux/trace_mmap.h>
+
+        #include <sys/mman.h>
+        #include <sys/ioctl.h>
+
+        #define TRACE_PIPE_RAW "/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw"
+
+        int main(void)
+        {
+                int page_size = getpagesize(), fd, reader_id;
+                unsigned long meta_len, data_len;
+                struct trace_buffer_meta *meta;
+                void *map, *reader, *data;
+
+                fd = open(TRACE_PIPE_RAW, O_RDONLY | O_NONBLOCK);
+                if (fd < 0)
+                        exit(EXIT_FAILURE);
+
+                map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+                if (map == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                meta = (struct trace_buffer_meta *)map;
+                meta_len = meta->meta_page_size;
+
+                printf("entries:        %llu\n", meta->entries);
+                printf("overrun:        %llu\n", meta->overrun);
+                printf("read:           %llu\n", meta->read);
+                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
+
+                data_len = meta->subbuf_size * meta->nr_subbufs;
+                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
+                if (data == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
+                        exit(EXIT_FAILURE);
+
+                reader_id = meta->reader.id;
+                reader = data + meta->subbuf_size * reader_id;
+
+                printf("Current reader address: %p\n", reader);
+
+                munmap(data, data_len);
+                munmap(meta, meta_len);
+                close (fd);
+
+                return 0;
+        }
-- 
2.43.0.429.g432eaa2c6b-goog

