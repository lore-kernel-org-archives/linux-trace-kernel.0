Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499236;
	b=kW8s0I4BRQg2pzMFIaBlYVWLq7FF31uuLFydztTv46FPtBK3AmoutwkmjMg22iQ1vos4
	 3qiWaYdonCgmHMR30S1OKPkkpw3sLMQYv/17DRMh81PLuID1J9+EGzk/XuUL6bGxaMkyw
	 IDMLr0DR00NTwmkDh8LSM7gbCYK9XcRr2PdWBt50PPW3TYfna61FzihoIyTdARQ72+lB2
	 na4jJJ2HeP9paGvC5D50rI74aErpO0GhYAOoeukZUzbhR4GbjToRLtp9Q/rNbljgEh6iG
	 QtKeDxAx2KETKpL0gI1Z1dkLwsnLbwqDhgt5g0uKNH/abNZ+PWI7oMNetF2UjOs1Iqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
	b=TOm0BFP30FOWc4ejl9YqzFnbxPDqCAOjDdEUII704zCvd3k7oKr7VA/x84IXnL9vOGar
	 Or443STnAnqmDlwsp+1UM7Bkg8FOwBuXJWGaE01G3M4yqg31BabTHPObe5xl7BD2E9T6w
	 U25dEPpvykz0rWCoP7v8k63OMsyQgRc3Tlc/YTsLxyvLWCFh9cjkVcAONHYJk4XBFJwDY
	 9SQo4zQ1ETK2tMnXJb6r6Jes5BHjAsBz/oqfoy3l8rSXlvUSypH0TP8ckDb9Pm/8C7pyL
	 y3X6/27Dxh924Tsq/Qa0q7WAdMk6AGjAKozeHwulOOtvNkvcscGVMNZ87c8CBEIyTJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpVI1F15;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD740606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD740606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpVI1F15
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f1ca4132bso181921785a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499235; x=1794104035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
        b=TpVI1F15EqWq+9Dt7LnuohChw9c1xQWLhpz+mP0apOhCRXWYe2F1ZJ1JkwKCTkdS4a
         C6LjtMChI0Gg5j5QbVZ1rteVHi/71GkW5i5xIE/y65dDvDtea1kq0uFea+ZbEik4iL43
         wKlIkGAdaWTjJhEDGdcKDK3DdjFn8W8126Si5zWOgrQojds8AtCC4e3a0xtnQXohbSlZ
         +WRlCX4awxDeV4qV8hRB6+BdbCjWINKo43CmjvBIxq/rLp/MoAxJaZKeGzzwPbpZGwSO
         xOP9eM2PHPHHeAt8D1yunZzFxvJqhnyKFt3kXmJKMwwHS37kopOVP/Z3BzWWHfCpRRST
         aqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499235; x=1794104035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
        b=OSibzhdxkk99helXCwSamdELb11v8Zq+jTcl9UGZCSyd8CNoo54B4jDxtTuPi8rjp0
         nJxWRmIOKB7Y95r7osZ7Au8aJ5yZ4I5L0bIqHMRrIHbJvSHfjGRgfNbc3wQ3zcNr8QBX
         GUuEUAMC1bJkIZ5nZ35z99IPUFREi2/2pbyuf8hbENXlYdj40pLSuMFW5omu0weKFw4t
         Hr/l+KRR4r6AZdSOC0h4ES3H2cxkNxOEp7RQ3TQl6/ysgD6gnqP45GgDhWE18mI1vIpu
         Rvzkt70IKyjksNWktjwVexV4XMdb4oqSButtMAqhgdBWI1268jR1iw9iq7dQ1KuD7tRk
         hc5w==
X-Gm-Message-State: AFq9FYIuBmYrxZYeudq/CsqlbCVH75FfWp4/Kb0QpuNKzktbOlG5hYFQ
	Nu6HFjcqW0nH+RUF8NH3F+ZZl6ZyaSPJeI7Zba+XFr3dnFNUHY82o3g1W+44cqkRTQM=
X-Gm-Gg: AYBFou0nZ7Y6+3Vqmg3n3gWVBozLdibbPQIjVSaVWyhoFh5G8UcZosWQHVhxXDqMWMW
	ncPpeM3LINsG21WBVDm3F2npQ9md5QD9+pY7Ra8l1hJPZ7ozWlKploeb1xb4kr40zP9RrBZKRhL
	h/uKrm4M6VN5DpE5We0HzxHuF9FB4aR6UxK7AaCKiCtv4greERF8glHbPOZwqjJ262eElUP9flu
	U7WZnoVnUW/2NKcyfNUnIMhifZlPXSzDjXuOPRAQX9hOEM3568pIH3BnHzKwVi4BwJzRtZa0iH3
	7/jzW6tD4/ay6N56jBR5OXSmHfXK8ll1WSz3MxCSR7kFQ0d4KvuVK+sc5yto0kuDiqgxTYwzaLt
	/oTer25JZk26d6zkhJXudWhO02Sr5y9GfcWWaEO339fCUsNLwZNcsyk1GzI+yb1swA1xtLjzKc0
	DZAfNveAdesHeuxK8ZjqHexNVyXYg2XSXrzWDIaiqVMsq2FFSSPNrgKX5uWSwuKJSCrMpr37GjL
	zmvr8w0+tX4G5JeZ5Bw8och85Ez9J+CgSvqiYIYFgqGpUaDKvVZ5HhUC4egbW3th90UCQeSp3J6
	A18QdF8uJXe7TY29PzprSMuQTN3M7Cj0eIbu9gYvfsI+K6ik9SkFgevUiuQqY1bAgj1pRoZAuV+
	Ez5BjpKQmiQ==
X-Received: by 2002:a05:620a:17a3:b0:93e:6a4b:3ea6 with SMTP id af79cd13be357-94421659b40mr1079691685a.24.1793499234785;
        Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
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
Subject: [PATCH v5 05/12] mm/mmzone: read the zoneref slot once in zonelist_zone()
Date: Sat, 31 Oct 2026 22:13:33 -0400
Message-ID: <20261101021340.2251928-6-gourry@gourry.net>
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

Memory hotplug rebuilds zonelists in place while allocations walk them,
so a zoneref slot can change between two loads of it.

zonelist_zone() loads the slot with a plain access.  The compiler may
load it again later instead of keeping the zone it already read, so a
caller can check one zone and then use another, or the NULL terminator.

Use READ_ONCE().  Callers that take a zone from a slot and keep using
it, such as get_page_from_freelist() with ac->preferred_zoneref, need
that single load.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mmzone.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ecd1ebd49756..4bc2318ac37f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1855,7 +1855,8 @@ extern struct zone *next_zone(struct zone *zone);
 
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
-	return zoneref->zone;
+	/* Memory hotplug rewrites zonelists in place. */
+	return READ_ONCE(zoneref->zone);
 }
 
 static inline int zonelist_zone_idx(const struct zoneref *zoneref)
-- 
2.56.0

