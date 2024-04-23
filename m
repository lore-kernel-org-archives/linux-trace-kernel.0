Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A72E62F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914863; cv=none; b=T/876Ynvvx0gqp0a7neSDU7tWlZYesix2jZnXYsdowuynLKLrJ1z212DpDSk2i3YnFkmmpRVrtXnydHeM9PmuUkkALL0SsGLeRptrfW+J+eN273pqfklHz/UoiKBzkN2bmHEhNT9q5ZJR9X+rhERYWrWuILW0V9U8j8ttQwKDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914863; c=relaxed/simple;
	bh=dEMBA5GZi5Sot6zwck3R23iFomdPROp+vd8L481uIME=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mu8Xjv1mdIJu8AWNUBa8b59YT+24tcfWPMeXTruuEOqIhfCfPonjkIKe+agdblEV0M68Ky+j3/HrJGwgnoqj6mInCdN+LMdS0+7ioELTsuRwU0MYACLBOB7Pf/Gq8CrdGilTZbQiwM1S7y8TcRigUJHlTQGiS2dROYvHWSwdCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHvQXsVP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHvQXsVP"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so9681196276.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713914860; x=1714519660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHPrRAdicf2kC6RLMUrl3hcP6CV9QCzcGC597dQMEhk=;
        b=PHvQXsVPEtj6CNaZ0RN9tb2SFpL/mCoCi9F1+UL/CLnvOiRTmfdjihSZyhS7OFs/U2
         qN7845PkdpOhJ6SRGYdER0tP/hVRZJZ+nfouYEseS1mkZIq4y6mwIS9wMwJj4SXuGQxS
         O9KfeLbDcenp0duX7cuBm5uS8GwNxeI0KkbBWKXneG9XjvsboVPnZZe2uGePBlLpw/7j
         zw8sUdTzb5GpEUfmP8ZYxlbnUsCuUSZhCcBxqur9oy6w7Ib6LXmtBKa/ncox0VuCmLJ0
         1ELXjGs3bI5k9Y8NP8YGTcTlIxKlx/5LZo+1bQrkqeE3XHHTfR9uSKeViDTlWYYL4VGd
         VNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914860; x=1714519660;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHPrRAdicf2kC6RLMUrl3hcP6CV9QCzcGC597dQMEhk=;
        b=q86mLjPi/c05p1fR55CUsTT8hFgvKQ/nKdqW6i2IR7RUIyRsTmcRa13v1UtCHt/AEC
         lDjCWfdlfwyh9+8vYyymgw7rkqEGFS0bD1Xs2FiCLGb2Tai9adazMD6cT6OWJfASL8MF
         JcM9PpImjZouXSW2t3o4xNRsfLI/dS94ktz87XuIxE+fP0VFuaYl0pDsYCOtG6+EnGGx
         WsQsXaqKYHKHzvDh34pGxKt6iHMzi4mYO8bhUcbskF0DUmLagJY3adJqiiAjn4xK7lYc
         RtFRe0iHJirIDf5noETnQ5ZsGyfLJHg9We0wfFNUKVnMcJiPI/k0hiizLBaHA5//WLn8
         vnkw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfc8y9pwTwgkHEFuovMEHdzNN03NWrJXjURycil27gBWXHmzYjdHPjGx0JbKF6A77HA4vAztfCOaE5xrO72+Na6ck2tLD7KbWa73gHm/q1GmH
X-Gm-Message-State: AOJu0Ywys8S2/sezDPSNnx+hSJgBt+m2fi6nucH1D3FoOAxxvV13GN6y
	buIEsVRHINsdZ+afZYjWlAOfpidvYc7Cezo9Que4FodV6m0SXnTvFt37W7U/c0uTImW8LOeVWR8
	7R7JQqbqwoSzRcFGnCA==
X-Google-Smtp-Source: AGHT+IExPSdsUSP2pev3IojmuItmUkc/WafwNWfwwEfyBprHlSLgltkPdqZort4y2T3S+xBi6X7p170gx6YPzUGe
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:124b:b0:dc6:44d4:bee0 with
 SMTP id t11-20020a056902124b00b00dc644d4bee0mr124378ybu.7.1713914860009; Tue,
 23 Apr 2024 16:27:40 -0700 (PDT)
Date: Wed, 24 Apr 2024 00:27:23 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423232728.1492340-1-vdonnefort@google.com>
Subject: [PATCH v21 0/5] Introducing trace buffer mapping by user-space
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
 kernel/trace/ring_buffer.c                    | 412 +++++++++++++++++-
 kernel/trace/trace.c                          | 104 ++++-
 kernel/trace/trace.h                          |   1 +
 .../testing/selftests/ring-buffer/.gitignore  |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 288 ++++++++++++
 11 files changed, 966 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.44.0.769.g3c40516874-goog

