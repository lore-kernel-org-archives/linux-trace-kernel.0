Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D93C3BFA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778633; cv=none; b=J8m7ukTgRBZ3W9YGAONhhTq8w/R5VrqBsriiH41LR1TJWqCXTuZMcW1kd9bG+Q7bt4OOBUrmrzpgr0GuCzUevghI9NlB2jSiWiuGW7P2rGuk0UkW21b0N4KezdHLyGcIheqkNdRrXFeKxcf5rKzVAMTHGmdw0NO0d4kG0jb0ouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778633; c=relaxed/simple;
	bh=LCWX/FWzch2f69uBq/OyOfIjJFTVyqrMC/8AOUgEdBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq4pcmCtV8xk/9197wRSccLiV+LMKLB85tPQk096v9iEgruTT3pBdiHl09pQ9rn1YZ/D+uill32r/H2t35C+vdU1bLXA2Ra2NWuOeYkfb7dkFXlZ4A9jLVgxwp4k2Tom9PeoHrf6YHQZ039+s2gODCwYNyH/4+lVh8iSuc5SeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcI3uw7a; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcI3uw7a"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so5237314a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779778630; x=1780383430; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBNJcSkWDMS2F/o+KqKiAkJP47naY8jIDQxVCXbkfTU=;
        b=LcI3uw7a7Jls9J4c5B0I9OCMJCHKetwP2oq2qmvT5EBxq9U9pnwvVbyynAexh99XMd
         zj7w+Vu8oWUk3XUiKv9QtPIxW3xBXyr1KsFpfJpJ/RiMWgGTle8ZOueECdbFxXPH//lH
         zFgdYawcD48kgbFCykq4wDoucPjx5K0zIhpmmU0fQ3q5bf5KTRn9hiSdeOCKvQHi/lr3
         NplxjEnerXjEpygqcJS3JPR85Xcd7gWIJ8DOpDqumN9L6pQif82bfDuHCrZ3ZAE5qsYk
         NYDRzE3BdqYikS/zOd2ak/kRerU7fH+2yOVdxDc52O9asPXEt1xZHYCMijOqeDmWMhpZ
         cySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778630; x=1780383430;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBNJcSkWDMS2F/o+KqKiAkJP47naY8jIDQxVCXbkfTU=;
        b=X4CtIhXx8feVnat9gr3/Qxm4cV5Mv1kuSVJfhfskvBI2UX6KhhkhoqulalDpe11WP5
         6JSSJOSPIjjVwkvrhyaroOJgfCrJK3Z6xtamTHYRzIqMhnGGlU/fNWnv6EYneXD856BB
         VOPR4DGmS5uoEQNSpNQZ5b1Z7Rdc/zIhWnv/+SJy1QjrLBOJrhCsLIX9ZgWuGBinLLrK
         NByrONPnYmx8H3lPh1u8jJLkWbLws5mbV+9s/qmtta86aYvK4JvDfSK4bdKuIc1zhn8N
         3kmbkMnY5Fs86e4GBaVUawioKH+F4psXrSgI97yL1C1DApNjsjgd+kxqX3oE4y2R6nDN
         +Ptg==
X-Forwarded-Encrypted: i=1; AFNElJ9loIQPFGe9ZXcH+ALr3LzIGoV0hD4P/ipfaJWtAaU3cvcCkJKM9iQo+d6KMywxQmGZZiv9UoiEo1HZ1jIWKmJ8cnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAumqO0aMXfsvLxFV8XC3NFBfuInWnLYdOfdllTmp7ks0BNVi8
	tzmDmT+iDMuW7LNIkYNtoC7D/0NOoPfamTzABVRY5hebyHCSQFe/Xh8L
X-Gm-Gg: Acq92OF0MGXx1hwip2oDJFuhc6KgRyUUOuV9sJCWOzBE3pRPyKXOVzZM2qOfCTWqE3+
	0bkuKdn6H2Gefs8oCCpZ3g8GQ9/JDmRDEFAxOPhip/FyCD34nZXZJHH3NDsv8OsWHfxYhQGkFfw
	umtxxZRnMoxi1t560S3ZdpL1jVhqlBGocRYeKL3YzWUdzwxYpU6dmRTTrB1zh9TfAZ6D4P1m83G
	twhCsRk5B9lU/mSbc3ElU68grWzOleKLfauu79fVlv3OkCb/enZt8nz3DeacqQW+nWE1bUJRaeS
	fEONLHLBwwIHys+8NNFU2pyIqVR/Y2xbikmmrra9JJrlAtXCQSO5wo2pnpDpWzrJkSukXt5AcLl
	ItcAbGNmmH9yK3kpqUR1L3lvRgFtUFyu9hO9fYLnsKjAcZNymoaWUH2vUa9AlI3OSAtoUJf67YG
	SsmxMvBAUJsN1/U4Qu76gVCg==
X-Received: by 2002:a05:6402:354d:b0:687:3580:fc26 with SMTP id 4fb4d7f45d1cf-6889cb3d24amr9081852a12.13.1779778629909;
        Mon, 25 May 2026 23:57:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1e984sm4668480a12.14.2026.05.25.23.57.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2026 23:57:08 -0700 (PDT)
Date: Tue, 26 May 2026 06:57:08 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
	jack@suse.cz, jackmanb@google.com, jannh@google.com,
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com,
	pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
	rdunlap@infradead.org, richard.weiyang@gmail.com,
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com,
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de,
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <20260526065708.oyyddmt2zgfwu2q7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
 <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com>
 <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, May 25, 2026 at 12:10:41PM -0700, Andrew Morton wrote:
>On Mon, 25 May 2026 08:15:53 -0600 Nico Pache <npache@redhat.com> wrote:
>
>> Can you please append the following fixup that reverts one of the
>> changes requested in V17. The issue with the change is described
>> below.
>
>OK.  fyi, what I received was badly mangled: wordwrapping, tabs messed
>up, etc.
>
>Here's my reconstruction:
>

Hi, Nico

I tried to reply your mail, but found it has some encoding problem, so reply
here.

>
>Author: Nico Pache <npache@redhat.com>
>Subject: fix potential use-after-free of vma in mthp_collapse()
>Date: Mon May 25 07:38:59 2026 -0600
>
>Between V17 and v18, one reviewer (Wei) brought up that we are not doing
>the uffd-armed check until deep in the collapse operation.  While not
>functionally incorrect, it can lead to unnecessary work.

So we decide to tolerate the behavioral change?

>
>We optimized this by passing the vma variable to mthp_collapse() and using
>the collapse_max_ptes_none() function to check the state of uffd-armed
>preventing the wasted work later in the collapse.
>
>mthp_collapse() is called after mmap_read_unlock(), so the vma pointer can
>become stale.  Remove the vma parameter and pass NULL to
>collapse_max_ptes_none() instead.
>
>Link: https://lore.kernel.org/2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com
>Signed-off-by: Nico Pache <npache@redhat.com>
>...
>
> mm/khugepaged.c |   10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>--- a/mm/khugepaged.c~mm-khugepaged-introduce-mthp-collapse-support-fix
>+++ a/mm/khugepaged.c
>@@ -1502,9 +1502,9 @@ static unsigned int collapse_mthp_count_
>  * If a collapse is permitted, we attempt to collapse the PTE range into a
>  * mTHP.
>  */
>-static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
>-		unsigned long address, int referenced, int unmapped,
>-		struct collapse_control *cc, unsigned long enabled_orders)
>+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>+		int referenced, int unmapped, struct collapse_control *cc,
>+		unsigned long enabled_orders)
> {
> 	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> 	int collapsed = 0, stack_size = 0;
>@@ -1524,7 +1524,7 @@ static int mthp_collapse(struct mm_struc
> 		if (!test_bit(order, &enabled_orders))
> 			goto next_order;
> 
>-		max_ptes_none = collapse_max_ptes_none(cc, vma, order);
>+		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
> 
> 		nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
> 							       nr_ptes);
>@@ -1749,7 +1749,7 @@ out_unmap:
> 	if (result == SCAN_SUCCEED) {
> 		/* collapse_huge_page expects the lock to be dropped before calling */
> 		mmap_read_unlock(mm);
>-		nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
>+		nr_collapsed = mthp_collapse(mm, start_addr, referenced,
> 					     unmapped, cc, enabled_orders);
> 		/* mmap_lock was released above, set lock_dropped */
> 		*lock_dropped = true;
>_

-- 
Wei Yang
Help you, Help me
