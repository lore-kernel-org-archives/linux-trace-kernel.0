Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440032;
	b=uioKfNvu6uNyGL99cqwVwrNrXe/HThHuFzdrveTFaE7uz1UESQz9ipoU5Vv/g6+sV78b
	 VhkyJFatC58I03piYyrtI5L5/nnGL8YEg0sIpjRL3YNkU7ZfBkxNx4u8mvRo5tTq5abkc
	 scM6nt0aE1mc2u15STXlJ3J4hXjzobQfruLmawmSadIlyBVjQ32mLV3X8yUs/DD+k33yZ
	 9Xs/wm3kE86RzwLNBINeChxjPvL7+34J/8HIO4W+IsBCiamcSRZMPZM/G44Kbph8vaI62
	 OhkrplOaHxpjUI+Ea6rCmVCpTFAfkhcf+VwTGUypKIiuwlzfuwZVH9L4YdzSiV5qsGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=i+///8mnECIM/kitzuhNw6Hg5zOvNqOpkINZPbtisJU=;
	b=FIYVKNQ4bonDAewCAyFpwnx5ls693yzUK2Z29k193HAySNQhD2h+7zcuKGsgOA15fm9F
	 A/EIvpOvtcYgS/yWujZhlVuM/1hSo1F+c55Afl6WNwFkUqixgZH0rFSTCMMPb5cOjnYVr
	 fIHGnqHkJcrFFMmB55fMZtNGI7SjPXBL3mv7qG7Un5nONDtm4TUf/f/rSYeOw9izDx6Lf
	 Sn4PlE4uSFalSk7MhJN/NanLgDzfuCQJ6EWN6aobzcFPurqKeGhESQ7IccUbhKIPQ/qtR
	 FmBjZOR2VJnaUDpfHZwwNTewzznd5GMZVvKzKb1qS9gziUyy3hV/IMlz+vj+etq+v8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=W4OTN2wS;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D6606A319
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C0D6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=W4OTN2wS
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so6304417eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440031; x=1793044831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+///8mnECIM/kitzuhNw6Hg5zOvNqOpkINZPbtisJU=;
        b=W4OTN2wSGX+iJF02FjnMhtc8QQRsGRKcVs2U57m+y0v/ffear/cMUrUDHXumScPdiw
         S0FvXpy4JaKRHZVT9/4DvL/c76b/mBFwyKryyY9QYvLyFZUoYigcffT9/ZmScUgj/1VV
         DFjUNossJluJpGDSUH8QAQpYyckaIevwmvFiqHsXN05IrGwTGAeTUiW4tXnxJvw9oerA
         BZjMrm2E0Hfxc7Ul08Cj1L58t3DVvhqdEbLJJSB8Rryct6bURy7SWWPH6RcxUgEVpYLn
         aq0x2Qp36I0UxX+H5zP1eJ0yVzBTPDJj1PkQdN5MkfJjJFY+Y2jWHFNXm/ikJdffyRlJ
         fgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440031; x=1793044831;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+///8mnECIM/kitzuhNw6Hg5zOvNqOpkINZPbtisJU=;
        b=sMNEHv9s0w00a0jEai6HDrxlgZKJGrbpiGLtjkG65Ibz8dMqR1UuXq6f+ZP6lHOW50
         oV5Q9/lfrb2d8HKKFzpJIU7f3ZNveBWf5tt1oUrtCknD+ICdK+acgKt9PWwKcpTuzw6H
         Nsfxl+J6rdcm+qgXKl7MjNh9mvHFxURb4iO1krWARp2AKhQT8RRgQpGbga+QoHyHKBwu
         nMo4DOV9e9c+MghULBmVwtoXcCTrTyp/ASNdNDpAj/wUoCGgbYss5IXguYGaNuypEln9
         5r2AXxEUWCyG9b4dUHZpAyBuy2go3Bg6im/7jW/HMeKGPUZcjmalXo0B0jBLuiJb5O3D
         COFA==
X-Forwarded-Encrypted: i=1; AKwUvBy8Lv4dNdwgof2UssRJadLAfFWGJYDF57bRh7ZrVGj2H1rUVBlORfEdIJ3MgLL9gbs4V4zEy8/czaJ7ijCZDx80Bpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw9AW5Net0ZVEpeIoyOjClpSMan889bbVmxNTtNmKyW6CS7VuM
	XQ5BQEB8qUKsS63SflbP2oPdHUwnBvddVihXjT6I5f4Vtpw89jrjWLWD3YLp8wPEH80yqD9Bn4k
	+aNdn0Mts2H6NEcwDoZXI7CdLiep4J6vdUQ==
X-Received: from dycmb7-n1.prod.google.com ([2002:a05:693c:20c7:10b0:350:9a68:218d])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8092:b0:35c:ea0d:a9a6 with SMTP id 5a478bee46e88-361a2942afcmr13177681eec.32.1792440030193;
 Mon, 19 Oct 2026 13:00:30 -0700 (PDT)
Date: Mon, 19 Oct 2026 20:00:23 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <cover.1792439751.git.abhishekbapat@google.com>
Subject: [PATCH v3 0/4] alloc_tag: Introduce selective tracing for MAP
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

v3 changes:
- Patch 2/4: Minor refactor, documented the `CAP_SYS_ADMIN` requirement.
  Moved the mutex lock / unlock outside the for loop.

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
 include/trace/events/alloc_tag.h              | 122 ++++++++++++++
 include/uapi/linux/alloc_tag.h                |  21 ++-
 mm/alloc_tag.c                                | 159 +++++++++++++++++-
 mm/page_alloc.c                               |   4 +-
 mm/percpu.c                                   |  13 +-
 mm/slub.c                                     |   6 +-
 .../alloc_tag/allocinfo_ioctl_test.c          | 113 ++++++++++++-
 11 files changed, 572 insertions(+), 49 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h


base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a
-- 
2.56.0.218.g1ec904b173-goog

