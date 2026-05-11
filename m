Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751042E0925
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540226; cv=none; b=EWm3G+YaKlw8RlgUKdW0KhsuhF2JVMOtR4cRfB2ooro0EgXC1/icTj83PI1dIRqxleVKZ6WPR2wy2dQrJmjYWCD+bm1JRw0MrvlE0AQLI7xPsOL+qZ8dBXs4yNq7lr7B3VWy28ZZBM7m4ggSrBL5Cmbic1/m+uHmJXeXsyXibqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540226; c=relaxed/simple;
	bh=s+9oIzVnD/Qb4i+INhtS+QO4GaKbnUimQ56w74A+F4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smsSMr0fsK8RKtYiS6IoYc3Yx6HjCg5c3GqT5YxovxzBgaqmUZUGN3EagifAqa1FmQtBJgDIafNtwfktpxOl1izKG1425XKd9ozyqyTXHCtsvORvx81HjPe3TbdYn2UusQads0oXImFmNFINQyTTYowY/sCJxXVnxm6mzYEqCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F61YNflb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F61YNflb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so3146394a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540225; x=1779145025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGwkBed7UDDk3zAI8J/n/bBtNTRM3sB7+XcI3xlgnOM=;
        b=F61YNflbll+t1JO8a0H0EbQVDm6gf89AYAIQodErtN7jHwNZFrGfDGDOBV+KtyoTW9
         28FJmE8dy8cGAIH3AMAl2Gh1jaPhkxU/dBDrJRrR+dLvcf4K8hWFpedYc2BuJ4zEpIuh
         X3dQTzvOythIQ3Q6x9y4dZ+x8DO7dxlpyaG1/eZJNNadS+K+hS4vv9WfGc8Z+qbQztQg
         4OmPZ7l0s7P8qdaro3Tw8SYHD1sYB1gEMS4P6Wyfj6wAPVaL3g6MGTCNuJJUQfrxUjZa
         oeOvS9BzLukLinrgq/l4/joF4e2Mg+lcPbhmzmVjbfcyAdAF1Xqr72s3gf2VHed7Xmq0
         2aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540225; x=1779145025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGwkBed7UDDk3zAI8J/n/bBtNTRM3sB7+XcI3xlgnOM=;
        b=dVis5AepFNmwqkBOsXy9t64pxpuPb0o8iX2MSIz6CueoI4SCSCwRlAWpPZ5D4VZU4h
         +F80NAPiZUl4yJOgvlFjpE4a6RCI7tj2lrOux0MdRTu+UU5/VnQ4yfljTZKzx3c91Ytr
         4yeZHyROulysnVMtE4KfX4F9ZnNJ/8rZBxJhWCNKu4GY+6hFHZ/NCXZdhOPjmqJvQl+D
         t8owvV5uIul0rGgtPVndNGlgMy2PLP3MbOzDfC0n0lyvBCOSoV2JS79NCFNjHcYVyGJr
         M76qd5ca5tXqnm81weyoKcOew0qlqjiieifp7Fj03aK6uFY1/Hc/gzLAKXSAcDs9hjT0
         dFhA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pp5fr8tLTsA/oFOF7axf1ZYYxA8Z1e++c5rWaJaISkU03DAIeUGlCL4Vie/Q4XrIRbfKfl8a9xSknhl8P9i/cO40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZU0dYTQwHIJQIaeMMZla5yLSqznvhDYHhmNbKHhk8obUFQkT
	xzIh27pg1kiO6w2dHTDk1vreB1b4H64b9xLAzvwHXILSfbgBkqh+1qou
X-Gm-Gg: Acq92OFUrQhM2rWSthgkaeyw5Yi5LRcT3GpkoWw/6sgjYSQzepVEY0dgp9QP4GrUlbZ
	T3v4j1Bjo98N5DvjEXB1NgBaa3M8GeSYEFVBs0laVxlSTZqTriVMGcs4LMlwzMTev6l08omgiS/
	9whyUBgalbXIAwS4S3OV/+OqpKMx6zV02eSM961kceukricnbodIAY0pW0Ur90zxypwyvJWFv0P
	kTg5QmvxNdIhK1CvR1rTxETuwHf/Vp3pgkW9R2vwudvIWTCnrHd8qSqXQIv1s4uUgmg10h7SENa
	6T39ax94nnVdCv6V/H7pWHkqRMdB6+0yKdKPED2Ci/Z753M+YD55OX0X9xq3BNqLoxc+6jl4tln
	HXJcu35BRKLFTgyFEf+2QruG7mO+1h+myyvjmC34tXcSgygeEBxzhkxZaSVv0xIyhxNhUiogGgp
	MIWhStgjNw+Gj0XphnSr40M1Lh49e6P8p17XutXYtsWh9vHPIQPu9slkNnYSeoDztExDAxWz46L
	AdYwCP6x6Ih2mdeRGWlf519A9CFCsxcksw=
X-Received: by 2002:a17:90a:d883:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-367d487d1cbmr13164585a91.21.1778540224836;
        Mon, 11 May 2026 15:57:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d6262349sm8875947a91.6.2026.05.11.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:57:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:UPROBES)
Subject: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Date: Mon, 11 May 2026 15:56:48 -0700
Message-ID: <20260511225648.27886-1-rosenp@gmail.com>
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
 v2: add missing kfree
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..eba71700667e 100644
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
@@ -1831,7 +1824,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.54.0

