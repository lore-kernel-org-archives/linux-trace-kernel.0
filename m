Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E893C3BFE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722509; cv=none; b=Z5/JHFR8+oLG9m1OczZcho1l8Nkeh5r9Peesv710snT5rxeCi4gVh+p6tQP7cKQcVNQhOLuMagJF0mHVj+NM0SYI64KkYD/PAYOt7yJMai1nWBIf1w6/ONkDAU1Pt3UGQ3iYI4xXty/GwGwbrrJ+kN5PvqTPCOkMpGtT8NU+pbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722509; c=relaxed/simple;
	bh=CT3raZkyWosW2On+45UqKAN16xN0mxzB57n3jmm7+14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YfAceFPJYIsr7zvv0nIsYpKrJWiLzESOhizYysMUdzhPcFJ/ozH1uuxtIR3nEP4LUYA21AHTaC6Nn1Vdqrun/j+6USp1zWbuUSTLoSoq/auqw5dJPf+w+RSmqGlS1biZbOVKvl/KKdrlsyxYN3C/rCB/t4Q09QudgX3R5MnQ464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQs84e40; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQs84e40"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4997d718093so7704175e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722506; x=1787327306; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjOXkQ8OMNAXPbWwcLoG5hyYdddbyNivq1QN045t1eI=;
        b=eQs84e40Kvkr6PAvScW9RoxXTyX192BXfwmeNpGDPJSmAHF7Gu2nZ1p5SvlO+FrpPP
         KCh2LRCZ2uOYy99IW5MOxyxgMndPk0Wy9Ih+olvsqOKwQIrITOwjMrFmWpG5xgZJ+Iya
         Eudgq1rtiIXmzYZqgXDUPgs0qtcgD9o7VT0ZRmY629qElKrGqNgTGvyfg4YfGiKdp1TX
         7q0yA2BMsDV2VwvsSi6U1/QHUnQgNIA2diwDp6if14/EL8xYkNWh1alQdaAf2Hrr5+KI
         awtP19sEx0G1ubeRZUFZ2h3sUW1c6b5noFAI4Ma+3j3y+PjADX3DUn50jDnxv4JTj8MC
         +53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722506; x=1787327306;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjOXkQ8OMNAXPbWwcLoG5hyYdddbyNivq1QN045t1eI=;
        b=HxxX71NluOjKXnHbIN6x8G6aaVVNzrbDJidBbBzFUMEOys8QAybudvdHpDlVtnrtsB
         6DSSuB3s3sXpqLlgQuhro+tfUMS3NPB8QBWMGCRoS9O2cjzr64eJ4IjFD2Fe1kMPsiGB
         8clFvNBO8XpmmLhKJlG/A1S4MFqk8bHsBVpZukiVWdNrlRHU/psk1IpPFpC8aJHQvDf8
         djTnUTXqzaXROG2+76/usN4uMOf9UW3VxisyNA6yKG9mViFak7Bop/aO2iDVjFIH+LBY
         jAMaB/hUtm+J4t0ymx1CVn220cw+MaRVAUlEL4i0iC6Iujdqkq4elqTZvztqBNCob35z
         uqgg==
X-Forwarded-Encrypted: i=1; AHgh+RpwM2PyDhpOcePJCy8fpVF4zi8I9Q5VSCdOrouJxdvIOjHDi2Sk2U5d1Pkk4RLbReO64Hyou+I7CvgXgJGDFvlKgbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzESe3hUn1ClKkIQrl3DRckC4iVhtUHe3uJ/YpC8BfOa3m9pkCz
	2kPExNLmejpZsK8v1UKjmig6cZDhzPyFY9ovuc3LHTKkB2O5c7Wr9s+ItHiKNVxACeNJqG7G0Gj
	cWvaPSIgy91lVC0GySOWOew==
X-Received: from wmma14.prod.google.com ([2002:a05:600c:224e:b0:495:5422:15f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-49987928d0cmr109063435e9.3.1786722505911;
 Fri, 14 Aug 2026 08:48:25 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:21 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814154823.755406-1-vdonnefort@google.com>
Subject: [PATCH v6 0/2] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v6

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

Vincent Donnefort (2):
  tracing: Fix subbuf resize races with trace_pipe_raw readers
  ring-buffer: Improve nr_pages type

 include/linux/ring_buffer.h          |   5 +-
 kernel/trace/ring_buffer.c           | 146 ++++++++++++++++++---------
 kernel/trace/ring_buffer_benchmark.c |   6 +-
 kernel/trace/trace.c                 | 104 +++++++++----------
 kernel/trace/trace.h                 |   9 +-
 5 files changed, 159 insertions(+), 111 deletions(-)


base-commit: 5f0775c9f72fd284028d955abb7098ecf212a604
-- 
2.55.0.691.gc56d675ccc-goog

