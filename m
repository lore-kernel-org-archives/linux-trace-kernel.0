Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACF1E8332
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318062; cv=none; b=UIwqSK6N0tgAC4i6+LwrIofpXSHPnsOQukrlOezZncBdgiDR1i7mh+nWilufoXUgSF3g6TdCocY7xOklU7+Oh+pZGazv3WwmWqur+cDwndaUhocukY8Kfk8BR0oF2T3wctsnDlm8btS/FDzAFk3iGBc6KyfmOfLAdtj/L2BcUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318062; c=relaxed/simple;
	bh=ykZqC/Mt6PvknDhYlKuIL2nlRrianZMm9PtDxixDlPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLbBKj4V3OtzpfhxTqChaBnPq+45JeR/o11acDnAHqsif5B+y+U6/xzd3B8kWgiZazp2mztS+MYbU2LyYRcbcipFOfoFru3SlH1iaX27XcBMZKqMhoyFqW+dRgISd/AUHmJgnFFWWCuNjfXmnMkAvawIpLIaPH4INCCj/Yc/8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lf57U9if; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lf57U9if"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50905b779dfso10914241cf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318060; x=1773922860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=lf57U9ifEBLyWexzvIhO+XWU98aspeK4epPDkVo+bdUc3uTnRHFJOzAQFqtZnirpvL
         k8WeXlvvSI8u+12g+H+RomdTCxvAsh3kAn5N2BjPPi8vq94s6Oz20FKmexletPuH9CDd
         kY6PAL0+tgqYeVJyO+vItC60qEHK3ThnYf/UD0MFEEj1sd/5cHAqC+CRrRhfsPUeevgk
         NA9hIOWisR9ITVunmGpPNJjiTOXkD9H2lvwvenW8CHns6evMimwcZUGyabHMruJwxAaz
         pcI1HmQBIrJQjeuMNGr7o3dWdYRxf7UmUrzRdYCqQcdIWMOebcd7mYF5Bal6OCbsQR4Y
         5nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318060; x=1773922860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=mCGJSAhzG0BeeU4Yxvl2aeATwTT0C88j/rNn6JjTilRCyl+hFULtk7ScP+TD8t014f
         O779m05m2uia/Q1jJrKm9/grBL/Y8zz8TxVOrC2b/3AibyIGfoRZuCtcnqP6FWRb/XxQ
         hEB8F4d1f5NGz1+0hlh5p8843+6PbK8+TXzlcpcYC9pbHIANTSTnQ3nq7lBWbGjANjAF
         CU4AHc3JlwsFl88nC4+WyYxyyZGnIK8IN6ioKLn+b2AHzb5vpMcOVt0UEoruVu3N83oN
         goxzK/umpQO2SoCk384Qh8kX42MfHwR99K610RUEofWFnOmUXp6qF4YqV3Y/iSFyyc3I
         XEqA==
X-Forwarded-Encrypted: i=1; AJvYcCUgpJgCRpWqLV9ladr9n65Bcouo4dMkySzBaZZPtchpnIn2d8v4eITRNIOMfocVp8deY30wnyA3izH3aHhOG1PF2FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIyYTtoSvzoQfCw2rwAJ9Gnq7pkfCAVskRLCLYvB79yfQbHty
	CpZrCdwFSquxjEOSvwoTEvUvTNC0rAUHyKOtbJ/dfsTsprhatRl28BMVQFvgMoVu/tipEO12e9v
	DQQCk
X-Gm-Gg: ATEYQzz34OFDErdEn7cKO8MVjuVZLn1suyAULIwJGYCosi3K6ty3CRRtZJIOMVWSOiu
	o6zMUquutSlSLOmobzYC3AA0k8ZkI2BXihi4JQo56Ufxf1sJlAkZjzgh7nuH1Ow9bTN/Yz34Fdr
	bYjynQqB4WvSSaKAOQn2GhV3nwsc6DXOT3cvqRpeSbfo8o1AfosmlEtk7YJNt32s098ES/PAVs8
	VTPE2nv8IMegFWwPIisZS38XFR2iv0p0rhCwIk2sPO++nFhXd5TPLe8JLTmhOiTMohNgBtK32rR
	rsXJ1r93akvMuz2VpJhoF3KuWU0lLex9NeffYhxHpli98riEfd5/5o9ECOXrEJi/66PiWxzrx4p
	OofxmB2o8BE5l1X/v6GvPjw6X3vSqJEMvWzJB47jDJY81zIhFHM1id+NzRDENlHfuv0JQ638w4u
	1P118S/Dg21HPGUE2oBTQagkVdJwTOoI4V9DZDVTu6U5UyEna5251/fHbD0FQqjGaDWfgsujnHO
	PF9CLLE0YqCHZ/i+44=
X-Received: by 2002:a05:622a:11c1:b0:509:4410:4492 with SMTP id d75a77b69052e-50944104900mr62025551cf.22.1773318060513;
        Thu, 12 Mar 2026 05:21:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec5017sm30688511cf.8.2026.03.12.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:20:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f2A-00000006et5-427z;
	Thu, 12 Mar 2026 09:20:58 -0300
Date: Thu, 12 Mar 2026 09:20:58 -0300
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
Subject: Re: [PATCH v2 5/8] dma-direct: prevent SWIOTLB path when
 DMA_ATTR_REQUIRE_COHERENT is set
Message-ID: <20260312122058.GE1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:48PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> DMA_ATTR_REQUIRE_COHERENT indicates that SWIOTLB must not be used.
> Ensure the SWIOTLB path is declined whenever the DMA direct path is
> selected.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  kernel/dma/direct.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e89f175e9c2d0..6184ff303f080 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -84,7 +84,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  	dma_addr_t dma_addr;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (attrs & DMA_ATTR_MMIO)
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>  
>  		return swiotlb_map(dev, phys, size, dir, attrs);

Oh here it is, still maybe it is better to put it in swiotlb_map() ?

Jason
