Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C240DFD0
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811736; cv=none; b=sXGyeMRwxcoOhSsuRbMe2SxHNtLAUWALJfAnkpKPosV/D8lvBrjEG8oSKZK6Lffo7C/gYbcT4yMOPHy+tXR8ClCimmU5/jADVZogI4qSJXpFZZfMTlLU9Gt1E/8SrAVpCgkzZDD6vpN83tPJt3jcDwLcb4RG0KiJvqjWX2AJbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811736; c=relaxed/simple;
	bh=fVpArD0hB5S8xTPoPjdIKgivbXLxnFmTD6v2RToci0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4FJfyDgeX/1KEnZ4a+VcuZ3JiLf+O/dHcG1l7KKv6331sTzotlwrCHKc7uccvfXJq+arXfVWGPdV6k9pxZXLRkSCYFMnDQsklL2Gz99drDx/GdTWXbkd0O38NknqxVygUNiNvpt9UsjrhGKC4h3A3zcmkbTB2s4X2yL2wc2RQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mnKOyOFU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnKOyOFU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=814WAN/LXF+0RpMK87ve3wk+gkrkIJkpXaVoqtCsqF0=; b=mnKOyOFUCVHyehHoI0Hn5txKbB
	ei1JzNeaP8NMbSLzW0P7kwqrI2D3vcUfVMlqkH4Pc5+3+tX2ADIVqzy7vXCAkq9Rp1TnvWG3LTeoe
	sztvTzH4VwPuERcrfVHtUOkPMborFiEOB29SxEUfLjeWmYynRlaAInXZjY/Rmw+oBT+TsTUME1ErO
	kq05I1SpXYwovWCZdy+IpwE7eOW0GlvlzXNHJOdnMiQBq2YtebDbKdiI+CircgDcxPJhOmAKznP/O
	rKdrdg54mJnWJXhQKZQ+lI/kxx3wA0TpGXsg6P388tSW8Wp1hDaZBa1rJJgA9LOe5y9FJgUu7+ArF
	HiSIGzwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJW2b-0000000Gzy1-29vQ;
	Sun, 03 May 2026 12:35:21 +0000
Date: Sun, 3 May 2026 13:35:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, kasong@tencent.com,
	mhocko@kernel.org, hannes@cmpxchg.org, david@kernel.org,
	ljs@kernel.org, baohua@kernel.org, mhiramat@kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH] mm: vmscan: rework lru_shrink and write_folio tracepoints
Message-ID: <afdBCWopkfF2ow-Z@casper.infradead.org>
References: <20260503085705.3276-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503085705.3276-1-qiwu.chen@transsion.com>

On Sun, May 03, 2026 at 04:57:05PM +0800, qiwu.chen wrote:
> Currently, reclaim_flags always contains RECLAIM_WB_ASYNC in lru_shrink
> tracepoints since commit 41ac1999c3e35 ("mm: vmscan: do not stall on
> writeback during memory compaction"), which is useless for debugging
> memory pressure issues. Other RECLAIM_WB_* flags are not used anywhere
> else, so they can be directly removed.
> This patch reworks the lru_shrink and write_folio tracepoints for better
> correlation and analysis:
>  - traces each folio lru type instead of reclaim_flags.
>  - traces each lru_shrink with reason.

You also removed the printing of the folio's PFN.  Was this deliberate?
If so, it merits a mention in the commit description.

Also if you are going to do this (and I suspect we should do this!)
we don't need to do the folio -> pfn -> page conversion.  We can just
store the folio pointer and print out the folio pointer.

