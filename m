Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363980;
	b=mYEMxnbh8me0F4kwwEjWr3N2RJOtLMG3/tOKBV2Il53XwgREd4aV/baqUKzjGpAQhGo1
	 ZcSkTp/0Ge7gbvI9W74NyERLMqIkGhdVW4BF3xAIq4jbmyZBxcOvx762K1dCO/uji9vli
	 g5hUyu0/elEsK6y0xIHCCN8v0k11SqXzVz9ISnR9g/INd5Dq2KsZUcUqnItoUnKwVqssd
	 HtA7GQwQ9aCcWdzDyAjhKQeFSyON96hD84gVr/R1m256mBz0yyvLgY3d91+kQZ90WG0l1
	 lvUg1SJ2Z2UPCGfw/0TcjXVESwH4YgUZy7RnKokxnBXPcntAM2cd46Hbjx1KkOhXCQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
	b=BjGl7DTbgwYXKgl3CaYXeT6lOIgMrT/fYdaSnKrg6HaGrFrb5JEpk3kUvUYPm63UB2Rg
	 AYVKAnpIwEznfVe3wzDOPkCPpO+A6HpJ97+5a/nmoAcPMHqGiSXCRaJ8wrzqe561GuWA3
	 TXq3MjsgCvZ+u51FdzQlcKkwlv+PcHZUULoOzpa5LW4cxqTvbqBqCdqa8eELLWwZfVij6
	 VPiPXFmD7D94xc15WKMiYXf4FxL4EOgSkujJsU+ahbcKxwpF1eHQg2uoQmAwor2E7L/4s
	 edRD9+HaFGzG62iWsfSg2uYTTPF4EMLVDZWA85rGN4vb3VtMKKlgLa2cRY38BfluLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU95D8oe;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04A606A327
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 02:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D04A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU95D8oe
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1075801a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794363979; x=1794968779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
        b=DU95D8oeVGyJ7lGm1+klKR5Z6Fk/s7oU4yM7eiBkpTWsH1IxOX1GVxxgHbdKZlUrUs
         OK/irF6YkwDerURylq/X5tipLKhdMTKb9A0rfqQYuB1bsJzkYHMczJBFWuXyDwVnrhCr
         ls1QiHmNodL1l0XfMt6oscEkou/Yk+29qGiLsoGzeWdXwfD3lXhOSFm3kENJ1m/7page
         4Qw0dAFY0rAgncIo46JduGecIsZ8HLMxYD2QlFh4fxFQj4upwWUyhMgt0ARkMvyTuBdX
         NIuwub7SbYcZiS6J8r4wb8getSQbSt4yMSPrBC49uqhFe9n1E+en8lyVpcXBOANajF7c
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794363979; x=1794968779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
        b=qxXQGNjpqxnsIzF0wSj3siD+XXtP7lBKeT1KfofWKFfMClj7KAFj66clYShK7McL3q
         xwFwLZ/4dq37/6NY6yoeS3RO31Vw/2CrgtmTjEKeMgfRgIDK986xFSF9nRB6xveByiNH
         UQUZwsqKWnJjJcTITZJFnl3yrxiOGjk6vbZ1XnseqXkkCOc1wF5OD/9i+EfxjdMbFq5B
         3eneMTj8IE9+6092o2XwXZdOSLfb2+rWLsoX7ekW0fesV6fGzwYr5553n89+ywI5sKSJ
         hzMvWKov5V+AS0oiyJWYurPsbaHp19NoK9eyX8pAtWLnpUJGNHwhWnEH1rubxdfkZxUR
         StQg==
X-Forwarded-Encrypted: i=1; AL+hErFsYGJrZkmz7bIEI9fJIkYsm4L8q9flQj1B2VMMP65wOkxdEwVgQ8KC+auxg8yn3nwUdPFDnbAfFmk/RBM8jJn+Jcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V0veHtXTNDT1O5mQJ+W0JTXqrii/5//G4Eh4zhsw+u8T96P2t
	vZuDFDsqzZAb9JFHg1YmF+oiyEk7U690uflrxVJoLEveiokpctWdciJh
X-Gm-Gg: AYBFou0pdZWH1uVDFFrdBOcsZZQnMcxRYBJ65efWF7CkXOqUMsXE+ITd5qoQY8tcCIw
	EUE10fVJp/R8rvPwbFRfT5TnI5zhYYyCEA/8YIsq2x2mduY54ZjaMiqG73H9E4FVKo597RismOq
	CsM3UxLyZCz13Rc6wGv6oDEManbmcg0jFJlupia8lOoSf3ENolZs0HCb2r7LU5Dr/WwwSUTRTvN
	Sx3MI2KRZZsM0IVQ2HDCfbuZ+JvLc9rtnExzG7GVT3LYYHR3w+i63w8Mlkff2k1oEFkE5njZrNJ
	NLcmHcUEJ5I+/GjNPIT02SpC3XwiwjbDV4zz6sPRPvWf3ZPao0+SfyxLFyzSo/3SL7MJKp1RvxQ
	D5vn5bHmdMrrGMaDT71BxR4G1DapR7C0YGrIgpNFyF60GU32FnHPLAWo77rxYUkQAqsEuWpdaGa
	9E5suDCxhYSgrB6viB105zcMKMlz2BjWrh8gBvUkpaCfWhcotH0K8h6y1M1edx91LSt6n/bd3Fm
	fzTDfs7aEvFV+5q4a85psQjkYQbRqqO2Wevg7uCsBzpMJ4aFxjRyeweHoYsSOFZfJCHTmZkj3Fh
	llONVNI6z7LvYDPkD+0zvG9IDklzUr9W7yRLBG1ur8+dEfd/UHTXMrodlx9w2rFpKAmEoCD4CyO
	4zQPLrxsqmVYeMv+VOc54puvP3t+c6eSf6AjAWuGq29UFtxKCChlo9AvVH6sdug/3dyDWCxZvfh
	Nujw==
X-Received: by 2002:a17:90b:35cf:b0:3b0:96ce:104f with SMTP id 98e67ed59e1d1-3b182dea718mr974216a91.5.1794363979444;
        Tue, 10 Nov 2026 18:26:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm2040066a91.8.2026.11.10.18.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:26:18 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2] uprobes: Use flexible array for xol_area bitmap
Date: Tue, 10 Nov 2026 18:26:05 -0800
Message-ID: <20261111022605.66010-1-rosenp@gmail.com>
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

The XOL slot bitmap has the same lifetime as struct xol_area, but it
is currently allocated separately.  That adds another allocation
failure path and a matching cleanup branch without buying any extra
flexibility.

Store the bitmap as a flexible array member and allocate it together
with the xol_area using kzalloc_flex().  The bitmap remains
zero-initialized, while the allocation and error handling become
simpler.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 v2: add Acked-by. remove Assisted-by
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 853fc952331c..876c3cfe8031 100644
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
@@ -1760,18 +1760,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
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
@@ -1784,8 +1779,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1826,7 +1819,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.56.0

