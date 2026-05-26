Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E68346E7E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809161; cv=none; b=dd+unHDegNsqRisxwps0/yXfl3E4EbnZwIZ7dYy+/THVDtvbMRPnUvCS7y4RI90YNZTt6seAOszcyZJro07ARiOxIXcHGSwsWNR7W/qc2YuYtiQma6v+M9xvEFuoETLovDX+YWg9HNOhhEhvE4vJ43o1Rtxp12TDuiTosqMuBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809161; c=relaxed/simple;
	bh=I0HaQDHIGp7peeqzmNtqtZVp+thYSCegR9dtL5eChOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3E7lVQS9rH9uQUFTpjRf51ZurF0hnWm+DfOhOHy3sdIm67mFQveojxl8otqJvrkHbAOwPhKkda1KT07Y9Z1mxuKbH2yY7tL+oJnaIghGYSiJCNL+GCNkXWyEzd6ZTPRTy7kw1hT4kt7YfOZ/tF5zUhPQWJ83qzXtnPm9K3mIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qXBek+WP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qXBek+WP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb856a674so131128016d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779809159; x=1780413959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVjcG15pNpaOurZH1fYL0bMY7EmAo4rTVh29axQ41G8=;
        b=qXBek+WP0vdrOjvSWgirkal+Fqek8zE6nvPDGRAAFjEXPrqkW8C7dUrR2E3p1Fw9zK
         JUHRqRKdsf61jvWvyP28w1RMvAv2HXt+ZOazqvfTRdfUi0WSbpzUv+GzSYCAhWLu6Tlz
         IqNUjOzv69Tl+FbycrZzxCCJ3/5OSWz5DzjxiauYodOQCPGMcY86B+h21+2sDPDIsw6Z
         LqWE7RExnIa0lU15/Gw/NtXB8aqdPrS/OzErECJK7Vt+qqA5LheRu52ncRLp9ud6eAyT
         ybjxHPy4WUVJeeMWDaDf7n3foyIUyjSNw6F39fEtya+bX7iJ5NdszkciDPSBIz5WJsXo
         tyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809159; x=1780413959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVjcG15pNpaOurZH1fYL0bMY7EmAo4rTVh29axQ41G8=;
        b=YQG0580oGAJxwOez6SVqQ6YJodHSBgh/x7Db+rqFQKH9wMuqC9iLhEgsxjQIZRRRuj
         twBnhCvcA0RJhun7xvQr3rYROhCmdqtQhUWFJW/xb4wpPiLF/j4nXiIc47mROzXjfHAO
         ocJax+n/E8NQBjzIFPLhxd4kk1cg8vJ5IEJMzwqe0HoB49zPP7ToL0Uo2TXjX5IB3YZ5
         rlCCu/DJ1Gxqgt3RB+v9zY27Jro4QnlGczZeUxOoogVRuWQUFbCicn47lIpokVU78keC
         eEZhlZKlVZ2FvZSbEAGMvfuanPDsnTDPS0Qh7a7RBfJBbb7Ej6rLmJxsF7wJGatzF2KL
         72Zg==
X-Forwarded-Encrypted: i=1; AFNElJ8d4H6MQm6ZfakAnUdlDrSU5XfOCSf/tWLSGkHddD1wHH90izwkJ2eePRN/Ne2x/j1NYyt0oCwkW1T9WzxjldQrsUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ua1ywqqeIkg22f6sU2PDvjdty5OnlgONpxME70NLVUcoXFxp
	9qaBLSlaXLv6Lluuj1Of5+sCT5tOPs66uN3m3RZugWe6Hb2QX+t5apdLGaZrelHsRVs=
X-Gm-Gg: Acq92OF5xmIDfkjV/iPeAI7Vg4DmgCleWt8GtnpNEQprUJUhvRc1HQPBmnyGR8tugdr
	W7/XsKqr+2NS4jrR05FllGoTrKbLrTSbPkFfoVpoyq542BkIYhNEWFiHV08X6SuMP4YhPkEuh7o
	U8pUzo3bWj6XG+NappANDHxQjjq88wir1Uakw7R/F+dcxupf+T+cjku4HNU5lXp65JxF+DDJ62B
	jZyI6DE6TP8gxlQBoQ68yc66ZwunEyl3Je7XymFgl3VuvXuYujElD9OLh6CxX2kIRWNLumCnq5+
	JLTE+Qa/gD6X3RLlDRecGR/wG9iDiW+iTX8cYU6O34YGwGOA4zyj8AgxdgGXp18t6436kjAW+tF
	HW/p02RtcZ5CHoLWagUGYwad90Efq/n6iU4cTZQvEIGvRPl9hDUFuRofBVSbX+XcayK0Z5dtIyq
	KUaBAlk9tl4IBVGxPF3k4eaOegPKhI5f6zSPky2OBlSrAupuJ3Xl5zTEkPpT2s2ps/YmGh5dpZg
	MvdARch0mM0
X-Received: by 2002:ad4:5ba2:0:b0:8cc:3546:2625 with SMTP id 6a1803df08f44-8cc7be71b20mr263886306d6.9.1779809158646;
        Tue, 26 May 2026 08:25:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80decd31sm141907226d6.13.2026.05.26.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:25:57 -0700 (PDT)
Date: Tue, 26 May 2026 11:25:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Rientjes <rientjes@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>,
	Frank van der Linden <fvdl@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Raghavendra K T <rkodsara@amd.com>,
	"Rao, Bharata Bhasker" <bharata@amd.com>,
	SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>,
	Xuezheng Chu <xuezhengchu@huawei.com>,
	Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alirad Malek <alirad.malek@zptcorp.com>
Subject: Re: [PATCH RFC 3/3] mm: use non-temporal stores for demotion
Message-ID: <ahW7gwgaF0zIPTAz@gourry-fedora-PF4VCD3F>
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
 <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>

On Tue, May 26, 2026 at 01:37:04PM +0200, Yiannis Nikolakopoulos wrote:
> From: Alirad Malek <alirad.malek@zptcorp.com>
> 
> Memory demoted to a lower tier is assumed to be cold and most likely out of
> the CPU's last level cache. Additionally, in certain demotion targets (e.g.
> CXL devices with compressed memory) the bandwidth can be negatively
> impacted by the eviction patterns of the last level cache when standard
> memcpy is used. When the feature is enabled, use the
> MIGRATE_ASYNC_NON_TEMPORAL_STORES flag in demotions to trigger the folio
> copy path using non-temporal stores.
> 
> Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
> Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> ---
>  mm/Kconfig   | 8 ++++++++
>  mm/migrate.c | 9 ++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687..4b7a75b57f6e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -645,6 +645,14 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +config DEMOTION_WITH_NON_TEMPORAL_STORES
> +	bool "Use non-temporal stores for demotion"
> +	default n
> +	depends on MIGRATION
> +	help
> +	  Enable non-temporal stores when migrating pages due to demotion.
> +	  If disabled, demotion uses regular migration copy paths.
> +

Do we actually need this config flag or should we just default to this
(if the arch supports NT stores)?

>  config DEVICE_MIGRATION
>  	def_bool MIGRATION && ZONE_DEVICE
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ff6cf50e7b0b..368d40dc8772 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -862,7 +862,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -	rc = folio_mc_copy(dst, src);
> +	if (mode == MIGRATE_ASYNC_NON_TEMPORAL_STORES)
> +		rc = folio_mc_copy_nt(dst, src);
> +	else
> +		rc = folio_mc_copy(dst, src);
>  	if (unlikely(rc))
>  		return rc;
>  
> @@ -2081,6 +2084,10 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>  	LIST_HEAD(split_folios);
>  	struct migrate_pages_stats stats;
>  
> +	if (IS_ENABLED(CONFIG_DEMOTION_WITH_NON_TEMPORAL_STORES) &&
> +		reason == MR_DEMOTION && mode == MIGRATE_ASYNC)
> +		mode = MIGRATE_ASYNC_NON_TEMPORAL_STORES;
> +
>  	trace_mm_migrate_pages_start(mode, reason);
>  
>  	memset(&stats, 0, sizeof(stats));
> 
> -- 
> 2.43.0
> 
