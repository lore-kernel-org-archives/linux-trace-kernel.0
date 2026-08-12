Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35C364022
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548816; cv=none; b=lKgHzehH2p1YN6nDrqRhMDN7mKrgOIzNWFeo85Zi/tkz3YrzuTe3oHG1jfGqK+IRG6zFvXAPwblzZ1P2FZ2W6XGV0+JjLG3MouYPjSrFgeC2P89aCax4mizYTsrNJf0uA1WVJXRD5tPj8O9UTPNvtyx0gL2AGVAQ0YKVr1sNWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548816; c=relaxed/simple;
	bh=Awl+ndncPDlBmPyWWPeCQSoUZ9lGBiDJC0aJU7naMXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iTPv1o6whvQ4yUIIQ3U76wpzkVE7O9gq/c2ILC2YofCNkHfU2dmH7Sotqjq58Zkt8POdNXjur5pF6ZICVZLY1CqRmdYveSqAi2BAKyJuLJF94AsCl1SyxgVuiazIKTG20kxJ6kyPs3W33a1CpmFcxHDfIQpaiAdOF10OYyET87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLBQ+PXx; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLBQ+PXx"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49554715277so8701465e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548808; x=1787153608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NW7wNIHYXgex6crNczote3UzTjVr5ceZuwNtR9niSYY=;
        b=GLBQ+PXxcwCiE6CS4/ydj91Onc8VRo+I7VW4zO/HL3y9iyJp1HF/0MByS+9Ome1CNw
         QJcFvaSyBxbDqi/xaLJGp1PAwmieMvO+UWpJ7e+xUhc50GdHn/mhIeYedbSnXNx378HP
         EznGWfqS5m/1TYMb/OWHC3S6LcBv+FBE0YIHNz6H8IFyYcYnoqdbooW8FuNdq4vS/7e+
         gqmJTG9hBMhHPuWbgUKOPY/WxW6kqnf9NDscwQdP0z0SEIoAC5BP2WD38vICH2LiDRK2
         E9Tv4FvHuCji9XcSYru/Hn2IuQxvHfVhN9Gvc4s6XYRFQAg5+9uMxBIgLrHPT4brQduf
         gayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548808; x=1787153608;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NW7wNIHYXgex6crNczote3UzTjVr5ceZuwNtR9niSYY=;
        b=Y++zqWLnI79yc6IiNx7heNKjEEi+q8LWXSAqnh4uDcCCz0erZP7RfJI1kJn2I2bHtP
         oUeykNTDJqUeoZKqAy+/OekEyJp5myHPJbaR1EURGju0JVmwXQgE8N0yFX30hwkwzxex
         JFjdwfhrnEe0hmoO1SaaOKTn+o0eEzpDc+iOiNtWtI3NQNMeu+cFJpuHOCFCCl+ffjYP
         R15X6akM0IaiKNplL5sXleCgzDbqbiUHVWuV+hft1ciq7xWZyk2nqSBtuFwI9pYFhrX7
         t0TprZIXsGHmkvjEzVS+GqF0ML1I2G7Jtp14eo1cPXn6bE2T0s9zlaBUSZ3zxw01BU8F
         7Zkg==
X-Forwarded-Encrypted: i=1; AHgh+RrVSrenWuCQAXMYcIwBIUw8MqqFckPeqzqUTvA8QExpj/6ZxRg2oNbMkFXZH+PMb98OtxT13jzZthrvP6PxmbyZpGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FYt5+0oysAktlqjpoRwNngpPcTBnyhv6Vjow+KKyGkzCdDJ2
	Y4mFOK8gBihOvy6G3+M/SDxvcHK8ShpiIzeuAEsLXfBpAZItJlWx9+h01Mbjn7HE3uszFYqD5GP
	deYhSbRKHgLnvOAL8Xn1WOg==
X-Received: from wmfx5.prod.google.com ([2002:a05:600c:2d05:b0:495:4926:42d6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468e:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-4997c127e00mr73513055e9.13.1786548806794;
 Wed, 12 Aug 2026 08:33:26 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:01 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-1-vdonnefort@google.com>
Subject: [PATCH v4 0/9] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v4:

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

Vincent Donnefort (9):
  ring-buffer: Free cpu_buffer->free_page with subbuf_order
  ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
  ring-buffer: Fix subbuf resize race with ring buffer readers
  ring-buffer: Fix subbuf resize race in ring_buffer_alloc_read_page()
  tracing: Fix subbuf resize races in trace_pipe_raw readers
  ring-buffer: Dynamically calculate max_data_size
  ring-buffer: Remove trace_buffer::cpus
  ring-buffer: Remove ring_buffer_per_cpu::mapped
  ring-buffer: Make nr_pages unsigned int

 include/linux/ring_buffer.h          |   4 +-
 kernel/trace/ring_buffer.c           | 354 +++++++++++++++++----------
 kernel/trace/ring_buffer_benchmark.c |   2 +-
 kernel/trace/trace.c                 |  92 +++----
 kernel/trace/trace.h                 |   1 -
 5 files changed, 269 insertions(+), 184 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0.691.gc56d675ccc-goog

