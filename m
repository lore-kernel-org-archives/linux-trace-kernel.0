Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550400;
	b=VwVIrHSScoraacPWZbBXWvZe3EIr9jg5dcOcMPtR7qNI1E1rhJHtk6Vdcp0MmDTWYJoJ
	 ACBnYQxHahQ9bK9z5oDh6mOAYl8K7TQLjUOBQrf66iWUCfRjNhvnwVxGNLnCW4jaFi/ZN
	 6BWoD7kFxpVDjOPPvEf5EhlplTrn8wDUBMxE3X+IESST2PNSqm7fTWwwqCsyVkFdvowK2
	 43GnBWxGEsqCR2mONR2IJPIKNwI9pEFuExo5XjytSTIEkLJ1OTzi8zvXlnlAtvoO5Cpyn
	 LrdGVuOChNjl6uyXFEKWjTi0uBK4eb+YNMto6+jVcugqMYQOpvxKZNUpffPkYI/BDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
	b=5IjWGMskz3BThO6HAC96HibE6C8MuDGSjPh22hkr1mwSaNf/uthNuN2anO0hkb4KeErG
	 wpa35vdIBFFRkxhq3nGfPkRCHkP3MtsZiEKaKP+X8B8zjZ6CjEoFRED0uoQ8ga3VFMmYy
	 S++3uZX8sLIdZ9MJg0yTAhQ9NewrAWJ7F2BdJeqKuWGptsw0siV+geUlifAMx5j5AKiHG
	 tqseK0X+gaqwLAaUupqZ91EykgvIC0E6PiudanjGbJP54fP3pA/OiiTqKWZG61RJLWRzC
	 mSCwRWRTR07Ht8o8MqgFCaRCkbad1FQASJoscr8SPelo2r3woR8G/CgCRObWed7HxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sdrXFa1x;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2660A2628
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A2660A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sdrXFa1x
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f22a8515eso23982485a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550399; x=1793155199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=sdrXFa1xLhvIReq0kw4CbXCZJcV4vwN9Cdl2Lfxt5cMVxYojNvyfava1FDldns2RkZ
         ezXEEqGOT+9F/nekjNoyU8Wz+hF3DEhVETvlRSsioDWxSsMaOMnjH2dyz1IM59kg3xxz
         s7KcqE1tEin89Dnr86ypQ1UOW42bzFF856AYOahJZWvg2kG/xiNcmWJF0I8kFZAiLuVK
         CxfeFSf6jO1LAuZRq1HtTDW1/4ncDhTlsemBl+P63gDuV7YR3Mflg+PCZL+InLftYvIW
         u/ELWKZnlcmjIfgviPbQyn9TP1UEVrcbRh2AP5F1tMafZJNXA+nMW5UVUBuLIVSVUxC3
         DmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550399; x=1793155199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=lxBSJVf/g8L7jskLzmP66LPNJXd7t1odozwlHFsqNSWm9BoSCH28frBOFn4d2w+wTk
         /EHw1gBqiz/N9WTRhIF06rylce1Hh0S5uKcbS0eY3bm2+djuLZogIfPX4gwtIZB9OXFI
         BzwWx95+q4IdtZqvW+SNfsLMfh83vUeMAPHA8VJLapk/8sMDqz8mPNROpZOBOlCns+Wf
         QphOp+p60fAMIkf77nySr8wcSjckRyE5gEm50NC3uBT5lFS/f4ZfeqlblCMhXf9hJnFO
         YnbDrcGud1GTT47nVSLGmBW3vwKH9mncV35SWQp0Cw4b5jbfivhv96Wwj9dvwjCGFzsQ
         RCVg==
X-Forwarded-Encrypted: i=1; AKwUvByBu4QCxf/ByCx8UBfCSG40tGBYiJkY2ub2cSgOVX7+opVflki5WrVeQOS8OBKMCokdGcGk20LN6QMRgCXWIdOGUKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5RCwEZYWm1v7m2Eehjh00sjDu/EQR/ECH7qu3LDWpIpOMC8dq
	/EMUXANialx8+wgDl+Nlz16vyP6b3pOQjOdVMxpyoLd+05ryMYvZnmnvCoXvifgalUI=
X-Gm-Gg: AYBFou0GbXvE3hAoW4DowlJ8V9HpUxu5XdLcEc1TzfL8j2+D0RZ6TUxDm3y5VYVCAgs
	7jOhmsOlxMWFwlimjrEj9TEo2ma5z0C6O73q97af8ZTiwnz6RIAxqibQjmVcRQ4IEM3p1lLjpiU
	Wgm0osmBTUrMd9x48Y+ixPewHssKolqOJ4kOP1kbxbWVtKbUM6nK8CL7xchTZFjEBKURS0d3WBx
	F9kTepSMBdVhLcICpR6A6rzn1hR/2Pzm3y0v3UpuMBe/84SO5tV+1NUG+uisk3ynI55g+YRh9+o
	DGcIMih/LzQ0Gj/DS7DifmCjP1eiI/z9yAD+Oaqz2hJ8YZmkn5DslmCyjUNnilSJ4ijznTM07TC
	n/wXIJBl2RawxN3mYRQgDMaovYjdEivBC5lUN0/keQ0ty+9IvK6+aUaGuGGRNVvFlI1Ord/PfSD
	sVMRIGNeRVhLZcx7uHx1TlRKf8hsF4EukRfOePlMudV6A+SDGf3+RP0yofPqklNZXTdCOFP6sLb
	hdjLgO3xtftLwiCGM4w1ya0RlBtMT4C97m51U/KiRKFnq6xnW0liyL0X+yUe5+hH5D1G/FKLSr8
	XPT8dVCCegN/SVCaUSxddM/qJoMsFo5jlJKznHS5fw==
X-Received: by 2002:a05:620a:3187:b0:93f:1823:308f with SMTP id af79cd13be357-93f57fe8708mr199104685a.81.1792550398715;
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
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
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 8/8] mm/page_alloc: keep a zone's pagesets when it goes empty
Date: Tue, 20 Oct 2026 22:39:40 -0400
Message-ID: <20261021023940.1940971-9-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
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

When offlining empties a zone, zone_pcp_reset() frees its pagesets while
the vmstat worker can still hold one across cond_resched():

  CPU 0                             CPU 1
  refresh_cpu_vm_stats()
    pcp = zone->per_cpu_pageset
    cond_resched()
                                    offline_pages()
                                      zone_pcp_reset()
                                        free_percpu(zone->per_cpu_pageset)
    decay_pcp_high(zone, this_cpu_ptr(pcp))

decay_pcp_high() then reads, and can write, memory the percpu allocator
may already have handed out again. With kprobes holding the worker
across the offline, it used the freed pageset in 6 of 6 runs, and
rewrote a new allocation at the freed address in 1 of them.

Keep the pagesets for the life of the zone, as pgdat->per_cpu_nodestats
already is, and only fold the stats in zone_pcp_reset().

Commit 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes
empty") freed them because onlining the zone again allocated a new set
and leaked the old one. setup_zone_pageset() now reuses the existing
set, and zone_pcp_init() keeps it when the node is re-added, so nothing
is allocated twice. The pageset address stayed the same across repeated
offline/online cycles and across removing and re-adding the node.

The pagesets take 320 bytes per possible CPU: 30KiB per zone with 96
CPUs, 160KiB with 512 and 2.5MiB with 8192. A populated zone already
holds this memory, we just no longer give it back on offline.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 96ae09c8099be..dfca77764f1fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6369,6 +6369,12 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* Reuse the pagesets zone_pcp_reset() kept. */
+	if (zone->per_cpu_pageset != &boot_pageset) {
+		zone_set_pageset_high_and_batch(zone, 0);
+		return;
+	}
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6465,9 +6471,12 @@ __meminit void zone_pcp_init(struct zone *zone)
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
 	 * offset of a (static) per cpu variable into the per cpu area.
+	 * A re-added node keeps the pagesets zone_pcp_reset() kept.
 	 */
-	zone->per_cpu_pageset = &boot_pageset;
-	zone->per_cpu_zonestats = &boot_zonestats;
+	if (!zone->per_cpu_pageset || zone->per_cpu_pageset == &boot_pageset) {
+		zone->per_cpu_pageset = &boot_pageset;
+		zone->per_cpu_zonestats = &boot_zonestats;
+	}
 	zone->pageset_high_min = BOOT_PAGESET_HIGH;
 	zone->pageset_high_max = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
@@ -7749,6 +7758,10 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * Keep the pagesets of an emptied zone: refresh_cpu_vm_stats() can hold
+ * one across cond_resched(), and nothing waits for it to let go.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7759,12 +7772,6 @@ void zone_pcp_reset(struct zone *zone)
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->per_cpu_pageset);
-		zone->per_cpu_pageset = &boot_pageset;
-		if (zone->per_cpu_zonestats != &boot_zonestats) {
-			free_percpu(zone->per_cpu_zonestats);
-			zone->per_cpu_zonestats = &boot_zonestats;
-		}
 	}
 }
 
-- 
2.53.0-Meta

