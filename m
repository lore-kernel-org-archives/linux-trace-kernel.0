Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3812CD8A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349882; cv=none; b=i4tQOuKxa98g0CbRvOpHTzwjsULmfojB6xOLd/g6bK3DOxqL+BLOnEzkLjU+9g5PWNXSZwgz5XzuYnUWsvj18EvBcH007wBibeh4vmIrtOXe8kqAYxu4hYr+IkBjeMwZUl+sFEbMh2ONv+TaSE+vdIdwmBkTWpx6Z2lzabvC2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349882; c=relaxed/simple;
	bh=xn3xccsaPVEtVmAU1S0do7h80XWViMaZ3yUPG7/GKok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W86neiCOBXgM7Rxalm3SiZYJ1GMsPFqLMfPoip8TjauW8FsGvW4WkIU4U2INV5Cahe+Hc6qC2TCsKsXUqbzThZK8cVH2Qy+n2QVh3nbQZZ9VunOeTDs5WWc+8pQhrLb7sVNstpnfe3XBIBbuxUBZhPnjvjxv6/pCn9ytEeE2R8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uafagYLX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uafagYLX"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41fe329e720so7010595e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349879; x=1715954679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CeY54PH7cQJvLaGa1tLmbeD0j0YkIh8z2oSQke6Rq8M=;
        b=uafagYLXnZ/BV1zlWh6zrtLNGRx1Y/aSDYxNAFT/yu8Aw0fmIezBiPR3YOw3uo7vRR
         RWlYituKfCnZ/IlVfC6+sqNmpCQvMLPg02JUFPb/aZGFJfQ4u9SRFjf8FiFJD+tbBdgW
         p3ZsrQUDwwyneOV2zXy8v4jdRQmiKQNI4NbW2xODomyD/MjVJPf7VDs1rLYpEfC89OyG
         X9COkblC2OvCOg3w/KjK38Dn+spgOhQUgPaXYH3ZcAeVuIj7ObTCw/wf+Rkh/lWLVAYP
         r5Me7H6FjVz4iY3+z+iQ37oV+XGmjpkAq1/kcb7rfSZhWmoH5C7Aw23Prvs+GD6Ite+Z
         MLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349879; x=1715954679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeY54PH7cQJvLaGa1tLmbeD0j0YkIh8z2oSQke6Rq8M=;
        b=vUIDu7+dqcasxOTZNk6MGxWPLKzK+iJGE6+hMqSmoId8tPm4RZVc+Fe1+aiQXlAdPz
         Jf3sLkIyLdMpD7HT/4BY29uGkGBBczYm9S8HeOeTan2xUgegRsiE5jUXjExLg1DNZBtf
         zn4qZKrSuI9kNqAkkhxWppB6sCgxUqr8d2qOm001aW2aujq7/XU6NlcGvPljUb+NbNaa
         WxUAQBZOpZRkOuu8uT1juvR/MsZcWbOk5k3qeIu1FFOaSm1NJpkfaM7FDgYwfoQsSYBn
         6O082j7ocSXEHbl7VK589PfxDLvauD5y0FhJbbuawZbRHQxUpd38sbxsjOdo5m27gAQA
         PZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXXadq5gOKSwVHnjNpDWB18GPOTYv0Lj9Ta9vRc/75BSZ/ui6OdIbnoC/nGvvTNhHsDhH3kUYnw46ej3kMH7PkvAkzJxKcON5Sg2D96AGHrzR0o
X-Gm-Message-State: AOJu0YzRxPo5y5OdA2RuUiJvT8Vy1COOhGCImd4kBmaHFg+uEnKiENRF
	QLysfrGvPpxU7irC+EZF39fomzP9kOkWWg+yb3EdMt8CUMl/mO5xVLPBIU6a6yEsqKQ6iBx/6yr
	o1BIwo+68LO/GS+yL+w==
X-Google-Smtp-Source: AGHT+IEFuw8oTDo+5mSVPg5nW5Sa79SgjuH8Q6G1UxJC2PezXC5gmx8VZmA1kW4nUrrH4h6i/QukvMU9elus6c2H
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:70a:b0:41c:7ffa:64b5 with SMTP
 id 5b1f17b1804b1-41feac54e90mr144025e9.5.1715349878929; Fri, 10 May 2024
 07:04:38 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:29 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-1-vdonnefort@google.com>
Subject: [PATCH v23 0/5] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
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

v22 -> v23:
  * Remove VM_IO (Prevent ptrace and does not bring any other useful
    protection).
  * Bring back DONTDUMP (As we removed VM_IO).
  * Add a check for root user in map_test.
  * Make the s/nr_subbufs check a WARN.

v21 -> v22:
  * Remove DONTDUMP (VM_IO implies DONTDUMP already)
  * Remove MIXEDMAP (implicit when using vm_insert_page)
  * Remove PFNMAP (We do not perform raw PFN mappings and MIXEDMAP is
    already implicitely set)
  * Add comments to justify the VM_* flags

v20 -> v21:
  * Collect Ack
  * Add .gitignore
  * Few nits
  * Remove meta-page padding (zero-page not supported by vm_insert_pages)
  * Remove single-usage macros
  * Move vma flags handling into ring-buffer.c

v19 -> v20:
  * Fix typos in documentation.
  * Remove useless mmap open and fault callbacks.
  * add mm.h include for vm_insert_pages

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
  ring-buffer: Allocate sub-buffers with __GFP_COMP
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   6 +
 include/uapi/linux/trace_mmap.h               |  48 ++
 kernel/trace/ring_buffer.c                    | 420 +++++++++++++++++-
 kernel/trace/trace.c                          | 104 ++++-
 kernel/trace/trace.h                          |   1 +
 .../testing/selftests/ring-buffer/.gitignore  |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 294 ++++++++++++
 11 files changed, 980 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.45.0.118.g7fe29c98d7-goog

