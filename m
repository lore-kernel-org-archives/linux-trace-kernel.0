Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2035C6B2
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412809; cv=none; b=qqnaoHqC29J0C3V3Wuq9CtwtXLLldrQcRx5Dlvu0QrzOf9ldTi68TQqEjqZGmkdE2VI6VZTQ6RO/SMl3cezKGVdjAoc/HOopScw0EzyS+EEL/bUEyE1l2AGd5aiBhbEhJsvBgLq80027Xoa9CBL5L+sC6MSE3pjMA3pe5YZyjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412809; c=relaxed/simple;
	bh=wDQs/sh20h3xtqVv0dW4uZdpBTmUfFDpqyEnKvT8U8o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vum90ViHKP1TPE9qjLszjY49xdy9dTDvuR9JVDH8G3OcMftdJPL0bS7bxXRpBMPJUqy+seWwdr2ulMdLeScJxgvcb7UmfOxv7juA/klMxMKRyhdQcT+dKaiSY88qNIZhEudXNPWYWzvcLMr8BY9nRqAfi+JoWg6KJ9I/AM5cqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKFcnT+P; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKFcnT+P"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so9280354eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791412806; x=1792017606; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIFYPTbMlvK7LEVP07VoMQmv5kgwn2c+6+4FzK8N/QU=;
        b=jKFcnT+PnFnU4LgtEEEGIA40DBSxiUpgsAKwmGWYGVfYcDDIhMOR8h8P6d/xNWJnb+
         I4ukwjJViogKU5QQ1CcbYD71CYfRpqzURvH0hXFcL2f73TFVsoMekAEW/od6FgHmvUCL
         EyimkWH39zSrY7K4r4EPhEmDMq2aaqHG3/7X1JbH2nxUqWF6LHkh12V+lotzjwDCRn91
         YJoUEqGsN8sc0CmJfQtXd3BzwsNSc4ma1Ll78W1qq5CRGyeF98YH9M5xmTAP12Jtld0D
         wj3LRCecdiZb9MDp+FJi22wX3J7c3Fwct5ersPixIw7xaGYI4i5sNYc/GeX3JULy3fB9
         k0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412806; x=1792017606;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vIFYPTbMlvK7LEVP07VoMQmv5kgwn2c+6+4FzK8N/QU=;
        b=KxxQSak+1TgNUIVhIl8egBAr++GTIR7jYbYAQgtOQcnQKfy+oTIpHYAGH08z8ZAYF3
         eguMe6OLP7QuVsvSPoJGK7aTz1J73xG0aXX00eR2Ql36lmapgo8VLb9Yx0DpeoT0UtQV
         KZqZk+evUkNOYBm+kvx5aiwCccMss0rycxjnF++bD0Uh2+gKsgZFFRvh7lAcsaj2JqhT
         v1pORksLEkrWGm7UD1TJiVBccnum2IacPEivCKqbRS2sH4z7fC4kGcgeRxP+NLPLYJo0
         Pog5A0S0oBVZu6BWCol64VroWqPPqrCvpRf3zPGg6eWn5kRqmRMig8D6EcgiERYJPmxH
         MMkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgx8J2sflEOF84P7+PihSI4sklhpBUobepAJ3SrXPFHL2HLUDmUhAk+zJ2+aULM9vj9l1B/z4kzhu8Tl0t3dRNZJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mN7cbfnstWMhfPKTAm3jtrh4rAHUQDl/MDlCxfB2XwPuLWsmWC
	9cEsN1sgudkhQ7whQ9hK4dBRbuTnoYVHLE6EO5k5TedLjiK+o3viOQwVzDOXtE8baRlbPpKFxmL
	6evKWTisWOOkBJ4CiXHFelEKj1Q0pJOo0qQ==
X-Received: from dlam7-n1.prod.google.com ([2002:a05:701b:2087:10b0:15e:35b8:18c6])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7e02:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16206b2b3e2mr4893297c88.25.1791412805684;
 Wed, 07 Oct 2026 15:40:05 -0700 (PDT)
Date: Wed,  7 Oct 2026 22:39:58 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <cover.1791410885.git.abhishekbapat@google.com>
Subject: [PATCH v2 0/4] alloc_tag: Introduce selective tracing for MAP
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing memory allocation profiling (MAP) tool accurately maintains
aggregate counters for overall memory accounting. However, relying
purely on aggregated counters restrics the visibility needed for
targeted debugging.

This patch series integrates three new tracepoints (alloc_tag_hit,
alloc_tag_mem_alloced and alloc_tag_mem_freed) directly into the
alloc_hooks_tag fast path.

Enabling trace events globally for all allocations introduces a severe
baseline overhead. To limit the performance overhead, we let the admin
select specific allocations to be traced.

A new IOCTL is introduced to allow privileged users to determine which
allocation tags need tracing enabled. The IOCTL utilizes the
pre-existing filtering mechanism to specify the allocation tags to
enable tracing on.

v2 changes:
- Patch 1/4: Changed the trace events for the page allocator to track
  pointer to the head page instead of codetag_ref.
  alloc_tag_trace_enabled() no longer takes a tag arg, that arg gets
  added in patch 2 instead where the function makes use of it.
  Introduced new sections in the Documentation expanding on the newly
  introduced trace events. Minor typo fixes.
- Patch 2/4: Toggle traces IOCTL now uses the same filter as other
  related ioctls. IOCTL returns -ENOENT if no tags match and an empty
  filter matches all tags. Added a subsection in the Documentation
  expanding on the new IOCTL.
- Patch 4/4: Updated the test to work with the new UAPI from patch 2.
  Updated commit message to accurately mention that the test flips the
  state of trace_on, verifies it and restores to the original state.

Abhishek Bapat (4):
  alloc_tag: Add trace events for tracing allocations
  alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
  alloc_tag: Extend allocinfo_filter to support tracing queries
  alloc_tag: Add a test for trace state toggle and filtering

 Documentation/mm/allocation-profiling.rst     |  73 ++++++++
 MAINTAINERS                                   |   1 +
 include/linux/alloc_tag.h                     | 104 +++++++++---
 include/linux/codetag.h                       |   5 +-
 include/trace/events/alloc_tag.h              | 122 +++++++++++++
 include/uapi/linux/alloc_tag.h                |  21 ++-
 mm/alloc_tag.c                                | 160 +++++++++++++++++-
 mm/page_alloc.c                               |   4 +-
 mm/percpu.c                                   |  12 +-
 mm/slub.c                                     |   6 +-
 .../alloc_tag/allocinfo_ioctl_test.c          | 113 ++++++++++++-
 11 files changed, 573 insertions(+), 48 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h


base-commit: a663a4c75b63341fa6cc16e15feb29f36321f5f2
-- 
2.56.0.385.gd3acb90ef8-goog

