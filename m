Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235B34CF5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611251; cv=none; b=LI2okA3zZBo5F7jetuUdo213eCuDxjJPoZumfXOvIHMd7uixCpNFIuVOx7hEUd69gWXqOP8LlGzYivH0Ni/Selyb6KxNlNsF3FwYHtoSL3S/wVSVP1YSJFUn0+xMpoRzbeWUSyEI781xrsDmpl0ksCqkzNfYa7Q78740+g7GZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611251; c=relaxed/simple;
	bh=a6+JQTsIgRc9pDgT44BOrIZwQPPPp7NtalWXb0q5F5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q8t3epQAbsdTkkXl0PViJdczmMLtSWphaJUoGsBIMABWgxTJweREOUjq6KCCdWbH7rslo9fFH0hRSPBY4/Uldl0hKei68WEpxRExpAAds6Q5MIfpsSAhYHOUwVQcpYMUA8zS3grP8tOxCJQ6WUy3HPifC6e/HPMC0eqlOkJHgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yixy7Q91; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yixy7Q91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745611249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8/4HYJEyKL0BmypDXzpIvuA602T0FZNtumDp2Gucts=;
	b=Yixy7Q91+DePz+AzUcfz0R5DTQLxv81cWvwifX+6X+gaKGSPuWqcNYcCZODxTmv28HHDhi
	Dglh12fIXOvm3GZA7VJovIlctvUR1SOIr8U4kj0Cl4nrMbAp9XqitPO8og0+AxMTPHrFHI
	f7VvGd001MzoGKFUl62wkqy+rgMP9xY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-tsEGM_JSPEK1YPFAnhlKlQ-1; Fri, 25 Apr 2025 16:00:47 -0400
X-MC-Unique: tsEGM_JSPEK1YPFAnhlKlQ-1
X-Mimecast-MFC-AGG-ID: tsEGM_JSPEK1YPFAnhlKlQ_1745611247
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5c82c6d72so443287185a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 13:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745611247; x=1746216047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8/4HYJEyKL0BmypDXzpIvuA602T0FZNtumDp2Gucts=;
        b=tv+7KbwUSiaoUG/mNTRxj9CAh+vknzH/mNoZMx9jCeXemMKt1gNmDuNq/8sHI25njt
         AZAnSK5KbJduUXjbekfT9mPoD46+ntbxz7IL/Qm3S534/wP6oNsfDLg0pm49Ul+ASnyD
         FPSvRyKi0loUMA1qnFFKrZIIPj9vX5yncF+4mF+n7zgnNtZaLzDmCXe1dEQuYY5EMznr
         rUicZsCow07NmlgqRXVOzImKmdbNFEITX3Y4S9yQYKYybVoHoyWw6W5r2JsGjD7MCMuU
         L4lL7v+5TqZ73amzt92XNAAve49wiQl4ItnzR6JD8RFlcChg2SerJbywvnv0w2VkjyDJ
         epeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVfc+3+D4En59pmWVmE0oWgKAQoOrTdlvffh4MgwK7HTD9T+dQ1/rPLIWX3+aMcKgj8K5klJMmkmMrn0TPMz97fjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaAbVmB+O1TH32LhH9QM63QNc4nw9dfdgYWLttxOjRVbZjO8F
	JLhC+mYyyAbO5WXR0DGyu4V6AYBQm6kpZkIPFyMqjTNxro4yTsvbrcaPayyLxdadYE0X+Rw4StH
	Xj7fcQ3odBSu3As8IEgsWD02vgN5OKk10NPKUNNSRTi0JOvw6EWLHpgbz4T4jz2oyU/EL1A==
X-Gm-Gg: ASbGncvwzCuUaqH+M8CdpSSjaJQR2AVQYQqKhyai3w2UisegP8ZJo1/X9JRAPDFgdVR
	s3qHGXbGIf6XvK43ExaK+g3EZWGVwnKfEMZJ8a9ir0Xkvg3XKDhR2PgVutjpuzgN9bbEMw9Zp2Q
	xt4Z7Mko6hZUD7djXKa5AaTcVy5GJF83VQVKbTbdh8kiHff6MnXtglRGAVHfXn+5HnGWEMG2B2f
	ljQ/XEir5+pVwl2Yn3cgIaqbUEkFDCabPVqE6MM16ndbKHZpQ1CnhDGbDyp77jKJJUNWB2e2zv3
	VEA=
X-Received: by 2002:a05:620a:24ca:b0:7c5:dfe6:222a with SMTP id af79cd13be357-7c960793e41mr556093985a.42.1745611246993;
        Fri, 25 Apr 2025 13:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9AqScyuP//w2WTf2DZKa+eTenWSA/B8rLTtbznOGZp/n+4SX/uHlViZL3kDCGa1T/CH6wQ==
X-Received: by 2002:a05:620a:24ca:b0:7c5:dfe6:222a with SMTP id af79cd13be357-7c960793e41mr556088285a.42.1745611246549;
        Fri, 25 Apr 2025 13:00:46 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbe651sm258957185a.47.2025.04.25.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 13:00:45 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:00:42 -0400
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
Subject: Re: [PATCH v1 04/11] mm/memremap: convert to pfnmap_track() +
 pfnmap_untrack()
Message-ID: <aAvp6umyw1AF2DbN@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250425081715.1341199-5-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C7NIyBN38Vn-ftnKONEHC7Ukm7FRKGpwzdrnBcR0hgA_1745611247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 25, 2025 at 10:17:08AM +0200, David Hildenbrand wrote:
> Let's use the new, cleaner interface.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memremap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 2aebc1b192da9..c417c843e9b1f 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -130,7 +130,7 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>  	}
>  	mem_hotplug_done();
>  
> -	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
> +	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));
>  	pgmap_array_delete(range);
>  }
>  
> @@ -211,8 +211,8 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	if (nid < 0)
>  		nid = numa_mem_id();
>  
> -	error = track_pfn_remap(NULL, &params->pgprot, PHYS_PFN(range->start), 0,
> -			range_len(range));
> +	error = pfnmap_track(PHYS_PFN(range->start), range_len(range),
> +			     &params->pgprot);
>  	if (error)
>  		goto err_pfn_remap;
>  
> @@ -277,7 +277,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	if (!is_private)
>  		kasan_remove_zero_shadow(__va(range->start), range_len(range));
>  err_kasan:
> -	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
> +	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));

Not a huge deal, but maybe we could merge this and previous patch?  It
might be easier to reference the impl when reading the call site changes.

>  err_pfn_remap:
>  	pgmap_array_delete(range);
>  	return error;
> -- 
> 2.49.0
> 

-- 
Peter Xu

