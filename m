Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66341D61A6;
	Tue,  3 Sep 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348319; cv=none; b=gHV2se+EYtPXqPd50a7mDWIOUiw6Y+tGw8KEFJbz/wOfxj4nsHYgN8+uuz1xlIFw9/lRq1V5R9IuXgqczXbHxmxTIXArJTt2OfoDZM9ud6GVzuqpr7ykuVboUErq0F5BwOaOi5WBvcwiOCe0YShluzClCoNTDxW0jqYdiJ3TLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348319; c=relaxed/simple;
	bh=eLzjW3Zn7o3Z6zsDPvNBNBqtGxj6v60sUD5Jc/XeOB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abwXzZ2IL9E4lvodkQBBB/AR0Q1+60GrgjmchODJKJLpr8k8tU5Zore+r+NKmbmAANS7bW/QFcuoDN3WF6k4i3zmQCvhI+e6jjI2S56schYtvyLC9fWlaOikiB5UrEInDsPsyM8zYbfujpDIV4wjA5TnbwOfde4TO/ObPUI+ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 741FA227A87; Tue,  3 Sep 2024 09:25:12 +0200 (CEST)
Date: Tue, 3 Sep 2024 09:25:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240903072512.GA1521@lst.de>
References: <20240826203240.2234615-1-sean.anderson@linux.dev> <20240829041912.GB4408@lst.de> <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 29, 2024 at 10:24:52AM -0400, Sean Anderson wrote:
> >> When debugging drivers, it can often be useful to trace when memory gets
> >> (un)mapped for DMA (and can be accessed by the device). Add some
> >> tracepoints for this purpose.
> >> 
> >> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
> >> similarly %llx instead of %pa) because libtraceevent can't handle
> >> typedefs.
> > 
> > and a __u64 would seem like the better type here.
> 
> libtraceevent can't handle typedefs, including u64.

Weird.  The xfs trace events which were some of the first ever are full
of typedefs and no one ever complained.  And looking at other
trace event definitions they are full of it.

I've added the tracing maintainers to see if we can shed some light
on this issue.
