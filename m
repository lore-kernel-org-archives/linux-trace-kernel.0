Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFF1C84D5;
	Wed, 11 Jun 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657406; cv=none; b=IJ3j6U7K2xSAMz/ZPumjxkP6AvKzuK3sT7/Q3FEM+JRlvv8+hENbzWaI3O9awTuvYd4scMpM0t1jVmyxhuLi/oRudwBH6Y3CraTohM2MQrazOHD7E3jRF7TN55JSYzwETEgIJfGi/MpCi8yOHX8SBOo1gWl89r4b077Ut49WJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657406; c=relaxed/simple;
	bh=toj2JtLdyChmNC+vIjY+Ugkl/HRFUXHuj2qZTM+EDyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPRPmjS+BZwzGXX2SR8hEPv2R6CgQGWv1ojjTbHImJIS4TKgENcdgyyMkVy32IXmzrnooJr7EXH/Byc5CxffOwGNbzgU0Iz9MydkV5xtTwdF2waxBwSI8W8DW2uwyAPrnrBmKVQ34m2oRFrhLjSc/xn1cSaDX4S9DElyk6f+mY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4233512101E;
	Wed, 11 Jun 2025 15:56:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 5640C22;
	Wed, 11 Jun 2025 15:56:41 +0000 (UTC)
Date: Wed, 11 Jun 2025 11:56:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, iommu@lists.linux.dev, Christoph
 Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH] swiotlb: iommu/dma: Move trace_swiotlb_bounced() into
 swiotlb_tbl_map_single()
Message-ID: <20250611115640.5e79bde8@batman.local.home>
In-Reply-To: <e2d856b7-0214-49ab-a4c5-4e6ee2541c6d@arm.com>
References: <20250611100103.7b3c28c8@batman.local.home>
	<e2d856b7-0214-49ab-a4c5-4e6ee2541c6d@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kk5eoxyb7r96nwk1iitx31b3medra1wy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5640C22
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19sKjfs4T1xcTnvYw55LHQUM8lLVhuD1yU=
X-HE-Tag: 1749657401-459559
X-HE-Meta: U2FsdGVkX1/mrC0pkss+1d34xPrpmRmFMb8hARcvWQyl3cXRB0MRVkDtGCi5h73BlRWVqakJQgXNNtnz6agR0fWMpKXtUf+Fu2NRBUxvk+zUQEWhlNLTWg9JIMt9pVcXKzbZ8tDc2VoNYcHgOjPZIqvL40QMOW22YBY3Gp4mAIo+x2mUHG1gORF652ZHQAaCfPYWeQUZGII0qEXHcFRtRQDV6QXT8C/xtDTIcSbo3jY4GZRk7cjhVw2VlglupxyZFUcaDF4/pbhb3+Wul/euSH77I0NXq1CUMfd3OpO9jj+SrCC3LpgtVljS720yp5lPlhivGKcZzzLb/vnVekZPiQbrlwhaoD7P+nxyzneRowPEyRUXipLyxl8dRs+hy7oFsLPn+FdyJjJAI8SJsVOHT61tEzE9J4IB33913Jmm35IrWxeP1GP43aHybIc2NXxlikFk1zgaOVO9l01cdjyU8pRb/OvfWsivYrEsTQEc/b8=

On Wed, 11 Jun 2025 15:28:52 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2025-06-11 3:01 pm, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > I'm working on code that will warn when a tracepoint is defined but not
> > used. As the TRACE_EVENT() logic still creates all the code regardless if
> > something calls the trace_<event>() function. It wastes around 5K per trace
> > event (less for tracepoints).
> > 
> > But it seems that the code in drivers/iommu/dma-iommu.c does the opposite.
> > It calls the trace_swiotlb_bounced() tracepoint without it being defined.
> > The tracepoint is defined in kernel/dma/swiotlb.c when CONFIG_SWIOTLB is
> > defined, but this code exists when that config is not defined.
> > 
> > This now fails with my work because I have all the callers reference the
> > tracepoint that they will call.
> > 
> > Thanks to the kernel test robot, it found this:
> > 
> >    https://lore.kernel.org/all/202506091015.7zd87kI7-lkp@intel.com/
> > 
> > Instead of calling trace_swiotlb_bounced() from drivers/iommu/dma-iommu.c
> > where it is useless when CONFIG_SWIOTLB is not defined, move the
> > tracepoint into swiotlb_tbl_map_single(). This also makes it consistent
> > with which memory is being traced (physical as supposed to dma address).  
> 
> Consistent with what? Certainly not the other callers which invoke the 
> tracepoint with phys_to_dma(orig_addr), but will now do so twice with 
> potentially different values. Arguably iommu-dma is already consistent 
> as things stand, since it does not support static address offsets 
> underneath IOMMU translation, and therefore orig_addr will always be 
> equal to phys_to_dma(orig_addr) anyway. The point of interest really is 
> in those other cases, where if there *were* a static DMA offset then 
> phys_to_dma(orig_addr) would actually be a pretty meaningless value 
> which is not used anywhere else and therefore not overly helpful to 
> trace - neither the recognisable PA of the underlying memory itself, nor 
> the actual DMA address which will be used subsequently, since at this 
> point that's yet to be allocated.

I only added that line because of what Christoph said. I'll let you
folks hammer that point.

> 
> > Fixes: ed18a46262be4 ("iommu/dma: Factor out a iommu_dma_map_swiotlb helper")  
> 
> It's a fair bit older than that, try a63c357b9fd5 ("iommu/dma: Trace 
> bounce buffer usage when mapping buffers") - looks like it's always just 
> been hopeful of being DCE'd.

Ah, yeah, that's the real culprit. Thanks!

Well, it may be some time before I push my code that will cause this to
fail to build, as I want to clean up the unused events before I add it
(otherwise there's going to be lots of warnings whenever it's enabled).

-- Steve
