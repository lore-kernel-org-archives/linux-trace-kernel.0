Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4192165E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609519; cv=none; b=abwu/1Zxb0pSzSeCZrAOX17NaD1zizBpHsovHhfQgj8SXe7+gDwZIIR7GN+LcPYkm7sVaCY2frw7XkWgXuzQAIJlyoR/0m7VgUWAyCFkzPF72+HrdKNjb1oGI0fwXCbrVA5wPd0jpFnuy/9llFxDyBr0FEhYu11XCg77Njsra48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609519; c=relaxed/simple;
	bh=D/Bi3qtltnNhmUOYmj1e8bbmuHRkIDfLolmIrIZxEaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tNgMuTieajI02C88V+eH1+ZcWaQaaVNXJXhFmF2YPB8qqRPFEz4gnhBw/7CHT1LxFw8Z6rIZwYhS3HsuHrVO/HOjQcMCII539FbFw8kvYtqW1EgXK0V1BCi8J5eI4wn3DVlNmNV5b09f/SVqOFQpKkd5m8XFAetW2xYBJDdXq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTnIrkju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTnIrkju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745609515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrYbbQSySK8OLKh12FO2t07RFwtdpfiRESaN7ZV7Leo=;
	b=eTnIrkjuwAUMOhZ3+A4usXVeEiEj6xq6uaewT0Jb96Rd/WUxLVUHXNhKavssj6AUCVsGFS
	xiG1mYlaj6y/LngQx+ymFzq2QUCf/taP4WvJaSLxZahbxMKio1ES3uaAAF9T1bOqRFJBQx
	5DEHfcRQRa2UOwrO3ZhzsYHfzC/H6xs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-sJECoiBCNSq1g0ZZG5RhrA-1; Fri, 25 Apr 2025 15:31:54 -0400
X-MC-Unique: sJECoiBCNSq1g0ZZG5RhrA-1
X-Mimecast-MFC-AGG-ID: sJECoiBCNSq1g0ZZG5RhrA_1745609514
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91ee078aaso42075656d6.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 12:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609514; x=1746214314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrYbbQSySK8OLKh12FO2t07RFwtdpfiRESaN7ZV7Leo=;
        b=i62mTCwqZ87vBObkmA7zAj0CRHWdiylqWGU26kpME4Ko/4NuJEQbkTkPYgFuI17Jvz
         /xqnlz06XR87werBjzKQsP5THbsJDhQlA1D2xwg/HX3FxJP0eUPWRZcfArumkxEaR7tZ
         yH+Tg0NuQC/rnXQf0Z3jiCLoAmvAn5x2aKOwCkI+v+iLPzRECNnEJlJ5/ilGLrUp02dl
         8s361SyNIOad2mv0ufcQMKjOE7imLTzqNa0LUnZEI/lgFyuA3XQsXv2zROVGUthL9sR8
         k3s4GoL1yFyAlmxt0+omJhOyyC5HLeP2HubpOfTmfJ4n6t8MZo09JOlMISb6defUI4JI
         4/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUnMzEu3BFWXdvw+iBftz6fVp2lYDXzImXAFTfAp9Gp3EdDEtLdu5DmtHSqezcWzAEZGFMxysT4tHpUILl4UY+APpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpR4V7aT3cKMJxsz3hKu9XD4KB52+RJ63A5dfLo5kpwGuRuYi
	96SC2UIj1FMx1yW8yB7SGRCONbme0gtIzfd2H0Wa61wNhPpR2fMUWJ832B9b8WUfTa5AW8zRzE2
	pH0zVWu6R5U5UsL9RQr8UI+JzEIQZ8cpFElXdeWXsZs9itXx7gdSgKuRwQLzgo8IETVwgfQ==
X-Gm-Gg: ASbGncs2uvTSlrOeMCBvDFaOAeROO2Q82SSgL4fFzXeZBH38VJYBGF6FRU082I3qojw
	9Oa/M4hH+IlR0hxcq8KyE97kDSidyk7wKo3C3cJgouP4GiSrm+5vCGWiKouOBCWUbb8Iwt/sXEb
	4Wi/GzL+epFtGmHG02s8hXKjy/q7XaIx8bf+PO9wrgbzLtyTWFMDTb5bTo64EjemhV2cvTCC+CF
	OASHAgw1VKTBY1n4RcUhciO0Vr2PQIg7ek6l2ThF4JeTKpuUELWzTPYzaiQ3UzZmUIbvNhm6qac
	8SU=
X-Received: by 2002:a05:6214:260e:b0:6e4:4011:9df7 with SMTP id 6a1803df08f44-6f4cb9d3063mr67389936d6.16.1745609513945;
        Fri, 25 Apr 2025 12:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFeye1Pg4uChOid/ZXXFZAWI36zPtd4Gkr5VYk4K8JYNC09QMimMlctuGeX7CWMMP3iJGqQ==
X-Received: by 2002:a05:6214:260e:b0:6e4:4011:9df7 with SMTP id 6a1803df08f44-6f4cb9d3063mr67389486d6.16.1745609513528;
        Fri, 25 Apr 2025 12:31:53 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae675sm25488566d6.100.2025.04.25.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:31:52 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:31:48 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v1 02/11] mm: convert track_pfn_insert() to
 pfnmap_sanitize_pgprot()
Message-ID: <aAvjJOmvm5GsZ-JN@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250425081715.1341199-3-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZEgeI1Iegra7-12LTyVKEEhWFUx3wd7_KXBtaF6FeBM_1745609514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 25, 2025 at 10:17:06AM +0200, David Hildenbrand wrote:
> ... by factoring it out from track_pfn_remap().
> 
> For PMDs/PUDs, actually check the full range, and trigger a fallback
> if we run into this "different memory types / cachemodes" scenario.

The current patch looks like to still pass PAGE_SIZE into the new helper at
all track_pfn_insert() call sites, so it seems this comment does not 100%
match with the code?  Or I may have misread somewhere.

Maybe it's still easier to keep the single-pfn lookup to never fail..  more
below.

> 
> Add some documentation.
> 
> Will checking each page result in undesired overhead? We'll have to
> learn. Not checking each page looks wrong, though. Maybe we could
> optimize the lookup internally.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/pat/memtype.c | 24 ++++++++----------------
>  include/linux/pgtable.h   | 28 ++++++++++++++++++++--------
>  mm/huge_memory.c          |  7 +++++--
>  mm/memory.c               |  4 ++--
>  4 files changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index edec5859651d6..193e33251b18f 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -1031,7 +1031,6 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  		    unsigned long pfn, unsigned long addr, unsigned long size)
>  {
>  	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
> -	enum page_cache_mode pcm;
>  
>  	/* reserve the whole chunk starting from paddr */
>  	if (!vma || (addr == vma->vm_start
> @@ -1044,13 +1043,17 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  		return ret;
>  	}
>  
> +	return pfnmap_sanitize_pgprot(pfn, size, prot);
> +}
> +
> +int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size, pgprot_t *prot)
> +{
> +	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
> +	enum page_cache_mode pcm;
> +
>  	if (!pat_enabled())
>  		return 0;
>  
> -	/*
> -	 * For anything smaller than the vma size we set prot based on the
> -	 * lookup.
> -	 */
>  	pcm = lookup_memtype(paddr);
>  
>  	/* Check memtype for the remaining pages */
> @@ -1065,17 +1068,6 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  	return 0;
>  }
>  
> -void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
> -{
> -	enum page_cache_mode pcm;
> -
> -	if (!pat_enabled())
> -		return;
> -
> -	pcm = lookup_memtype(pfn_t_to_phys(pfn));
> -	pgprot_set_cachemode(prot, pcm);
> -}
> -
>  /*
>   * untrack_pfn is called while unmapping a pfnmap for a region.
>   * untrack can be called for a specific region indicated by pfn and size or
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index b50447ef1c921..91aadfe2515a5 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1500,13 +1500,10 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  	return 0;
>  }
>  
> -/*
> - * track_pfn_insert is called when a _new_ single pfn is established
> - * by vmf_insert_pfn().
> - */
> -static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
> -				    pfn_t pfn)
> +static inline int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
> +		pgprot_t *prot)
>  {
> +	return 0;
>  }
>  
>  /*
> @@ -1556,8 +1553,23 @@ static inline void untrack_pfn_clear(struct vm_area_struct *vma)
>  extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  			   unsigned long pfn, unsigned long addr,
>  			   unsigned long size);
> -extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
> -			     pfn_t pfn);
> +
> +/**
> + * pfnmap_sanitize_pgprot - sanitize the pgprot for a pfn range

Nit: s/sanitize/update|setup|.../?

But maybe you have good reason to use sanitize.  No strong opinions.

> + * @pfn: the start of the pfn range
> + * @size: the size of the pfn range
> + * @prot: the pgprot to sanitize
> + *
> + * Sanitize the given pgprot for a pfn range, for example, adjusting the
> + * cachemode.
> + *
> + * This function cannot fail for a single page, but can fail for multiple
> + * pages.
> + *
> + * Returns 0 on success and -EINVAL on error.
> + */
> +int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
> +		pgprot_t *prot);
>  extern int track_pfn_copy(struct vm_area_struct *dst_vma,
>  		struct vm_area_struct *src_vma, unsigned long *pfn);
>  extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fdcf0a6049b9f..b8ae5e1493315 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1455,7 +1455,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
>  			return VM_FAULT_OOM;
>  	}
>  
> -	track_pfn_insert(vma, &pgprot, pfn);
> +	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
> +		return VM_FAULT_FALLBACK;

Would "pgtable" leak if it fails?  If it's PAGE_SIZE, IIUC it won't ever
trigger, though.

Maybe we could have a "void pfnmap_sanitize_pgprot_pfn(&pgprot, pfn)" to
replace track_pfn_insert() and never fail?  Dropping vma ref is definitely
a win already in all cases.

> +
>  	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>  	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write,
>  			pgtable);
> @@ -1577,7 +1579,8 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>  	if (addr < vma->vm_start || addr >= vma->vm_end)
>  		return VM_FAULT_SIGBUS;
>  
> -	track_pfn_insert(vma, &pgprot, pfn);
> +	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
> +		return VM_FAULT_FALLBACK;
>  
>  	ptl = pud_lock(vma->vm_mm, vmf->pud);
>  	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
> diff --git a/mm/memory.c b/mm/memory.c
> index 424420349bd3c..c737a8625866a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2563,7 +2563,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>  	if (!pfn_modify_allowed(pfn, pgprot))
>  		return VM_FAULT_SIGBUS;
>  
> -	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
> +	pfnmap_sanitize_pgprot(pfn, PAGE_SIZE, &pgprot);
>  
>  	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
>  			false);
> @@ -2626,7 +2626,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>  	if (addr < vma->vm_start || addr >= vma->vm_end)
>  		return VM_FAULT_SIGBUS;
>  
> -	track_pfn_insert(vma, &pgprot, pfn);
> +	pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot);
>  
>  	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
>  		return VM_FAULT_SIGBUS;
> -- 
> 2.49.0
> 

-- 
Peter Xu

