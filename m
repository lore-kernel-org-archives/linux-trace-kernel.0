Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A01FB3;
	Sun, 24 Aug 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755999472; cv=none; b=MIjOKI+axLNr/vrOIdK/kueQVIUvpB/Q613wOr5rePWVipZvsaRUQ7bF5pbzrf6OJ9qJjqyQfPFHA/8HtK2WQEw4DZAApJ3fwOh/eJ0mERVe1C3GoIHU8dMUBcYzBNyZ+SyhY3zX70lh2RemKBKYutfn8WnZmrosFGJW8IHIih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755999472; c=relaxed/simple;
	bh=+nC/GVo0QfwdaQuyT0nNE/Npbuly6IsAQTazyH5tsZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYF35lORFVrqtv/6+BKCb2e311/+n7pxt89TjxJ+XmRr+w8e1XSSOWtRnTHNeWP4BkJpjeDrGer7ZBEQZ/AKgXZR09sSrDEkPd5a4pmh0oVmbzpQnqjsDg5daY9HjDf+xW8VsgAHE2xtU5GFUOi676p0TP5E/0q/PR6PqcXqGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re0Opgd9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re0Opgd9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c20e28380so3010435a12.1;
        Sat, 23 Aug 2025 18:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755999469; x=1756604269; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UBZPF5YbhnRufm437C0PF5qAjXN/Uh/I6Zgp8tz2Ts=;
        b=Re0Opgd9jYlnwFpT6h+aVDFIjfXeYEmHQzqRsWqYSexyLkE1Whe9Va2mcV6aawmtp3
         VteU1OPu0TVHsxcKajkixt7WqdUQGJguM8kSpKyw/J2G0TACUKbA9NqkKOjNC9+5NLaf
         lzIHssA4/EGrlExK9Hv2PHwYySRY+SMmMkfo5sPzFrAuplk04WgVI8J02JIqZ9rDx/5V
         OYm8haE0mb7B7Wi1Ly69ZMGMxe6XXljeg8oXRjLzLeySkOzO8sw8Pd5meWeicifmxZl/
         FE8HyWlrKHEOPbmgkSGrEUSGfX8MZh+/NK8xeS/2gMEApu9qzMzxCpCs8728hRUmWkdf
         ItcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755999469; x=1756604269;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UBZPF5YbhnRufm437C0PF5qAjXN/Uh/I6Zgp8tz2Ts=;
        b=iYRL0CyEZvD5Ji1VDT+ILBrZMS9g7laFM2mI3WA1UVFxJxQcufs2MDsOwWAiETB6Gp
         GGt1WOOHebQx3Zwuawv9WkGNZjLEKNKSXu3bR469XpcCh9y7Vq1ChLqT27DzWHSOvqg8
         4+WJP73MzlfevA02U2tvqUUqL9ldcGM/sN4gMEWvyHWDIgXcqba4rJMe6CCOtEivSe1p
         kKb4RFvsKH5r9v2LLNJa7oehVOnhmCSC/impfJUYFMYCHvovylmldTG3DGtyqP8Mm/+2
         1SfKNGkFz1tAlENWqtuynRyBOX+AvaV/Fk3SkzXfiMM/uGuiLSCDUDTxcsQ0nwAdc4IW
         WBXw==
X-Forwarded-Encrypted: i=1; AJvYcCUH1YD1exwXwYjp3A5DnXI2CfHP21tQRooBKPIJkwM0kqk3qTxG6vPsRXhOz5GRkdT42J9J525sQYbwz3P1@vger.kernel.org, AJvYcCVGJjaE0Mx7lridWrkIjSFb3vU/N8KuA9RVi/mOobcw5r8gJd3B4TPKDGG549zRoO0+a6w61VQS6jc=@vger.kernel.org, AJvYcCWPPgI/lDdblIydXojlUkFh4U/ryZhgbh1uZ+u0xkEsxnQrsX7lp/xN0O4MPE05AMJ1aDdOnJE2rpWaLGuMlOxtqZRV@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaK61PZ1ayCouga1c1iySzYlj1HDyJ+C52wEt/FeJt2aNJeKZ
	1JVoOQGxBLX1vpceIYMZmG9we8SGiGSMqvABTRUQiIbq+G+w8E1Hw13N
X-Gm-Gg: ASbGncuRKnAPefp+65bCSeScioek1bbonfZ8QVyudVORliHbuaQernQjA5ggWk8frU4
	i5nhYQquNuTak3oer60jecgaTYNEFD0Vm1I90/ga2ogYkOVPG3DUi7kIlM4AThEgxGsWAgRQE9W
	olU+NFGloe6oSjWXnwG58C/eNwWnlqski26xNeqIXee0OPNKWzGmhHLPSzYBnMwirJETs7AiZmm
	1SoKYZnzGpr7H4EBXYMmSydUJIntnYwHHYPo2YB2KVgvswrlCTIZYLv13F3JJ1sekLQvp2t32Oj
	sMV1DlbawKs1qKYBBxuTBOlkvkxg4Sn9i0ULXaq+q8OMrHZLvEFQDthWPpiOocpltanX0/NlfYu
	AqtbX7GEJb6ZEiq4quaJc2sKFPw==
X-Google-Smtp-Source: AGHT+IHxdAZXliDg4Pz7o7ZUiSoOONIAXZLqOCQdY0hkLH1p+jqAseH5s/K0XVWooeUz0LaIMhIjAQ==
X-Received: by 2002:a05:6402:5057:b0:61a:8c7c:a1f4 with SMTP id 4fb4d7f45d1cf-61c1b48f5e9mr5913145a12.11.1755999468866;
        Sat, 23 Aug 2025 18:37:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3174f4d4sm2476072a12.54.2025.08.23.18.37.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Aug 2025 18:37:47 -0700 (PDT)
Date: Sun, 24 Aug 2025 01:37:46 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com, aarcange@redhat.com,
	raquini@redhat.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
	jglisse@google.com, surenb@google.com, zokeefe@google.com,
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
	rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
Message-ID: <20250824013746.bvsz3vajjj2kphrl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819134205.622806-4-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi, Nico

Some nit below.

On Tue, Aug 19, 2025 at 07:41:55AM -0600, Nico Pache wrote:
>For khugepaged to support different mTHP orders, we must generalize this
>to check if the PMD is not shared by another VMA and the order is enabled.
>
>To ensure madvise_collapse can support working on mTHP orders without the
>PMD order enabled, we need to convert hugepage_vma_revalidate to take a
>bitmap of orders.
>
>No functional change in this patch.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---
> mm/khugepaged.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index b7b98aebb670..2d192ec961d2 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c

There is a comment above this function, which says "revalidate vma before
taking mmap_lock".

I am afraid it is "after taking mmap_lock"? or "after taking mmap_lock again"?

>@@ -917,7 +917,7 @@ static int collapse_find_target_node(struct collapse_control *cc)
> static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> 				   bool expect_anon,
> 				   struct vm_area_struct **vmap,
>-				   struct collapse_control *cc)
>+				   struct collapse_control *cc, unsigned long orders)
> {
> 	struct vm_area_struct *vma;
> 	enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED :
>@@ -930,9 +930,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> 	if (!vma)
> 		return SCAN_VMA_NULL;
> 
>+	/* Always check the PMD order to insure its not shared by another VMA */
> 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> 		return SCAN_ADDRESS_RANGE;
>-	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
>+	if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders))
> 		return SCAN_VMA_CHECK;
> 	/*
> 	 * Anon VMA expected, the address may be unmapped then

Below is a comment, "thp_vma_allowable_order may return".

Since you use thp_vma_allowable_orders, maybe we need to change the comment
too.

>@@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> 		goto out_nolock;
> 
> 	mmap_read_lock(mm);
>-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>+					 BIT(HPAGE_PMD_ORDER));
> 	if (result != SCAN_SUCCEED) {
> 		mmap_read_unlock(mm);
> 		goto out_nolock;
>@@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> 	 * mmap_lock.
> 	 */
> 	mmap_write_lock(mm);
>-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>+					 BIT(HPAGE_PMD_ORDER));
> 	if (result != SCAN_SUCCEED)
> 		goto out_up_write;
> 	/* check if the pmd is still valid */
>@@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> 			mmap_read_lock(mm);
> 			mmap_locked = true;
> 			result = hugepage_vma_revalidate(mm, addr, false, &vma,
>-							 cc);
>+							 cc, BIT(HPAGE_PMD_ORDER));
> 			if (result  != SCAN_SUCCEED) {
> 				last_fail = result;
> 				goto out_nolock;
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me
