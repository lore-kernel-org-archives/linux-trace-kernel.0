Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE0294A13
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053285; cv=none; b=Aqu7Ud/SM25kYC5IHwwjk1nKSbxY8Dz8vNdfNLfb0ObUPNaxuPjOwHriaRLt4+YffcEnBRQEdzIz3vkIc2Eixky0wpZ90y9cGe9gTVD96M9cyMBWgo2wCoaSPdsOBuls5FUP6E/6B3W35aWPkV3FPsAxFz/17k76j2IaZB4wehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053285; c=relaxed/simple;
	bh=WQFbdZmur/Ytk9dJK/ooWmRT8pRAb8iNKuSeeh5cjDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HUpYWSv83FvnZARFYFfBHq4DSGXeiPcwVwczZmTEkl4xzhxDNPhALw6cpXn/eE58y+fzpjM7oL31KxNk36xrQcPn/xTfYs20umrMMH6oO5O+AgYi2j23LOmEp5Fi1u4+jJHz9NuohTyVgkV1bmQY3Y62jeVsTMo/B9Rw9S25r/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIxj/RFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIxj/RFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13dAic06AYXZ8stgi94MXGa0Osqutl2B39hqd6w6YHE=;
	b=HIxj/RFt6IxzJydIndMKI805Bnh8YlJkEHAI/p0MkIFNjb/+dOgN/nHAP3mjY6lCtgsdG9
	oFy2Ws0TRDRdO4q+h3nDeAsB8D1nWIIuSaw9DUwkBQfU+2eBr1I+mwlFghaqvt4xMQnQDx
	C4NsHTb5/lMCplL/LU8oKtpZJQEilj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-dxGVgH0QMHGn1IzfiJfI_Q-1; Mon, 12 May 2025 08:34:41 -0400
X-MC-Unique: dxGVgH0QMHGn1IzfiJfI_Q-1
X-Mimecast-MFC-AGG-ID: dxGVgH0QMHGn1IzfiJfI_Q_1747053281
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442d472cf84so19759655e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053280; x=1747658080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13dAic06AYXZ8stgi94MXGa0Osqutl2B39hqd6w6YHE=;
        b=IDKY2hjI7a/ydBA3why7+aqLRo9wVss7fJN4X6XhdIaydd7XuW50VddIzcz0W8bbW/
         29whkpQ6ojPAdJZzFZnPgqKPd6jl2AFwreMMZTTzrHf53uTbGnWfR+fBbxOAUUyi7Dmb
         9o2H6dnkE4BgVZczyePWv2LQm04i0jj1DVbHC/cKiKHSpQC4yxH/mN11RYF53xBGB/Ih
         i8Gqtaud2NNtrp85ku5mIBakIUgPZZVTK9GFKUt7X9O1NQCjPe7v4MeXsc3CfoRfTcYJ
         b6eyme3GAwNi4WAC69hO+QrGI4oX+xwT1LaHu+1rKtn2YKUciII0adGuZcDVjcn+YJuS
         3Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCWeTWMUrnH8A6eF+F0Rs6iZ1b/kL/9mpDzJBFOSOdLx6bnQkrXbgGAUO//n7WDYKlBWAqUpIIrqb7JUbSuKui7DE+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMlX2PWIjRl4JxP/gPaM3xYfbcYVd2OKEKXkDTFRFLnueXNAu
	WvhmPhXRosbWf5k7XVvHwbhmn1rjk2VqxzLvx9fputaPGSE6xcUzUOocaKrpl9e92Kx2MwfPwTy
	xRuhZmFlYX8XkqmoKEGiVBMYiv4w1QTLhW+NcE3kV7QkDRvkapYH5TXlzUZ5xnrgNSmnD2g==
X-Gm-Gg: ASbGncseSdhOfVVHMLfaxpCDIvJzEjiL1xjyNb0IuyiBB7olgxqc/zR1IpzxTek0Y/6
	A/BLMW16Q+s5K5AcM1VpJBeA5Xr2fyy9goxwV/WY25pV3A5FzcBFQ9BCxLKcveKQovjQKmmSKKL
	H+sdCH4UKy12mUjdWz2sPdw6gIAbpA8wEt+J2JodSZbRPVxidmb76wzV65UeeMRCHfXy31lau2o
	zfm30swnY5ud1W8Fv5NcAW06gbmsleJsoU0nYAJwPvGBO+UOAr4hCBqX2WWnTFiSvXdLmbv7Juf
	zB/Fwk9RIcyG8y/HXdMi3ESO7h8szJvpJI7DC26Q9AJA+OyHPpyZ86duI+xCvGIp9joha/Qd
X-Received: by 2002:a05:600c:8707:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442d6ddd6eemr75543235e9.28.1747053280397;
        Mon, 12 May 2025 05:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYcR0QvFdl5lqSrPfju6l0qj9023QUSGb7KmYchmWeB3prbPPuHFd5J5L+A7FGYZKCJT6pZQ==
X-Received: by 2002:a05:600c:8707:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442d6ddd6eemr75542655e9.28.1747053279973;
        Mon, 12 May 2025 05:34:39 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f58ec0e4sm12199823f8f.40.2025.05.12.05.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:39 -0700 (PDT)
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
	Peter Xu <peterx@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 05/11] x86/mm/pat: remove old pfnmap tracking interface
Date: Mon, 12 May 2025 14:34:18 +0200
Message-ID: <20250512123424.637989-6-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512123424.637989-1-david@redhat.com>
References: <20250512123424.637989-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8DKc0X3pXSiCGJjFAphMgVurj5xJgSdvh1xxV56gv_E_1747053281
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now get rid of the old interface along with get_pat_info() and
follow_phys().

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 147 --------------------------------------
 include/linux/pgtable.h   |  66 -----------------
 2 files changed, 213 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 1ec8af6cad6bf..c88d1cbdc1de1 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -933,119 +933,6 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
-static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
-		resource_size_t *phys)
-{
-	struct follow_pfnmap_args args = { .vma = vma, .address = vma->vm_start };
-
-	if (follow_pfnmap_start(&args))
-		return -EINVAL;
-
-	/* Never return PFNs of anon folios in COW mappings. */
-	if (!args.special) {
-		follow_pfnmap_end(&args);
-		return -EINVAL;
-	}
-
-	*prot = pgprot_val(args.pgprot);
-	*phys = (resource_size_t)args.pfn << PAGE_SHIFT;
-	follow_pfnmap_end(&args);
-	return 0;
-}
-
-static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
-		pgprot_t *pgprot)
-{
-	unsigned long prot;
-
-	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PAT));
-
-	/*
-	 * We need the starting PFN and cachemode used for track_pfn_remap()
-	 * that covered the whole VMA. For most mappings, we can obtain that
-	 * information from the page tables. For COW mappings, we might now
-	 * suddenly have anon folios mapped and follow_phys() will fail.
-	 *
-	 * Fallback to using vma->vm_pgoff, see remap_pfn_range_notrack(), to
-	 * detect the PFN. If we need the cachemode as well, we're out of luck
-	 * for now and have to fail fork().
-	 */
-	if (!follow_phys(vma, &prot, paddr)) {
-		if (pgprot)
-			*pgprot = __pgprot(prot);
-		return 0;
-	}
-	if (is_cow_mapping(vma->vm_flags)) {
-		if (pgprot)
-			return -EINVAL;
-		*paddr = (resource_size_t)vma->vm_pgoff << PAGE_SHIFT;
-		return 0;
-	}
-	WARN_ON_ONCE(1);
-	return -EINVAL;
-}
-
-int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma, unsigned long *pfn)
-{
-	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
-	resource_size_t paddr;
-	pgprot_t pgprot;
-	int rc;
-
-	if (!(src_vma->vm_flags & VM_PAT))
-		return 0;
-
-	/*
-	 * Duplicate the PAT information for the dst VMA based on the src
-	 * VMA.
-	 */
-	if (get_pat_info(src_vma, &paddr, &pgprot))
-		return -EINVAL;
-	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	if (rc)
-		return rc;
-
-	/* Reservation for the destination VMA succeeded. */
-	vm_flags_set(dst_vma, VM_PAT);
-	*pfn = PHYS_PFN(paddr);
-	return 0;
-}
-
-void untrack_pfn_copy(struct vm_area_struct *dst_vma, unsigned long pfn)
-{
-	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
-	/*
-	 * Reservation was freed, any copied page tables will get cleaned
-	 * up later, but without getting PAT involved again.
-	 */
-}
-
-/*
- * prot is passed in as a parameter for the new mapping. If the vma has
- * a linear pfn mapping for the entire range, or no vma is provided,
- * reserve the entire pfn + size range with single reserve_pfn_range
- * call.
- */
-int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
-		    unsigned long pfn, unsigned long addr, unsigned long size)
-{
-	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
-
-	/* reserve the whole chunk starting from paddr */
-	if (!vma || (addr == vma->vm_start
-				&& size == (vma->vm_end - vma->vm_start))) {
-		int ret;
-
-		ret = reserve_pfn_range(paddr, size, prot, 0);
-		if (ret == 0 && vma)
-			vm_flags_set(vma, VM_PAT);
-		return ret;
-	}
-
-	return pfnmap_setup_cachemode(pfn, size, prot);
-}
-
 int pfnmap_setup_cachemode(unsigned long pfn, unsigned long size, pgprot_t *prot)
 {
 	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
@@ -1082,40 +969,6 @@ void pfnmap_untrack(unsigned long pfn, unsigned long size)
 	free_pfn_range(paddr, size);
 }
 
-/*
- * untrack_pfn is called while unmapping a pfnmap for a region.
- * untrack can be called for a specific region indicated by pfn and size or
- * can be for the entire vma (in which case pfn, size are zero).
- */
-void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
-		 unsigned long size, bool mm_wr_locked)
-{
-	resource_size_t paddr;
-
-	if (vma && !(vma->vm_flags & VM_PAT))
-		return;
-
-	/* free the chunk starting from pfn or the whole chunk */
-	paddr = (resource_size_t)pfn << PAGE_SHIFT;
-	if (!paddr && !size) {
-		if (get_pat_info(vma, &paddr, NULL))
-			return;
-		size = vma->vm_end - vma->vm_start;
-	}
-	free_pfn_range(paddr, size);
-	if (vma) {
-		if (mm_wr_locked)
-			vm_flags_clear(vma, VM_PAT);
-		else
-			__vm_flags_mod(vma, 0, VM_PAT);
-	}
-}
-
-void untrack_pfn_clear(struct vm_area_struct *vma)
-{
-	vm_flags_clear(vma, VM_PAT);
-}
-
 pgprot_t pgprot_writecombine(pgprot_t prot)
 {
 	pgprot_set_cachemode(&prot, _PAGE_CACHE_MODE_WC);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 90f72cd358390..0b6e1f781d86d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1485,17 +1485,6 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
  * vmf_insert_pfn.
  */
 
-/*
- * track_pfn_remap is called when a _new_ pfn mapping is being established
- * by remap_pfn_range() for physical range indicated by pfn and size.
- */
-static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
-				  unsigned long pfn, unsigned long addr,
-				  unsigned long size)
-{
-	return 0;
-}
-
 static inline int pfnmap_setup_cachemode(unsigned long pfn, unsigned long size,
 		pgprot_t *prot)
 {
@@ -1511,55 +1500,7 @@ static inline int pfnmap_track(unsigned long pfn, unsigned long size,
 static inline void pfnmap_untrack(unsigned long pfn, unsigned long size)
 {
 }
-
-/*
- * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
- * tables copied during copy_page_range(). Will store the pfn to be
- * passed to untrack_pfn_copy() only if there is something to be untracked.
- * Callers should initialize the pfn to 0.
- */
-static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma, unsigned long *pfn)
-{
-	return 0;
-}
-
-/*
- * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
- * copy_page_range(), but after track_pfn_copy() was already called. Can
- * be called even if track_pfn_copy() did not actually track anything:
- * handled internally.
- */
-static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-		unsigned long pfn)
-{
-}
-
-/*
- * untrack_pfn is called while unmapping a pfnmap for a region.
- * untrack can be called for a specific region indicated by pfn and size or
- * can be for the entire vma (in which case pfn, size are zero).
- */
-static inline void untrack_pfn(struct vm_area_struct *vma,
-			       unsigned long pfn, unsigned long size,
-			       bool mm_wr_locked)
-{
-}
-
-/*
- * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
- *
- * 1) During mremap() on the src VMA after the page tables were moved.
- * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
- */
-static inline void untrack_pfn_clear(struct vm_area_struct *vma)
-{
-}
 #else
-extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
-			   unsigned long pfn, unsigned long addr,
-			   unsigned long size);
-
 /**
  * pfnmap_setup_cachemode - setup the cachemode in the pgprot for a pfn range
  * @pfn: the start of the pfn range
@@ -1614,13 +1555,6 @@ int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot);
  * Untrack a pfn range previously tracked through pfnmap_track().
  */
 void pfnmap_untrack(unsigned long pfn, unsigned long size);
-extern int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma, unsigned long *pfn);
-extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-		unsigned long pfn);
-extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
-			unsigned long size, bool mm_wr_locked);
-extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
 /**
-- 
2.49.0

