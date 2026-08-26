Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6073BB699
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737536; cv=none; b=WfDjpwFf9DLlKL/RHl3vsNl0e+4hRZwNTH7KrCvC/KKvzdxkT2hFkfAfwoIb5iYtoGKObaTNpMvNNWn3UhucqG14BxJoPg+rGjkURO+e2miIS5RgOw9qNRX5qFs4GbB7qnKOwI9HsPfT0ZBpWP3wamLVp0KCM/pxUdtKFkxdj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737536; c=relaxed/simple;
	bh=Ipf+H9D4STZOCneiD4/B6s3PQwhoDKtham2FxC+a/io=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pwTMfHtc4kXw2dXgytbIYYtuKncE6PG3fjlPFwnOv+oAkO5ocvEi4QpT5jfNPcQA8qBTmzHOEShmgf5Q68aKuV6IoaaYiYG5F/s59u24nNwMNqHRtksPrVhMwGiCXerW8V1OJDns7XxY2JVzdlkyq3UmVWX7v5NL7pkr6uDV0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVjscz5N; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVjscz5N"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f81362fb1so341896f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787737532; x=1788342332; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6Cr7H7jGc0jRwQb52xOII5xKwkWUBCQVrhxWDOYa9I=;
        b=bVjscz5NeaUmRhgrkucdIoef3m959rIaAA/FGYFGQ42Xa4Q89FmWh0gVu/i/b7xLBx
         uNp9yPxNtyl9B/AQN22yeaZSMNGpRP4lKtAbwWNTVqjfsH89Y9wNA04MpW+V4PjuT8z6
         1pG0LCFOfSpEW6DRhmn+f2qX7xgZxuMCxA6FbNgsjEXa47CA/7r0AxyT8kwPCw8b65PC
         hj1GoRyC2ljc5nzUBV5oUHRkrKzGqX3ZgTiWv2gQBj+rClkQZYSCSGgGtRRULw74GKYG
         x8SYokNmAyJgp6NNllC+qVKp+NOxtFfhA1/O4FeGUyzw20ioaps+aNdnM++YRv7u/WEo
         2WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737532; x=1788342332;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6Cr7H7jGc0jRwQb52xOII5xKwkWUBCQVrhxWDOYa9I=;
        b=KqBmNRX9ZTy8z5lEczFDO/abUsMNfLyeS++lyFFp2PcLd6J+FaSnDMOWJTHUk7c3Al
         OHXGf8aVr0rdZ2ChucMrwDkgo6QnBxj+d7QxLQNaK/AbPRsroAitgjozOn6kcFhRZrGT
         fFDAhM/VUgjZYIe5PfRcKPiqgkVpYCr4hc3FS9MvI9ngxedDts77l8ZRRkZWgDnFW4oz
         8k/MQ2oa/KJRT8bHvSepAfzlhokedpQ6yVWGhGnw5So4vo6YbhhybWzbWEmYqGoR3fDf
         8hTxXJPUJpZxHmWvb9Y6cGxNL1k2ssIyBQtKoiWCd+BpbhTOPo5dqXU+XulbhcU8r9Vy
         lBHA==
X-Forwarded-Encrypted: i=1; AHgh+RobbC7vWO6A6sRLNSz19icjWdY9m8djTDfX79bPwikelYOk1jvHFaSGC3NCONs07EbxG43zCObJRUpRW2cnw+W9HoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l8sze6W/xf4mF5HsErNQcK9P9DhVtSMiRgFPFWJ4QQd9SLtvdL
	+AhDqRQmQsKGncwDNp9TZhHDcs4qUJtrZQQlaic7KHB09tDIZoDQqkSQeRxRiuPa2kdfEtb5tNP
	vj6+rSzj7xC1z6ccm0GE4cQ==
X-Received: from wmga19.prod.google.com ([2002:a05:600c:2d53:b0:493:d3c4:6a28])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-499dc6e419bmr41771625e9.1.1787737531291;
 Wed, 26 Aug 2026 02:45:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826094528.3738023-1-vdonnefort@google.com>
Subject: [PATCH v8 0/3] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

I have managed to reproduce a ring_buffer_read_page() race with

 $ while true; do for i in 8 16 32; do echo $i > /sys/kernel/tracing/buffer_subbuf_size_kb; sleep 0.1; done; done

Changelog:

v8:

  - ring_buffer_read_page() handles gracefully read_page/reader_page
    order mismatch (Steven)

v7 (https://lore.kernel.org/linux-trace-kernel/20260817101533.1558223-1-vdonnefort@google.com/):

  - Match the "static" rb limit with bpage::id bitwidth
  - Cover another 32-bit truncation in rb_range_buffer (Sashiko)
  - Fix uninitialized spare_size (Sashiko)

v6 (https://lore.kernel.org/all/20260814154823.755406-1-vdonnefort@google.com/):

  - New prototype for ring_buffer_alloc_read_page() (Steven)
  - ring_buffer_read_page() to return -EAGAIN (Steven)
  - Keep nr_pages "unsigned long" (Steven)
  - Repase on ring-buffer/next (Drop most of the patches)

v5 (https://lore.kernel.org/all/20260813131152.3589632-1-vdonnefort@google.com/):

  - Reset info->spare_read only when data is in the ring-buffer (Sashiko)
  - Use `unsigned long` for subbuf_size declaration to avoid 32-bit
    truncation. (Sashiko)
  - Make cpu_buffer::free_page a buffer_read_data_page
  - Update kerneldoc for ring_buffer_alloc_read_page()

v4 (https://lore.kernel.org/all/20260812153311.2328812-1-vdonnefort@google.com/):

  - Add rb_subbuf_start() helper (Steven)
  - kerneldoc additions
  - Fix races in trace_pipe_raw readers
  - Use rb_subbuf_capacity() in ring_buffer_subbuf_order_set()
  - use rb_page_capacity() in ring_buffer_map_get_reader (Sashiko)
  - Fix 32-bit overflow in ring_buffer_subbuf_order_set() (Sashiko)
  - Hold cpu_buffer::lock when modifying cpu_buffer->free_page in
    ring_buffer_subbuf_order_set (Sashiko)

v3 (https://lore.kernel.org/all/20260810125633.3344684-1-vdonnefort@google.com/):

  - Drop first 3 patches (Rebased on 7.2-rc7)
  - Add a patch to align "nr_pages" to unsigned int
  - Add a patch to remove useless trace_buffer::cpus
  - Add unsigned long cast for rb_subbuf_size()
  - subbuf_order fix for rb_free_cpu_buffer() (Sashiko)
  - Use __always_inline just like the other accessors for the hot-path.

v2 (https://lore.kernel.org/all/20260806211306.3704194-1-vdonnefort@google.com/):

  - Prevent resizing of the persistent ring buffer
  - Add missing bpage::order init
  - Rework subbuf_size/subbuf_order (Sashiko)
  - Remove ring_buffer_per_cpu::mapped
  - Dynamically calculate trace_buffer::max_data_size

v1 (https://lore.kernel.org/all/20260805153225.2096152-1-vdonnefort@google.com/)

Vincent Donnefort (3):
  tracing: Fix subbuf resize races with trace_pipe_raw readers
  ring-buffer: Cap static ring buffer nr_pages
  ring-buffer: Prevent truncation of nr_pages / nr_subbufs

 include/linux/ring_buffer.h          |   5 +-
 kernel/trace/ring_buffer.c           | 198 ++++++++++++++++++---------
 kernel/trace/ring_buffer_benchmark.c |   6 +-
 kernel/trace/trace.c                 |  94 ++++++-------
 kernel/trace/trace.h                 |   9 +-
 5 files changed, 185 insertions(+), 127 deletions(-)


base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
-- 
2.55.0.860.g4b6b3295ed-goog

