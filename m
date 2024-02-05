Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE43FE3D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150859; cv=none; b=i8JUSAsWPYMjbCuhXTSweFleB7B1DeRRSmKChZ9HES15QMPwiJPzywFzZq/0zSTZmlEYiXDOTGlD5f9cOggf+Z03YHym6ggqu1KmL+1x+GNwx/JcPBstv/VsXJdyVjq/EajAR3SZ5UTolQLd3Bx5sV+49p5GqnfdvLSAnUnogTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150859; c=relaxed/simple;
	bh=tZH2CeWzrF3LXwnsAv3jlMz5yaTDBOLavgTl2tFS9Bw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p8SUzHy3Clb8hnyBVD7hq3u0aFPNx22YjjbSElz27/xjJB/S9wYdNlMS6y2R9qyKAieR+LAR+VHwXlN+JymfreYMjLn+fSMWrBX8vv9vURC1EbQCYM3fIBj6oZwtjKi8NEsPcs/TwR07Jh7bjk9iVx9ThN/BTXpNQN+QHuD+GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7zxTkwI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7zxTkwI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60444884b7dso24607197b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707150857; x=1707755657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpJg+QSlnAWjjgOu3uofSR4E+hbgVBBN+bxzotDQEwU=;
        b=h7zxTkwIPDVLSvQDiWVx0qoiCXeDyGBbg59emV4SQrmdy+o518eMcsw2FcUdo5Lxuc
         QjTSLc78kmu/HqjEcn2NSnglU88w6ZecNspy+nOcJpl0WjjbANP3d35USNQbvFMzZtKk
         L1iaNyMclrBX6DYij7iG7DpGTPzlOgrw97cDgg9vi5rFThLIJfiHN/c6oVmjLVlxcBZB
         onT9QqSNY15IWcSLFPK6rzEjEtHbdFyocbuz5AUcPK0sAouDqZBj+CMF5tGDwQYGLpcb
         zE+/KXe/bSGpmhmyw3gX2n7G61jWD3AP/ojikwmFxTDT1U9JaLe/+wWC/FCuB/XZA2Oj
         Sbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150857; x=1707755657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpJg+QSlnAWjjgOu3uofSR4E+hbgVBBN+bxzotDQEwU=;
        b=UCAqVGz8s4vdsVbh93MfyX7wtxxke1aAIP/8ojCNR7a6kbPm6ccmrNsLpa1MiwjKX9
         Q6emcZaIMvsA9C7ULZ80MAyHUVnpdbyqK35Tvc6bllxU6q3WnVNqQfluvembT+flnotY
         kYxpwKt7BhFwYSePArqf8ldZhnpOgzEJTMFM4fU/soPcruFEgF4acOg6sFPNtYkzQeBl
         kOZojzBiiLm2Ec6OHJHH4Xj05eJ9u16nS+CahHOMUk//IHuLmSmqikddXXqCcezNyVlf
         TTENghbYUSMo/btfIAuHvHvwWp1ktcGzkM1neFzUaYuw5ZKw2cDU/KinFS4cCmTzo7Ow
         J4Xg==
X-Gm-Message-State: AOJu0YwfpDw/rF7Y3y9eaNeZn6c6NKyWRLrarHbmNAsUONXwNA87txP8
	8E8LvjQbnGmxxwASYE/Cfpfp/PQ/3SwZrBvVgF+XPAukfx8UTf9dFSB0K08tF44pX+m7lMumQ0P
	94bWHUYPryGpQbLwbYQ==
X-Google-Smtp-Source: AGHT+IG9xRk/6XYsAS/orOHiz14UWutRLC9DGTBH6qjHxKsZJYds5u1iBQZr5mgmGlxbRyMQSvoRQspIEUVm1m1n
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:10cd:b0:dc6:e647:3fae with
 SMTP id w13-20020a05690210cd00b00dc6e6473faemr448377ybu.2.1707150857143; Mon,
 05 Feb 2024 08:34:17 -0800 (PST)
Date: Mon,  5 Feb 2024 16:34:04 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205163410.2296552-1-vdonnefort@google.com>
Subject: [PATCH v14 0/6] Introducing trace buffer mapping by user-space
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
 kernel/trace/ring_buffer.c                    | 344 +++++++++++++++++-
 kernel/trace/trace.c                          | 221 +++++++++--
 kernel/trace/trace.h                          |   9 +-
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 273 ++++++++++++++
 11 files changed, 1029 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: e2412e51fdea837b50ce31fea8e5dfc885237f3a
-- 
2.43.0.594.gd9cf4e227d-goog

