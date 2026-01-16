Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828834677D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582809; cv=none; b=n+BWL2vvV9SKYQ0NMTtGtm6JprbYKG4Uyu/cFWltlWPTLkLloTllW8Hegtgt4YZc5GB7LZPZoxPI83YJv86/u3OsDE7CszoIWIax5Xps25UFvfybIEPFwEENRt+7ui0tVrPbBPwWpRLKAF6CHfDWj/9iIPhS9K0l5WNV76n4lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582809; c=relaxed/simple;
	bh=w12kVIum+5hT80KSmtydVQZ1iiEJ4xy9RJwvCyIwfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsQslq4KrTk/tUBhqgQs8K25x61BWkRK39GIZemFVAj19qYEpZvkXgE3ys6yGf0lT8q1vEbFmLzCb8qjIhDy1eVpcVNLXuVkI9TFzThfUnmzT4T4whGDa/VkE738JMLm8pBk27FWPCRWBRUuMSFtkDMwZsfBvfHIICKE5sRfp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=lSwLgUxD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="lSwLgUxD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6af798a83so22325885a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1768582805; x=1769187605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39r+L65CbocMKJ2hSULIQG9yHS2j8i36ygEvkdqqJZE=;
        b=lSwLgUxD0o35X/iBW9QsKvB7g/cK4P2opSpPbzJT0ownCctwZhZ2zxHHLpQhQ91UQb
         2nfNBP/lQYG4aPacOFEK+XHlHDfl3JArjCSowyAvDViqp7NtcWCqIuOhMh2TYdfqhqJB
         /vwYsGK6TT0/Dx4V+NXYoGE2klgO0AfLixL1I3jV3+T2httzEjA7QuKtNfkXH3eNlrx6
         6erzdsuMWgCvnGjisoFqYunp21r5wZ7sbOD4aoiPXmr0NadYotlF4I70n0SWuNyld1F6
         2Myb9yAPdJ4kdJ6h4fPDyIpV+zM84yzP7Oc2hf+OVFFfcI2AqJ313Ol7fK+8jq//NXw9
         NUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582805; x=1769187605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39r+L65CbocMKJ2hSULIQG9yHS2j8i36ygEvkdqqJZE=;
        b=mN+ihAfiEW0gsNak29x3W3Umu8y20ZaUvMo7UicmpbrJngkDUMJ3z6AztspwvLfpqV
         3ZOzJ8V7w8BitJALKiE6rxJrRNHh7EZ/36pdEPfUMNymPChKkry0VogM0JYnnNYihISl
         gRtPo8UXgQiT1b2UTTN7VP6kf915HWm1zGtrcpsGh2ftsZaxOjUgUYogJxAM11cvq9nn
         QelR0GTztmTs3Q2ayPzGA870SFYW/RPgEDWKilDFopKvRUHyl7wgehyDQRpZmsJQtNTQ
         1ZumoGxQY/rPhjqHlHjibqJ98PJBNNWwMmgQm24A9eNbK6YhDt8wOwX8Lh207NOL2FXk
         l1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWUQTbdlSk53AHgjThDmjvJqCDqdI+HLiYut2wCUzEXS/xl4mH6QYe9e8lI1/0jnWKLaZo85VPja7NWbq8uSC4GYlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3c2Dv1dn5O//infaHyiVoEZdoTxDdGTDTpNBKEzs3MMGyaBm
	movY4qzcgQjmDdx1E+dJFvcGvfA1fSaBuxzLr4eqT3RoE95RHkWUpq7XSn9GbK4jwJ4=
X-Gm-Gg: AY/fxX5+pAAjCzkBB3dXJhwUcK9uxXscCu7GPZnpvBt8SZqLPkatIluMYTV3WibMqPy
	DUzG9yD5btGwr2xby+Ilz6PPfHb+uyL1HY7Nr5lxvM89ROyshnak//vhLh4oS11lT+yjAKqGftr
	+650WQ+KbXuV+j6dztc61v82zADlc8LgBE42GPDwasvnTWvvUvWhRvCfn6CXMoMBEXG13A4Ostz
	pnEC3zd5TrJOB4WXhTpHsIe02uz9gkZbt0dQQqMfTYm1YwJ/GUpzakbb8JnJLlejFcvfw2XJM77
	rJM3Pkg464Q7xvfcPv3U0ukH8EUtZrpaUUEL2nFQrAtlzwFgrW3KA/W0xednRI5Vu2SiwVxv+IK
	NGw62tHiijhGnFkCTtqmqEP+35zCiQs2BibauTgXkwzOsnQkkg2uGIFsPvECb9DMq3aTyRht51w
	mGGt7COSC/WA==
X-Received: by 2002:a05:620a:710c:b0:8c5:2e1b:7913 with SMTP id af79cd13be357-8c6a66ef7fbmr529344385a.25.1768582804795;
        Fri, 16 Jan 2026 09:00:04 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71d5b93sm262341185a.23.2026.01.16.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:00:03 -0800 (PST)
Date: Fri, 16 Jan 2026 12:00:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, shakeel.butt@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/vmscan: mitigate spurious kswapd_failures
 reset from direct reclaim
Message-ID: <aWpukFnKRoeSrcEZ@cmpxchg.org>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
 <20260114074049.229935-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074049.229935-2-jiayuan.chen@linux.dev>

On Wed, Jan 14, 2026 at 03:40:35PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When kswapd fails to reclaim memory, kswapd_failures is incremented.
> Once it reaches MAX_RECLAIM_RETRIES, kswapd stops running to avoid
> futile reclaim attempts. However, any successful direct reclaim
> unconditionally resets kswapd_failures to 0, which can cause problems.
> 
> We observed an issue in production on a multi-NUMA system where a
> process allocated large amounts of anonymous pages on a single NUMA
> node, causing its watermark to drop below high and evicting most file
> pages:
> 
> $ numastat -m
> Per-node system memory usage (in MBs):
>                           Node 0          Node 1           Total
>                  --------------- --------------- ---------------
> MemTotal               128222.19       127983.91       256206.11
> MemFree                  1414.48         1432.80         2847.29
> MemUsed                126807.71       126551.11       252358.82
> SwapCached                  0.00            0.00            0.00
> Active                  29017.91        25554.57        54572.48
> Inactive                92749.06        95377.00       188126.06
> Active(anon)            28998.96        23356.47        52355.43
> Inactive(anon)          92685.27        87466.11       180151.39
> Active(file)               18.95         2198.10         2217.05
> Inactive(file)             63.79         7910.89         7974.68
> 
> With swap disabled, only file pages can be reclaimed. When kswapd is
> woken (e.g., via wake_all_kswapds()), it runs continuously but cannot
> raise free memory above the high watermark since reclaimable file pages
> are insufficient. Normally, kswapd would eventually stop after
> kswapd_failures reaches MAX_RECLAIM_RETRIES.
> 
> However, containers on this machine have memory.high set in their
> cgroup. Business processes continuously trigger the high limit, causing
> frequent direct reclaim that keeps resetting kswapd_failures to 0. This
> prevents kswapd from ever stopping.
> 
> The key insight is that direct reclaim triggered by cgroup memory.high
> performs aggressive scanning to throttle the allocating process. With
> sufficiently aggressive scanning, even hot pages will eventually be
> reclaimed, making direct reclaim "successful" at freeing some memory.
> However, this success does not mean the node has reached a balanced
> state - the freed memory may still be insufficient to bring free pages
> above the high watermark. Unconditionally resetting kswapd_failures in
> this case keeps kswapd alive indefinitely.
> 
> The result is that kswapd runs endlessly. Unlike direct reclaim which
> only reclaims from the allocating cgroup, kswapd scans the entire node's
> memory. This causes hot file pages from all workloads on the node to be
> evicted, not just those from the cgroup triggering memory.high. These
> pages constantly refault, generating sustained heavy IO READ pressure
> across the entire system.
> 
> Fix this by only resetting kswapd_failures when the node is actually
> balanced. This allows both kswapd and direct reclaim to clear
> kswapd_failures upon successful reclaim, but only when the reclaim
> actually resolves the memory pressure (i.e., the node becomes balanced).
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Great analysis, and I agree with both the fix and adding tracepoints.

Two minor nits:

> @@ -2650,6 +2650,25 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
>  			  lruvec_memcg(lruvec));
>  }
>  
> +static void pgdat_reset_kswapd_failures(pg_data_t *pgdat)
> +{
> +	atomic_set(&pgdat->kswapd_failures, 0);
> +/*
> + * Reset kswapd_failures only when the node is balanced. Without this
> + * check, successful direct reclaim (e.g., from cgroup memory.high
> + * throttling) can keep resetting kswapd_failures even when the node
> + * cannot be balanced, causing kswapd to run endlessly.
> + */
> +static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx);
> +static inline void pgdat_try_reset_kswapd_failures(struct pglist_data *pgdat,

Please remove the inline, the compiler will figure it out.

> +						   struct scan_control *sc)
> +{
> +	if (pgdat_balanced(pgdat, sc->order, sc->reclaim_idx))
> +		pgdat_reset_kswapd_failures(pgdat);
> +}

As this is kswapd API, please move these down to after wakeup_kswapd().

I think we can streamline the names a bit. We already use "hopeless"
for that state in the comments; can you please rename the functions
kswapd_clear_hopeless() and kswapd_try_clear_hopeless()?

We should then also replace the open-coded kswapd_failure checks with
kswapd_test_hopeless(). But I can send a follow-up patch if you don't
want to, just let me know.
