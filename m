Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881F3E5A14
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795477; cv=none; b=o2tbvA9B277HVwmQL80hQLwKkzuiqkVJ6mwt2uIGUXvCHDPnONPcU6vwnnh8zQYpN5nVsmjYXLp8HJ5Q4D8nuA2RjXGktg8HHg2/nzKvj/7XgNPXl+mS3qTFI3klI1P2YL9nwmuDsLcWmg8WL9BUVeRtw977KvfluDJxu3xa53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795477; c=relaxed/simple;
	bh=SwXzV8tK9BQ8QjgrG6CC7I98NvDSuaRSrOJYRNh4rFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj3Ur0/PmRtoT6su9umIvJD5OFYZYNiGWDVQETP9HPmsczRSIdZv/2jN7VBOv0E+VmIAyJKaOIQ1N3j/LcBjdAPxSPn3V0Yd4fStknb2UJWNhEV2Hd3D7GUQYUpC1dpW+Ez/qL/pRo/LFUWDIG6eC5FRVOaPdvvdQ/w+tH/zLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPrQWuk7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPrQWuk7"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so6351582e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795462; x=1780400262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLeHkQsXAybNTL4Q4w5mxgSBDAtaR04/XoGzkQTY4uA=;
        b=cPrQWuk7sFJUVnkI4J/4xCExY/hk6221tlhx/fRQOGzXvYnbD8jjnmtRYkFbnZ/roK
         waeGXT5OZRhbCqSw5xnlFc0eASPxHOX7h50ogsv+uFqNtnKvGUUExbfF1La+W7rLN8ww
         Ldf1hFmkvdbphZQXxbd+1PFRGn37BZFi7x0doEwCnb+cJTP3EYWo/XgCk0/516EVhi36
         al3XS5e55xVWGBm4EdvarjPTK7n49WFmqJpg6ExdgNoeeQlySQkrNgXcQ/7MiCLZRjvb
         2TuEtQLcFmq6Tu9cGnsBBS55uskggQ3xq6pnvuIofrvHhlQTTN0BXOt++oBwCvRTzEQ5
         xxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795462; x=1780400262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLeHkQsXAybNTL4Q4w5mxgSBDAtaR04/XoGzkQTY4uA=;
        b=OnPpOc9uIJ0UhcgtsbZQ9qKAKMZm54/B903leh/Yhz1th8BWH1NBClXIwISjIegh7A
         oBYvpebHsBiFGHf17pD/uC5tbqTMeUhb3KZF+M3tzQVYcgUYoOswZuZIVPSiuuXS5kfW
         dy+JwRcoBfFn0o02tS4c7b1kPFAALQKVTrH8ADVNBZ9ynpJo3aubbZhQj7MpbDSO07Ja
         OY+NVOKTnRUB+4kove+9yCDlUSWX71ODeiojcHY+hDH8FX3wWFSD65HqWGxWwml3KbQg
         qnJdUkxCk34g+LifZzhNQU9BIJSI6sUIivYqk5Zkm91XVgcc0APlfAnrZjTUGCh6y7xn
         EJsg==
X-Forwarded-Encrypted: i=1; AFNElJ8qNmaiQ3C8rGYTfiQBvg1eXToieNw3HgSzLS3rU1NUCLdu7cYYp3Sfx7ZBM/jXDKgReY++Pht/rUrRXNT08JUWIZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+hiwuvb0MYZyICiYwjj7fsV4bP33e/GaILFjbiI+xqXpWSRY
	adImx5fDrVI+jgjf7c1MHrXXIzVavZ0Yy4yx1gJtilBEIGdTVrIOBwO4
X-Gm-Gg: Acq92OG8lWgO5SmRXyxw3fBorul6ZayKHq/PCKc90sjhhIn02LvUAsJ3RoaMoBTh+NA
	PKO69xvjnj2nhTCA+vcyG/7DKuUf69txSRjihMxkDON1XmjeE2JoqKhEkZqrSiQDeyRc7jIuuSv
	1ehoTonq7v9NbMKJwa6rbihxAnZxcYPktmQ8KNPr5P3ccioo5NU3i0gQpuyT07TuVn6aEito9wL
	/8X0IhWQXAkyH8xcG+yT/Nm6dmZ6vN7YJTZ4bH5xFRVCJob/Dc7gC0Xs/EVhrSQoDkDF7qna/AV
	/6SSd8Ib46BVIrxSymkX83QJ0fEhqXud84uECvN3mlXg4qREhTDRD1CPTtaKs/YFkGvt/r2zoSx
	36W042AJbEGzCDEjYhbC8lRlWqRrwG67s/eWsAk3sjZPYoI2dl3z/09p83Q2Rlj+6I8QS1zC8k0
	1LLTo49SkVtV+4NVe41cY48c7yoiQBAVqKdkaLP8F/qY76lS2NceZxLexGTjYPkfOq+HRn
X-Received: by 2002:a05:6512:3b21:b0:5a4:1a2:1d39 with SMTP id 2adb3069b0e04-5aa323143camr4952108e87.6.1779795461414;
        Tue, 26 May 2026 04:37:41 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:41 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Tue, 26 May 2026 13:37:04 +0200
Subject: [PATCH RFC 3/3] mm: use non-temporal stores for demotion
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
In-Reply-To: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2

From: Alirad Malek <alirad.malek@zptcorp.com>

Memory demoted to a lower tier is assumed to be cold and most likely out of
the CPU's last level cache. Additionally, in certain demotion targets (e.g.
CXL devices with compressed memory) the bandwidth can be negatively
impacted by the eviction patterns of the last level cache when standard
memcpy is used. When the feature is enabled, use the
MIGRATE_ASYNC_NON_TEMPORAL_STORES flag in demotions to trigger the folio
copy path using non-temporal stores.

Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
 mm/Kconfig   | 8 ++++++++
 mm/migrate.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..4b7a75b57f6e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -645,6 +645,14 @@ config MIGRATION
 	  pages as migration can relocate pages to satisfy a huge page
 	  allocation instead of reclaiming.
 
+config DEMOTION_WITH_NON_TEMPORAL_STORES
+	bool "Use non-temporal stores for demotion"
+	default n
+	depends on MIGRATION
+	help
+	  Enable non-temporal stores when migrating pages due to demotion.
+	  If disabled, demotion uses regular migration copy paths.
+
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
diff --git a/mm/migrate.c b/mm/migrate.c
index ff6cf50e7b0b..368d40dc8772 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -862,7 +862,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	rc = folio_mc_copy(dst, src);
+	if (mode == MIGRATE_ASYNC_NON_TEMPORAL_STORES)
+		rc = folio_mc_copy_nt(dst, src);
+	else
+		rc = folio_mc_copy(dst, src);
 	if (unlikely(rc))
 		return rc;
 
@@ -2081,6 +2084,10 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 	LIST_HEAD(split_folios);
 	struct migrate_pages_stats stats;
 
+	if (IS_ENABLED(CONFIG_DEMOTION_WITH_NON_TEMPORAL_STORES) &&
+		reason == MR_DEMOTION && mode == MIGRATE_ASYNC)
+		mode = MIGRATE_ASYNC_NON_TEMPORAL_STORES;
+
 	trace_mm_migrate_pages_start(mode, reason);
 
 	memset(&stats, 0, sizeof(stats));

-- 
2.43.0

