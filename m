Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFB214A8B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750160; cv=none; b=bzo8OrrnUNn7QQfzdfK47jMIln8kj20vaf5PhJYWBsFpHo/HDQ1e/jyn/1aQKA8q/z2/WRJWUcACmQiKJtfA9Qxma2GpS3EwEGF7rLTTClgnV5PfmRKeZlw1jes7fB+/iY17yUHQ7mn1RduCy+Q75x7ghl6r3xWUIAIIpQSlEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750160; c=relaxed/simple;
	bh=H6CTxJojW3RaznwU7e2tIws+8uIQCpQLDZJs/4YMrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APv79cdgg0uv5LRFd3glG45nPQVgTyS7SNw/ojxT0XEOSbRFcaK/VnSWHf3QiVgXmtMzy7jTcHv/0f1dvPB7Djum6XkRW7IkigYOAqW7NyR3mDkwvlu20h/y/5fDvEtWEHK5ms3PUhvN6BhvSsTkmap5ygugwm6xgMTeZfYRBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CGUxMNnW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CGUxMNnW"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506c02ec1b3so37405001cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750158; x=1772354958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=CGUxMNnWu02bmbzLcOlR+km3HPzPoJ9As9jFtY2WxYxvmgGbXZnW2cjXnNozVsjQCg
         t7pJkcAkvleH5Yb3EDUbbvUstv4VLIfoN74M9FfqpSgcx9GAQS8rOh2SM30ptHku+Xau
         0onGqjdY0agBTyizJgnBFlXfy0wZrXXGp7vBdUsvo3sz5UO61gYvoSishH6Qbu1Ss4Ga
         L/3xgM8iF1uTF1azirbKhglN4MFhDGoGyHyVbj/PDwB4YOXlPZqIt2L0NxfG5qx7LFIQ
         70woyJ8+DrFl3Xw+OnDabldE1/bCvwi6OMflG4FdQHJO1kcqsKoFif/Y2tJvocwdx9+t
         dZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750158; x=1772354958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=r/mrI7lm3aa0O42I7Q8cGskbJ3R6NAn3OiGIjFI2Rpp3gTvXMprI621x7YOvOiBkJy
         QnmVl2FhsABjKzx52qK/zrnW/Vlm+9RyZxjeVF2q+w7QYunnghr4CV2USIzH5N4qAboK
         phf7UwIjOsNFKdGny5nTdaccfVz8o2NYlzkAUnNRnf4tCf8P9P7e3PQ9su7QPLDbKtDp
         QJYSlLRJD14FeJpgQ5OnzKRXZAyNQkqwdaBTYmbrWOX/wFOA2aO8GGx0yRGJHCMtxoTe
         sM5GLJmyhy9Z58HMXEiOIWy1HZq38gMFNk63B0d92XXD5Wu6jFcygN/fx1Oe15nOXCXz
         aY6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmZdhyp4bmX45lRzHxKdGjxuRDpPiit13PM+O7s5rDUkZarWBUKBAuR02eQ/uk6HUVSsRRNelfLS7DDK2a70wq42M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG56qsIZpPwJlolI2yKF3v+suKuTDNUdxptKua1OZtZxfONHyc
	F/c4uopbsSMEoh2XxizW5HLximILm92ehinWk4IpaOopxSHWUgK4efoPiQFALHGzhQ8=
X-Gm-Gg: AZuq6aLdcynxG7O5Thy6zknF8AiASt84uEI9HTjAdGnAukickN3PMVGmdmA4V3d653U
	guaVx/buFJzh8U4M5+9Qhp5qG/ENGTL3dqpoW7zDExuLStQSZ5uPPXXi4/ZHESX9N3A7JbFmSNB
	BNnM/XASQ8kJtEredsUkBbQi5/OcS5QEHMlT5cvXpDvGpyj3SpsRmRNQ54QX4PPOxoed+Z5bj1J
	VPoY9ov27qqBMcndQj4vpi1g1Y0uAku9bVNQgi9XUGZxEuIf/uf4+SmoEz9rrOgcXvudWtgWczp
	8nhqQ3OQhK8ZmuddL6bOpE4haCJAYgK3BT5liPj62Nr3qQ1Uxy5vQh8c0tOpSw3HhTwVw8Zl7U/
	jVDXxFiSh8S+OTOLZiICG9Sl0lnDbonuQ0RuJEXvVQWqrLIZaRCfmJlTJQNo/4mZrznDGl8XFn3
	HgAHTllSQEJKIxImqyEaqxmW6axvblwZSXXr6AVrJplQISg5q02/c/E+vuljiwLjaOk3nkRpI6M
	YTI/5wd5FB/P/A=
X-Received: by 2002:a05:622a:201:b0:4ee:232e:4950 with SMTP id d75a77b69052e-5070bf3bb60mr62117601cf.8.1771750157802;
        Sun, 22 Feb 2026 00:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:16 -0800 (PST)
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
Subject: [RFC PATCH v4 06/27] mm/mlock: skip mlock for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:21 -0500
Message-ID: <20260222084842.1824063-7-gourry@gourry.net>
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

Private node folios are managed by device drivers and should not be
mlocked.  The existing folio_is_zone_device check is already correctly
placed to handle this - simply extend it for private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mlock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 2f699c3497a5..c56159253e45 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -366,7 +367,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
-		if (folio_is_zone_device(folio))
+		if (unlikely(folio_is_private_managed(folio)))
 			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
@@ -386,7 +387,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || unlikely(folio_is_private_managed(folio)))
 			continue;
 
 		step = folio_mlock_step(folio, pte, addr, end);
-- 
2.53.0

