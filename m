Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13E293759
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053277; cv=none; b=sYvSep2YYW0fn1EJYzQx5R2NDcHGn7TG9QuVARzmewpahQ9HnU0h8TDd4h6JHLkw24oL/uVMQhOSWj7dmZr/X/JfCbvQUr0On5nYA/eI1yOOkQI0Ckz1/nDfLgkUPOewe3VERHivtdnzXh6Ebot+rjFUX+q2jDYbzcsqEnZcuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053277; c=relaxed/simple;
	bh=HzndHn4T9ZYXppW40wlrwQTTad9pQBIWeyR83towNBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TadGGm97aq0EV9zrojU9uvg5ZR5yxKTBaa4nliw0+4SMMdEluHQDaxSO3b50jmjcRcae1Y1p9zdD5RoLtv+U47T3OyJuKPVMc07y4ePDTu7TajaiRzAGn00vibZDdZOCKU8MnaOIAAfTx0ztG7oFZ1fWNc3z29fhd4uu2pbnhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKuLvVQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKuLvVQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nHoWozKkbl8Jpefo8Zb0yf0bGe9671cYhr6GgVPgWI=;
	b=NKuLvVQcFCbfva4+Dq2Zyj+Jjfifl/4jbur4aORBavSd5zzika/TVLai+HIQofLsmrc7Co
	WLUrrtlOYzVcT3OF2CF4FAatSU0W3lw8OkXvoynRX6kmVJIRoQDENtSaRQHSmcQkGoY8RQ
	zgum4fpqNWjmhIipqBZGIuvhP2EkCBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-3IflrAqYOeqNtBKgzs_pdg-1; Mon, 12 May 2025 08:34:33 -0400
X-MC-Unique: 3IflrAqYOeqNtBKgzs_pdg-1
X-Mimecast-MFC-AGG-ID: 3IflrAqYOeqNtBKgzs_pdg_1747053272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so20824335e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053272; x=1747658072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nHoWozKkbl8Jpefo8Zb0yf0bGe9671cYhr6GgVPgWI=;
        b=oejwWiDZfJpqhIeqLyu3bsBoJBekZ0C6Ct95iZ+5Nn9Q8bp8xoZfswbCEcyF6rSRZd
         0HfL+YrteU0a8olC5m6mJeCwkPdYE+QSHLNacGO7p8QeWYjWpQw6LLuzD+RfWHuin1S5
         SE/Go6BQtBHShUBKwa+eNjPmpUMEE94toBjAwRzuwGaevJeMAgVyRcR9TPhhGQimrOrs
         0wBWatBXedWOO2yW3s9cjrdwcI6JY7tTrA81yqCDqkRZkV3yPj4jexxSo9shoNyxRL5Y
         z7updoZcuJwwZHccLdY3aTnAM7UcLMDxZiW7F/DzbzpSXvaSzpLxDlswVuOLuHo0P9n2
         ZXzg==
X-Forwarded-Encrypted: i=1; AJvYcCWFg0FYZiMz7xTBwvt/LvIL8vxHghgwrSAN4CEb8Vf6G33Md3eyX0lTIlvY3ZtrgNTqOBKx5J5suoUhCR8MegoXRMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCgy0PxcHMuW6ma8Epy579ywxkzVDnpb/P2Z9gnfJjTr8eZz5
	u5mQlAacTW3ozZKpag3F0PKcvcSE65Zhw2cXU/EDVNKfTHiowlLUGodrJy00UMGamCUc/EoHwD0
	uh9aKlHlM8vii/xEMuIfI6KtOZziHQYzNozQe6qiCoJVfUIXxegYQvyHIG00LI49mWKibLQ==
X-Gm-Gg: ASbGnct3lBqyQOETlUX0SSNEdZToQX9/ftDRYv3CoKUIPe0LVOOdMts2KPnpgmZzyxl
	FGINrvZMUkFKZgyAtKHYtHLirFGY7AWOE+bzhyPBZXNPMDN3xeoHKx0wRHpt1V+yt4tddByoIdJ
	nq5BKiUT7Zc1XURTPSWD6j+Gx8lBU1+3T20ljYtf6gn9neixYwveacCtOko+vgKJEkhH7gURmbd
	NYVqziQhLqKiyMglyVLS9zYyiVC5NibWNlXLANCgR1gg/YmgSInMtVRbP2FJjV5apOpGMjFYhtf
	cC+0hS1BFobADbNdDVSL0N43+kG8s0erNHiMdCpwq06X/aS+gFrZF76qLknsY7G7hc+KsJq3
X-Received: by 2002:a05:600c:3490:b0:441:d4e8:76cd with SMTP id 5b1f17b1804b1-442d6ddec00mr105442435e9.29.1747053272050;
        Mon, 12 May 2025 05:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAkmJW1RYt0shbyVSJYG/Cde8Y5kgDkvTgdUylwEM8H1PlNDd2NNsMG+k4pYVsizSZx0oo/Q==
X-Received: by 2002:a05:600c:3490:b0:441:d4e8:76cd with SMTP id 5b1f17b1804b1-442d6ddec00mr105442015e9.29.1747053271651;
        Mon, 12 May 2025 05:34:31 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd32f331sm168479925e9.13.2025.05.12.05.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:31 -0700 (PDT)
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
Subject: [PATCH v2 02/11] mm: convert track_pfn_insert() to pfnmap_setup_cachemode*()
Date: Mon, 12 May 2025 14:34:15 +0200
Message-ID: <20250512123424.637989-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: cxqYeynEwN0f1SMHFuLjHMLv27wGehnayUSJ6lNW4I8_1747053272
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... by factoring it out from track_pfn_remap() into
pfnmap_setup_cachemode() and provide pfnmap_setup_cachemode_pfn() as
a replacement for track_pfn_insert().

For PMDs/PUDs, we keep checking a single pfn only. Add some documentation,
and also document why it is valid to not check the whole pfn range.

We'll reuse pfnmap_setup_cachemode() from core MM next.

Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 24 ++++++------------
 include/linux/pgtable.h   | 52 +++++++++++++++++++++++++++++++++------
 mm/huge_memory.c          |  5 ++--
 mm/memory.c               |  4 +--
 4 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index edec5859651d6..fa78facc6f633 100644
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
 
+	return pfnmap_setup_cachemode(pfn, size, prot);
+}
+
+int pfnmap_setup_cachemode(unsigned long pfn, unsigned long size, pgprot_t *prot)
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
index f1e890b604609..be1745839871c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1496,13 +1496,10 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-/*
- * track_pfn_insert is called when a _new_ single pfn is established
- * by vmf_insert_pfn().
- */
-static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-				    pfn_t pfn)
+static inline int pfnmap_setup_cachemode(unsigned long pfn, unsigned long size,
+		pgprot_t *prot)
 {
+	return 0;
 }
 
 /*
@@ -1552,8 +1549,32 @@ static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long pfn, unsigned long addr,
 			   unsigned long size);
-extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-			     pfn_t pfn);
+
+/**
+ * pfnmap_setup_cachemode - setup the cachemode in the pgprot for a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range in bytes
+ * @prot: the pgprot to modify
+ *
+ * Lookup the cachemode for the pfn range starting at @pfn with the size
+ * @size and store it in @prot, leaving other data in @prot unchanged.
+ *
+ * This allows for a hardware implementation to have fine-grained control of
+ * memory cache behavior at page level granularity. Without a hardware
+ * implementation, this function does nothing.
+ *
+ * Currently there is only one implementation for this - x86 Page Attribute
+ * Table (PAT). See Documentation/arch/x86/pat.rst for more details.
+ *
+ * This function can fail if the pfn range spans pfns that require differing
+ * cachemodes. If the pfn range was previously verified to have a single
+ * cachemode, it is sufficient to query only a single pfn. The assumption is
+ * that this is the case for drivers using the vmf_insert_pfn*() interface.
+ *
+ * Returns 0 on success and -EINVAL on error.
+ */
+int pfnmap_setup_cachemode(unsigned long pfn, unsigned long size,
+		pgprot_t *prot);
 extern int track_pfn_copy(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
@@ -1563,6 +1584,21 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
+/**
+ * pfnmap_setup_cachemode_pfn - setup the cachemode in the pgprot for a pfn
+ * @pfn: the pfn
+ * @prot: the pgprot to modify
+ *
+ * Lookup the cachemode for @pfn and store it in @prot, leaving other
+ * data in @prot unchanged.
+ *
+ * See pfnmap_setup_cachemode() for details.
+ */
+static inline void pfnmap_setup_cachemode_pfn(unsigned long pfn, pgprot_t *prot)
+{
+	pfnmap_setup_cachemode(pfn, PAGE_SIZE, prot);
+}
+
 #ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2780a12b25f01..d3e66136e41a3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1455,7 +1455,8 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 			return VM_FAULT_OOM;
 	}
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write,
 			pgtable);
@@ -1577,7 +1578,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
diff --git a/mm/memory.c b/mm/memory.c
index 99af83434e7c5..064fc55d8eab9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2564,7 +2564,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
 	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
 			false);
@@ -2627,7 +2627,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn);
+	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
 		return VM_FAULT_SIGBUS;
-- 
2.49.0

