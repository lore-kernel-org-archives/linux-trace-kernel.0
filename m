Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AD30569F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626718; cv=none; b=ZQfbXdgyx3rgt1btyPEQNR/qSEl8CsvEz1fiN7u1FVUVL8TGyQ0/a/qrUESu8IsPy3Dyc18qU7pHlCUa79ybbaTrOq2tLmOKrBBujQE2qCx9wQzE8oDUSv+VARq5hlYfRV475roj6EehpdR7a5Ufuzv5t4WfvkYIvxp85MZDSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626718; c=relaxed/simple;
	bh=nyUx8ycpL1oKU4NOWzjt6R+AM5LyeZNfGTVPtxrpWps=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aF1clXeZIPnPOdWpzN3jbK8f3VECoHEBXe4XGlxH5Y9o7+q90XNAqFv+2MqB/DDEsdS/YCC2IAdb7Pj3haMnRA/UYAP+YmXB4utCxdtu6yaElAQhIB0Vi1ErwbswwLB0IPyTDxlaiDO9mrJd7oNr/MCGUOGL9wmJZUvlvj+d9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPYML00g; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPYML00g"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso19769215e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626715; x=1787231515; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JddlaFF/9a7mjYbfOn/ZXZvcAVEJVBnu5FYUflFVSnE=;
        b=OPYML00g7dzB7mcEUHJ45MyJuJqKcEZBgJ+QXYJrGgXae/3V9oRPRi0pdsk2KsFOvY
         72XSMlbwExrPZhwGn8PCnYM5Xa4mBjfMglI1gUF3PA1OVjQOuYE6G+k2auuf26vsugKA
         nh158M3wbcpk7i51+2WFW3UzCmpfmY0AlrbZIQqk0M1orjm++E5V4awLroM9CyXBqGtC
         fmd5vqQ1E/C1kz1PM4QFkfl0b1j+IwX0Yw3s1KuOpG9e+sO12TG8azKBJC8PBaBnK9lH
         7Zzgh9hllAHHJudZnFR7CA8l3xReiBp800Srou1njoaQJxyT4OkV/lczHPPvAdQ0uY4q
         580A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626715; x=1787231515;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JddlaFF/9a7mjYbfOn/ZXZvcAVEJVBnu5FYUflFVSnE=;
        b=CIIGJZ1fqZwUZ1ySmJindnQD+CkUluQ9+M3jQPWQpXdbr8xLSNWHNsJ3+mXcU0ndze
         JRA9tnlYOaFqIp2MEjQcIm1M9HcdgcL/w6gwYbwVjuMcBCIRbzFBqGM4S/c3Pc4x7HRa
         FFFq9kKubbC86pFjZxrJYkccRhZc8sgdoDydZYqD191qyB9LGU7TRkCuG0K8Ee7TWFcv
         hV/UPkiZrFapN1AZSHYgmR+l5LQupZoNc+9p2N7JCtnq7PHPA+X+lMzvVFDhFy14nf7h
         DzdG/5Ra0FDwegH3/yKN7SK3QWZ7Sh3R7KhH1cBTrwTKCmOzPIiZsfNyd2/dCBhscpN6
         WhRA==
X-Forwarded-Encrypted: i=1; AHgh+Rplmn7EjgChBUmwBaPdRdWfjMumw54OqZmn2aotu7JtPQZdAEwb4KtQ6+ZaDkK8ur/F1Z4MKFQ+jFtJDHROXxee9NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5QAQoLjC13mc8z8zTr3JTCJoY95O2dP+H19sHHCdisLqTwcb
	/NtYjNIDcLjxplIO7SVnZCRg5GP8OfzRYjft7ucikUbBAlaI+HU8Wi2ww5On6X62VN3LJNxN9WA
	BliRnORvpZ+rlWKNe2OTWNw==
X-Received: from wmbc22.prod.google.com ([2002:a7b:c016:0:b0:495:5bab:557])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8a0a:20b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49986ce46aamr8083785e9.4.1786626715165;
 Thu, 13 Aug 2026 06:11:55 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:42 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-1-vdonnefort@google.com>
Subject: [PATCH v5 00/10] ring-buffer: Fixes for subbuf resizing and
 persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v5:

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

Vincent Donnefort (10):
  ring-buffer: Free cpu_buffer::free_page with subbuf_order
  ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
  ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
  ring-buffer: Fix subbuf resize race with ring buffer readers
  ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()
  tracing: Fix subbuf resize races with trace_pipe_raw readers
  ring-buffer: Dynamically calculate max_data_size
  ring-buffer: Remove trace_buffer::cpus
  ring-buffer: Remove ring_buffer_per_cpu::mapped
  ring-buffer: Make nr_pages unsigned int

 include/linux/ring_buffer.h          |   4 +-
 kernel/trace/ring_buffer.c           | 393 ++++++++++++++++-----------
 kernel/trace/ring_buffer_benchmark.c |   2 +-
 kernel/trace/trace.c                 |  91 ++++---
 kernel/trace/trace.h                 |   1 -
 5 files changed, 291 insertions(+), 200 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0.691.gc56d675ccc-goog

