Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78223535E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569051; cv=none; b=Qtygk1skLJjFlwB1NOMuaV2tcqQlT3i7vMOfEDunZfxMHaY/SY9cW5ztxx6mpKkBvaWHdhkbUGCYwwKuLfi7XFnetmSAWa8n71dZk0Ndh6bh4lkqkqwDAuba/hHcedYnZi+DHLZ9kiFCPbSFEo3gwIb+fcwBtdP3Gf2g+TR/EYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569051; c=relaxed/simple;
	bh=rUDJGg2xixsJ9geC17OnQRzeOPjqu3DYWFdT6W++xX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gm6JLnLCLsKCPVAdauaps4Y67fFBq0SfKdtJhBp/qigFaP/qOR+BS4Rgs0x5zpGJ7jcTIQVONZ9bhRLMpMJRZimlto4wlFLyA46iwm3VpBY59pMGGsVw6loShYXlRCCF84O9oGVAUePNh2cnXQ7mosZz6MNaS3KE9ovItkDdCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxyOIZjZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxyOIZjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va9GMEIBRGZSICWJDrjnUC4vZ0n+XJyTsP+h0wQhX1w=;
	b=ZxyOIZjZImjx1rJD/pg88Ba6YvG4R0Ggd4n8omqhtxXBYB7L8EkC+FiS687hziXHUBRsLk
	QY62btTO+RYb5KitAlzFpRu9M+4lVbtZ9waabrbqYCdH8CLFoI+jPJcJjY0IFtcm3VNhIa
	O+yaj5rhNNj11BfDdKU4+Qxp1DOxHmY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-3DRxEu7UNdirVQDQUK_F8Q-1; Fri, 25 Apr 2025 04:17:24 -0400
X-MC-Unique: 3DRxEu7UNdirVQDQUK_F8Q-1
X-Mimecast-MFC-AGG-ID: 3DRxEu7UNdirVQDQUK_F8Q_1745569044
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso10774145e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569043; x=1746173843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va9GMEIBRGZSICWJDrjnUC4vZ0n+XJyTsP+h0wQhX1w=;
        b=Pqpa66UI/mHscHtGsBE0X91TD8AQ0wWIrs4xZLnluRtr4cLf+eeLRZsFYUlCglZhf9
         2vu73ohLDsZqjqBgEfTV2O1nkMilP+/1Px/Plsk2Jx9PxvYmGGCVdP9mPDcq3bkaWtUo
         tniGQt2A/wDHVGUP9SkgL81ORhk1v9kDWPfkspVrwIeHVKt83Bi0wcy1874s+RZyn30x
         5U4n1CpAOnkAoRRGKvu7dzIFikt0qnl89YKaPIY3HBGx1ZwqSQo0xOeeAwv3rdx73Z0d
         iYjUs0q75pf7tf7+8uWoq4D1cNm5xqJg7pphUC1S1SBfMMnIEBTOTi9ASO9mZShgHOk/
         vzUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0JKWpI/BzD8aR+XNLmQG+mP8fifd47Fix69JB6HFAIvvNfY1YoO3o1aQLvLC02a4cDGETA6h3O7RYPhHZK1S01U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcPd8wL49XH5sIw5R+9X5rcwqGVfza6me5SlOIni4lia2l1jY
	uTkfqbPhKQq9O8H2/1g7t1zyPt5j3JYSUikzknKMyTy1dscm+Km1GVb0uTE/JqPVWvEC6ANZdPP
	MYlZqpi83z3JthsN6XdFwc2PfQdkNt5/OIBYzol+kcFCQ0Z01uavvYB7HjBygtqC8FdGyIA==
X-Gm-Gg: ASbGnct77SvxNKoFLheoEZBRRFqDarwuIYJteoSPMJGKvv9rT4lN+BTP0+xnIXTRuKW
	xZUqyrQA0vrF2dTTxrZx+uEEjwhZ/7PkyNkAP2OEeRqT29RDFR5FRoRtcSszywLkzCR13sNoIOh
	6isHEAsQo5PxWNF5Jq2kNIQJqb4OpB1ruj8NHTklQrh3cO5Z2T6lUN/4djbE4HxAy5LGbcQ8222
	dfR+oazbpIyOThb3ANAWcurcLUcTYK1UIbxG+votRfZS6v4pFYl0YFgo+yDo2PUgkqOOp5m7M4T
	bJIxqDynpu5BGURyCg5ZEXlkg1s9+MLVoG2CcsUKH8+A1/WnO+YFzeS32T/pdsI8OsaNmgI=
X-Received: by 2002:a05:600c:468c:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-440a65dedaemr9657335e9.8.1745569043625;
        Fri, 25 Apr 2025 01:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI2/wK7u3Fl0eXpHmAGhyuo+dEfVtSzaDltjMj3X9fGs+yaHAUGB9HAX3epv5bPb/ULJhkQA==
X-Received: by 2002:a05:600c:468c:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-440a65dedaemr9657095e9.8.1745569043248;
        Fri, 25 Apr 2025 01:17:23 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4409d2e0241sm48926175e9.37.2025.04.25.01.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 02/11] mm: convert track_pfn_insert() to pfnmap_sanitize_pgprot()
Date: Fri, 25 Apr 2025 10:17:06 +0200
Message-ID: <20250425081715.1341199-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081715.1341199-1-david@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3xHId7TJAgJZItu1YyPC9DDI_t5iz7t9enO8ULm4gng_1745569044
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... by factoring it out from track_pfn_remap().

For PMDs/PUDs, actually check the full range, and trigger a fallback
if we run into this "different memory types / cachemodes" scenario.

Add some documentation.

Will checking each page result in undesired overhead? We'll have to
learn. Not checking each page looks wrong, though. Maybe we could
optimize the lookup internally.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 24 ++++++++----------------
 include/linux/pgtable.h   | 28 ++++++++++++++++++++--------
 mm/huge_memory.c          |  7 +++++--
 mm/memory.c               |  4 ++--
 4 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index edec5859651d6..193e33251b18f 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1031,7 +1031,6 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 		    unsigned long pfn, unsigned long addr, unsigned long size)
 {
 	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
-	enum page_cache_mode pcm;
 
 	/* reserve the whole chunk starting from paddr */
 	if (!vma || (addr == vma->vm_start
@@ -1044,13 +1043,17 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 		return ret;
 	}
 
+	return pfnmap_sanitize_pgprot(pfn, size, prot);
+}
+
+int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size, pgprot_t *prot)
+{
+	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+	enum page_cache_mode pcm;
+
 	if (!pat_enabled())
 		return 0;
 
-	/*
-	 * For anything smaller than the vma size we set prot based on the
-	 * lookup.
-	 */
 	pcm = lookup_memtype(paddr);
 
 	/* Check memtype for the remaining pages */
@@ -1065,17 +1068,6 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
-{
-	enum page_cache_mode pcm;
-
-	if (!pat_enabled())
-		return;
-
-	pcm = lookup_memtype(pfn_t_to_phys(pfn));
-	pgprot_set_cachemode(prot, pcm);
-}
-
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b50447ef1c921..91aadfe2515a5 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1500,13 +1500,10 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-/*
- * track_pfn_insert is called when a _new_ single pfn is established
- * by vmf_insert_pfn().
- */
-static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-				    pfn_t pfn)
+static inline int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
+		pgprot_t *prot)
 {
+	return 0;
 }
 
 /*
@@ -1556,8 +1553,23 @@ static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long pfn, unsigned long addr,
 			   unsigned long size);
-extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-			     pfn_t pfn);
+
+/**
+ * pfnmap_sanitize_pgprot - sanitize the pgprot for a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range
+ * @prot: the pgprot to sanitize
+ *
+ * Sanitize the given pgprot for a pfn range, for example, adjusting the
+ * cachemode.
+ *
+ * This function cannot fail for a single page, but can fail for multiple
+ * pages.
+ *
+ * Returns 0 on success and -EINVAL on error.
+ */
+int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
+		pgprot_t *prot);
 extern int track_pfn_copy(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fdcf0a6049b9f..b8ae5e1493315 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1455,7 +1455,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 			return VM_FAULT_OOM;
 	}
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
+		return VM_FAULT_FALLBACK;
+
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write,
 			pgtable);
@@ -1577,7 +1579,8 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
+		return VM_FAULT_FALLBACK;
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
diff --git a/mm/memory.c b/mm/memory.c
index 424420349bd3c..c737a8625866a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2563,7 +2563,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
+	pfnmap_sanitize_pgprot(pfn, PAGE_SIZE, &pgprot);
 
 	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
 			false);
@@ -2626,7 +2626,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot);
 
 	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
 		return VM_FAULT_SIGBUS;
-- 
2.49.0

