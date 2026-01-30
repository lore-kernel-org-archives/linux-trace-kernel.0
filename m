Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4141C62;
	Fri, 30 Jan 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785066; cv=none; b=P1L+U1oUFkcAHscWfXVQGaVsbLP8/1h0Dkv6j46C/BLsjZxXhRzNBSizW8OLarHIk82iVgW96XD9rQbCqFrhK1+jAqpDfyxYFWqjROaYLLyiE/6OTtQY47ZphpoHaImtMzIyTlwku4Sg0QEO7e2esAZwQj5h2WBNdliKSGrpulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785066; c=relaxed/simple;
	bh=gdi1o1yEraxfBlLDIEudjYZOF96pR8bktTWcko6RaK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoLWF4aMBIVvEbjlzQ2Oat5LsteWiH0PyflV80BSdSwvs6LOeLjN/A3O1xuVgTsWFFfZOlPmhfQ4zP9NeTye+kUgzfR9uqR6+NOgzI5wf/UydbxXKIV601OHQaKkbdlhOBjj1X0nlyt5wcDBIJzxv7t/Ou9Pj+YXUcKlbFYm1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 86A7A8B8EC;
	Fri, 30 Jan 2026 14:57:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 2BE2D20011;
	Fri, 30 Jan 2026 14:57:34 +0000 (UTC)
Date: Fri, 30 Jan 2026 09:57:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 m.szyprowski@samsung.com, leon@kernel.org, jgg@ziepe.ca, ptesarik@suse.com,
 kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing/dma: Cap dma_map_sg tracepoint arrays to
 prevent buffer overflow
Message-ID: <20260130095749.491f4152@gandalf.local.home>
In-Reply-To: <20260130060317.54522-1-kartikey406@gmail.com>
References: <20260130060317.54522-1-kartikey406@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: p34e55idrc864fbe1jqgtq7zmkb1r3sw
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2BE2D20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199er+PZNgLyn2sYRPPvDO+xAkCbZsPfC8=
X-HE-Tag: 1769785054-138516
X-HE-Meta: U2FsdGVkX19sQLUfWVC69cASmyI0VaCYcUH951r4AKVNDGTWJgEGUI5Pz6Cs++oKXRgzQeIrxpE03ptF5szWbqOwuw1Bm2h0NpOYdRRpjkOZ2Yb733dBTG0cO4IAJBUIsJi4iM09pwJJF9Qu53GrdFfw72ByPfbv1nOO3EK+oU7cr1YWwNjftbI6oXaVAJ/H10mBu9kQRle4J/BtckGBi66SYA/xn5/slBDkMPvtDkbsiHImnZgDM2pcIhnsTB/zNNAIlW4EIHQiVO5a1W85nLLPuOpVOWPj+e2JnU0imZ+W4MeCoakSuXhVCLqC/c6+fAO6C42W/vol0hAuOL1f3gTkxRI90YkzwlpI1apIWT9Uj0VaKLGRhIHo2Rf4etQ20t/jcDui4k0EnX6MgJ1ZiiKdR7kPpmk1es1aJsUt1WWLnUqMG1jV/VT6nrk2AKDUqS/+OLo6JjLv63kytCoKIQ==

On Fri, 30 Jan 2026 11:33:17 +0530
Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> The dma_map_sg tracepoint can trigger a perf buffer overflow when
> tracing large scatter-gather lists. With devices like virtio-gpu
> creating large DRM buffers, nents can exceed 1000 entries, resulting
> in:
> 
>   phys_addrs: 1000 * 8 bytes = 8,000 bytes
>   dma_addrs:  1000 * 8 bytes = 8,000 bytes
>   lengths:    1000 * 4 bytes = 4,000 bytes
>   Total: ~20,000 bytes
> 
> This exceeds PERF_MAX_TRACE_SIZE (8192 bytes), causing:
> 
>   WARNING: CPU: 0 PID: 5497 at kernel/trace/trace_event_perf.c:405
>   perf buffer not large enough, wanted 24620, have 8192
> 
> Cap all three dynamic arrays at a fixed size of 128 entries. This limits
> the total event size to approximately 2,760 bytes, safely under the 8KB
> limit while still providing sufficient debugging information for typical
> cases.
> 
> The tracepoint now records the full nents/ents counts and a truncated
> flag so users can see when data has been capped.
> 
> Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=28cea38c382fd15e751a
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  include/trace/events/dma.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index b3fef140ae15..c4e1a9f0c9c4 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -275,6 +275,8 @@ TRACE_EVENT(dma_free_sgt,
>  				sizeof(u64), sizeof(u64)))
>  );
>  
> +#define DMA_TRACE_MAX_ENTRIES 128
> +
>  TRACE_EVENT(dma_map_sg,
>  	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>  		 int ents, enum dma_data_direction dir, unsigned long attrs),
> @@ -282,9 +284,12 @@ TRACE_EVENT(dma_map_sg,
>  
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
> -		__dynamic_array(u64, phys_addrs, nents)
> -		__dynamic_array(u64, dma_addrs, ents)
> -		__dynamic_array(unsigned int, lengths, ents)
> +		__field(int, full_nents)
> +		__field(int, full_ents)
> +		__field(bool, truncated)
> +		__dynamic_array(u64, phys_addrs,  DMA_TRACE_MAX_ENTRIES)
> +		__dynamic_array(u64, dma_addrs, DMA_TRACE_MAX_ENTRIES)
> +		__dynamic_array(unsigned int, lengths, DMA_TRACE_MAX_ENTRIES)

This isn't doing what you want. You just used a dynamic array and allocated
a fixed size for it, regardless of if you use all of it or not. What you
want to do is:

		__dynamic_array(u64, phys_addrs,  min(nents, DMA_TRACE_MAX_ENTRIES))
		__dynamic_array(u64, dma_addrs, min(ents, DMA_TRACE_MAX_ENTRIES))
		__dynamic_array(unsigned int, lengths, min(ents, DMA_TRACE_MAX_ENTRIES))

And the same for the rest.

-- Steve

>  		__field(enum dma_data_direction, dir)
>  		__field(unsigned long, attrs)
>  	),
