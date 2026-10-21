Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550385;
	b=UkNeTDBYiEskmrhhwP9b8lY6ZAEUx7ufsSQzaHbFH00ZzP4F841eT4sXq/3XVrsrZ4Q/
	 aGoFEUlj4ZQts66H/qy9ajRbNT6GyAVAUGVPQvfX41iCyH/xA2HJoKp8XfH28OLygTmcx
	 ZSmkAsux8cymmz1Wn5WIbPevg9e37x+BdCmbLC6sqfSm90kWpf8SmPS27OL4e3hP5nsrM
	 kkZ4cGYyHlWsf1Ay7iK2VKA2VN7TTMT4/AqzB4r5xHSvlpck7INM/NvM25k/SW1bI6te/
	 NVl3PbpAqdhOu6mqZh7DGcGgpwrUuGVCoEMxMkd/iZNJmjmbSxQEHTs8CPicKHRUK4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IJC2MsJ0jpysriv3T3ncr7oRZBUiitKdqEmiCZfBP3c=;
	b=XVAVSC1kjK1JH+pEQWckbYaArO36m3q4YYGpRFFTudiN7zGNHTPU4Q4ODXc3tML2u5qE
	 K89AOLQTS5VTs/LXCi77TZU3Dw5ySaVGIWWfM2gwjvjAysutQ2JEneVaKtxLfV+0yHC75
	 OfOBGr+8xsMwuZILfwVblkVLW3CK/NJ3TR5ixB7vpBsORRxSOCZtYcWQunSsCids8wH4J
	 KxxEVe8P6aud0cLquGRZQyB53irDFXoqMsC7SkYLSXev7VNdU/fqHLlZRi2HFReMIyVWA
	 PzufQsfKbD7CHRIVLhHKQWVqzyhcY+L7G6rjTfuVl7lsqkrhn037z2I/UEBvP2mlVbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nSSuRi0r;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8F606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A8F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nSSuRi0r
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b8306b9f8so4261786d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550384; x=1793155184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJC2MsJ0jpysriv3T3ncr7oRZBUiitKdqEmiCZfBP3c=;
        b=nSSuRi0rD76Z+mPU/mnWiKz039LXlRWFW6nVXhi4s3UZ+g04tOq+dsBBeZQbXCbrnS
         zK0WKL/fhXWUJSIYUchbF+SBvXI5GjYA7jvsv6e9pZUQHzTFn2ZViJO4vF7lKI2DKmNq
         NNeJ5EulFeehC2UZDJh/PGgTsfo03S3BETEUuASgDtjBSYhXpg+KSsQo4sznnRbGKfFr
         IhdcESvJMBlTwhY3hcFFgXCBd9oY4CDd9iOCqHV4wUz+UhI/7xxDb0X7FCwn6nBR2Mtb
         nEjt2lR94eOvoJc9S8orS8DHi30L2atj6DvSLNh5r3tJ3Jh/IjURTQLlkGNIJTX3Swgs
         TbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550384; x=1793155184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJC2MsJ0jpysriv3T3ncr7oRZBUiitKdqEmiCZfBP3c=;
        b=dIGRGHh98sB/SMF3pnrx+DAxOEyDFyaGnSzW4E1FuUDSnVbKDR30IiTv2bDuglpf/2
         P8kId0KglIA8nBDnj6ezPgYB16A54Pnx1eogWQ53GcNyMiOrSTfYy1TMwIKi9o3saSoE
         Z0+zbSFVZ721BxhFcDMP04TqkTU/kZN0DBDOgCbxmcGRzGZlKwc3R2KtX6e2kIG765WF
         jcn3o0Wz7hsOPgxUEoLPpXbjpnYyIKsS2YWihEIQ2pu0SZUQiyTPFhXQYvMpCwtlcyAN
         4fizFlX5dzBprWSSbQ4z30zbjuVuM8oU6SmnAB2odLNwn/YjKpOZkK7w8i2Olrm5hiYf
         +GPA==
X-Forwarded-Encrypted: i=1; AKwUvBxospL2vdAxn5NraI2QFXZI3YdpjASoz/5SvumxB7fnOtVZt6amubhhF1kLH61mBeFgBsPY3sWNvWymCeFT7qAFifA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJET6LHzHK6slq/5l+KUWW4saC5LS/M6oZzs+iOf12Ato9FIM3C
	bLzUgDuSs+M6g8A00z5w8usqS7dnci/++fKrRbZ5+HNfm2bZMzPq2GFsxxqL+VKRDnU=
X-Gm-Gg: AYBFou1EBoj3XNkxUD39xSwZ49PAzdkcXtzglJn2QSxqR3nY+mQ5x0/pDn90QOtlcJM
	yCXfqUtmBot5BEL6I2IjGym8vK55Y6f15Z3nZfkcKhLm8gnnStt/x0tf1z7MTnKflQufbWk+a1A
	yIWNHNcNL+jgwjbeIu6Maq5gmuowIEfNHguH4fwQiGtxAZc4IFotzctuGqGDdIVl2fJHf/CSq8U
	ymiCIhnm4NL+fT5WV1KBTesLCbWPwWt6ZIUe0UpwzX+Ct9dleODl++LNIMziVrdp9t2U/0TaKae
	gRQpTs4DgwPnWYCupj8GYa/4cXhx02SXuwN/28oO9xcgkLbxj8Yp5wC5MdIs+sYEPrsjjmFbZwU
	GGhHaXRDOYMdEFo0QX3U7zdEndgPL7wqXcpr9aiji6EC7dmiS1sTrLX4Pzuyxpe78lkhSspzgpM
	O1GDLjPx+/AC2g4/QyPsqxFkaeVfYbF5kcbALUNjUVJ9ysqc04PixN+wa/hLViMFAl38ssLypo2
	Yvj1YJq0rY7xhaM6oWXGU96dWdxrFPlL+F4rSP244RONycJYBZMSG8+ep+p68SVMJvRpOi48c5f
	+W8HqKT5Q0gYpUBgmfLlaTP433QHQBEk6vjXPJudhg==
X-Received: by 2002:a05:6214:3bc5:b0:91b:8059:5037 with SMTP id 6a1803df08f44-91c12ee3a7dmr14525426d6.32.1792550384097;
        Tue, 20 Oct 2026 19:39:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:43 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com
Subject: [PATCH v3 0/8] mm: fix allocator races with memory hotplug
Date: Tue, 20 Oct 2026 22:39:32 -0400
Message-ID: <20261021023940.1940971-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eight fixes for allocator paths that can act on state another CPU is
updating: zonelists rebuilt by memory hotplug, and the pagesets of a
zone that offlining empties.

I've packaged these together because they're all related to hotplug.

*** Backport note - Patches 5-7 build on patch 1: without it, their
    retry is compiled out when CONFIG_MEMORY_HOTREMOVE=n.

Most of these race conditions stem from zonelists being re-ordered
in-place at runtime during hotplug.  The result is a mixture of failed
allocations, NULL dereferences, incorrect placement (GFP_KERNEL in
ZONE_MOVABLE), node misplacement, or incorrectly allowing hugetlb /
contig allocations on a node/zone otherwise not eligible.

Most of these are incredibly narrow race conditions, but since the most
likely impacted machines are VMs with memory hotplug, the narrow
condition can more easily occur when a vCPU takes a long interrupt / VM
exit of some kind.  I've made all of these race conditions
deterministics with a kprobe reproduction module described below.

Reproducers
===========

All eight races were reproduced on unmodified source in a QEMU guest
with three NUMA nodes:
   node 0: 3G, CPUs 0-1
   node 1: 1G ZONE_NORMAL, CPU 2
   node 2: 1G ZONE_NORMAL, CPU 3

And a 512M pc-dimm cold-plugged on node 1, left offline at boot
(CONFIG_ACPI_HOTPLUG_MEMORY=y).

Patch 1 needs CONFIG_MEMORY_HOTREMOVE=n to show the failure
Patch 3 needs mm/mmzone.o built with -fno-inline -fno-ipa-sra,
        without which the two reads are merged.
Patch 4 needs the reclaim_retry_zone tracepoint enabled.
Patch 7's hugetlb case needs a 64G guest (node 1: 4G) so that one
        memory block is 1G, with a 2G pc-dimm on node 1.

The windows are a few instructions wide, so I used a test module to
widen them with kprobes that stall one CPU inside the window. This
emulates an interrupt or vCPU preemption.  The vCPU preemption is the
more likely event to cause this at large scale with memory hotplug.

Patch 1 (zonelist):

  Online node 1's first memory block as ZONE_MOVABLE, which rebuilds
  node 1's zonelists.

  Stall the rebuild after it writes ZONE_MOVABLE into the first entry
  but before it writes ZONE_NORMAL into the second.

  On another CPU, allocate GFP_KERNEL | __GFP_THISNODE from node 1.

  Before: the allocation fails, 3/3 runs.
  After:  the allocation waits for the rebuild and succeeds, 3/3 runs.

Patch 2 (preferred zone):

  Online node 1's block as ZONE_MOVABLE, so node 1's local zonelist is
  [MOVABLE, NORMAL].

  On another CPU, allocate GFP_KERNEL | __GFP_THISNODE from node 1,
  whose preferred slot is NORMAL, and stall it after it loads the zone.

  Offline the block, which rebuilds the list as [NORMAL] and moves the
  terminator into the preferred slot.

  Before: NULL dereference in get_page_from_freelist(), 3/3 runs.
  After:  the allocation succeeds from ZONE_NORMAL, 3/3 runs.

Patch 3 (slot reread):

  Online node 1's block as ZONE_MOVABLE, so node 1's local zonelist is
  [MOVABLE, NORMAL].

  On another CPU, allocate GFP_KERNEL | __GFP_THISNODE from node 1
  with nodemask {1}, and stall it after __next_zones_zonelist() tests
  the NORMAL slot for NULL but before it reads the slot again.

  Offline the block, which rebuilds the list as [NORMAL] and moves the
  terminator into that slot.

  Before: NULL dereference in zone_to_nid(), 3/3 runs.
  After:  the allocation succeeds from ZONE_NORMAL, 3/3 runs.

Patch 4 (tracepoint):

  Online node 1's block as ZONE_MOVABLE, so node 1's local zonelist is
  [MOVABLE, NORMAL], and enable the reclaim_retry_zone tracepoint.

  On another CPU, allocate GFP_KERNEL | __GFP_THISNODE from node 1, with
  its get_page_from_freelist() calls failed so that the slowpath reaches
  should_reclaim_retry(), and stall it in zone_reclaimable_pages() for
  node 1's NORMAL zone.

  Offline the block, which rebuilds the list as [NORMAL] and moves the
  terminator into that slot.

  Before: NULL dereference in the tracepoint, 3/3 runs. With the
          tracepoint disabled, no oops (1 run).
  After:  the allocation succeeds from ZONE_NORMAL, 3/3 runs.

Patch 5 (zonelist slots):

  On one CPU, allocate GFP_KERNEL with a nodemask, and stall it after
  the iterator approves its first zonelist slot but before the
  allocator loads the zone from that slot.

  Online node 1's first memory block as ZONE_MOVABLE, which inserts
  ZONE_MOVABLE at the front of node 1's zonelists.

  This was run for single-page and bulk allocations, and for a
  single-page allocation whose fast path is made to fail so that the
  slowpath's walk races.

  Before: nodemask {1} gets a node 1 ZONE_MOVABLE page and nodemask
          {2} a node 1 ZONE_NORMAL page, 18/18 runs.
  After:  nodemask {1} gets node 1 ZONE_NORMAL and nodemask {2} gets
          node 2 ZONE_NORMAL, 18/18 runs.

  The check adds 5 instructions to an order-0 allocation on x86,
  counted with a hardware counter on a non-debug build.

Patch 6 (hugetlb):

  Reserve hugetlb pages on every node. On CPU 1, fault a hugetlb page
  bound to node 2 with mbind(); the pool walk uses node 0's zonelist,
  where node 2 follows node 1. Stall the walk after it approves
  node 2's slot.

  Online node 1's first memory block as ZONE_MOVABLE, which shifts
  node 1's ZONE_NORMAL into that slot.

  Before: the page comes from node 1, 3/3 runs.
  After:  the page comes from node 2, 3/3 runs.

Patch 7 (alloc_contig):

  Write 1 to node 1's 1G nr_hugepages, and stall the gigantic page's
  zonelist walk after it approves node 1's ZONE_NORMAL slot.

  Online node 1's first memory block as ZONE_MOVABLE, which inserts
  ZONE_MOVABLE into that slot.

  Before: the 1G page is allocated from ZONE_MOVABLE, 3/3 runs.
  After:  the 1G page is allocated from ZONE_NORMAL, 3/3 runs.

  Calling alloc_contig_pages() directly with GFP_KERNEL in the first
  guest, as in patch 5, nodemask {1} gets a ZONE_MOVABLE range and
  nodemask {2} a node 1 range before, 3/3 runs each, and neither after.

Patch 8 (pagesets):

  Online node 1's block as ZONE_MOVABLE, then offline it.

  Stall the offline before the zone empties, and stall the vmstat
  worker on another CPU (kicked through /proc/sys/vm/stat_refresh) in
  decay_pcp_high() for that zone. Let the offline free the pagesets,
  reallocate the freed percpu area with a known value, then release
  the worker.

  Before: decay_pcp_high() runs on the freed pageset, 6/6 runs. In
          1/6 the area was reallocated before the worker resumed, and
          decay_pcp_high() rewrote the new object.
  After:  the pageset is not freed, 3/3 runs.

All eight reproducers also pass on the series tip, 3/3 runs each.

Changes in v3
=============
- Replaced v2 patch 2 (zonelist_zone_valid() recheck) with patch 5,
  which checks zonelist_update_seq whenever an allocation succeeds
  (Vlastimil). A raced attempt's page is discarded, so a stale preferred
  zone can no longer affect the result (Sashiko).
- Moved the NULL dereference fixes ahead of patch 5.
- Added patches 6 and 7 for the hugetlb pool walk and
  alloc_contig_pages(), which have the same slot shift.
- Added patch 4 for the reclaim_retry_zone tracepoint's re-read.
- Fixes: tags on patches 2-6 now name the stop_machine
  removal that made rebuilds run concurrently with zonelist walks.

Link: https://lore.kernel.org/linux-mm/20261014222456.2318284-1-gourry@gourry.net/
Link: https://lore.kernel.org/linux-mm/20261015210539.3243563-1-gourry@gourry.net/
Link: https://lore.kernel.org/linux-mm/20261019172346.3344005-1-gourry@gourry.net/

Gregory Price (Meta) (8):
  mm/page_alloc: detect zonelist rebuilds from memory hot-add
  mm/page_alloc: snapshot the preferred zone against shrink rebuilds
  mm/mmzone: read each zoneref slot once when filtering by nodemask
  mm/page_alloc: pass the zone, not the zoneref, to reclaim_retry_zone
  mm/page_alloc: retry allocations that raced with a zonelist rebuild
  mm/hugetlb: retry the pool walk when the zonelist is rebuilt
  mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
  mm/page_alloc: keep a zone's pagesets when it goes empty

 include/trace/events/oom.h |   8 +--
 mm/hugetlb.c               |  13 +++--
 mm/mmzone.c                |  11 ++--
 mm/page_alloc.c            | 106 +++++++++++++++++++++++++++++--------
 mm/page_alloc.h            |   3 ++
 5 files changed, 107 insertions(+), 34 deletions(-)

-- 
2.53.0-Meta

