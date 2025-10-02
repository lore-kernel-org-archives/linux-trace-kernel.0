Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11A148830
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437255; cv=none; b=O0wYWOLD0ejwjNsI8k7nzVRfJ/klAqcUeTHpdzYHs6GWElvFGkKl+5e55ZCs046N3lHdm/DNLMwDimks7mRRA79xABMW8wprqtMBhdRVsJiQtNnKIjST9rgk8oQKrel8AHEiloJC7Nzdc1vqRCxUhNrRh5We2XJfhfgaxU8yjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437255; c=relaxed/simple;
	bh=KxcDfMj6BbUZHpgx4zrwoZXOxwZsiz8a/JwZYsk8jkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYO07Im/cGZgORwtfxifbuOJM3eOspGCuFhaQm3LrV77szUVOiz+UsFAVzqt8JyOLT/QDFvWfsvaeYsabUNpBO3L6ORUsmDpsOTV2ZyPbLTBFKF03V5WBnw/Z/e43sGK5YW+AEFYqwt9SHhHLcETyPQmhHprySskDBuSb6vkLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vk9dGjdd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vk9dGjdd"
Message-ID: <a97c8722-afb1-440a-83a5-32d7ab3b1a19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759437250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjbekaK0BCBK0ojECpE2phUEY94cpmK8rXiAaha3OvQ=;
	b=Vk9dGjddnciJjriAQomEjFYMFCip4uvxbiLXJxP2Yw7Mrqy969f7R+Y/NtbuX/BbmiJ4r5
	PzWXyYQ+GOZCZMDgCIMLFJ5rJp1AUN8r+HxH8PPCrMzOZ3w6oC7fuNktFbqotwd/oq/Zge
	7v1MyphbvYVs5vrAOIa04efrpmJXC4Y=
Date: Thu, 2 Oct 2025 16:34:05 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction traces
To: Petr Tesarik <ptesarik@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251001061028.412258-1-ptesarik@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/1/25 02:10, Petr Tesarik wrote:
> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
> ---
>  include/trace/events/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  		__entry->dma_addr = dma_addr;
>  		__entry->size = size;
>  		__entry->flags = flags;
> +		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
>  

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
