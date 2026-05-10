Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9F342CB0
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 May 2026 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449299; cv=none; b=T7D6iHzy80UPw3EwPpp1UEE/2urZvp9JVkdJI/4MRswQGRbT0qjIVdNeCJ9/ptYRrni4JhV8xFdht5d/aYYKf74tux3HkmwNQrVe+Zhvgf58nQDi0SDjId+lUK70j6JZgjFqsSSHW05psOGgahhpUot6kNsIjHK/Ikf8iGIqSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449299; c=relaxed/simple;
	bh=xpy9AyhUst/uLBO9xlxIdK2zcPLCL9yNJiiQAZ3hkrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSZLJNmCuVUXhtoER4mORndVuUYFSqB6ucUmE3raxOYduLjImtnm0ZJKazYBwMXwUTgrEVHfRZ95w2BhH9sHNFU5dM0WciXSuFfxBbI+rGo+06YA5izJoGwSBlQAYXFez6sPvRNXxoZ6szikdiBSidWwbH9waIl2vXp3Xy1YBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sv0rEXQ9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv0rEXQ9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9705613ddso22044615ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 10 May 2026 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778449297; x=1779054097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqrHxbDBE+DHYuDSqc/T5P005krzaOCUo3AtLPcUMkM=;
        b=sv0rEXQ9choFpQXhHS8jI3nqoEFuH0/EOvseq503RqWbeyTJ5YWAUD6/BwAzLJZwEK
         iBcedQHrqON6AfSxFAFAUdZIwXZr5Zou0hlTfQ/hn0f25I/WGQ9rnAQKbQSMabJifMGT
         HX6XwSQyQi0C8pfk2rMaIQA1QPICpoUCG8uBDuAxN21gzarn5GJItpT0BYgrcNezCKrs
         DvuE9Q5kmXbpDah7Q8PuD/SNUjCxEYk1apv5U11/ylmYrPkbH442LKV0k85awQjxKJBX
         3SiwbTbWtlDmrvlbzdPhBVRM3oIEKbKhPCfFfMWHMT7sBaj/4G/Oi3DGA71OacdQl/rH
         3LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778449297; x=1779054097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqrHxbDBE+DHYuDSqc/T5P005krzaOCUo3AtLPcUMkM=;
        b=SHN0hfd9JR2RuSdQxbV+bqmQbe36B+WDPELk68UjnWEodbrq2i0xClvptaV0p1puA6
         chJoCgBkiBLl0epaK/Uui3OVSVaCU/KaBb4yA6L9/Ns7nNMAfyWLMFxcrLRsteCSzYcW
         kEDOqu0g9+Y+huyBPmf7hxs5BUJAKHosQLmqe29IYz2yoiJzqTUnsikmP57grFoJnx6Z
         Z/qXSeXh4SL9dQcT3frUrr4R5q8XAiOz4iRmCREzxobEScRujO6L+1qpjqgjb6zGOSdQ
         iHlElPKHJkfGJ3WdNvG0NmxkRCx0hU2QPGrEEv7280mLYgL+eTXem2avhTDqynOxTAhS
         1gXA==
X-Gm-Message-State: AOJu0YzfydIq183WBZE7XnoUBs/7oK1boGOIoNCpfKo426thcB7L80O5
	i1Ffw5xLzqWCxgm8+y7SQzKf2+IQwn7GMuKplBkAEbZ1BXYhw2mNdxJl5lP2L7Lh
X-Gm-Gg: Acq92OFvFcEXIn08RA09McGa9bqFoS/JvmIrAyJ055kCso4EGWQODN+c5xg6qyz0CRA
	6dASKZhhPQadFtTIGft65IYSfIGgV5Dxxc+c6P/3wPApdN/qOL6YCAtj4YdaKKStBaSoisAv1xH
	qQCq2uD3GaOwIcUHsVeqnExnHeap6joUuGNJWmGkXyw6Rehgjktst/apnxjw+ljX4/zyK+NAL+b
	OoAC2d9tbfVUTHzDcD96yi1onM+qvA2AGfFnbuvZBZ/KZCxwKjlkXArI81vckoykgEJ/esQjOn3
	PD0e7m/fqbExokfc3dyDK6ejT8I4DY5xZ2169eOPzOLALZKcQCW6SBcwHLdsQ1snQVlsyAdICIZ
	UyANsWqh5SQxp03m9TXyQLvIEtmpo7DYp5LpmSOZTXfmHUYlGnzTKljIqCMnLK3DThtZAdYuLB0
	sHRE97CNVuKGGu1G6VwFzjStOadj8Xi7S9Ik6ZXs6DsOEueGQaKBQNGgOgjG2D4SXtdfhsO5bsU
	f5xzk6UxBHCY1o8UdFEGFx9GWhmTEU7o1LVa5iBD4nk8g==
X-Received: by 2002:a17:902:ea0e:b0:2b2:481b:de68 with SMTP id d9443c01a7336-2ba79c14a7cmr248908885ad.35.1778449296667;
        Sun, 10 May 2026 14:41:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e99be6sm78597955ad.68.2026.05.10.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 14:41:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org (open list:UPROBES),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] uprobes: Use flexible array for xol_area bitmap
Date: Sun, 10 May 2026 14:41:18 -0700
Message-ID: <20260510214118.41926-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XOL slot bitmap has the same lifetime as struct xol_area, but it
is currently allocated separately.  That adds another allocation
failure path and a matching cleanup branch without buying any extra
flexibility.

Store the bitmap as a flexible array member and allocate it together
with the xol_area using kzalloc_flex().  The bitmap remains
zero-initialized, while the allocation and error handling become
simpler.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/events/uprobes.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..9ef74c2ad390 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
  */
 struct xol_area {
 	wait_queue_head_t		wq;		/* if all slots are busy */
-	unsigned long			*bitmap;	/* 0 = free slot */
 
 	struct page			*page;
 	/*
@@ -117,6 +116,7 @@ struct xol_area {
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
 	unsigned long			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			bitmap[];	/* 0 = free slot */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1755,18 +1755,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	struct xol_area *area;
 	void *insns;
 
-	area = kzalloc_obj(*area);
+	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));
 	if (unlikely(!area))
 		goto out;
 
-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
-	if (!area->bitmap)
-		goto free_area;
-
 	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
-		goto free_bitmap;
+		goto free_area;
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
@@ -1779,8 +1774,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
-- 
2.54.0

