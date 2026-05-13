Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4347DD52;
	Wed, 13 May 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686366; cv=none; b=WS5hkc15X/s9STP3/HSnAt1CWYccx4qLU74+oqmuMRh1At+s/bXjcGFx7dn0BNw+w06bYRq6hh0B7BJv3oBO0QAYEgj4U1LvtVdNNiYu6exNxmnrSKfzwgxiUxo2/g+1b9PkWwMPX+4M/1auXYcBoPyEN5KGjZNoN95c1I8lfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686366; c=relaxed/simple;
	bh=0ci+iek60SmkhVTT/zsTtlI1fmuGknW5HfienBWjnFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxsDXwqDzplup4nM6vXv/3i4IcVwmnRCsuRgYc1Sb+5+gHY/jhP09RaKyI9k7ayhG0YPG6hwupix3hj+zag3xyx1R1ytFfeXoD+E9K247+jNDLZoMQ1wbi6D9D082EWe8HSvyhjTGbPZWwk5Fo+CMF5p8u/w4muXZidEjH7ekRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRTu9XDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRTu9XDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A925C19425;
	Wed, 13 May 2026 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778686366;
	bh=0ci+iek60SmkhVTT/zsTtlI1fmuGknW5HfienBWjnFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JRTu9XDXhzehWq8qRyftamEAEiC2Q020LlHtCb8ip9vhqdfOOIyj4jK7UPjULtzhI
	 zZuZM5tkxjuJs4A3fyl2dsEpZeU52xFGEfrhndTWEGcg7JrRto/QW/+YloP8U/4Y00
	 8mGcx1WfnBEux7LgwoEw/Pyyum2fyzPcmHddAruShjQzhEOQOePuv/pQNOizNGhXhc
	 vhCaeRPmjpXIwyFkd8lEJzBfYA2LTFPMb2uWzkr90owubbZxB/KJlM8P7PhiFDpUtp
	 zZvtrZNVeiUNOYiRitoQCLBsE3i3C3DsmRRfUlEOHBPicHRbc3ceG6xJgVKLVuweLD
	 OXBiwUtPeWVqA==
Message-ID: <fab7d27a-6c2b-47aa-abe8-a327f05fb5cd@kernel.org>
Date: Wed, 13 May 2026 17:32:41 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock
 acquisitions
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan
 <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
 <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
 <4f61457e-deff-430f-8a1e-d3c33c925db3@kernel.org>
 <af4mbDB3-ohO5DCp@shell.ilvokhin.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <af4mbDB3-ohO5DCp@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/05/2026 20.07, Dmitry Ilvokhin wrote:
> On Fri, May 08, 2026 at 07:40:51PM +0200, Vlastimil Babka (SUSE) wrote:
>> On 5/8/26 7:38 PM, Vlastimil Babka (SUSE) wrote:
>>> On 5/8/26 7:29 PM, Andrew Morton wrote:
>>>> e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:
>>>>
>>>>> Add tracepoints to the page allocator fast paths that acquire
>>>>> zone->lock, allowing diagnosis of lock contention in production.
>>>>
>>>> Thanks, I'm surprised we haven't done this yet.
>>>
>>> There was a recent attempt [1]. Not being a generic solution wasn't welcome.
>>>
>>> [1] https://lore.kernel.org/all/cover.1772206930.git.d@ilvokhin.com/
>>
>> And this is the generic solution I think?
>>
>> https://lore.kernel.org/all/cover.1777999826.git.d@ilvokhin.com/
> 
> Thanks for cc'ing me, Vlastimil.
> 
> Yes, this is an attempt at a generic solution for tracing contended
> locks, including spinlocks, so it should also cover the use case
> proposed in this patchset.
>

I'm aware of the generic solution and often use `perf lock contention`.
And the tool libbpf-tools/klockstat. My experience is unfortunately that
enabling these tracepoint is prohibitive expensive on production server,
and production suffers when I run these tools.

I'm very happy to see a patchset adding a contended case. But I worry
that tracing all contented locks in the system is also too much to have
enabled continuously for production.

This patch is carefully constructed to minimize overhead, such that I
can enable this continuously on production to catch issues.  If I
identify issue I will use the generic tracpoints for further debugging.


> In fact, zone->lock contention was one of the primary motivations for
> this work.

In the generic solution I'm loosing the "zone" and pages "count".  I
need this information to get the answers I'm looking for.  Specifically
I'm looking at reducing CONFIG_PCP_BATCH_SCALE_MAX, but I want to this
to be a data-driven decision (my first principle is: if you cannot
measure it you cannot improve it).

I'm likely going to apply this patch to our production system, such that
I can get my data-driven decision.  I need to deploy it widely enough to
get enough server experiencing direct-reclaim.  I'll report back if
people are interested in these learning?

--Jesper
