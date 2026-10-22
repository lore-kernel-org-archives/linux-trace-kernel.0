Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636891;
	b=EJkQM9QmFICxfv7jeGxYdb4HWWnsJ4yLTUJT70ZTm+WI4FyWkLHMiGyKD59JSelBl8cC
	 cibtAkGIRcDdVizIx0U1JffYNivAWpuYVHzw6JD9b3q5T0sB1NHWWiu5jdEsDqKPId/i7
	 xtQpWRDG/k575nhPvD85cklP2T2vabJ840OCA2yFxjFBvt2vi40wezMxhcPYap3qKiX6j
	 E26Io5SvOr9h0JA89ozNRIqHo3PzAYDV8GC9zyZakquJNS+OdUX+IswH9Nd4O9/uIc2IU
	 YmP8co49crTnRXKe8T4knRrnYgI5Fl3raMf8ir+Yk0t/BLatN8S/r9pCJTfxNr+1L0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hwz8KwnzYesAWw+pJbG6JjCf7JDB6j+uq8/Noh3mphw=;
	b=mrkB4VHNS3JpKiaQPG2kLCOE2nc60TFpt4GOj3Alx7nh8RZd+2aBtwqTuG+AhXwdqxlX
	 PAoqC6tONprooLxtdkc1Gy34hu4zew/eww2y6iDQ4pxFOqpTaLaBb1nuniwd5UgGbb3ap
	 +fwVu+3g8JWBFi4tZwsQc+PZ3c1IQ22glexJv4Q9mxWgPdHsXb0X8RcGHdbgQPTNEyjjP
	 VkvXY8YTFn0EIJWAdfp9THSLSEbtaVkV/YHUZJpsJOmZoiDKM50O5lzRRFkZmHnSNg6Ke
	 vHDQvmqZ2CBkFh8web3Kb+IzQSEBj+AleRkaDeBtpgtnSi8gz5qI8xGFi2ji9d53EYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBVWmPbo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE9606A31A;
	Thu, 22 Oct 2026 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBVWmPbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECDB1F000C1;
	Thu, 22 Oct 2026 02:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792636890;
	bh=hwz8KwnzYesAWw+pJbG6JjCf7JDB6j+uq8/Noh3mphw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBVWmPboF2Fa4QC//+1hcRTzeNrYA5258Nkn+gxRl3xbPw4Cg7beSeEDjLiiZk3+B
	 9eDa5NSjOTNYh54X8eCIo49ulHqDZuYbt7tyEpeYEBxczCUIqQ3j2ir/3D+2yBdB0I
	 Uy+QWYiBvqdoWPoTKVMX0arncdTvR01vnq0Kn0Efn+yY/zmKE6S/OshAjiG9pKCB8j
	 R6j0ItS51xJPQjpjUNTc1R2iPep9qSb+3QhACU5Z2FI6qca5Ccs/LE3AmKS4CPqkGD
	 o9qszAKymSzz5YY2E53u8psyrOyX27SD+Zcd6oChCCbuXTGj5BhuTD/5vvWF50DlvW
	 U0sr0RWGW00UQ==
Message-ID: <sashiko-outbox-180880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] mm/page_alloc: retry allocations that raced with
 a zonelist rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, kernel-team@meta.com, akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, mgorman@techsingularity.net, anshuman.khandual@arm.com, Bessel.Wang@huawei.com, jiang.liu@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261021023940.1940971-6-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
 <20261021023940.1940971-6-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:41:28 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm/page_alloc: __alloc_pages_slowpath() restart loses reserve re=
try
- [Medium] mm/page_alloc: post-rmqueue() zonelist retry leaves ZONE_MOVABLE=
 blocks unmovable
--

commit 3b023f87050323ef9781701d5864437d2b2b4b5e
Author: Gregory Price (Meta) <gourry@gourry.net>

mm/page_alloc: retry allocations that raced with a zonelist rebuild

This commit checks zonelist_update_seq after page allocation succeeds in the
fast path, slowpath, and bulk allocator, freeing the allocated page and
retrying if a concurrent zonelist rebuild occurred during the zonelist walk.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1bb308296fcdc..dd8c9046f9a06 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
[ ... ]
> @@ -5114,6 +5127,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned in=
t order,
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:
> +	/* A rebuild during the walk may have handed out an ineligible zone. */
> +	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
> +		__free_frozen_pages(page, order, FPI_NONE);
> +		page =3D NULL;
> +		goto restart;
> +	}
>  	return page;
>  }

[Severity: Medium]
In __alloc_pages_slowpath() in mm/page_alloc.c, can_retry_reserves is
initialized to true only once before the restart: label:

	bool compact_first =3D false;
	bool can_retry_reserves =3D true;
	unsigned long alloc_start_time =3D jiffies;

When a reserve-eligible allocation (such as PF_MEMALLOC, __GFP_MEMALLOC, or
an OOM victim) fails its initial get_page_from_freelist() attempt at retry:,
it sets reserve_flags in alloc_flags, clears ac->nodemask, sets
can_retry_reserves =3D false, and jumps to retry:

	reserve_flags =3D __gfp_pfmemalloc_flags(gfp_mask);
	if (reserve_flags)
		alloc_flags =3D alloc_flags_cma(gfp_mask) | reserve_flags |
				ac->alloc_flags | (alloc_flags & ALLOC_KSWAPD);

	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
		ac->nodemask =3D NULL;
		ac->preferred_zoneref =3D first_zones_zonelist(ac->zonelist,
					ac->highest_zoneidx, ac->nodemask);

		if (can_retry_reserves) {
			can_retry_reserves =3D false;
			goto retry;
		}
	}

If that reserve pass allocates a page and reaches got_pg: while
check_retry_zonelist(zonelist_iter_cookie) is true, the new check frees the
page and jumps to restart:.

At restart:, alloc_flags is reinitialized without reserve_flags:

	alloc_flags =3D ac->alloc_flags | alloc_flags_slowpath(gfp_mask, order);

Because can_retry_reserves is still false (and ac->nodemask remains NULL), =
if
the first get_page_from_freelist() after restart: fails without
reserve_flags, the can_retry_reserves retry is skipped. Callers with
!can_direct_reclaim (for example GFP_NOWAIT | __GFP_MEMALLOC or
GFP_ATOMIC | __GFP_MEMALLOC) or current->flags & PF_MEMALLOC then jump
directly to nopage: and fail without ever retrying get_page_from_freelist()
with reserve_flags on the rebuilt zonelist.

Could jumping to restart: from got_pg: without resetting can_retry_reserves
(and restoring ac->nodemask) cause reserve-eligible allocations to lose the=
ir
reserve retry and fail spuriously?

[ ... ]
> @@ -5472,6 +5499,11 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp=
, unsigned int order,
> =20
>  	/* First allocation attempt (or, for nolock, only attempt) */
>  	page =3D get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags,=
 &ac);
> +	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie)=
)) {
> +		__free_frozen_pages(page, order,
> +				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
> +		page =3D NULL;
> +	}
>  	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
>  		goto out;
> =20

[Severity: Medium]
When a non-movable request (such as GFP_KERNEL with MIGRATE_UNMOVABLE or
MIGRATE_RECLAIMABLE) races with online_pages() -> build_all_zonelists() and
get_page_from_freelist() selects ZONE_MOVABLE, rmqueue() runs on ZONE_MOVAB=
LE
before check_retry_zonelist() is checked in __alloc_frozen_pages_noprof() or
at got_pg: in __alloc_pages_slowpath().

Because ZONE_MOVABLE has no free pages in MIGRATE_UNMOVABLE,
rmqueue() -> rmqueue_pcplist() -> __rmqueue_pcplist() -> rmqueue_bulk() ->
__rmqueue() -> __rmqueue_claim() -> try_to_claim_block() claims a
MIGRATE_MOVABLE block in ZONE_MOVABLE, converts its pageblock migratetype to
start_type, and expands the remaining pages into ZONE_MOVABLE's non-movable
freelists and PCP list:

	/* Take ownership for orders >=3D pageblock_order */
	if (current_order >=3D pageblock_order) {
		unsigned int nr_added;

		del_page_from_free_list(page, zone, current_order, block_type);
		change_pageblock_range(page, current_order, start_type);
		nr_added =3D expand(zone, page, order, current_order, start_type);
		account_freepages(zone, nr_added, start_type);
		return page;
	}

When check_retry_zonelist() then detects the race and calls
__free_frozen_pages(), __free_frozen_pages() reads the mutated pageblock
migratetype:

	zone =3D page_zone(page);
	migratetype =3D get_pfnblock_migratetype(page, pfn);

and frees only that single page back to ZONE_MOVABLE's MIGRATE_UNMOVABLE PCP
list or buddy freelist.

Can checking check_retry_zonelist() only after rmqueue() has already mutated
the zone leave converted MIGRATE_UNMOVABLE, MIGRATE_RECLAIMABLE, or
MIGRATE_HIGHATOMIC pageblocks and populated non-movable PCP/free lists insi=
de
ZONE_MOVABLE, where normal movable allocations will not consume the PCP list
and compaction will skip the non-movable pageblocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023940.1940=
971-1-gourry@gourry.net?part=3D5
