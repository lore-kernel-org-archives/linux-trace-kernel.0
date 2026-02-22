Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F625A2C9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750214; cv=none; b=ZBn2PfVK5a9IUjXMTF6eyeTUyn0mrQo/Z3LO9xSNORo9Le6rfO8CyA0LqBZVi4/wt/Z8zFY388jqXdhnVqj0f95MCcOBxQ3/yNSTA5SFLQfnscICZdPwb5ACUOfphj5AloqHcGlyBBm6rnjzHN9YBBGZ2G1g+QGHeWf4xrBHLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750214; c=relaxed/simple;
	bh=FN4ZcFBXmxL8uNXxIrtPiA8q89iYFsEg9AGsn3itCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlnWo0D33aLOAYZxt8W7B4nmJ+cQbrwQTl4nPuM3wvT6+bIOfvMz9OJ/hL41TQO1wnUKjvCS+g+3Jg2556p9ST0B94FqCqVoraxa1zcZR79YLgt1w488BSXb05t5eXPYTBPJUZSnqR7SuACNlUa7mM1xvHX+Xpi6eXzgsDRnmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AMgGTcyf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AMgGTcyf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506cb1b63d0so36184111cf.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750211; x=1772355011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=AMgGTcyfQf9iv055uiUbmo2/DT9ZzIlRdOWsoEXzGa4+dLTnjjAPBqH+bKkLciHrPo
         MCjf1nrpUeLkvrPoJAQeJZk4JbA5qaWd7LElyh3Hpj1+xiho2eydUOjGL26lEjb2oJ9b
         tltNFOtLr3Z4mB8k6hJQR4Vo1KoGEqXzqFd1Di39RBotgcEjavbAemGUUeHOXMeT+S7w
         PXAf43ug6v0b193VQTxW7RzYJxAUDIw6coy7fcC8n0Y+rdccyO+CpMA3sdCNJb1RUJPX
         WWFwFtv8teBXDON0TOvLtVyWcsUDwcrIj83hYFlM/Eo0aDVp2Ehoc7SigIvBomwHcKTf
         X0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750211; x=1772355011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=J0bd7iDguHU/+32DULxNz6wsUM2pH2/USpE+YgqUxqsS7uqXgZqW9nsIrcvwB+7JP2
         osc4yrd9Pi7wz67wH6lVke4vrHAuBejsT8jT8zhIw+613VxS9a5IReUpMMyf6ZCb3Ew8
         ktoTBVWrEt3EpZcqRwb3lwOLNyWvhFRaR5MGNhxLT66NPlimJkaknhn/u2ZfLN5TdurW
         gSnlnD4DJX1P4gFyx6+aHas55D74Iwp3zr8GKnW2lg2J9HH9DkHUs49xfA5XMelFi5B9
         bVVCLdn8mEBCjekbWJjZ1pYmp9udtxntnbJXRFGuZuUIeDLlKkKpMrprcOEONA8iRbpD
         k2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5o6ZbZqRekOd0OA2J7+wP3QC+rODmrJJAuZ8GEfy21QJicVrResMC5+sJw2qO5FKpD39fo4/vWlq5rzoeUcy+OKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGM00hU0+SvXbvBjab/U0ghx3Igi5NDx6lZa9isW53XzeDMvwg
	XyfiH+8Vr0qGarYljm/hcfM+xbEX96hlSw3eU7qjZnN07pLJ7bm66rPyFs7DUKayf5M=
X-Gm-Gg: AZuq6aITSI0ahw9dxp+FPIKNrYR8r6nLyoqTFu9vv0GB6K1EUvhs9e4p61ilD1VSCWo
	5t1FIDB9ajcrgm0XRBfUsBBtFlL9vA04l8KkTa6x6xcaCkMm332RzK6IPwXMQYIg9/Mdb4YtTR9
	CW/PPwFuMxFOjQD7XDv8HryFvIhbqR6M+3NLa2ghdEUVy4Xzc8lHKZlzV2XDlmmt3SeVsLcRV6y
	QjN+lBnECO1t/bC3dy/OVPVjtzFTuGHgoZyU4F1eADvz0lrFdRNRfnIF8yqaWWWPfzk75m2Cvie
	ATxNFWHgVgdnkjl9pNbLrxYkjGQmCiUy9KgPSYZQBcP404sk4pnuXbwIntFvletFeumChtg/61t
	Oj+Pffn8Xf2DSE8xx/aGe7jX5CF1ih90dmGEq3XX9r5OE4qZFk4mmq8eZ/ztAAmj//1QOVT6GDA
	qMh8b4S9wokliBqn4zBW2KPzuYdsvrmNLXpAujgyoAIqOBM1hsxMVuhXS57gjwvdXBvsJq8qI9S
	RbWxgigiCFRxOeWoJtq+M69OQ==
X-Received: by 2002:a05:622a:1789:b0:4ed:ddd9:1402 with SMTP id d75a77b69052e-5070bbddc75mr66100291cf.24.1771750210655;
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
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
Subject: [RFC PATCH v4 20/27] mm/gup: NP_OPS_LONGTERM_PIN - private node longterm pin support
Date: Sun, 22 Feb 2026 03:48:35 -0500
Message-ID: <20260222084842.1824063-21-gourry@gourry.net>
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

Private node folios should not be longterm-pinnable by default.
A pinned folio is frozen in place, no migration, compaction, or
reclaim, so the service loses control for the duration of the pin.

Some services may depend on hot-unplugability and must disallow
longterm pinning.  Others (accelerators with shared CPU-device state)
need pinning to work.

Add NP_OPS_LONGTERM_PIN flag for services to opt in with. Hook into
folio_is_longterm_pinnable() in mm.h, which all GUP callers
out-of-line helper, node_private_allows_longterm_pin(),  called
only for N_MEMORY_PRIVATE nodes.

Without the flag: folio_is_longterm_pinnable() returns false, migration
fails (no __GFP_PRIVATE in GFP mask) and pin_user_pages(FOLL_LONGTERM)
returns -ENOMEM.

With the flag: pin succeeds and the folio stays on the private node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          | 15 +++++++++++++++
 include/linux/mm.h           | 22 ++++++++++++++++++++++
 include/linux/node_private.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index da523aca18fa..5d2487fd54f4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -866,6 +866,21 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 static DEFINE_MUTEX(node_private_lock);
 static bool node_private_initialized;
 
+/**
+ * node_private_allows_longterm_pin - Check if a private node allows longterm pinning
+ * @nid: Node identifier
+ *
+ * Out-of-line helper for folio_is_longterm_pinnable() since mm.h cannot
+ * include node_private.h (circular dependency).
+ *
+ * Returns true if the node has NP_OPS_LONGTERM_PIN set.
+ */
+bool node_private_allows_longterm_pin(int nid)
+{
+	return node_private_has_flag(nid, NP_OPS_LONGTERM_PIN);
+}
+EXPORT_SYMBOL_GPL(node_private_allows_longterm_pin);
+
 /**
  * node_private_register - Register a private node
  * @nid: Node identifier
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb1819ad42c3..9088fd08aeb9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2192,6 +2192,13 @@ static inline bool is_zero_folio(const struct folio *folio)
 
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
+
+#ifdef CONFIG_NUMA
+bool node_private_allows_longterm_pin(int nid);
+#else
+static inline bool node_private_allows_longterm_pin(int nid) { return false; }
+#endif
+
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 #ifdef CONFIG_CMA
@@ -2215,6 +2222,21 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_fsdax(folio))
 		return false;
 
+	/*
+	 * Private node folios are not longterm pinnable by default.
+	 * Services that support pinning opt in via NP_OPS_LONGTERM_PIN.
+	 * node_private_allows_longterm_pin() is out-of-line because
+	 * node_private.h includes mm.h (circular dependency).
+	 *
+	 * Guarded by CONFIG_NUMA because on !CONFIG_NUMA the single-node
+	 * node_state() stub returns true for node 0, which would make
+	 * all folios non-pinnable via the false-returning stub.
+	 */
+#ifdef CONFIG_NUMA
+	if (node_state(folio_nid(folio), N_MEMORY_PRIVATE))
+		return node_private_allows_longterm_pin(folio_nid(folio));
+#endif
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index fe0336773ddb..7a7438fb9eda 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -144,6 +144,8 @@ struct node_private_ops {
 #define NP_OPS_NUMA_BALANCING		BIT(5)
 /* Allow compaction to run on the node.  Service must start kcompactd. */
 #define NP_OPS_COMPACTION		BIT(6)
+/* Allow longterm DMA pinning (RDMA, VFIO, etc.) of folios on this node */
+#define NP_OPS_LONGTERM_PIN		BIT(7)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
-- 
2.53.0

