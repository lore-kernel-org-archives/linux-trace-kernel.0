Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189D16CD33
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317982; cv=none; b=GynYAG26Lq7ysTf63HWeZymVzybYc9wk5AM+3ApwnFni7P0Lh3oeBUWwMkxGHg8AJPfkFAkq/7Gr88tJm70pbODHL+TiBvNh+NveoK7yDrBQKVePv1PIsINKTdoUA/QnvSagymuktCAm9rHSl2foACBCDdu0sNF7/+VF5OLRBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317982; c=relaxed/simple;
	bh=Oj/7ehc0cCCCDQU/7pS4vL4fF7AXLJnL/YyNxYgW3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEVaGulSccxCh9sSHv3LWr1nVjKuP0PGMzZ4kY9xeJND6f3rcsu1rDyEaVYbuMPUGkMCAaadKsuq90AmxY0U7lwsk5u5O3rxMNZwXVL62u5UlFxI/IGp9a2/E4DTF5TwYiyXImaxZARKhISCjx4mZN0Ou2PYaCdEa4iZe64kk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BKS8aTvx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BKS8aTvx"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd8576a512so215180285a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773317980; x=1773922780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=BKS8aTvxZ3yh3IKjkSO1betRitYvAMjkK4YVAlshSXkv+ZnnBOXn7O7vaa1xC/RfHE
         zkAT2IkDbxusmUdQBc03On3Qiajg5+h3X3muwby/ijTjxLZBSm5SYsOa7xok8BrqH3LN
         GLFLO/42YieyVkWFv+HoGj95X8UG3+cuKr33MM8HWMqACq0QTUPGEYEcq/UsSdyMbSFX
         GAifEack/sIllT9LxthUXMJMeOlziVtcG2Ljouz+6y6o8KqRsAM6HTyboxZrtMUgzNsk
         RMbV/Q6WtRTyCeZUGeROzDdlUhO5p8muQs9pa4NEB7B0le9KZsotXJ3Ii6ruCleOy2Ub
         FnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317980; x=1773922780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=sEoLb73Ua/QRDjOqNTPWcx8lz5mrb0AD4ZXJXSYpWheBwEkv5/kjZz137EYT+Hkw8F
         OjQNUOdGnODph+W/QSUXLzJu8uHPhi7Edo5WffQq/VF5cbtFQt6EXbpr93hBZnkShtax
         ATCEsUnKOfCF8rN+cVEljhHrhwfFcdH7WDh/qrKv68WZg+DVKP9mX/nPbwPMQy+Sq/am
         gY9LI4SxZIh5s++OwE0MJmkKJuSSwuHpBTPKOBEi51YTCFAQb6IJ6GhXfa+IvaW8tZbe
         MsrfFOh8VUvpBeupgk5MnrhFcplU6Hekl4ujcsWyV07h/pIshcMARBjQ/yhlE0jv7Zt5
         D6tg==
X-Forwarded-Encrypted: i=1; AJvYcCWFuOBJ3i+947HBsDKVHBfOW38dvfOMYTd3auHEfcjFEkAH1MJuh1lUq0xtm0SOS+cMe13TXKNNu5RWpQVD1yfoOjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcH+79bD8jsuyMGu3CoUsq8Ngk7orydU4LYn37XGBI50e7EwO
	hPYIOCZUIcSW+ROO7D5MrRz4KL5YIk7SIcMMqb52GOOP5YcwXAmeaQWoRAlBxQKT2l0=
X-Gm-Gg: ATEYQzx6hVGRN1jJuRVYmPtjNckmsP8ppLcjZ8//PIR3X7zbP5/SUOHwPDPFyVpRc5t
	lZUXoEM8oNxW5ahsv0NjVekwYCfgXE8b2isnXGd8Gy3yjaUtQJvYij8KU4YpF7shd0mjNWNUO3h
	R4e+xuIOQxap6zAGv+NVFb8piNlZhGrJdiU5gHxmAcBxJvhXK1sFM3CHnlwmc2ZZU9i/VOZXUhM
	BKABKiofan3wrbVJ/NqMaWaS+YRz20G2nb+0kQIDuMhfx4A7QIZDVjX1KMqc5K+ZgkOAN9ij0Xu
	LxJtTErEj9cz8wX/90HhU8+9u/rpLDwdmVuMxgma/aQHc5ajbqH1EGvU7SmvJW3oCfNpe7rnzTy
	8kJx+oNur5nbM4nSoAsoVKcdOsOKENxFKpA42/pWBo9UthXefFh333BhmgUQLMn+D+th8LkLDhq
	jViVQkCnHTDwN5OiD6I/qCQ3rJdczoo+W8VuzrOP2bNSN53XZpMY9bYaCw/mJ9oseNH4T0H1mUo
	uNKkaGg
X-Received: by 2002:a05:620a:4041:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cdaa7b6b03mr382866785a.15.1773317979843;
        Thu, 12 Mar 2026 05:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm321675885a.34.2026.03.12.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:19:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f0r-00000006esN-1WXU;
	Thu, 12 Mar 2026 09:19:37 -0300
Date: Thu, 12 Mar 2026 09:19:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/8] dma-mapping: Introduce DMA require coherency
 attribute
Message-ID: <20260312121937.GD1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mapping buffers which carry this attribute require DMA coherent system.
> This means that they can't take SWIOTLB path, can perform CPU cache overlap
> and doesn't perform cache flushing.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
>  include/linux/dma-mapping.h               |  7 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  kernel/dma/debug.c                        |  3 ++-
>  kernel/dma/mapping.c                      |  6 ++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 48cfe86cc06d7..69d094f144c70 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -163,3 +163,15 @@ data corruption.
>  
>  All mappings that share a cache line must set this attribute to suppress DMA
>  debug warnings about overlapping mappings.
> +
> +DMA_ATTR_REQUIRE_COHERENT
> +-------------------------
> +
> +The mapping buffers which carry this attribute require DMA coherent system. This means
> +that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
> +cache flushing.

DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
system where SWIOTLB or cache management is required. This should only
be used to support uAPI designs that require continuous HW DMA
coherence with userspace processes, for example RDMA and DRM. At a
minimum the memory being mapped must be userspace memory from
pin_user_pages() or similar.

Drivers should consider using dma_mmap_pages() instead of this
interface when building their uAPIs, when possible.

It must never be used in an in-kernel driver that only works with
kernal memory.

> @@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  	if (WARN_ON_ONCE(!dev->dma_mask))
>  		return DMA_MAPPING_ERROR;
>  
> +	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
> +		return DMA_MAPPING_ERROR;

This doesn't capture enough conditions.. is_swiotlb_force_bounce(),
dma_kmalloc_needs_bounce(), dma_capable(), etc all need to be blocked
too

So check it inside swiotlb_map() too, and maybe shift the above
into the existing branches:

        if (!dev_is_dma_coherent(dev) &&
            !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
                arch_sync_dma_for_device(phys, size, dir);

Jason
