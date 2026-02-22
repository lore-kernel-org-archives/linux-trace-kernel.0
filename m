Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A72147E6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750151; cv=none; b=NZzpdy19NtYQCuRY9gpTR6MiEoUWKCSgVwr0CLaGXOPlQ04F4cN+KAcaNXNcJDaFqyjve4+qczkbAPx6wnp7YO3oS/HuZ48kkRsDHRK2w3+5NPFkOyujfd2SU4X9gXUp20kW7YxiiB0HHVvlMS+HEGMebBWOS5modlxwW7NK3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750151; c=relaxed/simple;
	bh=o1uIXG0iQdOCtI30tu/L41w3N6UZHqstojSncqQCHfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L44VX/NSYn4u49VvKC3picRaTnSEFByLIGl/ubWXDH6Aj2tdTL0BxpBKmsg3ypFAjB24iGXPa19ymkJJTM3pPPsIrnoxYYUibDRpCk4c+iDcBHSI07c2uMW+jOm0dEioUGPCG2LtyW34bZcympUJmVKslzYdb1RcNqNrp8OTcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BwR5OqEE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BwR5OqEE"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a747448dso28328791cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750149; x=1772354949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGcIZ9Wm+WSSeosg9CDJTkTmHYD7k8AbIJs84ojn3vM=;
        b=BwR5OqEE2Y8vC7qmhlGoGNrr8k8dZ3djpOE11UwLN83Ev8kbqqjme8p2bjgZtAolDv
         lq8PNNmXflFihcmSfy6XKFT4vS7n/t0YjGT7NMDFOJYUVXMlL4s3FqDFE903/pRst9po
         0MR68OM/qO6d/8LCohX3Sofjd06NnBzQDJncqLi5qRJIWXatZqhV0TzGOCS61ZaH/Ugr
         eDc08Rh4t/6dPPjJr8Odt3OqFWLSJN2v2L7qPG2ksqK0ODxRna8Rrl2GMo9qrPhslLSZ
         jRzowAtXcFbwsUwP8mhyhstAFbGS9kkgTu9EnUNPaPlntsPukVJiaTPL6qJYmhG8cxrw
         lETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750149; x=1772354949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGcIZ9Wm+WSSeosg9CDJTkTmHYD7k8AbIJs84ojn3vM=;
        b=LJ8DVIrXlL9+nhknFPll5YFZ4YtaZ57Igx1zWMKAqeksdoXgI+VOU7VNmkSwo2Fnuw
         bHj9DHg6+u0QCjE7NvT5SrJWCv2cp0DfIjYYjUonkGRv7ALLfcOFitbHZLllWSg3gjin
         dJoQAmDJ88j5b8yfNlZUQ9Xs36bcTtaE3HEv7tdoV7nMG3wV3icKy+W55bOr+1JdzCd+
         O493WH0j0FnIvOomr3j3tsQCRx/tvBQ+QJfkgxXUGODGnMoJVIyuoyED84PRPJplohjv
         WfdOZ+IDGuUm9+BCWKOYfTpQjJiexGeGLgifg6zyzGnkI7QxRwa6QgbdAJfLMB19whUv
         9VGA==
X-Forwarded-Encrypted: i=1; AJvYcCVTsbszi8uXMYIMwabS+a0XbDLG1Q9nTER1McpIh0IRf6NzhLNxVxIzwAG5JdiKJiM/mm7qCTfPPdT32LcF400OMZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X13vkzUdoABcRj7FSCQvS9NUi/oRXFY68wZtHBghZweNSCeY
	ggmLPo5wJCel6J7Pmdo34JfigeFtAaSgmrjH0bZBBtSYUYbN3d7KI7qR5at21aE0jAI=
X-Gm-Gg: AZuq6aJDTcjNSzLKqYLjOrTOlzAxtbkAqmpb6WBUmUxGIMciHK+FDSahSMPztbmvthi
	ZtE/Uzcg427K3W4vuHnBcncp+InmcjQRxomY6ZK4st4O7VzdNuK1cLZMIaxzMXFAXy+DcL+r8M4
	mEK/YkuCej/P96/anpKIZZWODgaphJWM5vR2XSVyixQXGpZzH3VpOEH2yYgeFrtoahnwsGIMZ2T
	cvpdRX07hF+xuEcLauEItt0kflDb+ktl105ZaPxsNV8/idtCIBZCdcexlS9WkoPna43VgH0vhBb
	i8U5Zwaktr5x4cHPSkUXFuC5VZB2+/7THQzGcumE9KZWAjOBnq/UfrLJWZObhgxFH9YM+ztg4xO
	kI2Zcnq0eKlyPRi4v5zj1rQY9IyKGpPoNZlpUarDq/C9TRUijgABYXHTT5B3hAoyJ7Ul3Xx4jIa
	6H98iCuAYmiSjPd7QpxuIHH4Eo/ND/zv2MYqeEC53sf2uM+I0J1Tc2E/KWmxjEfmpeXEjLuf3wx
	WdCK8fIL+qOrf0=
X-Received: by 2002:ac8:7fc9:0:b0:4ed:1948:a8a2 with SMTP id d75a77b69052e-5070bc68c0cmr70819951cf.40.1771750148853;
        Sun, 22 Feb 2026 00:49:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:08 -0800 (PST)
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
Subject: [RFC PATCH v4 04/27] mm/page_alloc: Add private node handling to build_zonelists
Date: Sun, 22 Feb 2026 03:48:19 -0500
Message-ID: <20260222084842.1824063-5-gourry@gourry.net>
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

N_MEMORY fallback lists should not include N_MEMORY_PRIVATE nodes, at
worst this would allow allocation from them in some scenarios, and at
best it causes iterations over nodes that aren't eligible.

Private node primary fallback lists do include N_MEMORY nodes so
kernel/slab allocations made on behalf of the private node can
fall back to DRAM when __GFP_PRIVATE is not set.

The nofallback list contains only the node's own zones, restricting
__GFP_THISNODE allocations to the private node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47f2619d3840..5a1b35421d78 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5683,6 +5683,26 @@ static void build_zonelists(pg_data_t *pgdat)
 	local_node = pgdat->node_id;
 	prev_node = local_node;
 
+	/*
+	 * Private nodes need N_MEMORY nodes as fallback for kernel allocations
+	 * (e.g., slab objects allocated on behalf of this node).
+	 */
+	if (node_state(local_node, N_MEMORY_PRIVATE)) {
+		node_order[nr_nodes++] = local_node;
+		node_set(local_node, used_mask);
+
+		while ((node = find_next_best_node(local_node, &used_mask)) >= 0)
+			node_order[nr_nodes++] = node;
+
+		build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
+		build_thisnode_zonelists(pgdat);
+		pr_info("Fallback order for Node %d (private):", local_node);
+		for (node = 0; node < nr_nodes; node++)
+			pr_cont(" %d", node_order[node]);
+		pr_cont("\n");
+		return;
+	}
+
 	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
-- 
2.53.0

