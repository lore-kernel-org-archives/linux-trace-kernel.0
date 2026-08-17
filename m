Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343A3D47A0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974482; cv=none; b=Mzd2oaYxpTKbS6d2avJ3NJ3BHB0iAEy5J5LTlV+8CBQrE2X+qwRzuuwjfexkQbynpxS2+l0QpITRhGdOR8qu1A+l8/grzY6fMMKP12iPoBzCwTXbYLfoNGU1zM/0ihK7zITjoo03B+/R4bSZeU4itLTz2xSTT+T+xIPEzK7uNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974482; c=relaxed/simple;
	bh=wLdvS8J+Y9CyUr3LRopLNeShbFf/fncIFik0YUXJa9k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jz4ZCBuwIu4bRnoPhUPZa/dFkK+rLS368ImDJWTipKh7DcJ8pszvVbCdkU5T3Dg2ILxoAmwZEwcSlBYbOsPBkuOhDko+ID2XiquxYMPV0SfKBfa6/KU18K1VNtquN3KPGNL39k0lJnVkMDYTksG0x4uqcNr48orG/jzswyvaQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlO9yM3I; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlO9yM3I"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495529a93f9so34414835e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974473; x=1787579273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mW/FeJu1Nbb01FNYhICdkqAU1UXHHos9+nMEqvEz9Ks=;
        b=TlO9yM3IO5eTrQ+2Gg/ckRMurNuI1LIwfYoAFO16DpwgVRNRZeeL+lZRFTbzmOn6wB
         iSYi/QCdnnRH59ysMo1pcK1N4KWlyOvqjLdF/31/rBVyl3jZw/Tdp1QaWkxGvRVcAAJj
         WIS5b7UJhO1w5zwCv1qDk4IhIYM3aekLPIZbroFzwpeNACb4G9fuxckCbK/JdiYuR33g
         IBuoWaCdjxIBEFZoE9sSZY5RdECsLQ2gD6mjXjn4SKhArvy26jhhhleaPx1t45+zKaxT
         X0ayBCtn+0KdQJH1oKy1Ne/knvIcLl1RHZAAX4vIJzHmhelUJ/7QL9I26/Di/ED5yft7
         hwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974473; x=1787579273;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mW/FeJu1Nbb01FNYhICdkqAU1UXHHos9+nMEqvEz9Ks=;
        b=entvHx4cjvs5zSVqywZCmWKDzd/nGFr0TQ40oSPKd1DoNTy5W4pOQxhw71uyjY/dqW
         l2sr1K+NwonEG4PxiUZ0r1mF7wDZFPgxv8OASw6Q1L4SjF56fXgG76aZLgqHalL8sSZf
         V6wVAZM05KIG07rhXhMqdPKaAgl+ERZwnCCaqSS1HRVvbwopz4u9jNvhELWR2mBydhb+
         k8AD7xBe1/kOuw/UjQkSVvJYmYg+A8R1sIeDzHAFy2iRZ9zbjqNn3bz5tk3wP30wO4Wb
         m0929foN216AdCIzimPPP+O0DrJmZVS3ejNwygq2uR30etmUnwzBMSjAjlhfcZivUfyL
         gYaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOioo/y+zJm5pjp0KZiOakUKzvYMLbfVHz5VDj9vbK6PY2qH1d9sb7so9ppAeEz/kpQzu0RlWajReLiTZRTrrJSV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWfmu07BWNDyZl0+2ufQDkbVmVItMK/zRvmfJP66EglyiRTic
	a681InXZ5Ag41w+eD6wDoRPOA6G3X959vtTcak4a4cNjCcRIv6bOyAFC1X/YSTZi9zoSBQmC7TP
	PiMAKuT+U7yqKLpMdDYsAZw==
X-Received: from wrrq2.prod.google.com ([2002:adf:f942:0:b0:47f:50ce:a675])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5299:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4998d7aeb77mr308215735e9.2.1786974472409;
 Mon, 17 Aug 2026 06:47:52 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:47:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817134750.3909384-1-vdonnefort@google.com>
Subject: [PATCH v7 0/3] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v7:

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
 kernel/trace/ring_buffer.c           | 182 ++++++++++++++++++---------
 kernel/trace/ring_buffer_benchmark.c |   6 +-
 kernel/trace/trace.c                 | 101 +++++++--------
 kernel/trace/trace.h                 |   9 +-
 5 files changed, 181 insertions(+), 122 deletions(-)


base-commit: 8b502bf6eb3da15f4b954ad3632335ff10ed746a
-- 
2.55.0.691.gc56d675ccc-goog

