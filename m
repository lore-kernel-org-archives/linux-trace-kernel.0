Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819025;
	b=Kycow+CNqxw8SIB3U5fK6EZJBaqJ6BwS0knFulXDrXe2Gp+el+46pZaTgn8t/Oijuix5
	 R/Yh0DHzdIWA0uWyop4c5mQAtRCL2QU8LRkVqm2/CrxgHE7NWs2hKX8GxqRhx0EQ1asLo
	 y11LWexWJ5pwit4QlJq+7hxFjYSkkw6esZc2r/koMpZfCdgVgHPLyrD5u6Cs7amedA2WT
	 NhjBS4z2d+mupQvbNLUuQS8eP0pzNhhy5I6e9dsPwj3xhkZ4zpMoD5zRHirFlwxwZa3Xg
	 P06cfM3cIRMskhNxlSrSwKb+dD/YKGN+p1xaeHD/Fp+9Epv4VDL81MOsCuRlSkmBIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XMmoP1+qWKtXNy9UbFcoNobznW37r4Fg/NhEAO7nu0w=;
	b=kxNXdhbWxSX+WF/TPqAZBxU9P863aX1jjcwwl8M0ADnHtZbQiVLj1xHU6+DJZvvhLYIW
	 fLDl7tyjJpbcCZ+QwCr/IkuaUPX1U6k8eDdfo+qjKfnuyX2IjjFMNuJm6XeilTl6CZjux
	 aNBSl1e/WsJRrGCqcQbYpwpQSobgOsg5xOEeXhQF4jcul6Wmc+v9M9WVMeSwCCnfASUsV
	 BfOlDeX7UefgGGhG1HuWZMuwUgr/rHTIQTBx6SO7HfcP6UNEE7D/bO/AC5NN3d7YEBR9o
	 v1vDUQ8GpmpRgM6bb2irsEiVqPNae0cJGTkoCnIEcCXsETrQ0ktR1TGXsciwsLADVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oh6ImFOa;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D4606A33E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370D4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oh6ImFOa
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36c9e87d262so1414140eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793819023; x=1794423823; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMmoP1+qWKtXNy9UbFcoNobznW37r4Fg/NhEAO7nu0w=;
        b=Oh6ImFOayl0UKzLRyC4m0Cv4gfVyJ+t1b72/ZjShhLUOp1XVodT3V6dJF9jCWdxLXy
         oSs2zscPrqg5s1ycwKKFhoP3kpe2Lunz8EcUblo6fGRl98yfoqQJhpidn4EGgSuY1IJM
         NJ2JdGFtKQMFLQbFf1LMzaAZNKCiYfNG9K34Kn6IRJFwixTBEzz1Hx6qyIF81S/WwuDo
         WEIj0fc0/ZVDh4O0UPsAP/e2J1KU5AJb6wEXVI7sUSWoFYJeycIJgynR5Hf9FZe6Y/5N
         8LjaHO9S9CDc6oL8mcVK/5PGEnt/CnvuN+1w/RO1dCGujCzHni1WQ3B5RCVDxHSbyiWz
         sWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819023; x=1794423823;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMmoP1+qWKtXNy9UbFcoNobznW37r4Fg/NhEAO7nu0w=;
        b=hy7cjFLmTCngT4cDpgEvfTZHiO8bz844Ooci40Pm1y8iiDrko1h2ZmqFflcQp12l+F
         XZPpGmEzQkENv6YWyJn8s2zwGgl+xhTpz1AHBfcdciqjpv4nHWMcYhw+JvwqokW11QJQ
         CJMW7QsCbLdNZw+nBipKltT+NJsh6fYb04OY9wwnFN0QvN/tYycPtNVGUImI7un3twjR
         AFDF5mf6xUP7lCTDL78rE5ZcezppbNaNBdUJ1E/1aFU1lpqTaqCxJeaCbgOrZCCI1NgT
         Vl/tlGEfzYtpkTp83s5unQjqE7FdnPbKl0HyBLK9/x/hPEDSccvM31UJF7E1QiVq5Wx/
         XHKw==
X-Forwarded-Encrypted: i=1; AKwUvBxdz2L2o6xoWMNHqF4qEK2gQNwy9KqIcl4TGTX8H4hTYlcfFmYRS2RcTdctThKO62dJb21JKOJpSqUPvfBDlCAHvPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bg7buccxdrRFskvvSHZsI82ONap5/Zc+oQMfjD/Vu9GMFzrOh
	kengGXsfcw3DfUoLe4EMDQyPbVROoTbtlF5pP/FsN4O2FmXHwzKtxGtj9fn9TZQwgTn0RqUHimh
	cN+PePffGvlZJiqa/UbrXoZJbocDIhaHq2w==
X-Received: from dlbsv9.prod.google.com ([2002:a05:7022:3a09:b0:1ab:fb55:f657])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2097:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-1ac600d9f9bmr25256760c88.43.1793819022924;
 Wed, 04 Nov 2026 11:03:42 -0800 (PST)
Date: Wed,  4 Nov 2026 19:03:35 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <cover.1793818636.git.abhishekbapat@google.com>
Subject: [PATCH v5 0/5] alloc_tag: Introduce selective tracing for MAP
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

v5 changes:
- Patch 3/5: Introduced a new patch to introduce a flags field wrapped
  in an anonymous union with the old inaccurate field. This allows us to
  extend the UAPI with more filters without breaking backwards
  compatibility.
- Patch 4/5: Minor update to filter out trace_on tags using flags.
- Patch 5/5: Updated the test to use the new flags UAPI.

v4 changes:
- Patch 1/4: Minor refactor, changed macro definition of
  `alloc_tag_trace_hit()` for the NOOP case.

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

Abhishek Bapat (5):
  alloc_tag: Add trace events for tracing allocations
  alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
  alloc_tag: Add a flags field to allocinfo_filter
  alloc_tag: Extend allocinfo_filter to support tracing queries
  alloc_tag: Add a test for trace state toggle and filtering

 Documentation/mm/allocation-profiling.rst     |  73 ++++++++
 MAINTAINERS                                   |   1 +
 include/linux/alloc_tag.h                     | 106 +++++++++---
 include/linux/codetag.h                       |   5 +-
 include/trace/events/alloc_tag.h              | 122 +++++++++++++
 include/uapi/linux/alloc_tag.h                |  37 +++-
 mm/alloc_tag.c                                | 161 +++++++++++++++++-
 mm/page_alloc.c                               |   4 +-
 mm/percpu.c                                   |  13 +-
 mm/slub.c                                     |   6 +-
 .../alloc_tag/allocinfo_ioctl_test.c          | 114 ++++++++++++-
 11 files changed, 589 insertions(+), 53 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h


base-commit: bcc036cfa1670a64500f6d857eaa71908b79e3fb
-- 
2.56.0.506.g506a7eabc5-goog

