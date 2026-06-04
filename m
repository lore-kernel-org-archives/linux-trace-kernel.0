Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D92701BB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540730; cv=none; b=WjpBdTkwuJdQ2axrrbO5K3fbZCvffZLe+9xKb/+53vwiOToxvcWwWrzm2TCWwrE/LauB09nL6+rqGGDE/3hQGIYiXIi4wPAzVIRxLELrMojLN1F+218/CJOalk8rFrzI0b5X/red/bkzWlw2U9N74XzO7ZRkxwVw/+g6k/GxtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540730; c=relaxed/simple;
	bh=IYmoyLg/EeJdFRiogqb1Pp9mqFRQfPgEPlVgRs+mRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obrGdGzLKuguBMpyeKvhDr21CeQ2EQuwlNqWfQbl+MWWxklNn/1jTATp4rK9rdg0srEfa09rwMzH1it0+Km/ZjtJ4XRSjBUePfoch3tkHPUIPHLW+pDJcrr3JKcvZ6gcyitOYZYZVDsruzl1mzEm5s0nGLFZzBGTnSd0UnI8KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An5fzT8b; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An5fzT8b"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so81545a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540728; x=1781145528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=903p+XYNW6RRuBbLdT64GGYbi0Y3SIaWw22qBNVgp0Y=;
        b=An5fzT8bDvQsj+HXZpLrF1Wlp+N5ka0dUJWP4Nx+KgNQwKiEHgRhSFmiDm0VdTU7Fw
         JDLBX0nV2t7rGdIA7wG52JnwuGl1LK53ciD8bBWq4aY/Puec2gdcvsCjjhkQpwhYa8dx
         57I8W7ZczBA5pKwf1PzcUmZsPs+2lFnxrrw8IAC+INWzgYPTDmKoQgxpSqZMJCj9270T
         37z2LwjCJUSnqBo6PI3jgwD+FNQUKap2X2l63IjeJJsVPcjfPNvVNUuasMWWZY9iZtxe
         lnKQUCXfXkYODjgS4aA/1oD6fXajZOdIsIQbCXTf14wkcdrJCny2F1SV65sH2w3KwrY6
         ArGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540728; x=1781145528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=903p+XYNW6RRuBbLdT64GGYbi0Y3SIaWw22qBNVgp0Y=;
        b=UxVRbvPjt3viDxe1wN/vqbY/dnwrp4TaoYVfWEvhPA4xzV9RTPuYAcSlidBd7AxOy6
         2976Yhg8bz9nD2GLCWoEl2n9g66knLdwbpeXwTbwne1E0wOb+49U76lIQ0MgIxhbto02
         0hROxIamGwPYkn0aWnaMwcp/p/0+vRHQgBMgceEjpgybJiHS9JNxmByr+1iXvdSPJbda
         wVOHTzTq60ts1G6TdssoEHjT46RtwHkl5A1AuNoRkQHFgMTkjIFJwxhzEs1TRkMIj6sd
         cvMRNBLcAO0YL7xHB7ngMUGpmdDRALh+FKUg2VXwOVwQMgEL6bd+Vq32BtDncJlv0pPB
         utww==
X-Forwarded-Encrypted: i=1; AFNElJ/U/M3Es3qp8rIUVKpRDztQuUCr66XF0AKjQBuQEpR+dumkKRJFpdQGqLyGLIV/KQqy1LPVVNGqEmanbCpzd+IDwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ygyf35wdJb1WKqa0JOHp+G4Pde5abss6NnuabPQrQFfSPjPv
	V05u59iRBj/VJ375FuHjx0dBXgFrq3SGVM1xbUvhn0vme/ZyMQ9jkBkD
X-Gm-Gg: Acq92OF04s2GQJRrP5+1gCm98jjLNmvn0Yr+zmoozGQJd9joHeJp6khKlQyKyRKAA7N
	h6T2duA1lrTov1v8r+qmxX621LC2EMPvlJdkDum1mEcw7laYySeSoDxaI01egdQHwTh7WnyXtIG
	duWLVMKEKQoL9Wxyd/N9WHcZI8q5mnyZoythpa6vPbyVSRljjAMC7CmcRPqcNXfXMof8j+NRMzf
	qKapde7yj1vZLxqJdslyyM+bE9aVqgDyB8fFBGs1W6RDLHbuHUn1jjw+JoljbJogMjOb7tJe3Z5
	k3zFSq9FHTmuimHHhhac+s3DBiwOE+m4+P9y/ywy3LYUY+DsEcHqhCs4VkBNg8RRQ6z4oih07/s
	XnNTZq4cWL71d/HlCIRdA/ss1866XZoGNLHSs8xQKxdS1WBdbU5In8KxLzoYRYxRHXS8sQy18FB
	sDNR4mfLOjiFuRx3LPkU6WK5KGUPRe27kmy4IZxpSgyGMcOZc=
X-Received: by 2002:a17:90b:2b86:b0:36b:aed6:235a with SMTP id 98e67ed59e1d1-36e33106b26mr5951841a91.22.1780540728330;
        Wed, 03 Jun 2026 19:38:48 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:47 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	Alexander.Krabler@kuka.com
Subject: [RFC PATCH 2/3] mm/compaction: add per-folio isolation tracepoint
Date: Thu,  4 Jun 2026 10:38:11 +0800
Message-ID: <20260604023812.3700316-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add a tracepoint that fires once per folio successfully isolated by
isolate_migratepages_block(), recording the pfn, isolation mode and
the folio flags. Knowing these makes it easier to debug unexpected
isolation, such as mlocked or unevictable folios showing up on
PREEMPT_RT kernels [1].

Inspired-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/20250820142919.HTybedrl@linutronix.de/ [1]
---
 include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
 mm/compaction.c                   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index d05759d18538..8b8b3ec0f324 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -76,6 +76,32 @@ DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_fast_isolate_freepage
 );
 
 #ifdef CONFIG_COMPACTION
+TRACE_EVENT(mm_compaction_isolate_folio,
+
+	TP_PROTO(unsigned long pfn,
+		isolate_mode_t mode,
+		unsigned long flags),
+
+	TP_ARGS(pfn, mode, flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(isolate_mode_t, mode)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = pfn;
+		__entry->mode = mode;
+		__entry->flags = flags;
+	),
+
+	TP_printk("pfn=0x%lx mode=0x%x flags=%s",
+		__entry->pfn,
+		__entry->mode,
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK))
+);
+
 TRACE_EVENT(mm_compaction_migratepages,
 
 	TP_PROTO(unsigned int nr_migratepages,
diff --git a/mm/compaction.c b/mm/compaction.c
index 7e07b792bcb5..007d5e00a8ae 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1223,6 +1223,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_success:
 		list_add(&folio->lru, &cc->migratepages);
 isolate_success_no_list:
+		trace_mm_compaction_isolate_folio(folio_pfn(folio), mode,
+						  folio->flags.f);
 		cc->nr_migratepages += folio_nr_pages(folio);
 		nr_isolated += folio_nr_pages(folio);
 		nr_scanned += folio_nr_pages(folio) - 1;
-- 
2.43.0

