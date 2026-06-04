Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE603A6B8D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540745; cv=none; b=dMFtszt7JvUcawRME0/B+yAe+mYp6lEEkzzz7s/Z/IS5OHuWkWEXjPnS205jOmwrgIn2EzhGK8Wz162+UkMSu4enuUXaDeJFxlsAmsQt5XJhZtejiJ02Z1Ke5ZXWVeUKrE/ScWRdsUrQvymY/zOJh7ary7w5fwzoEtV+RRymYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540745; c=relaxed/simple;
	bh=Z/Eh9Ow9GWrkfmkO+fjqV3ynDGOPRF2+Js97K1B7ZoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIwILlE0UgxIot5wu/66CR4pevey/H/3OuLtA9g8LTZQ60dIHlraUPwWBlUvpUW9Zq7gVeAfL1qTtsLCA+sG3JpEZYTnkGNfk3gtSimiDTTlgm9QdtHsuolVG4T/I+obcYB/zaBU96KJhAuPVkNOFR0CbZuFxY4qapj8E+TUgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQRvYIVf; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQRvYIVf"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so97971a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540741; x=1781145541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY6gm/PYAmXfMCLc0nBMu9O2mOg48yeIOplSmvWr19Y=;
        b=iQRvYIVfjsGG3arVLfNoG7woel5fUonNz0AoNjaktoYVBau1BS1gAbI+Zpn9hB8dch
         u9yso3iEvSEbQRnwb68lRrUPoB8i8Zo26TfjkwBIsfyQgTUjoAr+w4FM6srDHT9lruqM
         ejHRufQ7OMRecOO2+goIkbhzIWJlVqGEgURBhuNftENrVhlGrTWMHpB2YIFqIZlwyfKW
         GOY+/4T2vq8RF6HTCVw2+U78E0eL2jSyrW/5PXMv8flPnWYe6YOztE7S0SyT7VzzV2TL
         CqgOGN/gnBAd6NqRWVw7k8rj3locHIbE4YfNpcrB+tKpuzuiziCACRcsV+2OvsMFiq7l
         VkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540741; x=1781145541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fY6gm/PYAmXfMCLc0nBMu9O2mOg48yeIOplSmvWr19Y=;
        b=FborOCjgjIdg4GyFWETsRzsqFUMvJ0gKGV6IZ1z/Y7/yevWAtXXdo6lJW/Ueq2AnpM
         JmvWpG9du4bvbbEBGY2qo7Z9ouiEFxkVW91MqBnzyRRFzsItxv7KzwhxbIY12KLdDHnA
         Yr92J/XG+NVu6PYXxSu1cLGKY31K95K9S5GBu/drKPR8MssJ4WCnqMFgOogwKPbYbkD/
         Gg/w0GSz/6XEr/1fGnqfPqmQ65rWwuH3zy7WINU+kTNoBOGqaoI1h97tFJvAQG0E+ZE6
         MszlNZPPNZyMKHSSit9UILpnHTWUn8os6ubOQ/7JaW0Ieq08k7PAcfAfY2ReG54dh2iu
         g78w==
X-Forwarded-Encrypted: i=1; AFNElJ9N4PRMWHto0Yd5Oz3qEdhdhm012EStDgT48zq6JetL5R7as8MB8g3lDrsFA4156o1zgez20e6D/J14ko9exPO9m08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP1K0apUENtf4vX+oESbr80GcvqqTlgGYS9bjz4YwDBqDAtgZ
	j54Mp1DtiPG65RiGYCZGDuUZs6O1YMOEaYvRDHwfleVWXANpjraVw1tm
X-Gm-Gg: Acq92OH22Uv8H0ozxrzyY8ZJOU1kQJ/hm2Ik3XtuOQvRnCO8523AavfkPCS5BTxCRiZ
	Wb0OPMWAuvNn5c2l7wglZCPqs3OAImkkvIuXYSuc+di+X3i5C35C9DIknwwn6XwpNEdDbbB4lyi
	lENR/Eshu/x6mg88A8IJ3l2EsLSuggef3UbbW9I7djZ+XjK/SercyMqL0aNclJ3R4Zyu5p8c14T
	Tqz50KD0xodeOtSTeseoETVTOWJW/1S7iGdK2f6v0SRMkYlG3al1RurpUUqGZAOIrCpQqO6+ujK
	fIVCF2UmdPzdsN314pT90IeU+OE0EA+uyrIrgD13iJnTlbrty1U2tWEEwSdkf+pCbPoGqp/NWTa
	a4lW6S3MA3IkhjXr5qGvrtyRlMaCC2BvJAiKL4GRtgobaavvJsv4pG83DGDI9S6cf2LPQA9eERb
	kvTs3KGqoyKSfPnnXFoVXz2xS3yaMS9GjGpNfucU2kyA9Bze0=
X-Received: by 2002:a17:90b:4ac7:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-36e3064896cmr5407549a91.1.1780540740997;
        Wed, 03 Jun 2026 19:39:00 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:39:00 -0700 (PDT)
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
Subject: [RFC PATCH 3/3] mm/compaction: respect compact_unevictable_allowed in alloc_contig path
Date: Thu,  4 Jun 2026 10:38:12 +0800
Message-ID: <20260604023812.3700316-4-chenwandun1@gmail.com>
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

vm.compact_unevictable_allowed=0 is used to prevent compacting
unevictable pages. However, isolate_migratepages_range() passes
ISOLATE_UNEVICTABLE regardless of this sysctl, so the setting
has no effect in the alloc_contig path.

Fix it by:
  - Keep ISOLATE_UNEVICTABLE for CMA allocation, discussed in [1].
  - Honour sysctl_compact_unevictable_allowed for non-CMA allocation.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz/ [1]
---
 include/linux/compaction.h | 6 ++++++
 mm/compaction.c            | 9 +++++++--
 mm/internal.h              | 1 +
 mm/page_alloc.c            | 2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index f29ef0653546..04e60f65b976 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 extern void __meminit kcompactd_run(int nid);
 extern void __meminit kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
+extern bool compaction_allow_unevictable(void);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
 {
 }
 
+static inline bool compaction_allow_unevictable(void)
+{
+	return true;
+}
+
 #endif /* CONFIG_COMPACTION */
 
 struct node;
diff --git a/mm/compaction.c b/mm/compaction.c
index 007d5e00a8ae..a10acb273454 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1341,6 +1341,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 							unsigned long end_pfn)
 {
 	unsigned long pfn, block_start_pfn, block_end_pfn;
+	isolate_mode_t mode = cc->allow_unevictable ? ISOLATE_UNEVICTABLE : 0;
 	int ret = 0;
 
 	/* Scan block by block. First and last block may be incomplete */
@@ -1360,8 +1361,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 					block_end_pfn, cc->zone))
 			continue;
 
-		ret = isolate_migratepages_block(cc, pfn, block_end_pfn,
-						 ISOLATE_UNEVICTABLE);
+		ret = isolate_migratepages_block(cc, pfn, block_end_pfn, mode);
 
 		if (ret)
 			break;
@@ -1902,6 +1902,11 @@ typedef enum {
  * compactable pages.
  */
 static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+
+bool compaction_allow_unevictable(void)
+{
+	return sysctl_compact_unevictable_allowed;
+}
 /*
  * Tunable for proactive compaction. It determines how
  * aggressively the kernel should compact memory in the
diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..163f9d6b37f3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,6 +1052,7 @@ struct compact_control {
 					 * ensure forward progress.
 					 */
 	bool alloc_contig;		/* alloc_contig_range allocation */
+	bool allow_unevictable;		/* Allow isolation of unevictable folios */
 };
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81a9d4d1e6c0..1cf9d4a3b14c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7118,6 +7118,8 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
 		.alloc_contig = true,
+		.allow_unevictable = !!(alloc_flags & ACR_FLAGS_CMA) ||
+					     compaction_allow_unevictable(),
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 	enum pb_isolate_mode mode = (alloc_flags & ACR_FLAGS_CMA) ?
-- 
2.43.0

