Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD33A1B5
	for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Apr 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777241202; cv=none; b=QxC4Ha7Gn00aZHl5rfaXNEXs4SbP/h8PLh5RG7/vK4bC2pXAVHYPEaOekfXW80fGcnVGr00viyzwBkJbEzILa2unzuaGCw2+lpKA24LvzsOnIeKmhxIBrsyLx5A3T3PJFzEv8jDf99++uqi8P5KdxVImIAmEtseBTIq77NZ89Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777241202; c=relaxed/simple;
	bh=52tKa67iGb1IORoxe4ZYHwagg5DfBxmhace2N1GfDeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF9XpU3guCuDc+1T0n8yIwRUNwooHdrj4t3UFNk2ofRTpkERAkJll2DdlvkEOQo+qr2xuVoP6D8NaSboUldBTfm1LWesZQnftoeF/vRh/uSzjcy/J3szi7goy2iHl8MvGPWazJCTPz5A7AC2Quh0bbdHuBNs98y8d9bfjAlBe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHDlFAq1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHDlFAq1"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so13516412eec.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Apr 2026 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777241199; x=1777845999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF/9PrWdSCugZscSXWokV8Z5ndKFNcsdESXX37E9bAw=;
        b=FHDlFAq1qL5zBdkYI1Ca7gJ5PykHB+2uS8hhoStoq2PIkCFKWqX1FDlYeHpouDNwcj
         i5zS/RbQPzlnuR8m/+hSTCyNwGtetBcem5b8bjVQ9JXPXGCgCgbtMHEPrvA6Vbx0aZFi
         F6xSbh+9HihASC/umoIrFG7IxBPk/QN0SCpDnPnW54/I0VGrRXg071/f6K+4nne0M/yK
         fey3sQ3GSgSiFHukRvQDfpGAU1vMHbnGFW5ivI6Y7IdXWLbG6H1qb9SbwDecm324H7Ro
         szMJWsSEs8PYMcE+ZpbCCvKR1C1v61yOq9lRiKNYEDVz5wE1SQC8Q9+x7XaxIF1s2Y1P
         LPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777241199; x=1777845999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF/9PrWdSCugZscSXWokV8Z5ndKFNcsdESXX37E9bAw=;
        b=NBQSGqKrHjAbreNNGkY51Mg2BYZO7OEHrg4fsmmJVHsBJKgr30QalUVEdO+W/jnsC3
         dNnngAQKYtcRtPtHAhR4eWFjqV1Tfsq1TMI05HZiFhg4H39ZxH7w4y2EBbbsVSYLxnN/
         jv4r4debw1N+hE45Q7SciKmAOn4zrfjbwAOcDlSONa4trjB1OJm4ea7D/PDWqhMd8wfF
         hQ5DxrWFpdPktTfKwWdlhqXMR0BEQK9OipkbBocfhUf9I/Zny9X+6ywY6swjJGeBZq/u
         lmjHN1FPpqQ8PPRaaLk8Iq69ZIDVH68x8HbR3bPXR1fbL8hKbjvLoObfIbJ6vyhtt9zT
         sA7Q==
X-Forwarded-Encrypted: i=1; AFNElJ92h9dS2W955D7AEq1HJxSpquFrJkYxwG8mMMS5537vVOBah9tqsX/bWnw52scX8xcwJqLhdYcs66VSa2W6qgCGaPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD03bG+Qsk88vzfQ4fGzCU1/YpiGTn1N4vlnWnccO47AtxELOP
	aK3Wy89nX0GEMSkhdPEzHiZ9ACD5zKeVDxLklUSdr5kUErspTDIS1hVo
X-Gm-Gg: AeBDievv2UeZGrIXOAjZ2JWtoCNkuJy8J53QVfw1XfXSaaBk0wMypASxJIkhEGaBGi5
	O8+akgBkz/oyf2zLO0rut9j8JqXR44smdMaplV04si7xm3610GVAaG+M9LJ5za6+i1eKH9aHb+9
	7yrIAZcQzQkrDThxb5QqZXFU4wTYarVR+yw5mKD3iJk28BPxZ3X5+YvQxnACdDXfnouTasEEjOx
	VIAdnZeZE6gclBMEg9V3cPszHtkXBCuodeHXsHjJr8b+Z8kX8h4mCqclBdlAsI2s5SVVNR1KO3e
	Y7pxkv09KTYi88kER4Zk005TBfTy/NWv82XCykxGuBTHNfOkSgVvD2sY3veJM3mM2thsIVLmOyo
	hxpAX45Jtj5vh14kxHKT/coXuKE6vtsB+Ij/aIXEGg6rR9eCCqr8Pwo2m0GpxO7Mpf070lFD7Hh
	rP8nn8AGGBNsTxX8ma9fAQFhahsptoepzzShbM9TjocKJrKwI=
X-Received: by 2002:a05:7300:8c9f:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-2e465487fa5mr21912607eec.9.1777241198958;
        Sun, 26 Apr 2026 15:06:38 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90::47b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm42170346eec.13.2026.04.26.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 15:06:38 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:06:35 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
Cc: akpm@linux-foundation.org, vbabka@kernel.org, linux-mm@kvack.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [PATCH] mm/page_alloc: add tracepoint for PCP refills
Message-ID: <ae6Ma68umBlqVdSP@fedora>
References: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn>

On Sat, Apr 25, 2026 at 05:13:35PM +0800, Bunyod Suvonov wrote:
> The page allocator already has mm_page_pcpu_drain to trace pages
> drained from the per-cpu page lists back to the buddy allocator. There
> is no matching tracepoint for the opposite direction, where
> rmqueue_bulk() refills a PCP list from the buddy allocator.

This sounds like a reasonable idea. Does this tracepoint show us
something that a workload might care about? Not opposed, just curious.

For future versions, would you mind including documentation about it
in Documentation/trace/events-kmem.rst?

> mm_page_alloc_zone_locked is not a good substitute for this. It is
> emitted from __rmqueue_smallest(), which is used both by rmqueue_bulk()
> and by the direct buddy allocation path. Its percpu_refill field is
> derived from the allocation order and migratetype, so it does not
> reliably identify whether the allocation came from a PCP refill.
> 
> Add mm_page_pcpu_refill and emit it from rmqueue_bulk() for each page
> added to the PCP list. The new tracepoint uses the same page, order and
> migratetype fields as mm_page_pcpu_drain, making refill and drain
> activity directly comparable.
> 
> Signed-off-by: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
> ---
>  include/trace/events/kmem.h | 23 +++++++++++++++++++++++
>  mm/page_alloc.c             |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index cd7920c81f85..16985604fc51 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -243,6 +243,29 @@ DEFINE_EVENT(mm_page, mm_page_alloc_zone_locked,
>  	TP_ARGS(page, order, migratetype, percpu_refill)
>  );
>  
> +TRACE_EVENT(mm_page_pcpu_refill,
> +
> +	TP_PROTO(struct page *page, unsigned int order, int migratetype),
> +
> +	TP_ARGS(page, order, migratetype),
> +
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	pfn		)
> +		__field(	unsigned int,	order		)
> +		__field(	int,		migratetype	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
> +		__entry->order		= order;
> +		__entry->migratetype	= migratetype;
> +	),
> +
> +	TP_printk("page=%p pfn=0x%lx order=%d migratetype=%d",
> +		pfn_to_page(__entry->pfn), __entry->pfn,
> +		__entry->order, __entry->migratetype)
> +);
> +
>  TRACE_EVENT(mm_page_pcpu_drain,
>  
>  	TP_PROTO(struct page *page, unsigned int order, int migratetype),
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 65e205111553..a60b73ed39a4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2544,6 +2544,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * pages are ordered properly.
>  		 */
>  		list_add_tail(&page->pcp_list, list);
> +		trace_mm_page_pcpu_refill(page, order, migratetype);

If you're trying to trace all pages as they come onto the pcp lists,
should you also account for the free_frozen_page_commit() path?

>  	}
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
> -- 
> 2.53.0
> 
