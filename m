Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744122505C6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216347; cv=none; b=tqqzn96sbztcQsdJpowr+ZiU91CXEcKLkk03/NYlqAKii+VaXJ4ttAriCxhkfuMI/9eepcVtSO2Qvfbn+lnbJI/38nfh8WJRUSlsy4z6GbNWU9e1Lhorlt2lawgEhp5GPLdEdiFH9IXN8updCbeAId36ViIorPYknyCq5X6rjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216347; c=relaxed/simple;
	bh=eeTQic3U3Pz3ShuuvH4rmh3qdHr2tcndU+mn29E8LNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gk1gEtbreW0DRh6Y500GV0r+Z2QW/a8TT2JWgVwGIbsJxGsZva/WUEKfBSMtf2NzawGA/duKNE6haEqYL7MZS9UZM3b2B304GEgWfHej4+RatsLvb8QcFZMFQrtlv2IfmlQ1oHtNUGyzbeA56ukaaT4HD4XwvMasR2ux7EQ8NAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmY90EVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmY90EVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
	b=VmY90EVeuasymwo09mvaugZJVMt9XXNThXA2SNv5uzXii4d/djlwCwTyODIE6ja4L8CGzV
	B+D9OxHu7vyGm82L0J4kvuIfpk0aytE67PZsfz52BD5QVE9H8hZr65iLSgf756ORxVDG7E
	rFsd+L6rOqyNZa96f8zY/JRVVADuOhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-DWoiHk8hNGm0a8L8e6AOaA-1; Mon, 10 Feb 2025 14:39:03 -0500
X-MC-Unique: DWoiHk8hNGm0a8L8e6AOaA-1
X-Mimecast-MFC-AGG-ID: DWoiHk8hNGm0a8L8e6AOaA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38ddee8329eso708599f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216342; x=1739821142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
        b=OhdOEdaG2TWULNiorx6LwOl8ooplYoa7inVo+Pz7aDQHKH4/7tc8Cfb6euSJBFG1y0
         9Mn2D/rhayb3wXkC84mWjDQlfQJomSIp5AzvZYEGPdEGvoq6ShxonZp8JDaQIpZFjS5C
         F2mRaD+QXCT7dHlnCuBxzchP+DxupJE5j63iO+luXAAWm3H92HHDpoerfJtuBihoLdmv
         XJTq7gzN/MQUcopz4WvEHpceXSTkZz9TU64HhF9wV5tQA1h9AQ+3fsXTS2leG5mRevtn
         /H1VCVpf8lRTd8cW4lrMTNaMNiRf6W/xRj0nn3hCT+xJX42btqKnFRLI7Q7UAKPDrN2v
         SgQg==
X-Forwarded-Encrypted: i=1; AJvYcCVSEeW3+H1H+b5bQ3QHmXcvptTLfND9UoOfuaco1EhNaJ7x74akk7xACTAk8w7OFBOW/PBb9nv5uiCiUrW1tKanyCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2bBsCidXLJGR5ZZd5ZSWsygIh26nPGp0q3k73R7UTXUP24SWj
	0nuJPpG+sKO9wO8TfUVQ69rDSBz+p3+HNlDqV42BnajTz2ScTbnTno5CQ9o9kOdfYGmjcKqP2zK
	sWg6QWt9XdoP3wNQzeWCnN9FiLx7xMbEZvAJHFv8Aci13uSTUJGBC6gtLAWYr+GzRUCYlyw==
X-Gm-Gg: ASbGnctN/x2LThuubaO+SUa7/3gtifCkwYAF1EKwFO6ONmG95NcjikUZcoMEoFQkkO6
	5OCXHEbpBtNAcmiWXmU9KxIrCwI/XxQTe4zWVQj0a3ODFFF7/QOYS/Cnc/QqM1LQPusYdfZ+NNS
	C5kKW7I5z4q7v16SgkunFtlRlDmWJ6gAWF6vIgvfUFMfWRRnGBCkj729/AuqeQ6IOjKqpxV0mOE
	uNQ7ZAFWX21ybz6mepPzWhYTFaR8nRypjSWLOKyvXZfYxPYHuMe3wJ/BCXUerOvGYfZgqvMnAXd
	eEzFFFOYUhobs1hAaF12r1guNJtgDoRfHl6PFDeKsxPX5n1ztdATgtqvf5Snrft6rg==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8277024f8f.53.1739216342063;
        Mon, 10 Feb 2025 11:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTiiTPkwAyfuLx0qL+LO6PapdaXuVNjUwBeGg/Z0ah/0RffyIckymQJ3LkKa1NUzxInLX6yQ==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8276996f8f.53.1739216341643;
        Mon, 10 Feb 2025 11:39:01 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dc4d00645sm11916376f8f.66.2025.02.10.11.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:39:00 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 15/17] mm/damon: handle device-exclusive entries correctly in damon_folio_mkold_one()
Date: Mon, 10 Feb 2025 20:37:57 +0100
Message-ID: <20250210193801.781278-16-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GHKHc-pr5u6hR1hkEp_Jp5sSjnxkaIJodDoxZD_sx2g_1739216342
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

damon_folio_mkold_one() is not prepared for that and calls
damon_ptep_mkold() with PFN swap PTEs. Teach damon_ptep_mkold() to deal
with these PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, as damon_get_folio() filters out non-lru
folios.

Should we just skip PFN swap PTEs completely? Possible, but it seems
straight forward to just handle it correctly.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/ops-common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2bb..86a50e8fbc806 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -9,6 +9,8 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include "ops-common.h"
 
@@ -39,12 +41,29 @@ struct folio *damon_get_folio(unsigned long pfn)
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
-	struct folio *folio = damon_get_folio(pte_pfn(ptep_get(pte)));
+	pte_t pteval = ptep_get(pte);
+	struct folio *folio;
+	bool young = false;
+	unsigned long pfn;
+
+	if (likely(pte_present(pteval)))
+		pfn = pte_pfn(pteval);
+	else
+		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
 
+	folio = damon_get_folio(pfn);
 	if (!folio)
 		return;
 
-	if (ptep_clear_young_notify(vma, addr, pte))
+	/*
+	 * PFN swap PTEs, such as device-exclusive ones, that actually map pages
+	 * are "old" from a CPU perspective. The MMU notifier takes care of any
+	 * device aspects.
+	 */
+	if (likely(pte_present(pteval)))
+		young |= ptep_test_and_clear_young(vma, addr, pte);
+	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
+	if (young)
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
-- 
2.48.1

