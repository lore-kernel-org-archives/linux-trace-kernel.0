Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748A22CBC6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750168; cv=none; b=jGphc10J6wp+u5pr+4MCHaPBnOxqCMUWvq8w5rH/r8ZrSu57Z7j0d/L2mhtOlGO8Zb6UICqqB4H8hnQoaHr8QihR7iBAJDSYddKcNG47DZyMWC+EeQJThX8ENcq8/GmxFopp5iYxqKlh/CYHKxUy4yRnq+B3jFNe/RLrPTZcb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750168; c=relaxed/simple;
	bh=RBdmtloBdxUpHWxlqKJWGoVvcuaOTpX5GdBn/hyqYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFVsT1FWZ5gCkQEwbFvN4LSpz7qzWTV9Sbajrls1W8Rmq8Ff+l4/dXKjgWgScyRow7vfZ0II3EcyCKNQx0CNfZ0n8KMj3DiRPs09dd8r6LnSzyfFxhLe0UehSoO49f4yUVqCSFjoer2P1FSgB7bR8gHyVaxhUKa/JdcgDhVgmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jSqP4sHV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jSqP4sHV"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a321cc53so38880571cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750165; x=1772354965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=jSqP4sHVyxKHeQwa0cDMYZhNTDSnXVNKEtuQxARnmGuWQx5B7R2yj1gEdcs0KbQjHc
         pYkLTHIIXrOicCCwUZxKjZlh6pktNI+IWOGiM5T8iJcEnUodJYu7tMOoKKMEQ8ZawBEK
         s+g4ZpqatyOf1yMvnZjz23i2lJaY+yalR3W9cXm5P+6Lyt8pZzOYmROuU7alpODJM3Zf
         iCF7JICQMS2x+Mi3opCCO/pfeAXf9ng6+8hRFf+0gdG7H7CiYUdNTaNKGdC1dxkp3qDU
         vyu1Et7B4+TUWB+7YN3RuZ/C2f+xTtDSGuYojtvPAfUokN6fvwNIcfMSC0UyEXU4we2m
         mN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750165; x=1772354965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=kqQUj+F8EQxmHUkuACgPPkETSzfwd67fVJy7r/oliGv6PEVJkY+eQ5MNshjHjOu2I1
         jXz2W6gZTU/0xhRPnFwOEx1GqjG07h9QnhRjeoXm5fT5HKF5ZDnV7rsT+giRLcxl/5ap
         R5ZsMw3afHQ6+FsSa3CiNyH6Ho6gOc14B/xaeVNY16XY4HJMaVrIRRUl0fgku5/K2PjB
         ixATHzq1WHM8FnIjWtjIsec3beSZc19E6nJZpz4EnGt6SR3plZiU2XtRf4YCyU55x6Ul
         HZJH3dk7uCcCbLOZgE0YmpNVzQebNGzu8pMFWQv7A2zCel3nHE8MZm6HrQvOkyK9HUP2
         motg==
X-Forwarded-Encrypted: i=1; AJvYcCW3KjdE/KL98uA+wK0dpr3fQuGm+OCzOQoqJMezZAnx1OwaB/vweEv4NeG1R35ihaSQxwidUw/6yheE9EDx97yqSaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxSyCzLwuoCnDK8C/b3/suOdAebs8hq4dUocUjt8WbsZdko+N
	2xQv6k/0l6IXMszXTgwJKtk3CzHw1yUKRqFh2k9Gc8lD2uqw42oEZZubBgTKLxcViMI=
X-Gm-Gg: AZuq6aJ8DUDGSv18cdd5i9jenM8IFmkFqcOcyDMllg7PKe2OKi1nVoowIgpx9mPp+w7
	Q0Uq7OdnGGflYEKv+6YlBMXWWctbCw2HZ7jKuQH7DOMGDI6cwJll+DCy/cqgt1h0/KsG0rResFo
	VK6OC5Q9Ds310r8APUS7S5u0Mallk3We6Qo29etbbvftHUpdglxwDJis0kmVyCrtlc9qCr39q3j
	TI5CmfV8nYL8gzMy7XbiJ/hHGfsdwxsIggZPM1b/DVUb1QuQ1aoUsrworMwmQxX5qd72eiyS7TH
	pztccx1jNFfL7u8wCRFYSdz0jDcq96ePhJG00OuPT8Ka5ZcFy/aCX+sx1nX3bxrK2wOWsc1BuLY
	Pqp4WFMRYfoHorjGvm/qoNFHWwf7vGxbwTCApqoU5Cqz8KOXX64XnWQiIypFDAS43nEkkPyNfq0
	QnjdLS+qypVQzJEedDojNFzeOF1tN8S9VCwPsJXTk1+ojyWGZR+cMp2/U22sXjSD0/FtKS5/BTh
	s1+TINjO8pxcbY=
X-Received: by 2002:ac8:5816:0:b0:506:9b96:6280 with SMTP id d75a77b69052e-5070bbe5967mr70651841cf.21.1771750165415;
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
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
Subject: [RFC PATCH v4 08/27] mm/ksm: skip KSM for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:23 -0500
Message-ID: <20260222084842.1824063-9-gourry@gourry.net>
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

Private node folios should not participate in KSM merging by default.
The driver manages the memory lifecycle and KSM's page sharing can
interfere with driver operations.

Extend the existing zone_device checks in get_mergeable_page and
ksm_next_page_pmd_entry to cover private node folios as well.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2d89a7c8b4eb..c48e95a6fff9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -40,6 +40,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/pagewalk.h>
+#include <linux/node_private.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -808,7 +809,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2521,7 +2522,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2545,7 +2547,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0

