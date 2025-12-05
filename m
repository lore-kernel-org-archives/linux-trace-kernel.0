Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A15225413
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977542; cv=none; b=nOx8weq9uQKgWyK57+psbYD+/zpk4+y2i8picjnKkA8lwgvQRWJWBSPm83xwBLKIpFhxyKyXEx7cvLrQQSKxigBxmVpOg3CHtJPm1H3L7d3em0IVvQp+fK9Be6WKozlI+Td7gBiwpijVpzggykd1UWt2zliGRIFWqg/6gJbBY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977542; c=relaxed/simple;
	bh=KsyL1tAa0IIhbMiJgBbcZLIMfFacJIN5WXZgweQxvgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFK3uQAuPSARjFEHecOmvxivk2n5jrXmkavrpHXyvk7S3ndvURIsXcd4YiRAAekCvFSy3TfTsv6W6AoN4nBYaGGtt5Z4seCnlYf1oI5hoF1ztYFjNcnCIfHP30oj4molpMn0WDaoJvkD5kMTJPi16C4xV8PVA5oKTb+Mp00cC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITLlYHSJ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITLlYHSJ"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so3073665d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 15:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764977540; x=1765582340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVNIZshLyuSr21iBy7gYlmgdiF5+BHlPixcUrdxDgUM=;
        b=ITLlYHSJt+0E+fQQ/kPGOzRfb+mRQgKNM4KY4FYaKEqyOuCfZwnQ3HZFVUIevZU2kC
         5JpwTbzMeq9ith2RMcdYF83MpBjeJtyVzFdvLV36fcqzS4P0A+zHkbmHndcLo96/shfx
         cjD7Rhtclp+DQcU4QGaFy4Ul3kH8l3ot06ojBUmwmW+raaiItchtatyIMJZuUhB+sQti
         yJA/cA4nJ7bVcjJN4I8r9PMsSqiMIad8i1KpshZKAj1ai+QUdJ/f+d4a04jDiNqFoX6d
         NSB3zJMMI6ObaaDBtVn8bHzECOgTobefAGRm0dBX1HyIghGdCrD4pa8iQuKSa+BPYQ8z
         HFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764977540; x=1765582340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVNIZshLyuSr21iBy7gYlmgdiF5+BHlPixcUrdxDgUM=;
        b=e/1iQ3DFsubcfe8kz5a/fTXT7ImD1ahPKutn9eeo0c2bpoHI8AnjjNw6a0wJ68yzBA
         uNU5MW4clSJPjkTdZv6Au7C+D9lwv4xbOVrNCV6RqKpCgGXu9VD4hnIgXnVKS+MjSBZl
         AK0P3ONTngGvtGiyb0P4P71bfWPKBP09P4Q+ngpwc8QA9dy8YC1XrmqdHVDaAKuZu7SA
         /KWhxtHXr47iyzZKiG1k1YsTIFPknxdMfLIxRYymPeR7/0DQab1ARUr/PV5TDdMX78Jl
         fPJUWRTTmCMee4K3b+nOBPhU8zy8uaN78sb1LL4WhkkBO/yl/dJSRPt9oAC7U+vjgfUD
         TFoA==
X-Forwarded-Encrypted: i=1; AJvYcCWBfxzPJYFOr5/Xqg6wM8vnVvN1qVnUt9kpVgzyI79Tv3ySRRmE3mTdjCFrQlragMHGVAZMdsw3XIzI9bi0UZe6zxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aGTOCEdoYoFgLnes/tnsH0CsapkkrcPuQNZS3yaYZ8Rqa0Zm
	4QB1+GZHrILm7pqyz7ucLQZoZUYMxMwlZ5yWYTi8qt3TWKBq+PtEKmUv
X-Gm-Gg: ASbGncv/FazhoiczZxJY1XDPiaAAyMq5gYjbASUNVzrCux9gusxKnHTS8imc7S8WbNl
	TYHaGYu8oQN8pVtyV7GqDa0M4PHmSjSA80CIXi2QqJlzy+8Sqzb3gc3jpup1xZg9j3a7apfhjqt
	uRQuagt0x3muhPW2iOZOrd0eSueEbMSa+WbFBr2HzrEpMKD9k4cESqKpf3W1/3RNGy6j6nQLmAd
	ZnVjVxYXIv5Z7DzD2i2FlFZaS3ontN3YDPUFj4F0HihMiN9ZjQX33LG2KDPmFvHvbU9zT3Hp8Bh
	uX2SRU+EsIa7aOXcKbKVsp5ocLaAv32sALu3zURhDgNeMV/9aXK+WaLmyZJV15uo+687LpFfWjN
	wQBBhVAeUYonwRfkUW+7mUn/Ue4mQO4YSCSYx0O44nVoQ43nmXk5gP6zXDULs6A67lTryErDkYy
	cahYpEb7TrhMRdc+h6noweEw==
X-Google-Smtp-Source: AGHT+IGQ5c7kUmmwqDGLvrjuZJ0aZLEBVHhDBqk12LjM5CR3AT6ty5CjA/zMORi2krLA1PmCDUq99w==
X-Received: by 2002:a05:690e:1401:b0:644:41e5:dea1 with SMTP id 956f58d0204a3-6444e756d86mr556035d50.4.1764977539865;
        Fri, 05 Dec 2025 15:32:19 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2b80casm2356630d50.9.2025.12.05.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:32:19 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: 
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC LPC2025 PATCH 1/4] mm/khugepaged: Remove hpage_collapse_scan_abort
Date: Fri,  5 Dec 2025 15:32:12 -0800
Message-ID: <20251205233217.3344186-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205233217.3344186-1-joshua.hahnjy@gmail.com>
References: <20251205233217.3344186-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 14a4e2141e24 ("mm, thp: only collapse hugepages to nodes with
affinity for zone_reclaim_mode") introduced khugepaged_scan_abort,
which was later renamed to hpage_collapse_scan_abort. It prevents
collapsing hugepages to remote nodes when zone_reclaim_mode is enabled
as to prefer reclaiming & allocating locally instead of allocating on a
far away remote node (distance > RECLAIM_DISTANCE).

With the zone_reclaim_mode sysctl being deprecated later in the series,
remove hpage_collapse_scan_abort, its callers, and its associated values
in the scan_result enum.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/trace/events/huge_memory.h |  1 -
 mm/khugepaged.c                    | 34 ------------------------------
 2 files changed, 35 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 4cde53b45a85..1c0b146d1286 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -20,7 +20,6 @@
 	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
-	EM( SCAN_SCAN_ABORT,		"scan_aborted")			\
 	EM( SCAN_PAGE_COUNT,		"not_suitable_page_count")	\
 	EM( SCAN_PAGE_LRU,		"page_not_in_lru")		\
 	EM( SCAN_PAGE_LOCK,		"page_locked")			\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..a93228a53ee4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -40,7 +40,6 @@ enum scan_result {
 	SCAN_PTE_MAPPED_HUGEPAGE,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
-	SCAN_SCAN_ABORT,
 	SCAN_PAGE_COUNT,
 	SCAN_PAGE_LRU,
 	SCAN_PAGE_LOCK,
@@ -830,30 +829,6 @@ struct collapse_control khugepaged_collapse_control = {
 	.is_khugepaged = true,
 };
 
-static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
-{
-	int i;
-
-	/*
-	 * If node_reclaim_mode is disabled, then no extra effort is made to
-	 * allocate memory locally.
-	 */
-	if (!node_reclaim_enabled())
-		return false;
-
-	/* If there is a count for this node already, it must be acceptable */
-	if (cc->node_load[nid])
-		return false;
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (!cc->node_load[i])
-			continue;
-		if (node_distance(nid, i) > node_reclaim_distance)
-			return true;
-	}
-	return false;
-}
-
 #define khugepaged_defrag()					\
 	(transparent_hugepage_flags &				\
 	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
@@ -1355,10 +1330,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * hit record.
 		 */
 		node = folio_nid(folio);
-		if (hpage_collapse_scan_abort(node, cc)) {
-			result = SCAN_SCAN_ABORT;
-			goto out_unmap;
-		}
 		cc->node_load[node]++;
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
@@ -2342,11 +2313,6 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		node = folio_nid(folio);
-		if (hpage_collapse_scan_abort(node, cc)) {
-			result = SCAN_SCAN_ABORT;
-			folio_put(folio);
-			break;
-		}
 		cc->node_load[node]++;
 
 		if (!folio_test_lru(folio)) {
-- 
2.47.3
