Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB25692FC
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496499; cv=none; b=Ef4dDTHOnA0hhU+XluiRtEekUC2SFqsOkhUlVmwaUlEBysnkQ64Va+Dv6zyEHIeAPcuyH7fTYdz/22E3Fo71D8mjwkUzP2pvjBOXjcRae9R7XxfHAjnCxwgzPTeHjCrRcRGTQTB7/LhulMfNrXwqcHVlaFsD6GedE/BwwTU3LX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496499; c=relaxed/simple;
	bh=f6SYsq2J9oZNGQ4fQ1jsMdMcI2ye1z9gZlftlvhm57E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZAl7KkkOcRTgEs2Erij3FklgUiYTaRu804Romt4DpyBduByP6RcgykHm45AU8PUa5rzWfknpC2zZ+Wx4hJT627/NOcwdk2bLlZbOB70/JRdmTpG4E8yBCW+bh/YHIjl8dLeWkJ0QYZTdU3+SS3/giofG3u/8MMo2718WiP59BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJHxKgp1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJHxKgp1"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40ff7e36f34so8319835e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496496; x=1708101296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LGRaaDmU2EJZ2LL8v6Ox+e2XARQ3mCjhMk/N3gVZF3Q=;
        b=xJHxKgp1pXYVYRQMzIBrpR7S38qa2qGueAvOZpg/pDShxhSyxi/ZS+7Hw1HKg59qs3
         XaceALNC1WoQtIARwWYhPs2DO1iCa7NRErHiWaaYg3QoI+ogsfeiJg2zf1d/xqLlcrPM
         Tu8pvxgDUfGMHmrax1BbfTWhwmgQ7GlilgDkOD0+K+s4DHn+kv4aSNjffCtwX+EHdMEh
         n1ZWrETY03ct7o9H2xK7UXv45VBMdG8rkCQNt0S1UImdSI3yDv+v9Na/lgML1+J+InCB
         g4/r2KkU6UzEjSH2moSDugjIpd3e8iOnacT9ObpNC6FSmbw0oZk9Gfy+RdzljjbDos6p
         XT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496496; x=1708101296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGRaaDmU2EJZ2LL8v6Ox+e2XARQ3mCjhMk/N3gVZF3Q=;
        b=U3ViAuX80BC6lWSk+oicAmNVJMeYAogcxUL7L59wFSDOP6uxF3HpKENXWt08SX+I9D
         IcAfeg5MknXmJ/DN87bUPs8F2NlioD8PkSw1f4rX2qiOV4ceoqhYOl0b0XKlojLe9n6g
         Hmh+DG8IngxkSJDoB2OsT1u9cMGd9bU2ndTYgaXB6fp52YoL0KhDj1gHPtnO6Bgsyf7m
         n8ygYrpSV1ds2reW4Qa+AFVtOp48uO/5e9/LsS88n0ZMlEPMAULlNJoTeiqPKL7Y6jNO
         a+A8SExBpMfhB/j837H4hQp28VB+bpvI9A6sFqREb6S1TxIpgv+S0SfssIryBpEpSPkq
         2C4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtYsqCe0e3JI1Oa+47CQSfPggVOJvKh3cRKNf9VDdHUtx8xJjF0QpStIYiS7EyJqh6VoBVii8ddkaF8I0wcVzh1emssxRlWvfJWGeoJz4kmA4f
X-Gm-Message-State: AOJu0Yy6cgJL2wR9EQf7iY4qJacQxTJ37EL+QLJiKybA59Zg7dqKw2N0
	33eTuMj+3Hxvev62H95wNbIQIV4l6OFWKhSanUzVvMWUWZQAkzuogjMjehyknVDazAssfwRFUTc
	PWoqEfJDEScYBShwZzQ==
X-Google-Smtp-Source: AGHT+IFFR52/A2jWpnPren2niCnynx0UW65AJjUn1CHD4IFPRp7sLDZlsAmYZt5/CWoW7ygGiwEJ+2cdPy7MhQik
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1e28:b0:410:5957:423d with
 SMTP id ay40-20020a05600c1e2800b004105957423dmr15314wmb.7.1707496495714; Fri,
 09 Feb 2024 08:34:55 -0800 (PST)
Date: Fri,  9 Feb 2024 16:34:42 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209163448.944970-1-vdonnefort@google.com>
Subject: [PATCH v16 0/6] Introducing trace buffer mapping by user-space
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

Vincent Donnefort (6):
  ring-buffer: Zero ring-buffer sub-buffers
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Add snapshot refcount
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 104 ++++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 351 +++++++++++++++++-
 kernel/trace/trace.c                          | 221 +++++++++--
 kernel/trace/trace.h                          |   9 +-
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 273 ++++++++++++++
 11 files changed, 1036 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: ca185770db914869ff9fe773bac5e0e5e4165b83
-- 
2.43.0.687.g38aa6559b0-goog

