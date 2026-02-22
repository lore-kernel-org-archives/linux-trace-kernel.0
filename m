Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88933222599
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750155; cv=none; b=ea5Q5Cri38KG41z9FpXJo6n6DQBxFm+d5DdW/ljgduByg849qkYZBIRwnVgbX/jB/Cq1O13kjlBa+riqm5e8dzqcT9K7H+Mre9+gAhUSMMNZP33Q/y5K9F47jqitMgbMpZWA9HynkpdgRcNrExvtXosEE14HRFS05M6Bb3oFLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750155; c=relaxed/simple;
	bh=MuywZZqjbsDPW/ovI/OCTMqxWg2NlbhEOkNx8sr65qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXA4CrOC0V3OGqzrA2hkasjxcEJvI7KCKsQowUv60jXY1ZT3iLmeIEe3qqKdjgukQ6SOt7Kb9hUWV4dp9J9PWVdrHYHmLmSV8THNVg9KllZVOM2RkShrTsa7EKZv0U4LD+GH7kthuWX6Ud7jBIklktzln5H1qy+RS4JaCZrlpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=o3cWCvJ2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="o3cWCvJ2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5138df1aso353870185a.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750153; x=1772354953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=o3cWCvJ249TD53qdrNw3U79RdwQQzHlb10zj7cMr6gbST/FXfVXE81zQbxwhIW1XNJ
         p0Fgy42nooHtKhFwcVgIH2IdA2R13/MhC9DNZag5qhYC6lQy4GADcq1XX5lBsc2ogBfc
         U0ADrPLu2Au6b/0Br7BQjlNT2fPg1s++g7dJoc5nKZ6xS8wKMqsWLDWS8oE0m37YoZaz
         fI3Mkg1UdxOjEZ5oy8A+j4pGdB5KJ8PqHO62z5tB2hwIY2MHjdy2qd/7KyQpTvKRsBgc
         YM1T3mKrcnNQiXVsE0fS5LLB464q1c2bBPd2k2w37Jg1s+ygUPBHUlagCPtaIfXD19OR
         Vshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750153; x=1772354953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=lDX041jfkKZTCEBLVKSvXV8Qj6mXySKTlDU6e3KL/dqhgLPp7sYibxuJeh/+Hn/f46
         iNF/QJCgdPmgtDEHaESE4TZPUloYPaOAYG14pEb4Xix9J6lrRFKef7ilpNDM405dr/tf
         kX1/To/yXEWYqMFSTDph0KkPJiUYuNgYnDf8ueZ8ktEwIGVgk0jbUakL0+h7PeVY+z0z
         l3tw+Ga5HgeB9qW4x88h4yCsGGSsQeOGWWTRNuAQzSI0x/vA5yxRmkpNvgMsFGyO8nuR
         QHaPb5QxP+ks3R+Xg5K4oKSqf6twvyVxJ3woiq6jSUBs01q/e865G8C7qaeDPERLYT2h
         m7yw==
X-Forwarded-Encrypted: i=1; AJvYcCWRZL9qPCoHto9KkdwLL7Pg2Q0ACScltOdwnIZ4ps8CIvBSR37z0wzO9Qh5jYKrFYWlMUSHawy+00CdUUyez2JlsoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuOdZui/YghLTU+ao6Y8Nn7X8fIu7oELBcCBQCq2SkkEN/znF
	/Y5uYkwy29PLuE0CZ5rnlR9HHQBZLFtuQ8HvxgxheixBQxhRvSA83WZQYCAjqfKF+wU=
X-Gm-Gg: AZuq6aK970xTKx1AU+B3l97BN3LBw9LYDnx13W5+hyfEf7uK0G9x/UnLiZ22XFVIV/B
	pmaTLgXPIHZ9C356f8y4eXzLucFwbSEzGqj5EVa4kiXsDqM0grfE4ahsN+WZsu8QOKSt6dOZOn7
	DUq7t3zo0agth51dmm0MqpEoJc7vZy8v8n64BKpHnQlP2gsc+u80r9CxrT1vd26wwczAN8w5g1F
	e9VfrcjbG1Sil/wmnaHTy1yrBoS5u24JCM0YP54nKQwV42LmqhqQKi8JJOWrBkaZI13vQj3PyKI
	7myHUn5ia+QMaaJRzJRSr9p0tX4lohCyn/iRf6Vx0/z20yF3zPdbklcwkOeECq6Kf7qJt2F2q09
	GxxAWB/YSqcoEXfP6wNNpHeevqxnOG0qprqtgRbIUKK36hE0lNl7xJ4oc33MVC26JO3DIM4kE/K
	hzmOSTkgEl97HEB4AncDvZqEaQR4l2NXnvUwTkafNfAava2CM8V17SoT6k0xqdlASCMTjS0UcRv
	8PviJyZJfW8ogggSU0xZaNCjw==
X-Received: by 2002:ac8:5d0e:0:b0:501:4f3d:1469 with SMTP id d75a77b69052e-5070bca9b16mr59670661cf.52.1771750153314;
        Sun, 22 Feb 2026 00:49:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:12 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 05/27] mm: introduce folio_is_private_managed() unified predicate
Date: Sun, 22 Feb 2026 03:48:20 -0500
Message-ID: <20260222084842.1824063-6-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple mm/ subsystems already skip operations for ZONE_DEVICE folios,
and N_MEMORY_PRIVATE folios share the checkpoints for ZONE_DEVICE pages.

Add folio_is_private_managed() as a unified predicate that returns true
for folios on N_MEMORY_PRIVATE nodes or in ZONE_DEVICE.

This predicate replaces folio_is_zone_device at skip sites where both
folio types should be excluded from an MM operation.

At some locations, explicit zone_device vs private_node checks are more
appropriate when the operations between the two fundamentally differ.

The !CONFIG_NUMA stubs fall through to folio_is_zone_device() only,
preserving existing behavior when NUMA is disabled.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 6a70ec39d569..7687a4cf990c 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -92,6 +92,16 @@ static inline bool page_is_private_node(struct page *page)
 	return node_state(page_to_nid(page), N_MEMORY_PRIVATE);
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio) || folio_is_private_node(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
@@ -146,6 +156,16 @@ static inline bool page_is_private_node(struct page *page)
 	return false;
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
-- 
2.53.0

