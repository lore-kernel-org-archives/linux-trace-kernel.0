Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690708;
	b=WTw+5Y1t3dsRVD9VVhotHB4LkYEAwZzF3lLRU8O5sugRNNKWaz5byWviJq5xFM/Jy7VP
	 AfvvhXJDsYrFwZCqhtC0lgr8MbyJ9EnVlTogbySgCjJbXFOcCG8SFx3+47FvJ99iz+XQB
	 4uWR+HEsGot3malkH8GaA9IOHSXO8Hqkfz98AeQ1o+XfmH31Gr7a/EUluJiVgCp2CyplQ
	 +b7z1EmNsVsuKxs9FyBFnTELy12IlAT0JIgTzAu+V1XfpDJAEzIjOqAElxT5skNsgWvAj
	 HK1XMKWCRU6g74o5pLihA647ebXd/SopOfsHyv70JOKgv8dJZKL33Vw+yEzEOmAIQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fjiXARepIxbfti2BIQyWUwFTisje2rpKo84txmBJh7c=;
	b=QDDJEUnnv2ISEvlk519ZT9amyURu5JSfGx0QCh5xE988j0owRipfpjq4ef7zTytupGD+
	 I4KHoDyPIgg37P0Jlq2OpAxeaknqmCJjQZkhRUNEaVGIIGhWtdWbc53mjDKGYg1gepbNE
	 DPOndvQXl26jgRUZBFiXj0PekCPvYuNNze41qCy+ATYERdzkgvVBCDmpjoAxEt//J2dJm
	 IT3fVIeUCmvyf71tIOyrAayaHlXAP1zlkpn0qqT8Q687w+mNGvE3mToa4dDi9kAbhaYOm
	 If3V3YfjNJsf1RAfzbiRHEtnnvh8FEoolllr1I01zjbKAgE7ykz6nGyCbsNJ+N1IPwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dn4tiZku;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB5606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 17:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AB5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dn4tiZku
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso61716eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792690707; x=1793295507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fjiXARepIxbfti2BIQyWUwFTisje2rpKo84txmBJh7c=;
        b=dn4tiZkutPMh/7B3JxLtfOQ+VtId33zPLn8uX0jw9gIDdLgI9EmNXXfVhFvxn504sn
         fFUiHPOgp/X9PbuoRQF/segyfr5g/eo2zkCR13LAEzUnQYrOh+sWE4PQ6xLAzEz8r1K2
         HxomPEsNgzPkOjd3owtXMyMXSL6dYsfoelIWTwvWvCJUVENO8zQ1uoufxdW/FRYwILdV
         LAvx6kKxbzEiWyDNll9LgPtCO6Ag74AqLDwLkUeNtsAWyhKL4enl9m+CrSEPrnheDvJq
         DF4FlBpPfyyAl7NxUvv/AhkoUCDuiD0qD0upjbwFLH0UgiBsLXsWJoiRiz7Wh6YhwWsJ
         lfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690707; x=1793295507;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjiXARepIxbfti2BIQyWUwFTisje2rpKo84txmBJh7c=;
        b=oe0FugCLf3CZJm9RvxUoQjgobYBmMQwExaAHriM89vn4YZADLvKL41kvQx4GzE7CaT
         Ipfn/RZEgcithjEkYJdqzfbasa3H7KiDVHe37MeNwF2ANjuEIA+2k5WGarzoGVWlXT/e
         pypVidDT0m6dlKOQCsGkiHffK5fqrAB11GSuRFMR88dESwMy+H4gv2SX526zG4F4ucQi
         gQgrP9yHGu4yDFXU7FaAZolX/rdYv8QTu9MqR3rpbSLjuwK2sQPmX++9QhT2QbdaezR9
         EaMScQKvrzD9rzbC9MnuWrDj8YsN1vfsxJTjr9KR6t/5RVLincOGAW2Majfge+MXNrVK
         yjDw==
X-Forwarded-Encrypted: i=1; AKwUvBzkuyUQQqYgicbBIflFJGuBvswGNh97wulAMDPksRZDVLy2U0cMZ+wbe039zDlQ+cDhbBlb317huT7fkrYpydfi08g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIayfm/B1dzR4xdpr7E4jfpTP7/0rdTJQ5GGmUzTSe+oegaVcJo
	gmsTdZNzdTzcTBtd3GICWIBYQwIsQeVQJGuMrNrs1iODpzHHO28tz2d6Agw/b6YSg1SgtRRqsVK
	1QraaE+xfdM7okp9nuhGSLt1Z+NjTjgMCzw==
X-Received: from dyau28.prod.google.com ([2002:a05:7300:601c:b0:35a:f5b8:c8c])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88cf:20b0:35e:cfe7:4c5e with SMTP id 5a478bee46e88-3674f424b7fmr7710405eec.41.1792690706777;
 Thu, 22 Oct 2026 10:38:26 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:38:19 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <cover.1792690544.git.abhishekbapat@google.com>
Subject: [PATCH v4 0/4] alloc_tag: Introduce selective tracing for MAP
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

Abhishek Bapat (4):
  alloc_tag: Add trace events for tracing allocations
  alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
  alloc_tag: Extend allocinfo_filter to support tracing queries
  alloc_tag: Add a test for trace state toggle and filtering

 Documentation/mm/allocation-profiling.rst     |  73 ++++++++
 MAINTAINERS                                   |   1 +
 include/linux/alloc_tag.h                     | 106 +++++++++---
 include/linux/codetag.h                       |   5 +-
 include/trace/events/alloc_tag.h              | 122 ++++++++++++++
 include/uapi/linux/alloc_tag.h                |  21 ++-
 mm/alloc_tag.c                                | 159 +++++++++++++++++-
 mm/page_alloc.c                               |   4 +-
 mm/percpu.c                                   |  13 +-
 mm/slub.c                                     |   6 +-
 .../alloc_tag/allocinfo_ioctl_test.c          | 113 ++++++++++++-
 11 files changed, 573 insertions(+), 50 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h


base-commit: 5f980b2d53abf3950caff5d77b5c69dc6ebb19b6
-- 
2.56.0.257.gf7497c7d27-goog

