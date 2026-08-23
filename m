Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5541344DBD
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503976; cv=none; b=XXi7arGKB/dK3d7GIXxE/91zZB5aohbnDaa1XHQfbBwEK/SD3Atxm53KKXGlO8YZ9CZjmFdM+tKxALcBRLGOua23n3Yfa8tRAIWAGSosohKZ3duLgP/7UpVp0KLIBUP/MtqteVKCWAP3qE3gG69Fe3qQwA+3KrB5jwTXyUKERYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503976; c=relaxed/simple;
	bh=hWjQifge1RAK6z478R1PFnRWX2lnMwsgDiVDTSmBsn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sygYuqxjuGfJ/zFFug52/j8k/jZEN/b69+ZtvhFm/e7njUYBMJBXSkzrZwthLgyeJQ4+CyPcbiQvAUqX7Oz4dZKmqyk6JsndPVchaMAu0I7mF6oFI7z8lweAobykNPFhwvGMooU23v8FVQD1OJzm+sXktxF6V8Y5RsiUZFQSHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSR/krCB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSR/krCB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499b0eefa61so15065305e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787503972; x=1788108772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjRcKycCgEIdRjuuH2tPItX4wlK7ZDllY3I75Ar7NjE=;
        b=GSR/krCBETjHDRHfIT+yJupj3qM6I2DiEfRPvo0ckTQ7BwoR7fYMdY/yytfRR8kufQ
         fVf2aFwMqflvHWsUNWfWyrzeF/7LICRSVmzT7H0xiA+zI9f02Eb1Wco3bdatGBSpZqIL
         gfQugnMPnF6zGU8SrmrBJM8DgbVUdDxu1jNaaIBm+j6/nFciAPFAVSQcLSyvPdtBfMob
         8U2YUVf8Ib6S28kOlvl3YDp+P+msDCi6ZngCAJ1sNC8KQf811M8TJluLgzeZCwhnFPyz
         qEG6GyFh30l7hiUaYSQlwTph8cagFfArmxfYNA16Q9qgurPz6bb9UReRJNCx/4hiiddF
         fhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503972; x=1788108772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjRcKycCgEIdRjuuH2tPItX4wlK7ZDllY3I75Ar7NjE=;
        b=By3exWO9jGGLYBdb2+HcDUfYw3jPcUChNVd/z/B1PNyM8ETclsiVO47ZGffIc0DZ5W
         uX9vfYmv5d4qxzvl7Oxkv7jkDO3FA53haV9YyLg3cgXp+j1hfTfq4RKLYX/570hu1z7j
         unGj5G6VbxDqPjKdjfaBCeDYwOBIAKJFDcw8jyCocruHr2vINp5Gh3biK/0j9FmxXjfZ
         Jg2Bgr1jFInrnspOZve9KJSV0EY1nhOFwyYuGT0J5/a9voeClNIqbB6pi3SvEg8GA7iU
         7sB7V8GA9JrgNHaJZivkEiSV6pSR4aR3a2FvRneXRNcZFTn1+x4eL6j3dbxZ11Eqebzd
         w00Q==
X-Forwarded-Encrypted: i=1; AHgh+RrBiJBNvLw0XpRrXbrER34p4ifou3SE+yO52km0N4fu2XH4+bhkL27xt4lvEtknVuZFlQXpzAZyC2ccenJcAtNCjNE=@vger.kernel.org
X-Gm-Message-State: AFuF++kWI8MrSiBw0i6F+d89VaQ3sOa0kzU8GsOa9hLwGrMrCQcF8xsZ
	euR7ScGJYwSl3qFDvxIHHZJTai0RXAwof4TjaGL2WQR3OOPB4oOhcvdOcsWOOTAhVg==
X-Gm-Gg: AR+sD120by7bBEWdUt2WJkspH7gTul0NEFrbtJAJwZ4utWBMJsxCyJ5lPotaXR1+oA/
	LZ59PlSoFdgsRjMVanmMdF70xr94p633JocOxx9lS+Q98Lml8kYHnUuG5ppc4za/qWtJlezxdhu
	XSjwyU44wuP0jo2OiuU1pC1i87Z+vz/VlHRJkhKagT7pu8xsQQFJEXZqFRqfTanObhP/Fy8ljqJ
	Rf6CGXpAJamcAIkjohGDjKgrR2P9n/Fyh8+XtKS/EKzdhfN7ETavCy49vSEPGXQc87iaFK4e4BS
	FDnGbBwowSFd0R3ByncNPJRXh9lpSiynxbWF2w4vk5dvcCUcySCdsol5PEILIFyPSQNaSRFlVBF
	/zpgw+A0utasa1hu58ex/bNsxQ8Z8HdORIJP/qkX+khd1CrxCbr9rx7okAJ+HVwxsf7g94MuHSo
	HqY0qEV45HgH7wrOqj2YKx3tHANGhzV5yXXJ7Tt6T4sOH1UAMMjmcjCbT/k/dnz3bkedd9eFLA0
	nwT7JEmx0yxRgN7vfWSOJJMmTM24BDcfZ7NAVZ2yrLELTqF
X-Received: by 2002:a05:600c:34c6:b0:499:5f7a:7ea2 with SMTP id 5b1f17b1804b1-499c19cbbd7mr122720055e9.12.1787503971299;
        Sun, 23 Aug 2026 09:52:51 -0700 (PDT)
Received: from google.com (78.207.190.35.bc.googleusercontent.com. [35.190.207.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c33098besm53780005e9.0.2026.08.23.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:52:50 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:52:47 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 5/9] arm64: mm: Permit permissions changes on huge
 vmappings
Message-ID: <aoslX8cDCR647ebE@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260822135323.795946-16-ardb+git@google.com>

Hi Ard

On Sat, Aug 22, 2026 at 03:53:27PM +0200, Ard Biesheuvel wrote:
>From: Ard Biesheuvel <ardb@kernel.org>
>
>Allow permission changes on huge vmappings in cases where no splitting
>is needed (i.e., the region is aligned sufficiently), or when the system
>has support for splitting live mappings.
>
>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
> arch/arm64/mm/pageattr.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>index bbe98ac9ad8c..20ff9cb273c1 100644
>--- a/arch/arm64/mm/pageattr.c
>+++ b/arch/arm64/mm/pageattr.c
>@@ -169,8 +169,6 @@ static int change_memory_common(unsigned long addr, int numpages,
> 	 * we are operating on does not result in such splitting.
> 	 *
> 	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
>-	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
>-	 * mappings are updated and splitting is never needed.
> 	 *
> 	 * So check whether the [addr, addr + size) interval is entirely
> 	 * covered by precisely one VM area that has the VM_ALLOC flag set.
>@@ -179,7 +177,16 @@ static int change_memory_common(unsigned long addr, int numpages,
> 	if (!area ||
> 	    ((unsigned long)kasan_reset_tag((void *)end) >
> 	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
>-	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>+	    !(area->flags & VM_ALLOC))
>+               return -EINVAL;
>+
>+	/*
>+	 * Disallow VM_ALLOW_HUGE_VMAP mappings unless the region is PMD
>+	 * aligned, or splitting live huge mappings is supported.
>+	 */
>+	if ((area->flags & VM_ALLOW_HUGE_VMAP) &&
>+	   ((start % PMD_SIZE) || (size % PMD_SIZE)) &&

If I understand the intention here correctly, I don't think it is valid. Even   
if it is PMD-sized and PMD-aligned, it would still cause a split because  
the loop below is not using page order, but performs attribute changes 
page by page.                                                                     
                                                                             
Best regards,                                                               
Adrian
