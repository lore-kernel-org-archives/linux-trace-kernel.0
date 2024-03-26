Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFAB4D9FE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447469; cv=none; b=WBrOT17H9bYK60J0mwg0sBSWoaTMS70yxvRr3GkXz8Bx60G5atK10vTR4dGF6q2CqVVs+8+AXMTeX0VRlKeH73Eo3e+gmpRR7JrQ3M91jR/uz/DdxSCFcl5k9iqEDFYPT79TCkvKu1hXzGT6Cj8VCt5f1M7KXWP2gGp4vz2YTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447469; c=relaxed/simple;
	bh=YhZi47uHgagethz/FL/89AbKlyMLuDA2yhemmdX0Vh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lDfBzZ30epzf9BJt5tGLrcv/qSh36mWIjrhPYKxTlvYv85VdbJzeRsIsU6rU1dz5YuzX4Ih/X3wJvpZEkUfciCI5TVFO9Nv0kAxTEvq/nspMaAtTcFm8CyLzFNJ42XALUF43OWHEWNvs8XuFDcVu4lJ0JoBG7oT7e8bkGA7iL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BefCY7Tr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BefCY7Tr"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4147ddecd52so18308945e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447466; x=1712052266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaC0I3xs2cykMLEBqrJ0O6H6eh7LunXx8Vj6sAn28jg=;
        b=BefCY7TrMvlxh3tZ4VkGlLEIuqMwnNeZXK7RZUL3wTDg2UtBbXNzAWR8+bxQDRFNTG
         mGgWA9AtYrujp3ob9Yz9fOOoLns947/13e7RY+8HgIoUJcATvux8+jG4s1uTShfCY1vc
         mIVkFVdGsaECzaqs9O5ZQtQvR5ctZyJj4QZmykE0WQyydPexdo1eBnWmaqoI0bHAJeXN
         oUz/z8y62ZDkQ2v8quV4Ku8yMIi6xZbywAKR73tqLadM9Dko202kdIPTg17tPWyahVU7
         8pyGQzIs/v5tSbcKHsUgNXnvvVD24lfGrZp1ZbGGHQg3yebXYzkF8ngKfBm/tnpn7BUS
         eY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447466; x=1712052266;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaC0I3xs2cykMLEBqrJ0O6H6eh7LunXx8Vj6sAn28jg=;
        b=vwCCLFN9Z1ETUKaGiO8CJYjoTgHlFN8a+qhCD3SJn8VFs/JBZ+6weXYIg3mEy0eCeT
         SqJ2Trgv80HK+NkHaVitM3x4TmocdG4+W3TEziC6Y7nd2Cg779F20MZxD3YIo8uD0gAv
         Wo8M5z3H7YBFxZpU5u26YgLGm6qn9qCYM3Hwhh1PaB9P9o/g9WQWcFtd6rNVW0D73JO+
         eGOpKJkPZFEVi9yfTyBXDxJm7WBwA4dk/vxJDonvzzw75ZjYzwPF4lnCXyTh+wOqxC16
         Z633c/nkXXfgOiwc2zSG1yJQKMAWLT2pUDiX6NBjreu3PnUjaBLeRVOJVkBhqUmNOO97
         CshQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqiCki2vuC1oBqYpqqCCzsHXKZsVg7ltzNJ6MfS9CU8YwKVn+T6ApjGpIsAoXZayTmjxFvZ0JarAy3R9DuEaitQFazXWXxpjPeM5Y6BgMuoXlQ
X-Gm-Message-State: AOJu0YxSionQlJjHiOtVR9ckUbnh1L6IeNYP7YVhjzqqMwddHPpCCwIm
	IyimvY9aEks1dvrFX9+HMisZ4nHY30fwBpi/5zTYIGmD1QQc9WXvozXPleiCEzPhZH3Le3dB1IH
	kEOZ0vJIhFK76l209Cw==
X-Google-Smtp-Source: AGHT+IHsQzrLKKad1YiXVvjOy/OQ7PFGai04aBXP/VkD1cf7DAHciKN3msfe26ixbUO5UV184AumeqfPxe7Ns8jf
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d05:b0:413:f62a:aaf8 with
 SMTP id l5-20020a05600c1d0500b00413f62aaaf8mr30091wms.4.1711447466330; Tue,
 26 Mar 2024 03:04:26 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:25 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-1-vdonnefort@google.com>
Subject: [PATCH v19 0/5] Introducing trace buffer mapping by user-space
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

v18 -> v19:
  * Use VM_PFNMAP and vm_insert_pages
  * Allocate ring-buffer subbufs with __GFP_COMP
  * Pad the meta-page with the zero-page to align on the subbuf_order
  * Extend the ring-buffer test with mmap() dedicated suite

v17 -> v18:
  * Fix lockdep_assert_held
  * Fix spin_lock_init typo
  * Fix CONFIG_TRACER_MAX_TRACE typo

v16 -> v17:
  * Documentation and comments improvements.
  * Create get/put_snapshot_map() for clearer code.
  * Replace kzalloc with kcalloc.
  * Fix -ENOMEM handling in rb_alloc_meta_page().
  * Move flush(cpu_buffer->reader_page) behind the reader lock.
  * Move all inc/dec of cpu_buffer->mapped behind reader lock and buffer
    mutex. (removes READ_ONCE/WRITE_ONCE accesses).

v15 -> v16:
  * Add comment for the dcache flush.
  * Remove now unnecessary WRITE_ONCE for the meta-page.

v14 -> v15:
  * Add meta-page and reader-page flush. Intends to fix the mapping
    for VIVT and aliasing-VIPT data caches.
  * -EPERM on VM_EXEC.
  * Fix build warning !CONFIG_TRACER_MAX_TRACE.

v13 -> v14:
  * All cpu_buffer->mapped readers use READ_ONCE (except for swap_cpu)
  * on unmap, sync meta-page teardown with the reader_lock instead of
    the synchronize_rcu.
  * Add a dedicated spinlock for trace_array ->snapshot and ->mapped.
    (intends to fix a lockdep issue)
  * Add kerneldoc for flags and Reserved fields.
  * Add kselftest for snapshot/map mutual exclusion.

v12 -> v13:
  * Swap subbufs_{touched,lost} for Reserved fields.
  * Add a flag field in the meta-page.
  * Fix CONFIG_TRACER_MAX_TRACE.
  * Rebase on top of trace/urgent.
  * Add a comment for try_unregister_trigger()

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

Vincent Donnefort (5):
  ring-buffer: allocate sub-buffers with __GFP_COMP
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   6 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 402 +++++++++++++++++-
 kernel/trace/trace.c                          | 122 +++++-
 kernel/trace/trace.h                          |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 302 +++++++++++++
 10 files changed, 987 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.44.0.396.g6e790dbe36-goog

