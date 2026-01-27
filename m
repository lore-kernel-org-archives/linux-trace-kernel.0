Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47582EE268
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557465; cv=none; b=usPsvBBfZgGodJWSaciyIxJ7UOqhYfjV5TbK80Drd77SDcr1C8kWiD0ASE5/KgKf4QhR7uWzn9520a8t3H2NdGJZvaeGeoCqZA1Ry5r4LlGGDeIDs2xiWq2yy8/UOYeRCP2r4A8u8PHwjGfUKYzQiuIYhuXbK7SedMRvjPdv4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557465; c=relaxed/simple;
	bh=d6y/6MFN08Jz8qe7wVacv3NaQ/zsUwOWxhos+Uo+Qu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqvRAqs0OGOqvhZlPy4bD4Si8rwHTQb3sK9qr0p9k0yzCgxL4sTctmXRCm1Qjr8QYjG5v81nPpOf87TK67/7yzacvvI415pCRrT/3ig7ygKk0BCQ5EuNVwifb/d9sl5G1Dxj3VhzVO59KZii1e5iVUkoJCAI1dLGZVmF6oI09U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rw9aTQfc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rw9aTQfc"
Date: Tue, 27 Jan 2026 15:43:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769557459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rWKhogrgDYfP+mABM+WRRO2AR1U7gX8ZMeWgwNxCK2g=;
	b=rw9aTQfc5op4FjU7TIB4ogB5HvPbv6+K9tFpTKVOMNNTq+wuLOzHxn/AwqXIUdIJfwh0EP
	vf9lOCmrG/fbwLR+XksFm2jGheXRIHpI2rhdPmI7jwKFktW71NT14UIRhDa/RST2DoJk9x
	Z5rtR9lqFbL5d0piShKOUCbpRXzVoSk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v5 2/3] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <aXlM7KqRIkerP8Pa@linux.dev>
References: <20260115123809.2257-1-tballasi@linux.microsoft.com>
 <20260122182510.2126-1-tballasi@linux.microsoft.com>
 <20260122182510.2126-3-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122182510.2126-3-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 22, 2026 at 10:25:09AM -0800, Thomas Ballasi wrote:
> Memory reclaim events are currently difficult to attribute to
> specific cgroups, making debugging memory pressure issues
> challenging.  This patch adds memory cgroup ID (memcg_id) to key
> vmscan tracepoints to enable better correlation and analysis.
> 
> For operations not associated with a specific cgroup, the field
> is defaulted to 0.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
> ---
>  include/trace/events/vmscan.h | 83 ++++++++++++++++++++---------------
>  mm/shrinker.c                 |  6 ++-
>  mm/vmscan.c                   | 17 +++----
>  3 files changed, 61 insertions(+), 45 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 490958fa10dee..20160e79eb0d7 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -114,85 +114,92 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
>  
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  
> -	TP_PROTO(int order, gfp_t gfp_flags),
> +	TP_PROTO(gfp_t gfp_flags, int order, u64 memcg_id),
>  
> -	TP_ARGS(order, gfp_flags),
> +	TP_ARGS(gfp_flags, order, memcg_id),
>  
>  	TP_STRUCT__entry(
> -		__field(	int,	order		)
>  		__field(	unsigned long,	gfp_flags	)
> +		__field(	u64,	memcg_id	)
> +		__field(	int,	order		)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->order		= order;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> +		__entry->order		= order;
> +		__entry->memcg_id	= memcg_id;

Please pass memcg pointer to tracepoints and call mem_cgroup_id(memcg)
here.

