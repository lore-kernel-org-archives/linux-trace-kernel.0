Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499228;
	b=J2YZnXA44dDEacyk5O7M3Ac2UZ1XBMdCwo7aN/r9ojrMEcdYO8ZScbInWTcQ0ETUb280
	 Pcdn6iNt0gdkqGNkdGiDBJ36n0t1kcR76YWOtbd3TD8FfaY4zj/eWmygXJ7Dj1QCmZ8P+
	 3sELacd6B7aV4eiosfBtfSL0LATLheDlECIYud5rty8nfwQgxiDjrWFDBMTZeWZ+n+Tp8
	 2RUR1aoggyAiMGnK/SF+b5K7gvc8XsPeVKY38uSiNtumEDbiZQVuIks0R1unjIG+5L5pM
	 ibp7+vgIhisvsgt7gmyVrmIbQFBqM3xn6ETahrKSCvfcil8+Rq7PIk1XSNdFjkJa/SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=//dwDWwlt0K01pJNLrRVdLtiRgsCM03tXrjKo5UHy9M=;
	b=LLU3xCs+VEaKhv+K6tPHxbwpcfysTKuj0gTPTeZ1cnvhWbSHv25b5JTs9Z6Oug7Oss6R
	 1VMrtBWc80gpM+Pb/fijUaFd2ud94aHNaSahBMq3z9oRFpXlyExkIxKpLOafPIWV2d7SQ
	 r2lJhp41dxdGIgtn9Rl/GaJ8XWzkMnLeNUMtSvnw+jI5bSjOnzr1Ldtbf0GbJqVgpKkjW
	 oEZi7I7R9wQOjgcPDj2dJchLFg+Xv15fRrZXq9+drepddFXPXCTKKVTyr4F638nOJXUkQ
	 rWxHbDdGesfdMU7R4D4oWpwqQhok0Wn982EBBPEfmgMgQpkBl1zqoGqR5gPMZx1U9+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H0H3M0Cs;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB32606A325
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB32606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H0H3M0Cs
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93ece7a73b9so258155385a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499226; x=1794104026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//dwDWwlt0K01pJNLrRVdLtiRgsCM03tXrjKo5UHy9M=;
        b=H0H3M0CsItgFBfoc8Tj7dwbmapyg4/KLDl+ED9vqhSwM4MHSdfX7/kj0EJ9XkbLsrZ
         +6YMh1M6hl2hXYLX2GSph2c1a2JcpJzR/jWrMaKgrhCrrLbtaT0xClwigTDuyBPl7QfI
         2S6ZeJyUIp6R30Xtc/iUiuH/hMK2GsjJUYx4fqMOIzOeCbO8z6ZJV1nOJ23TS6ePLr56
         BNy24LLaFGaozo1TROAT/xyuEEpNrnK4qg2KJCyaSLebEvtG/JTzQPIdrSr9TpQ/BxJk
         wS3kAk1qKz+v2r3C/E46V7jDRt8zru4RccFnv44stl8/MN2lsra91EggDRPONtyG1FBK
         Qelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499226; x=1794104026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//dwDWwlt0K01pJNLrRVdLtiRgsCM03tXrjKo5UHy9M=;
        b=Q7pi1+5dukiZgGMrFdaNT/GwqPgoxlCBGCn+aU+3JIDRogZGDKgh8QwtoGzTBoYyMC
         mKMhnuP2j61U2ycoYwsGqCwtSCS2LDARXuRSZt9+DYl/pS1dCr66xuEkjwe+rr2DSarI
         C5qHwSkO8byTbDdDYenUnPZN2Hwxrtz+mYpItuAzU9aighq9KPsxJYYjxiV/ZpQqzviN
         NrS8pGO1ZuF/UfHdAtvRKuhZH1D4+IQMizVu71H2LtwS9SrK0U4mRsk51RJxcwg77jmJ
         0sLu6VxiT4EyuS0saXgkCktd9rHXQSuN8qQhO1NPdRYQl7VeRfgseCk4uc86mQtGwA3p
         VNlg==
X-Gm-Message-State: AFq9FYIISOqvLZZWBlOCNQ809oV/OHlaY3RVk/HEoNzh77burCmhn/aZ
	tIuj/ByuQqMOSB58SvQQvGYr4zrwlG84YG7IqPrxGCXA55TAZdlaT2JiPIRUb5yU4Is=
X-Gm-Gg: AYBFou2ofPO4DIFvK0fuckKF38HqZqXLyPkstHP43lXbtIraXyjWjTY02N2ziPZSXx4
	Xj3p3vqCWYWbzuBUiOTg71xouGjYCEcmx8e66XosJPEiyNQrPuGFSZbfpdaY/UQqVeXd51XXh6t
	L0BhhdGpcKt+DJdgOFZVw6jV6FYMO69FM4INu5cYV4fDP8FqYDwJPpNOl7RApfcGLRdjEuZEgDu
	9Ld5pWWcDGCeFn2WJ/NBdFjOtTuTA51QvSVnCaCdC6StdmZIdDl5pZR8aTV+ByylyFuxsqBMnp6
	OB6wIAW8Qj3xO4APLKpM0ZLEC0eC/uRW6p9Qell1hNXbFmEsRDaD5cTUMHm6fNCeqBjBxjXmgfA
	cZopm/A34O92gci7w9q1W2dO/wbPK8aG4zFbRCF9+GrXHzzKJy5hLIWK++1BNVtAz/olw0TsHZy
	YP6rXvQDqWpTwPnC5eO4xk/9BW1t9M+aCcvtszAArzcu2gSemwkzWu+3Azcv8PnoYf+IBsGs0C8
	YFbbxnx1U9lo7IfWbmeDqOIL07kaJ3WH7CgPub1aH4Jp2ZXi2X9j3hph+OIG+0l+W0Vyiww4nVy
	53M9ozOQOwB+LjF0s4k44tUGN9qze/ZBupSorfHd+996KGHxEl4GQ087bG4sfOXdTqJNhRNNZK/
	vsGBJ0iPwsSnHEHYbiBB2MJupszvq9hY=
X-Received: by 2002:a05:620a:6406:b0:939:b057:daf2 with SMTP id af79cd13be357-9442176d62emr1044006585a.45.1793499226345;
        Sat, 31 Oct 2026 19:13:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:45 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com
Subject: [PATCH v5 0/12] mm: fix allocator races with memory hotplug
Date: Sat, 31 Oct 2026 22:13:28 -0400
Message-ID: <20261101021340.2251928-1-gourry@gourry.net>
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

Memory hotplug rebuilds zonelists in place while allocations walk them,
and offlining an emptied zone frees pagesets the vmstat worker can still
hold.

These eleven fixes cover the walkers that crash, fail, or pick the wrong
zone or node as a result, and a twelfth patch removes a helper that
invites the same bug.

   1. a restarted slowpath loses its retry with reserves
   2. offlining an emptied zone frees pagesets still in use
   3. the reclaim_retry_zone tracepoint rereads a zoneref slot
   4. the zonelist retry is compiled out without MEMORY_HOTREMOVE
   5. zonelist_zone() may load its slot more than once
   6. NULL preferred zone after a shrink rebuild
   7. __next_zones_zonelist() rereads a slot
   8. allocations land outside their zone or nodemask
   9. the hugetlb pool walk takes another node's page
  10. alloc_contig_pages() takes a range outside its filters
  11. mempolicy_slab_node() rereads a slot
  12. zonelist_node_idx() invites the same double read

Patches 1-11 are for stable.  Patch 12 is a cleanup and is not.

Patches 8-10 need patch 4, without which their retry is compiled
out on HOTREMOVE=n kernels.

Patch 8 needs patch 1.

Patches 6, 7 and 11 need patch 5, which makes zonelist_zone() read
the slot once.  Patch 12 needs patches 7 and 11, which remove the
other callers of zonelist_node_idx().

Patches 2 and 3 are patches from anthropic, pulled in from Vlastimil's
series to keep the backport issues self-contained on the series.

Testing
=======

Each race was reproduced on unmodified source in a QEMU guest with three
NUMA nodes and a 512M pc-dimm on node 1, left offline at boot.

A test module widens each window with a kprobe that stalls one CPU inside
it, as an interrupt or a vCPU preemption would.

       base                            this series
patch  outcome                  runs   outcome                  runs
=====  =======================  =====  =======================  =====
 1     NULL returned            3/3    page from reserves       3/3
 2     UAF                      6/6    no UAF                   3/3
 3     NULL dereference         3/3    allocation succeeds      3/3
 4     allocation fails         3/3    waits for the rebuild    3/3
 6     NULL dereference         3/3    ZONE_NORMAL page         3/3
 7     NULL dereference         3/3    ZONE_NORMAL page         3/3
 8     wrong zone or node       18/18  right zone and node      18/18
 9     page from node 1         3/3    page from node 2         3/3
10     1G page in ZONE_MOVABLE  3/3    1G page in ZONE_NORMAL   3/3
11     NULL dereference         4/4    keeps allocating         3/3


Cost (these tests were run on v4, v5 hasn't substantially changed)
====
Kernel instructions per order-0 allocation and free in the QEMU guest,
counted with a task-bound hardware instruction counter around 1M
iterations on a pinned kthread, non-debug kernel, mean of 15 rounds.

                           instructions per alloc+free
                             base   this series
  alloc_pages()             890.5         900.5
  bulk, nr=1, nodemask      865.5         875.5
  bulk, nr=16, per page     477.2         478.1


Bare metal, two-socket Xeon Gold 6138 (Skylake-SP, 80 CPUs).

will-it-scale page_fault1-3: each iteration touches one page, so
the unit is millions of faults per second, summed over all tasks.

Base, millions of faults per second:

  tasks                         1     10     40     80
  page_fault1, processes     0.46   4.16  10.51   9.23
  page_fault1, threads       0.46   3.51   4.35   4.19
  page_fault2, processes     0.43   3.66   9.02   8.33
  page_fault2, threads       0.43   3.48   4.37   4.19
  page_fault3, processes     3.89  14.78   8.10   8.00
  page_fault3, threads       3.87  14.29   6.88   7.96

Change in faults per second with this series, + is faster:

  tasks                         1     10     40     80
  page_fault1, processes    -0.3%  +0.1%  -3.0%  -1.7%
  page_fault1, threads      -0.5%  -1.6%  -0.9%  -0.9%
  page_fault2, processes    +0.0%  +0.9%  -1.4%  -0.5%
  page_fault2, threads      +0.3%  +1.5%  -1.4%  -1.0%
  page_fault3, processes    -1.0%  -3.8%  -0.7%  +1.2%
  page_fault3, threads      -0.9%  -0.7%  +0.8%  -0.2%

The boot-to-boot stddev is 1.0-1.8% at 1 task and up to
15% in 10-80 tasks, so basically this is all within noise.

Changes in v5
=============
- Pulled in patches from Vlastimil's series (patches 2 and 3 here)
- inline functions (Vlastimil)
- Added patch 5: zonelist_zone() reads the slot with READ_ONCE(), as
  recommended by sashiko on v4's mempolicy patch.
  Patches 6, 7 and 11 call it instead of open-coding the load.
- Added patch 12, removing zonelist_node_idx().  Not for stable.
- Patch 1: reworded the changelog (Vlastimil).
- Collected Reviewed-by tags.

Link: https://lore.kernel.org/linux-mm/20261028211930.3504634-1-gourry@gourry.net/
Link: https://lore.kernel.org/linux-mm/20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org/
Link: https://lore.kernel.org/linux-mm/20261014222456.2318284-1-gourry@gourry.net/
Link: https://lore.kernel.org/linux-mm/20261015210539.3243563-1-gourry@gourry.net/
Link: https://lore.kernel.org/linux-mm/20261019172346.3344005-1-gourry@gourry.net/

Gregory Price (Meta) (10):
  mm/page_alloc: reset can_retry_reserves when the slowpath restarts
  mm/page_alloc: detect zonelist rebuilds from memory hot-add
  mm/mmzone: read the zoneref slot once in zonelist_zone()
  mm/page_alloc: snapshot the preferred zone against shrink rebuilds
  mm/mmzone: read each zoneref slot once when filtering by nodemask
  mm/page_alloc: retry allocations that raced with a zonelist rebuild
  mm/hugetlb: retry the pool walk when the zonelist is rebuilt
  mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
  mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
  mm/mmzone: remove zonelist_node_idx()

Josef Bacik (2):
  mm/page_alloc: keep the pagesets of an empty zone
  mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone

 include/linux/mmzone.h     |   9 +---
 include/trace/events/oom.h |   8 +--
 mm/hugetlb.c               |  13 +++--
 mm/mempolicy.c             |   6 ++-
 mm/mmzone.c                |  11 ++--
 mm/page_alloc.c            | 107 +++++++++++++++++++++++++++----------
 mm/page_alloc.h            |  19 +++++++
 7 files changed, 123 insertions(+), 50 deletions(-)

-- 
2.56.0

