Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E75C90C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008084; cv=none; b=bKjx99H/nivy3byNjuOIo8W9rNNeclCVqZvktYZdgwD17tlSU4zD0LYqkPvh7dcRIfdMPdPybHnqsN8C0ixaHs3TkXwOuLPVxBKmT0g2umXQNDBzNfbfrgV+KWukF9A/nAv3eatGWzdicgpN9KJha5pjRJcFOhF4TYEzL7ss2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008084; c=relaxed/simple;
	bh=/WqZhdO9B3n6i+QEfAJZMfeGldCMX4PS9Sj3wBElUGg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f0gsiK9f5UMVR/xWewUcIDMLHZ2kOt9u9M5J078dpnJp65lihsV2VQR4QjTtWsAjrotZA/jv6TBQLnUMCJNgvTdM324DcE5GavQ5cQ3UyShv6O/4PZoIngKx13LhCVoav6DuzIxA3+cd+0FpSR3YGsI0iJjzuWycLUBgtQFuglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbb2toz5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbb2toz5"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-337d92e34d6so3032275f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008081; x=1706612881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7bCkUi25orQO9x3R58BSRYv7KUbFdewUElN+OYKzwq0=;
        b=pbb2toz5XRzGEg8YWrsMqnk4b+UNwTNwNihXJ4R8i1PsaRB361vdWh9acd3LLNNi/H
         XXjyMpAvUGfUw0yYk1yvHmfg6d+UwDdmjq4l+8pTpCKCk6a9yqvxkqTfJDzX+rGEFoJS
         JeJPdf4iKQU/QZBJopwNPm9gPwBJtjOcHdMVtuC3w2lAQCczft4Zn4ArzexPIxNVXr6C
         Y2dqaNHA6mWoyBJOwmgUCmDmgr73AJH7xmicCzBcuku+/YVKSkyash+LyRiv/s8pj7V6
         oaiUJ7NFI7dg7J8Hbd4slyKLX60d5S8n7L/yU9OKk338LgxWQImElBBOTqb5cflfKDyw
         wvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008081; x=1706612881;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bCkUi25orQO9x3R58BSRYv7KUbFdewUElN+OYKzwq0=;
        b=wylla1dCDcOgcSUN6uoCXgAuF69DOmmgCkBIdWWG1eL3RkN+XpIQz7lsfVx/BwpXS+
         zT1KiM1n084Fs+d3YDFdeHERU6U8XiiLQmDD/Kzwr4WDWth5/Xo2FSyooG3SCRIHA3NK
         JUGj57zws3ZVWkNS+v+tWfT2OBz4KSEoGwkl+bcMbIbsSe9vJmw2Oc/DMlY7I5up10Pb
         YpDim6vN5rMvjHgPWPXJlECYYXjNSskDXELzndw12t8ZtF2KdSxtsvmBfE7TVuVO4K4D
         +Kyam4sgEDCCKVZD6IMtv9ywscdgSJ/fb+jahSYkRqXH3onkHgU/AQnkxPeOtpjHi7WZ
         UcCA==
X-Gm-Message-State: AOJu0YxRVYOBOyIg+kt6GWOBuvWec7j3Qb9je9vP3tKjhnuMPGeMPs23
	wwKeVqfr/heCM+nQuCyZ0m5OdaqBwka+nbglIvkur3EBzHWMVL8w9DQU5KaQoyuiVEZG0KBdLQr
	GP9aL3Dw1xbaHL9+ukw==
X-Google-Smtp-Source: AGHT+IFNWFA+quXSMXuBoGds3b8SCPzQ2fkKGJdyNSBdlUEwZGpg05sSJIhRWBvR0ZvKtOjVqiLE8jTZa1h1MP88
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:4449:0:b0:337:97ee:f408 with SMTP
 id x9-20020a5d4449000000b0033797eef408mr15661wrr.12.1706008081071; Tue, 23
 Jan 2024 03:08:01 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:51 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-1-vdonnefort@google.com>
Subject: [PATCH v12 0/6] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracing ring-buffers can be stored on disk or sent to network
without any copy via splice. However the later doesn't allow real time
processing of the traces. A solution is to give userspace direct access
to the ring-buffer pages via a mapping. An application can now become a
consumer of the ring-buffer, in a similar fashion to what trace_pipe
offers.

Support for this new feature can already be found in libtracefs from
version 1.8, when built with EXTRA_CFLAGS=-DFORCE_MMAP_ENABLE.

Vincent

v11 -> v12:
  * Fix code sample mmap bug.
  * Add logging in sample code.
  * Reset tracer in selftest.
  * Add a refcount for the snapshot users.
  * Prevent mapping when there are snapshot users and vice versa.
  * Refine the meta-page.
  * Fix types in the meta-page.
  * Collect Reviewed-by.

v10 -> v11:
  * Add Documentation and code sample.
  * Add a selftest.
  * Move all the update to the meta-page into a single
    rb_update_meta_page().
  * rb_update_meta_page() is now called from
    ring_buffer_map_get_reader() to fix NOBLOCK callers.
  * kerneldoc for struct trace_meta_page.
  * Add a patch to zero all the ring-buffer allocations.

v9 -> v10:
  * Refactor rb_update_meta_page()
  * In-loop declaration for foreach_subbuf_page()
  * Check for cpu_buffer->mapped overflow

v8 -> v9:
  * Fix the unlock path in ring_buffer_map()
  * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
  * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)

v7 -> v8:
  * Drop the subbufs renaming into bpages
  * Use subbuf as a name when relevant

v6 -> v7:
  * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
  * Support for subbufs
  * Rename subbufs into bpages

v5 -> v6:
  * Rebase on next-20230802.
  * (unsigned long) -> (void *) cast for virt_to_page().
  * Add a wait for the GET_READER_PAGE ioctl.
  * Move writer fields update (overrun/pages_lost/entries/pages_touched)
    in the irq_work.
  * Rearrange id in struct buffer_page.
  * Rearrange the meta-page.
  * ring_buffer_meta_page -> trace_buffer_meta_page.
  * Add meta_struct_len into the meta-page.

v4 -> v5:
  * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)

v3 -> v4:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the
	 ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (6):
  ring-buffer: Zero ring-buffer sub-buffers
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Add snapshot refcount
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 ++++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  46 +++
 kernel/trace/ring_buffer.c                    | 338 +++++++++++++++++-
 kernel/trace/trace.c                          | 208 ++++++++++-
 kernel/trace/trace.h                          |   6 +
 kernel/trace/trace_events_trigger.c           |  57 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   1 +
 .../testing/selftests/ring-buffer/map_test.c  | 188 ++++++++++
 11 files changed, 925 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 4f1991a92cfe89096b2d1f5583a2e093bdd55c37
-- 
2.43.0.429.g432eaa2c6b-goog

