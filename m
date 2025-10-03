Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E91FBC8C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474826; cv=none; b=SiNSUOWbj2iKMBaHRKUjmRzDsJ1SYeFCpMaOClHHHmFOlypKz9oq3lC5XToCEU1AYsTCKv2V1USIBJOSfjB18ybt1XIbmY4TA+TaHpJuDovMnesaFhLRtoCVOlJ8m23BpweDTo1NzA4gLmMZ6eHwOPnKZQ3MMAwR+US6uLgvhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474826; c=relaxed/simple;
	bh=boKwQQTvvSbv4t+73ZXF28R6yCtMpd5mDWoNlD9rM/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kPynwCIDVfh3+Ad19ynfbi22uEbJHsfF6ErxBphOsNxVnI/kvdr8xSoAOlUsTGmsBCdDv/OyVZxIE2O1c1bWKEE+60uPCU2qZ0N1rSmNHSJNL12keSNE7wsE2f1s9KkX3IQ6nqAAo73TKInzbcOPByzJF9nCNYpC+SpYLKFP1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e/KK7viQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e/KK7viQ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251003070015euoutp024a1277ae4583da3de60ab174ce0511c3~q6QXWp_-E2779927799euoutp02g
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:00:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251003070015euoutp024a1277ae4583da3de60ab174ce0511c3~q6QXWp_-E2779927799euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759474815;
	bh=LSGPDYp4xyAWC832iPznscRm+XYwz1Gfb+Q2HoGidkk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=e/KK7viQmpNxw3W+nPiQFLEo7KfiUm/Wdcem3LzvjEi0RgpGIsS4Jr6G5vqigNmcC
	 IkYuXFpTzPlmViynbA5JrA9NIJXuUvr9iK670edeJxwSOFQjcGr5uQuLwj5QUN91ap
	 UPcSgkBqG7Be9/Fs7Ge7OOZ6FzrQWfFSJmuTNw2c=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251003070015eucas1p13319bcc33f480b5b5f27054c21b4c018~q6QW2j5bi2697726977eucas1p10;
	Fri,  3 Oct 2025 07:00:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251003070014eusmtip2580963f80bd4896a98960b2d4b2ac4fe~q6QV_npGR2697326973eusmtip2o;
	Fri,  3 Oct 2025 07:00:14 +0000 (GMT)
Message-ID: <9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
Date: Fri, 3 Oct 2025 09:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
To: Petr Tesarik <ptesarik@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Sean Anderson <sean.anderson@linux.dev>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251003070015eucas1p13319bcc33f480b5b5f27054c21b4c018
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e
X-EPHeader: CA
X-CMS-RootMailID: 20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e
References: <CGME20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e@eucas1p1.samsung.com>
	<20251001061028.412258-1-ptesarik@suse.com>

On 01.10.2025 08:10, Petr Tesarik wrote:
> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
>
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")

Applied to dma-mapping-for-next (for v6.18-rc1) branch. Thanks!

> ---
>   include/trace/events/dma.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>   		__entry->dma_addr = dma_addr;
>   		__entry->size = size;
>   		__entry->flags = flags;
> +		__entry->dir = dir;
>   		__entry->attrs = attrs;
>   	),
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

