Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AF6A8BF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474145; cv=none; b=LnMk63EZutu3dQmjb5sf8uaZkiUhqY6QHOiS0aTPSmsQTmDGvUw/OC0UmeeEJzMV+pI2S6/U48wEUVGC5N6FcAarE/y+LwH9lueLEAGkRX4vUgfCUx1an7KlK8WOjhAbnip5mvP0EfRsKfOtROgHWn+bC6xlVvtbv8FZppx/y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474145; c=relaxed/simple;
	bh=iPiTM2h7tTVjI8Bap8UHkeVYN1GEEKgHI982louZIPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hg2XmOm5G1eAj6/XRfgemh6Vf+486gDqklapMfFuI7Cfi2ZyTN1T4J4FJht6qNnfqOCmKMfbeYhK9knsBT8c8VxTPY3Jj1a19C341hO0dlLO2yVXn78fi9ydFdMb8O98MST7ag132tlcPl/MzSKIA/lhbMc4A1g4xihSM6a39f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBWat87h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBWat87h"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ad18981eso18249217b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707474143; x=1708078943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgkRDZd+PHk3bo7bl2fMfaI4+BE0z0Hk4GDGmCozprQ=;
        b=tBWat87hkNnH5xslKZXl0zV+dOOXPYB3JLZcZlutDQ2hCgQWBAjt5k6a8IvVL/PNmv
         1tF5owEVNy0DVEVUFM9prOp5ZPWC2CYMdydy04bKfdg/rGSJEbnuaE+zXYAL/FkUjdSl
         C3LSNIFP9I+idO6O8bDG02JunEtfLCTtNKlE7bWS8aFgTMd45RjgWN4TLNHVoQ0j4QI4
         fXAp9g75pCI4vgEH+9k6RF+zsPdZ0wEaqD4ZivrcaW9LqAMZvKw6eJUDgJd9Bwl0oQXg
         5ii4feaV8B7gZ8VyrGJ2UqsNtJdAhuM9WBAB9KhzPnCPGGH6MlCcXqH2Pr0PX3HvHXZP
         iFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474143; x=1708078943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgkRDZd+PHk3bo7bl2fMfaI4+BE0z0Hk4GDGmCozprQ=;
        b=m5JjsqXG96D6XZ00vUERIgLeOVi9pDbfFh37HBKBOfkC17cYp8YX+iKeXJKiIiSjlM
         Ghv116XNGg34Gl2zIOIZFh6IWn/9QKdMUD1P3woa6GTo0yOlXrOfM6K2nxX07DSutLvL
         jKico7i8DwTmHcX/WdosU2kS+wwe4rEjS3WIj+J3XDuPWtfhpj9pqiMf8tsftdeiBPYl
         70GUOEUinaBIGBq+KK/d40b/YKDEZGYHql7832FjWzKGrJhEGs3VrVH6C0iESKmGHF65
         B/MwPcsINb73d8NTvsTY7WJmPTt9YziIdfdHfcT0x8FiRKaAjgWcilU8fq6CsElDcYHH
         H/zw==
X-Gm-Message-State: AOJu0YxjDMGZWj6/Q4aw8tyt5oLZTGqkLKJPLZiNsZsLhegMVQV9rF3n
	oMLKSqwALgO+odg7Bdy7L7RGShMmxrpRUwxQtdesBqULOCpDxdhxFX9LD2wUdzYQiH8Lo/JJgpA
	TkA7M8gYHjT+Wzr4XSw==
X-Google-Smtp-Source: AGHT+IGMS/FEXVJSaP5ycPnLKBn0cDzbJwah//e10Y95e1xJ+MuEsR37x1mSyHmJmnid1bxct4QemhKZc9MzLa1Q
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:3687:b0:604:9cad:8c36 with
 SMTP id fu7-20020a05690c368700b006049cad8c36mr275510ywb.4.1707474143306; Fri,
 09 Feb 2024 02:22:23 -0800 (PST)
Date: Fri,  9 Feb 2024 10:22:01 +0000
In-Reply-To: <20240209102202.649049-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209102202.649049-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209102202.649049-6-vdonnefort@google.com>
Subject: [PATCH v15 5/6] Documentation: tracing: Add ring-buffer mapping
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
2.43.0.687.g38aa6559b0-goog

