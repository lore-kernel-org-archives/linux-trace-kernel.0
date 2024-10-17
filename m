Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE21D47AC;
	Thu, 17 Oct 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179722; cv=none; b=DkVMcLzuYmPJxQpSAYVZwZ1jTzapKK3a+l/x89+GbXNXdGJ6i2zmc4RDSK6OIYKzIo2HSybjLWvcJ3DOyWbLKXo02BS29tlwl+hOwcNSbViUyrAAOh//Abi6rmsgWHavuojYhKQTs2PdHqg0jQkkhVAYYYBM1tQ1CG+tBwdJKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179722; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP1htZkcrOA1PI8PI27oSC/BXDGSztqk9YRrJvvX62OSeKRlJylMs3lYACOK/blk1xv0pWx3OE6pBjW8kL5Txcnw61IpOR8WwFNhsY771lLOAaLRnGMG3xnsXTabu6JWA+jiTWl6WL2Arbt1wiYHxdClpm88jpCqhMiG2JYMw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28C17227A8E; Thu, 17 Oct 2024 17:41:56 +0200 (CEST)
Date: Thu, 17 Oct 2024 17:41:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com
Subject: Re: [PATCH] dma-mapping: Fix tracing dma_alloc/free with vmalloc'd
 memory
Message-ID: <20241017154155.GA27107@lst.de>
References: <20241017151055.2806066-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151055.2806066-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
