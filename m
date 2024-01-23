Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BA5D72F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008096; cv=none; b=Nntgs5JNs3OOtqGr6YLRCqhqlmrFqvWVw3edgSo/ei+lSuM7RkdjeQNRKbgO4sKKBfObpraWncbSQB5j+ENAXU4e67gCAURdA0mSq4+aRP8OFIzolS23werpJt7TUZZRk38OmyfSj6Cr9waSt6bUvcwuYFjwnWjzGtwZGAnkemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008096; c=relaxed/simple;
	bh=2ydE7p4I+jn1AqXuKc/xAoa8ZK8YfR3uygNBDatj3o4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cmwH4qjEXicTLqehB+aqRTcIEIF0dgeHW0bsVt98Agfaiz3INxmrweDu9J8gdcg4u2FjUv5XLCiLQ7spyqrQnZOH40PMlbLo4Y6nf4f7aI6iF7JjaiOflX29Sgwj/8Fe39ufX/4H3nvFqq8GbDR7+7TYRoybbDq+y6p5Bnbxe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDtJL47Z; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDtJL47Z"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33926c83a2cso1916129f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008093; x=1706612893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7oPXmEt7YsbEzKepN7rYv6YN542PMGBpLDCQVs56QI=;
        b=eDtJL47Z++DAwOfHG1DGRJOoXqG7PzQBIMI8F89Xp6bYqUNkogJ6JuNouzMXS41h+s
         oDoGX0CziDo+iE8w+TaWUs6smSuwSJueJbcLfai6tJUJtLvJbkxcfbS/Jg4vWDZCsSKi
         I13ZrZT3xXnQGRrmuDYySQfhQWX45ayitTMvUDXLQ4zvozTFrretALDq//EmInF3WFR5
         RdGURbixEtoc8AzLz7JvBl52bB2pnR7LD8ELiOcZgynLgWVcGcBr/magEnVxk4XkV658
         17fdV65mZ4LUfc6cnEbo4rINAD5fGtWff1lKKapH9S+mrj0NcUd8okcOZuwXlCT4mGh3
         C8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008093; x=1706612893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7oPXmEt7YsbEzKepN7rYv6YN542PMGBpLDCQVs56QI=;
        b=hc+SV3lLHQ4/VRGlxdK2CxLdex8tvN6V/+mRyqrcllRqBXzIY5wq3aRIH/dO8CCq3L
         vjblnBwIxmddYvCWWrX/ABMWMMlk0VuN0NFnRko1Ja8cDJCF8nIebWnCEKY+17Y+iP/U
         S5AnUJcJ25VV4k/dh2GqIW1gjMldirvdcdJN12RHz4XMcezFJ3Q54o3fr5z5WMVViqnb
         ECCaVVp3LutI9JV1BlZqVkyCSiCW6xLEqtLnZW3z0p4U5P5aVX4TL4tuRW0ynothN/Wo
         WG4DsJvrR7SfhP5cuM7NszMoAa3qNa76HDY4UdZui7SHwQy1N7+u5R9J0olucktPGZx4
         BvzA==
X-Gm-Message-State: AOJu0YyI4JMfUpq4GL+8uq21GK25lZG+Yr1SUI6AZq+h1hAJCgyuytbA
	xOfLJEPavlCAlTWkluk6rymwsJmfTRYYUgtujysbh3KP7aFpmHim7hoHk9MIoz9y805j4Hteyy1
	+Xl47ks3bdm5AmiY76w==
X-Google-Smtp-Source: AGHT+IHEJGbZrETgw559I9/W3u+W2YGFU+Oe4jSe7q7hW4mNL2TMFi4oaAiUTwtfI2L+rZVdaj4sAlJfb2Z/KvN4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:71a:b0:339:22b6:b56f with SMTP
 id bs26-20020a056000071a00b0033922b6b56fmr23400wrb.0.1706008092731; Tue, 23
 Jan 2024 03:08:12 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:56 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-6-vdonnefort@google.com>
Subject: [PATCH v12 5/6] Documentation: tracing: Add ring-buffer mapping
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
index 000000000000..7d7513180893
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,106 @@
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
+the meta-page is the reader. It contains the subbuf ID which can be safely read
+by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the subbuf, ordered by ascendant ID. It is
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
+                printf("subbufs_touched:%llu\n", meta->subbufs_touched);
+                printf("subbufs_lost:   %llu\n", meta->subbufs_lost);
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

