Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547793;
	b=MsT55DUnRpkJcg3OIA2CVgZ4T8GpGpptmRbmWkteGzjUefVzFnDEc8UB4hflVTT7d1Wh
	 6WbMGwndaIRpm2QUOyc3EWQNgge/iP3IqLmlu+reouA9YMbtblDyYYtxz9iw62yemxY0v
	 6LPEvZz402eAGuQUF9j2cP8++/I/GhUzlreUaNnV125YpF+PTCeuVtasjpz3q7XJAXusz
	 AaMXXUi5tpGAprrDyuClTWh9zw7b79kDV4bmMCFkQd60rKj9OJJuBZjcBh3rhn/iYkeq/
	 86HHKvumiOij8Kg9eUqynydsRFHIUC8j/abc+Q3cUvsrgiX0Mr9xBib6io6wasxNiAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
	b=GhrWGIIA8wtSZLT9NdgwvACVdofbli0O1cLTKqPVkjQBCZOGZloDe9e88eE+9Vvrvg0s
	 8PKaQ+HCAXAYk2sTq0cvWe4EdoB73f8IcYgM/F7AItZ4h/4z9wmIS3veHzirvI/JuEZyt
	 CLpZjFvQhaUDlYMhHEmEbNqCSL2aQX4HlVBMFlo3zmMUQI1tsJf5DRSsjaVFlHtAgRHXf
	 nTYYV+bCS0UNUEElcEL8HdJ9WPuaj3CzUiKjPqAUi+wo/IBvWDiCC0Jn+BWEZwaA6obV3
	 7dM12Kd4pMFDoAf2mgf4iQnF29BEykmre2mz9bgYcuVOKMaHdW9Oha1lrBwMQxF0Yiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTr5Bwh;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD05606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 05:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD05606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTr5Bwh
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37600b0db49so1479220eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547792; x=1795152592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
        b=PTTr5BwhmRs2/AFfoHlX1JH2aGlF6UyCg8JCt4429REj5J56HKY0blS17xm0FUl1Fn
         Yjlcc1SkPzH7ARelj2G0DI6MEaQiquUAg476OW579h8IdNP2BHGN8ZpfvUHAavRK6OmE
         nssTGjFiXu+d2qaQVA7sVgnDE0j6AEkl33pUaT9Jy6QnYETF201nnpsOegB26yZXyAQZ
         VAoSGPJdtRPcsBH5VjvpIW8ZKtdNbP4xRtRyukIpadR870cjko8ayzjSZKdU3aLK+Z4g
         3oE5Uxlw5JeDzh7ului9/65e424iwZuQvjFBvJX8hUzROTjucYDhTSHURrOtBUMs2dP1
         eGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547792; x=1795152592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
        b=rWz/qlxg9rsPuTpG1W5XryBVSLKNsPxJKvjpd6F2CGar+leLfLBpOwmIb0gaGDJNjG
         XZSNBfYayNaDCqTS+Y9wlcWo1sh6TDhxhAYC2VmqZODfZZCg16uPutNcZTb7blbaa9Ym
         xg2F4TUAzcTj7Z9FfqbkIazW8Mt9Wu8r+8+BFGEfZirC8Zm4tNuu6PnZILHJulV5Otp1
         sfBllKUJsBOAwJChEX7nPpDdSK0KNR/QDOT2ElIDnP5tRUG8OABzIMSENJJgVnkNtQlN
         1wsMWvikqz4M7Ql9PmhP6wHW2xahXmL75I6YvjZOES6UiXGqy0B/BI2DXh2W3fRLa6RK
         cSbw==
X-Forwarded-Encrypted: i=1; AL+hErEhIZ0gEWjxurIK6b2lb1HSOyq+PaZqoKF0E1yy9XlI/yLIWYUfSw3E9dcqx1mX5tNyMcNmPcS2+oxYpe8hSp2gxU0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F5BGuArJRBJeXzJkz+tkFjDAEfVG8ueByWaSUkw9aSMVgxdyV
	ljIMm1zTWB/3brQ7Nm0DLXmqK0i2LcjVNzmrSdmBrQSuVpl3bvzM0v4W
X-Gm-Gg: AYBFou0Bwg6JBvm+xoMVupmffb1RFsd/Md+PCloYesGiluFvSvuAFx80nWReITqhn71
	d6wtDARR2O0lm9X35qPkqf8DLBSkYPHw9WXMrB+GSYix4ms7XZnb1nm6wi0cyzHvp1+A2y6I0pa
	1xbSlypWcIj0QHIEIIy11miH8JL49VG1ItYM5ZoetdanhoSkvz+aQKiofeNsfNWTcey7ezzUQ//
	wHk/zt/K65p/uHiLTFWTMWQZv0U8lgGVnGfwyReBLYktd++osNlIUzi5vrXvertr09xM7Xd6pdP
	BDBRly4C+oLB32l4wHenVtaMhFrGRjxj7YsU1+be50IFuRx/pr5Gqe3BQO2vSf61SH31mjey9Ne
	A47bUFD2vqKe11/Y0ISaxPQmc9RhUnrv6bRcIetuHlzmnxzBQjQV2S3cV3KXrUxYbtjXiN9ehv9
	joSknwqnLPhE3Icpbj4ZXaAS+GjQYcsItcrKULF+kNivaepQDMCUYml9jPD/9/9YmpzwJ3KeXoO
	HqszqBNOk1tO5VgZiasBgP/jcJ6HHvRpaCE5Heqj3bD/E2s/1TonDccwAbgheSEBYmR2gk/HQjS
	udTcDZ5/KBIdnc4gQT8JpP4J9VuEMSpY6nxMwtnH/aDeTDryFaSsCyxAiFUwvJwW+Vj/UDIph0W
	Y9Dj9bwQWqgpfCbK1A/YHh3o1hn6Xo7rn4Zo8FKERjzENWbZyMdZDX2Q+UVlE/fjms2cOfR6QZu
	0Ayg==
X-Received: by 2002:a05:7301:2783:b0:379:2c7e:7dff with SMTP id 5a478bee46e88-3792c7e7f16mr1623959eec.26.1794547791950;
        Thu, 12 Nov 2026 21:29:51 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm3832840eec.1.2026.11.12.21.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:29:50 -0800 (PST)
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
Subject: [PATCH v3] uprobes: Use flexible array for xol_area bitmap
Date: Thu, 12 Nov 2026 21:29:48 -0800
Message-ID: <20261113052948.2668076-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Store the bitmap as a regular array and allocate it together
with the xol_area. The bitmap remains zero-initialized, while the
allocation and error handling become simpler.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 v3: use normal array
 v2: add Acked-by. remove Assisted-by
 kernel/events/uprobes.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..c5c90b53d4cc 100644
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
+	unsigned long			bitmap[BITS_TO_LONGS(UINSNS_PER_PAGE)];	/* 0 = free slot */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1762,14 +1762,9 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
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
@@ -1782,8 +1777,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1824,7 +1817,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.56.1

