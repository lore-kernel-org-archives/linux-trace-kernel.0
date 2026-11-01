Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499230;
	b=tcHmLQmNnzkyjhxrCm2BW7D3nhb0dR5Qu39efaU9ZrnbPU+ine6IIGCOq4ZU7f779JYP
	 zgl2mB0cDXIN1t64lQrbYqc40pQONtpbPGDYsITgqd7WULlgPkietk2dfljN7r7Np+MHk
	 UrnEBFd+mDaLFiKz8BS3+DUL3bJ9hDE0ujfH14YtSM1BQCpR/vSNdWuxCbkJrzVeIuOUj
	 doiKPBcfjGUJPwQk+spkPPcCp+PYnIFI7A0wnD8iEsoDv2qWty5C+AXxjE2WmnYypOnAY
	 +HPedQmHaW0OmPQrlyaMexq8CH6rXeeM8qGWdD/MP/7VNwsHw5Po5N50tKiGFBOtOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
	b=sKlDfF1hsAncPpMZLS18dU+6HHx5c6vUAuW1ULtNU5F9/3LO22KJ/BmVXx/oF5UfQbwi
	 Kf8vfoRJsoReARqE6ZU/0ielxD2o7dSEyyoRAS0ea758CYw9JfTxfSNLBBGZAm7cnaRfI
	 cU2sr9n3ldRaug52WNTlnPxZV9j2rxwEorXxU//hpKnCUhoG9/GbQLPxgWlZG8lj7xvHf
	 lYAgP2YtcS1aRKUlDfPYEDcWHqPQ4jpeNTSITo1s/OOO5EVN1zi5EWMbIUdIIZK+48Vtl
	 sFQDvVJ7AzfUBhQXOu8n458DSCknrVmSaAcw8q+wjU3M9D6nAnVmmJQfQSJTKYPBC0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GNmjsmd8;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8A606A32F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A8A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GNmjsmd8
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f1cf92c9eso184301485a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499228; x=1794104028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
        b=GNmjsmd8iGlfyBA1iasvKglTU/FEUH1bUdSpfcXjk1tMl+SxkcJZjHg4tkHHvtroeP
         0vmUBDD+pG3IoM8tTP/kFrZxaC0s8cUzTxo5yBRThneKxH0gnUJRuD7/hIu0/Wu2El0D
         7lT+8XCqhgSs/DpjBGyS43yWOWDCiDaKvjvIv9ED1kB1vIYk8iJZ9uh80JZHQs/SjscJ
         p55ebujVQf7xav0vx7NwkgNmZlyZ/HcGv7aT9uFs1cO0vshiYyhjahKpjjUDRGAsR4Zk
         tmGC8v7U6q1cIm1mAzQ9Oe+1AwiXqjESmHz8O4BI+CyrRHs/Bss37DFXx+Nly4ed906T
         um/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499228; x=1794104028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
        b=sEzmHlvCkvvYjE6Ta0aPKDdkC1jnWPTB4/x1HfRzfbOEHMuCLuxkbreSTzNtPbKno4
         W6CGBz0/b72F2pr8fbEorZnlLsBb2sIs/ze35/Umdsjqn3rWAFDgwdDu5Bwtj3OfAncy
         zYwF6X0ic+q/ICOYp2kzCiJ5Gt1HmVYQlXnfja7iBuRFrZ2lm1qOyWR8suAh0UoPCFN6
         Yvp9dAzjj8ouJXdfmlChyLnDDvQ7jKe8j0fVs/8AeTrzdiNcI/wF9EFMR/8bzl93gnCx
         pcoGC0D4qVrDNPIpjFZetuImmY94M//2fXeuhHwlk/wemol3GS0Xl3SflDQ2EqEvU47C
         jFnw==
X-Gm-Message-State: AFq9FYKickVLZutfvE06yWAguI9LFYWuocol2sR6/kBQdAhGD7biAuJq
	fj8Z4x7w1MySHbp8iUljHWvMlhAoI5HVp5oYUJSEG5gV9QE0JtsKVx3A9EybSFYMRUY=
X-Gm-Gg: AYBFou3KFUg6Kw7I3H55m6xYBdrNVUk0CuCU/ievhp6Y4YR3HeYMswW3eBXwFKo0CqI
	zy0S+tQVXxCWuYhcPpmFg2JdaTQzGhJ3Ha4JeKJ0ZKQUehsRGg6Py6G65ltXlppQJ2BW15VVh3j
	WffELr18MqjyEFVkSRNI647c+d9Zl2Jt/yGmVUniZ5hPdzSS/ZLF7aFbZ7UtD9GxBy2+OE+bFDI
	r/9yMBGk5H+3Uic+Z3ePgJ87UWXvoJQrc1T7ZZEhjoc+OhuhgtVaOe0aeWqKdorijkzPYNTFPrq
	ogDiCYiB7/m35yNRwkEsR3nmihNNHDSlVVv0IAlrqq0xmF3akk3fQwI6YvGNmPPLBPvDdTFOSBL
	PGQtjU+MJfLhowkQ0DXXU03Ou9cSklhpvOLpmTwVrY3aZzktvjWLT2bkLqhU5CoWcaU6lRYPhtk
	5ziqiUp5j/fifPUdxHhmugTgRdTTXL6Vkh8QmBch7uk7v2PEzEYU3YIvoDNCwzHUH4XZl0UqlQV
	htjdC5EqvMkRHlpzOEB7fD5ZL7gPysMOTU6p8vR1egT1CprGWS9uiUm2C2K1ZlYw9jgs9XjVUff
	xULN9TyltO0UzNfm5dyrVRbqkuWrAP6b1yl1VTCP/dMKqqNC5CT0KAQzm4uYQXqiQ6GkkQgE7LK
	8LPgMmUmtKg==
X-Received: by 2002:a05:620a:2a01:b0:93e:c12c:f136 with SMTP id af79cd13be357-94421824e76mr1073212985a.81.1793499228208;
        Sat, 31 Oct 2026 19:13:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:47 -0700 (PDT)
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
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 01/12] mm/page_alloc: reset can_retry_reserves when the slowpath restarts
Date: Sat, 31 Oct 2026 22:13:29 -0400
Message-ID: <20261101021340.2251928-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

Commit 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath()
flow") retries an allocation once with reserve_flags when the caller
becomes eligible for reserves, guarded by can_retry_reserves.

A restart after a cpuset update or a zonelist rebuild retries with
can_retry_reserves already set to false, so a caller that cannot
reclaim (GFP_NOWAIT | __GFP_MEMALLOC), fails without trying reserves.

Reset can_retry_reserves on restart. Only a cpuset or zonelist change
restarts the slowpath, so the retry still runs at most once per change.

With a kprobe helping to make the race deterministic, an allocation
can be made to return NULL. With this patch the allocation will succeed.

Fixes: 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath() flow")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8cac5e01066..f1048168c90c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4783,7 +4783,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 	bool compact_first = false;
-	bool can_retry_reserves = true;
+	bool can_retry_reserves;
 	unsigned long alloc_start_time = jiffies;
 
 	if (unlikely(nofail)) {
@@ -4805,6 +4805,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	no_progress_loops = 0;
 	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
+	can_retry_reserves = true;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
 
-- 
2.56.0

