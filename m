Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA034199931
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977541; cv=none; b=Peyzo9Y9UrxVWyj0cOP3WhkzdFjPY/PI+ISoAzeMQOWTAZ/I+W++TWeEchLcnqdKc+LbNHZqSab/QblDo+IvbKSN/uZ6Jb+z8o9wZyLLLzFe/P3hymvtpv/FOr1X5295B/7pNv7ZlGWrCJo3Ljd1sHiOqdi7RarIVJWvyo/jCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977541; c=relaxed/simple;
	bh=OhsYRvQ0+++zYLai0AZulPI1XO3JJvflgRCC6u/WXJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/4hCSGwq9FzYiS2QMeLdPrxJCQmsdR0BZNvtl9EPwl18SN+Dsk8BSdgFr96xSRWciqlDs10LdMQEbimLoYoFncizaNurPNCaUym/7fdKcGK0WDIEb4DvMKitIk5XmRbu3+XqdFDK6VKmQeKwmSjGP45X1QS2Qs8AlhiNlbymag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpnsYzGn; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpnsYzGn"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6443bc360bdso2307230d50.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 15:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764977539; x=1765582339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjASHCs44SnDjJeYh3qYw2ycI6GE9TKZGAruEoGfPyQ=;
        b=kpnsYzGnWr6v0Tn08xK0XnW9Hq7URMIcYu1TgYfk8N8Wh377Y2tfzA+fEnpKNvAne0
         yV+BfR5nYDxazT+d2CYQXrD6vaMS/BFAXPfefeozd0gJ7wUIJw7n36mWNp4gvIEPW78D
         jz0qYkYasTU9yJ7k+6r+jqNIOLnORFSkYJQFe6m/6sMCKtPcnf1BpofdFBRQjNrr1h0j
         1/pNm6/dRY9gF/qz/rFvcPi3TCd06LlVimAU8wBwpPHffUOSLNCAeTQVOHc5aWG0bbGB
         tuEwFDC6pGn4GRnY8Mrr0IropbV0/kEUp0KY+K5xTHBfbV2AEYpp9RUZMz1jSCtFDZo9
         57Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764977539; x=1765582339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjASHCs44SnDjJeYh3qYw2ycI6GE9TKZGAruEoGfPyQ=;
        b=F5l+TdksXpm97+sVgemeRPMhC1pn2Hhqy2Ngm18y6hSyXS92sD5kGO8SV7PO5F2s2D
         LJx+pjbKKyNXCsKLHHZ5ZrnetxEp0UlJ+zFsyT3VMJ/Ix8jRb2F6eDqHhnBPTPxV0dhQ
         tjJwbiXkhDACBFrXhH37QLp/+9k/004uKSp3tF8+9pYw7wGZ5oMHNn3BAb9JL6ZUY2aK
         dCxQ3vEk3FFUH7Y0P+MT9CiMEK1i2i2nkw0MHfPKWVruBO/Oy0vYUf9UI1IjZHmb8/li
         sxGH24L2DnrAHpM6FiSG/n8jCPD8jhfKZowcRl1io6/j5R1I7VrTtkNqAaa4szITMx4C
         vOOw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJJd2OsIbFyPEcj0qbajj+5nFR/Cxrj/OUFcnQ1caz2/HrvXr80Le7ZgVKPvL/LnteSO0LiTi2di4VUT3ZYNsCrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtx3AowYU3gStJAK4UFrNADtqvKW35WgO8QzSNcqHuol9ms8Q
	RvqvvuNqeEHmjFmEGkLGq235jQyz+VcAwHFi1tPiIItxvWkd5BQain/C
X-Gm-Gg: ASbGnctuUBqcGkpfapry3BO3LVr5AD2D+zGyUOWXg9hqkkW/9Y9Bcbl9GZMNthiKfEN
	9kATNHVad7YpXxWZemRKZ0gB7fB/KVyyi9lXVyKCOHcaBPK2ttuO+vmtDpyEd+1WbcT2B9+8IyZ
	7HJ5jmqJ9VZtnWQzQ0OJoTXRJSc27D6XeQrJ2MxysMUGRz7wfH6rjdUQVuxfGR+wpRHoiE1ppCa
	ne1pt1kg8+FEJDhOIyNvv97Gq9xahQYPEXzHgLrmW+whSg4oI1ijMnqn+3BP+zEwM07Ko8An1U2
	+/SO0MYKjIhQj0U69Z+ONxIxdRWRwvb0dl6/JDW9EW2g3ODnGH9T9t9P30qA5ZjY4uT3aYv7eSn
	qbV4hEZn2eH1mHh0g9lhMozM3pLG7xE3m4w+YoLDPUjL6mz7ODpx6KSJ5EyjiUPSc/UKW6TRaVp
	KlYAP3RGRFrhyk23IRx0vzZA==
X-Google-Smtp-Source: AGHT+IHM12t6gDjzVKLcRmx1gB6wbrzIhaFWpatYaAHdWKPgKCT1195aVWoslNVYKST9kzwC9iOyBA==
X-Received: by 2002:a05:690c:7002:b0:786:4f8a:39b5 with SMTP id 00721157ae682-78c33c9797amr14147897b3.59.1764977538563;
        Fri, 05 Dec 2025 15:32:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4d66fesm22045327b3.23.2025.12.05.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:32:18 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: willy@infradead.org,
	david@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel-team@meta.com
Subject: [RFC LPC2025 PATCH 0/4] Deprecate zone_reclaim_mode
Date: Fri,  5 Dec 2025 15:32:11 -0800
Message-ID: <20251205233217.3344186-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello folks, 
This is a code RFC for my upcoming discussion at LPC 2025 in Tokyo [1].

<preface>
You might notice that the RFC that I'm sending out is different from the
proposed abstract. Initially when I submitted my proposal, I was interested
in addressing how fallback allocations work under pressure for
NUMA-restricted allocations. Soon after, Johannes proposed a patch [2] which
addressed the problem I was investigating, so I wanted to explore a different
direction in the same area of fallback allocations.

At the same time, I was also thinking about zone_reclaim_mode [3]. I thought
that LPC would be a good opportunity to discuss deprecating zone_reclaim_mode,
so I hope to discuss this topic at LPC during my presentation slot.

Sorry for the patch submission so close to the conference as well. I thought
it would still be better to send this RFC out late, instead of just presenting
the topic at the conference without giving folks some time to think about it.
</preface>

zone_reclaim_mode was introduced in 2005 to prevent the kernel from facing
the high remote access latency associated with NUMA systems. With it enabled,
when the kernel sees that the local node is full, it will stall allocations and
trigger direct reclaim locally, instead of making a remote allocation, even
when there may still be free memory. Thsi is the preferred way to consume memory
if remote memory access is more expensive than performing direct reclaim.
The choice is made on a system-wide basis, but can be toggled at runtime.

This series deprecates the zone_reclaim_mode sysctl in favor of other NUMA
aware mechanisms, such as NUMA balancing, memory.reclaim, membind, and
tiering / promotion / demotion. Let's break down what differences there are
in these mechanisms, based on workload characteristics.

Scenario 1) Workload fits in a single NUMA node
In this case, if the rest of the NUMA node is unused, the zone_reclaim_mode
does nothing. On the other hand, if there are several workloads competing
for memory in the same NUMA node, with sum(workload_mem) > mem_capacity(node),
then zone_reclaim_mode is actively harmful. Direct reclaim is aggressively
triggered whenever one workload makes an allocation that goes over the limit,
and there is no fairness mechanism to prevent one workload from completely
blocking the other workload from making progress.

Scenario 2) Workload does not fit in a single NUMA node
Again, in this case, zone_reclaim_mode is actively harmful. Direct reclaim
will constantly be triggered whenever memory goes above the limit, leading
to memory thrashing. Moreover, even if the user really wants avoid remote
allocations, membind is a better alternative in this case; zone_reclaim_mode
forces the user to make the decision for all workloads on the system, whereas
membind gives per-process granularity.

Scenario 3) Workload size is approximately the same as the NUMA capacity
This is probably the case for most workloads. When it is uncertain whether
memory consumption will exceed the capacity, it doesn't really make a lot
of sense to make a system-wide bet on whether direct reclaim is better or
worse than remote allocations. In other words, it might make more sense to
allow memory to spill over to remote nodes, and let the kernel handle the
NUMA balancing depending on how cold or hot the newly allocated memory is.

These examples might make it seem like zone_reclaim_mode is harmful for
all scenarios. But that is not the case:

Scenario 4) Newly allocated memory is going to be hot
This is probably the scenario that makes zone_reclaim_mode shine the most.
If the newly allocated memory is going to be hot, then it makes much more
sense to try and reclaim locally, which would kick out cold(er) memory and
prevent eating any remote memory access latency frequently.

Scenario 5) Tiered NUMA system makes remote access latency higher
In some tiered memory scenarios, remote access latency can be higher for
lower memory tiers. In these scenarios, the cost of direct reclaim may be
cheaper, relative to placing hot memory on a remote node with high access
latency.

Now, let me try and present a case for deprecating zone_reclaim_mode, despite
these two scenarios where it performs as intended.
In scenario 4, the catch is that the system is not an oracle that can predict
that newly allocated memory is going to be hot. In fact, a lot of the kernel
assumes that newly allocated memory is cold, and it has to "prove" that it
is hot through accesses. In a perfect world, the kernel would be able to
selectively trigger direct reclaim or allocate remotely, based on whehter the
current allocation will be cold or hot in the future.

But without these insights, it is difficult to make a system-wide bet and
always trigger direct reclaim locally, when we might be reclaiming or
evicting relatively hotter memory from the local node in order to make room.

In scenario 5, remote access latency is higher, which means the cost of
placing hot memory in remote nodes is higher. But today, we have many
strategies that can help us overcome the higher cost of placing hot memory in
remote nodes. If the system has tiered memory with different memory
access characteristics per-node, then the user is probably already enabling
promotion and demotion mechanisms that can quickly correct the placement of
hot pages in lower tiers. In these systems, it might make more sense to allow
the kernel to naturally consume all of the memory it can (whether it is local
or on a lower tier remote node), then allow the kernel to then take corrective
action based on what it finds as hot or cold memory.

Of course, demonstrating that there are alternatives is not enough to warrant
a deprecation. I think that the real benefit of this patch comes in reduced
sysctl maintenance and what I think is much easier code to read.

This series which has 466 deletions and 9 insertions:
- Deprecates the zone_reclaim_mode sysctl (patch 4)
- Deprecates the min_slab_ratio sysctl (patch 3)
- Deprecates the min_unmapped_ratio sysctl (patch 3)
- Removes the node_reclaim() function and simplifies the get_page_from_freelist
  watermark checks (which is already a very large function) (patch 2)
- Simplifies hpage_collapse_scan_{pmd, file} (patch 1).
- There are also more opportunities for future cleanup, like removing
  __node_reclaim and converting its last caller to use try_to_free_pages
  (suggested by Johannes Weiner)

Here are some discussion points that I hope to discuss at LPC:
- For workloads that are assumed to fit in a NUMA node, is membind really
  enough to achieve the same effect?
- Is NUMA balancing good enough to correct action when memory spills over to
  remote nodes, and end up being accessed frequently?
- How widely is zone_reclaim_mode currently being used?
- Are there usecases for zone_reclaim_mode that cannot be replaced by any
  of the mentioned alternatives?
- Now that node_reclaim() is deprecated in patch 2, patch 3 deprecates
  min_slab_ratio and min_unmapped_ratio. Does this change make sense?
  IOW, should proactive reclaim via memory.reclaim still care about
  these thresholds before making a decision to reclaim?
- If we agree that there are better alternatives to zone_reclaim_mode, how
  should we make the transition to deprecate it, along with the other
  sysctls that are deprecated in this series (min_{slab, unmapped}_ratio)?

Please also note that I've excluded all individual email addresses for the
Cc list. It was ~30 addresses, as I just wanted to avoid spamming
maintainers and reviewers, so I've just left the mailing list targets.
The individuals are Cc-ed in the relevant patches, though.

Thank you everyone. I'm looking forward to discussing this idea with you all!
Joshua

[1] https://lpc.events/event/19/contributions/2142/
[2] https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
[3] https://lore.kernel.org/all/20250805205048.1518453-1-joshua.hahnjy@gmail.com/

Joshua Hahn (4):
  mm/khugepaged: Remove hpage_collapse_scan_abort
  mm/vmscan/page_alloc: Remove node_reclaim
  mm/vmscan/page_alloc: Deprecate min_{slab, unmapped}_ratio
  mm/vmscan: Deprecate zone_reclaim_mode

 Documentation/admin-guide/sysctl/vm.rst       |  78 ---------
 Documentation/mm/physical_memory.rst          |   9 -
 .../translations/zh_CN/mm/physical_memory.rst |   8 -
 arch/powerpc/include/asm/topology.h           |   4 -
 include/linux/mmzone.h                        |   8 -
 include/linux/swap.h                          |   5 -
 include/linux/topology.h                      |   6 -
 include/linux/vm_event_item.h                 |   4 -
 include/trace/events/huge_memory.h            |   1 -
 include/uapi/linux/mempolicy.h                |  14 --
 mm/internal.h                                 |  22 ---
 mm/khugepaged.c                               |  34 ----
 mm/page_alloc.c                               | 120 +------------
 mm/vmscan.c                                   | 158 +-----------------
 mm/vmstat.c                                   |   4 -
 15 files changed, 9 insertions(+), 466 deletions(-)


base-commit: e4c4d9892021888be6d874ec1be307e80382f431
-- 
2.47.3
