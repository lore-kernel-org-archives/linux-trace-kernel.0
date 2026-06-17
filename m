Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE337DAA2;
	Wed, 17 Jun 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722653; cv=none; b=UQlt7CtPCWJlWbv8TFf4CN+sGS0GrUm/MWtJttYmZAR+iScbVoXfHziFN9By2hDJ/o6pSqwQF5rsIRw9EuXP6Pmu3hSNp/FaFlfhWiEcHW2Vjx7BwE9zva2BkwIerFkuqFx0xsIGiTSePBwAbEMpCMoMJv0ZapIQ7O+vqDkUH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722653; c=relaxed/simple;
	bh=RhM1si7AiBQSL9pqxtl9GolkybQbQ56Si1L1KVCopAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cW7Bs+gMkpKCzx1r2ZliFeJdPVmfl1swGVYCxKduzl4VnyYscxeoBo3dYqLdtuLG7Uf74zAYgMYe+YhpkrNnriVVEkSso/HNqP49geDHCKc0wSo94Ff2BNcKuiYaTdpqIrNC+F3fiu1G1BxNji3rnUcOug2yH+xeQ3Yvq23unJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss5/7B8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss5/7B8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A281F000E9;
	Wed, 17 Jun 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722652;
	bh=zZWtaENFb8wsffv7f3IzX9YbZfqNh2H7+UoPSzSXYuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ss5/7B8P4iVJPoxo3V8uqSXR32uktKCar1PAxSEIUAkKWjK8zbtQ2aArLbreU0Dd/
	 7ARsemNGFI9DMTx4NFvVe00i0qE7iAmuiAjGwFAfU5HJ6PdTHbtQw2OOLGuUs+6rgx
	 3EbBDikXjrhTlqc4ygMfDWESvYheqwElZvDOrvmIvINI37/nUboqOPddbJ8SCbzO6r
	 /2Z8H9gMlcozH2lAEvmRZJUwubNIOEKzpesBcu5K+64kLbqGZNzYKkVqvSJQYSGzpj
	 WE7rsyuS5eyLMDPAOIorSpQCck6JXOPZfxf0+kgMnp9w+AdSjyvjky6mwfDHk60mnt
	 pGTM/sFIr1riw==
Message-ID: <9890b8f5-69b9-49bc-8ed6-ea47723b644e@kernel.org>
Date: Wed, 17 Jun 2026 20:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] mm/compaction: respect
 compact_unevictable_allowed in alloc_contig path
Content-Language: en-US
To: Wandun Chen <chenwandun1@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-4-chenwandun1@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260604023812.3700316-4-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 04:38, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> vm.compact_unevictable_allowed=0 is used to prevent compacting
> unevictable pages. However, isolate_migratepages_range() passes
> ISOLATE_UNEVICTABLE regardless of this sysctl, so the setting
> has no effect in the alloc_contig path.
> 
> Fix it by:
>   - Keep ISOLATE_UNEVICTABLE for CMA allocation, discussed in [1].
>   - Honour sysctl_compact_unevictable_allowed for non-CMA allocation.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/all/25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz/ [1]

There was also the "Ideally by not having mlock'd pages in CMA areas at
all." part. Is it the case? It was more elaborated here:
https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/

> ---
>  include/linux/compaction.h | 6 ++++++
>  mm/compaction.c            | 9 +++++++--
>  mm/internal.h              | 1 +
>  mm/page_alloc.c            | 2 ++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index f29ef0653546..04e60f65b976 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  extern void __meminit kcompactd_run(int nid);
>  extern void __meminit kcompactd_stop(int nid);
>  extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
> +extern bool compaction_allow_unevictable(void);
>  
>  #else
>  static inline void reset_isolation_suitable(pg_data_t *pgdat)
> @@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
>  {
>  }
>  
> +static inline bool compaction_allow_unevictable(void)
> +{
> +	return true;
> +}
> +
>  #endif /* CONFIG_COMPACTION */
>  
>  struct node;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 007d5e00a8ae..a10acb273454 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1341,6 +1341,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>  							unsigned long end_pfn)
>  {
>  	unsigned long pfn, block_start_pfn, block_end_pfn;
> +	isolate_mode_t mode = cc->allow_unevictable ? ISOLATE_UNEVICTABLE : 0;
>  	int ret = 0;
>  
>  	/* Scan block by block. First and last block may be incomplete */
> @@ -1360,8 +1361,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>  					block_end_pfn, cc->zone))
>  			continue;
>  
> -		ret = isolate_migratepages_block(cc, pfn, block_end_pfn,
> -						 ISOLATE_UNEVICTABLE);
> +		ret = isolate_migratepages_block(cc, pfn, block_end_pfn, mode);
>  
>  		if (ret)
>  			break;
> @@ -1902,6 +1902,11 @@ typedef enum {
>   * compactable pages.
>   */
>  static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
> +
> +bool compaction_allow_unevictable(void)
> +{
> +	return sysctl_compact_unevictable_allowed;
> +}
>  /*
>   * Tunable for proactive compaction. It determines how
>   * aggressively the kernel should compact memory in the
> diff --git a/mm/internal.h b/mm/internal.h
> index 181e79f1d6a2..163f9d6b37f3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1052,6 +1052,7 @@ struct compact_control {
>  					 * ensure forward progress.
>  					 */
>  	bool alloc_contig;		/* alloc_contig_range allocation */
> +	bool allow_unevictable;		/* Allow isolation of unevictable folios */
>  };
>  
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 81a9d4d1e6c0..1cf9d4a3b14c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7118,6 +7118,8 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  		.ignore_skip_hint = true,
>  		.no_set_skip_hint = true,
>  		.alloc_contig = true,
> +		.allow_unevictable = !!(alloc_flags & ACR_FLAGS_CMA) ||
> +					     compaction_allow_unevictable(),
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  	enum pb_isolate_mode mode = (alloc_flags & ACR_FLAGS_CMA) ?

