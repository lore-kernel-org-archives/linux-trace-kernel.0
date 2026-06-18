Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC933F1AD7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783274; cv=none; b=cU5znF91/bUFbmRMbMQgP1/SAzAINGCx62IbuIEYUYlGeC4kxpsiQTjbrZXqEEYDzFjvQ6NyeGsjcKZyJfs2HPXmwGRMR0ste3M9Iblkqtc1BqHZkzeoXuS2f8T8YqyAk99ENkBdGxhqg8vCwxe1Ix+p7QjLPmha1LD2J4X0aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783274; c=relaxed/simple;
	bh=DawbSgcdQQQz1EZyan4wjlE7kUMw/zCrfNcnbNjat5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6Kk91Sk/6eyS8pe6B/AEtREU36MmgKtHQP1ecH6tbTtHOR1vOQews3A2A7sBgyIWbxZE+24EIZOytwTbytQNiFoBXKx0nVunSeDr6VTAmMhMsydwaC6N7Ncnzd3Fy59Kissdl7cq96QFQfgjuuVkc0Q5ngIl57EXfWWlu1nU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI5nx+6W; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI5nx+6W"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so440169a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781783272; x=1782388072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgJSxfkbpRL1li2RmiPzgr2AwPNLZXo7UF6R1jDsgxA=;
        b=aI5nx+6WE+egF02khgwQA/AuS55fjsdcEGbdlL01mOZ6AcH5FT9Ycp0ucPHvb4VTYR
         Eh00qCP9xztQxe5JOSLZjtzgL8Jl48BVHK6MRpyhZMe9lp6Ldr29CICx0tnpgPAj++Vk
         BpFlFkLQExRtML0hk1WOqFfKUSGLAMYuX75rPNCWwfhWDwnM+INJ1o5M2fwBsjZ0qPFt
         nUcXR/F3ZJdV5b9wjI1u4akVsIdtftEd/AqeIxM4Wy/tLlEpGMcql6oAuuBM/WuF7raD
         YSwruePTl/w1Ka5WR+WgqmoMWJ0pLKoQo79FlF/LVKxC9FzNy00zXX13/8BovPW8wHBK
         9fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783272; x=1782388072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgJSxfkbpRL1li2RmiPzgr2AwPNLZXo7UF6R1jDsgxA=;
        b=hNJOWChys/d58MZjOvG9Y/Nr2rhecRYKsvTBIGSMdDImRVgeCHoxw43l68L8QMvaC0
         9ye5vwykwIGAxJHHlfWoY1ubnEyybRGooQ+/3xV13wBP9HHn5i/Ef4ansBNrQuSjIqb5
         3dIX/9c6gXRmRNse49GIDnt8zQUuXk4mrmOG3WR7SgenriJVQYTZFaF4fvubSg0GDggU
         IaunsqeG2ZMvnE0iu82feuSoU94cXC/cJtXEt3O/oxcPrXriNZ4yNV0xdBH2qyZ07o0T
         VU3ALUQ667GzvxlGGqPMNrCqjwSAZzzLqWL1IX1Df50IFiqEGhz8bDm9JG7pszfw4tV2
         iWpw==
X-Forwarded-Encrypted: i=1; AFNElJ+mtAR6rY2FNKGTu75gYj2kDdFzvb8OgBBqlHKwmS29JdJoJHNUNOebHeeY64KVbLSml5aWNi6Av9/ou4s+9XKuA78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoX/qkV6fDy21RXpBxaM8QFsFtXAW7ACKEuU5UtGKZLmmgn++
	ausVcTGk1i2rKbQ0wWkr9GzfgvYtzCJIztIQAEMdk9a6y6dR6Vj9Dkhp
X-Gm-Gg: AfdE7cmN+lgcdt6+5hFst5yfAzXhGECxv4rUZIY0iQwGRTiOGNCpqHTpFM2YBAezPRq
	o72nkUkyg9ZevAYSR5mXwtbcO+LdO24wOn5k5R3+3i7Lo1vPCEuXGwTXBdi9RYoU8LygrLgQd1l
	/qkvxAkkccGm9VWJQdiNlfuWSAkVE6c2XN5dDVTJxg/lyRSh8GHyNSQWM7LB8K1p/im5jjxvnET
	jIPZgSGauPgUo5MD8UdY+ARBDskwjmHF5qSzYjwmuKaRp+aOUUMKyDnxgbrMdqHOFD0E1OHgQLK
	fEw3A/71kr3frsyzM/AdFWW2XRlVN/Wxr1/CVvNaWajJUcsRRrW/B3S4K9XkoTGaEIok+CKTkQ6
	0bUDrViM1Ph9kpSQ8XPWVWBD00NDfGWhKoT7sWICOEUFHkmD9hNUQo4JM4EwPzm1kk6mf7E5nKq
	P4oqZAtIV59a3k14OvRq0cO+Tzcv2IECA=
X-Received: by 2002:a17:90b:4c84:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-37ce44caf41mr3737106a91.8.1781783272420;
        Thu, 18 Jun 2026 04:47:52 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm9530544a91.6.2026.06.18.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:47:51 -0700 (PDT)
Message-ID: <b5605aef-c3a3-4a35-aceb-d1df3c9a7f4a@gmail.com>
Date: Thu, 18 Jun 2026 19:47:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] mm/compaction: respect
 compact_unevictable_allowed in alloc_contig path
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-4-chenwandun1@gmail.com>
 <9890b8f5-69b9-49bc-8ed6-ea47723b644e@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <9890b8f5-69b9-49bc-8ed6-ea47723b644e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 02:57, Vlastimil Babka (SUSE) wrote:
> On 6/4/26 04:38, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> vm.compact_unevictable_allowed=0 is used to prevent compacting
>> unevictable pages. However, isolate_migratepages_range() passes
>> ISOLATE_UNEVICTABLE regardless of this sysctl, so the setting
>> has no effect in the alloc_contig path.
>>
>> Fix it by:
>>   - Keep ISOLATE_UNEVICTABLE for CMA allocation, discussed in [1].
>>   - Honour sysctl_compact_unevictable_allowed for non-CMA allocation.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/all/25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz/ [1]
> 
> There was also the "Ideally by not having mlock'd pages in CMA areas at
> all." part. Is it the case? It was more elaborated here:

Yes, It is the case.

> https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/

I missed this important information. Thanks for pointing it out, Vlastimil.

Best regards,
Wandun

> 
>> ---
>>  include/linux/compaction.h | 6 ++++++
>>  mm/compaction.c            | 9 +++++++--
>>  mm/internal.h              | 1 +
>>  mm/page_alloc.c            | 2 ++
>>  4 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>> index f29ef0653546..04e60f65b976 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>  extern void __meminit kcompactd_run(int nid);
>>  extern void __meminit kcompactd_stop(int nid);
>>  extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
>> +extern bool compaction_allow_unevictable(void);
>>  
>>  #else
>>  static inline void reset_isolation_suitable(pg_data_t *pgdat)
>> @@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
>>  {
>>  }
>>  
>> +static inline bool compaction_allow_unevictable(void)
>> +{
>> +	return true;
>> +}
>> +
>>  #endif /* CONFIG_COMPACTION */
>>  
>>  struct node;
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 007d5e00a8ae..a10acb273454 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1341,6 +1341,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>>  							unsigned long end_pfn)
>>  {
>>  	unsigned long pfn, block_start_pfn, block_end_pfn;
>> +	isolate_mode_t mode = cc->allow_unevictable ? ISOLATE_UNEVICTABLE : 0;
>>  	int ret = 0;
>>  
>>  	/* Scan block by block. First and last block may be incomplete */
>> @@ -1360,8 +1361,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>>  					block_end_pfn, cc->zone))
>>  			continue;
>>  
>> -		ret = isolate_migratepages_block(cc, pfn, block_end_pfn,
>> -						 ISOLATE_UNEVICTABLE);
>> +		ret = isolate_migratepages_block(cc, pfn, block_end_pfn, mode);
>>  
>>  		if (ret)
>>  			break;
>> @@ -1902,6 +1902,11 @@ typedef enum {
>>   * compactable pages.
>>   */
>>  static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
>> +
>> +bool compaction_allow_unevictable(void)
>> +{
>> +	return sysctl_compact_unevictable_allowed;
>> +}
>>  /*
>>   * Tunable for proactive compaction. It determines how
>>   * aggressively the kernel should compact memory in the
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 181e79f1d6a2..163f9d6b37f3 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1052,6 +1052,7 @@ struct compact_control {
>>  					 * ensure forward progress.
>>  					 */
>>  	bool alloc_contig;		/* alloc_contig_range allocation */
>> +	bool allow_unevictable;		/* Allow isolation of unevictable folios */
>>  };
>>  
>>  /*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 81a9d4d1e6c0..1cf9d4a3b14c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7118,6 +7118,8 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>>  		.ignore_skip_hint = true,
>>  		.no_set_skip_hint = true,
>>  		.alloc_contig = true,
>> +		.allow_unevictable = !!(alloc_flags & ACR_FLAGS_CMA) ||
>> +					     compaction_allow_unevictable(),
>>  	};
>>  	INIT_LIST_HEAD(&cc.migratepages);
>>  	enum pb_isolate_mode mode = (alloc_flags & ACR_FLAGS_CMA) ?
> 

