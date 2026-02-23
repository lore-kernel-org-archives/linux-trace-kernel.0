Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217736EAAE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875214; cv=none; b=XC088zLB993Py6UZyim+1xflRbb29brm/nfGK+ipoXFiDlVjE8B4QWAHGVXUYrwxbOoLQxS2jB9mMGrKslZPqUpMDKfS6pbsZKVgnUiVYW8IojxXNAiby/qNXcBuCnulhaSXgrFgwDZsVYJJe7px/Jr0EMdfF3+aQUWpwiUcYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875214; c=relaxed/simple;
	bh=ZFnoq/GDDB2TwDyS0mA6hBr2/nAa2trQwXigGlx1Hxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsoIj1xRIRojj+CVXVf1xMKCkSsxWtBRCjito7vDcYisvWmhCY7iCr8yx8VM6RcX7wOl9cX5uAQcJE950BdOQJDuE8+hjI3C6tIaQrtD+QWKsM2dKrPPnXeZJopIxU3ZyDyP0UCq9VtlC6bryfEIcWwCHi+nCK4OKgG2XZyc0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YULXbRD4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YULXbRD4"
Date: Mon, 23 Feb 2026 11:33:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771875210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtNSHW/b265W1kLR/SmhQJYrrQY0IXE1Gxp2ymx0KdM=;
	b=YULXbRD4qhttVJj7wp9uK8Mc2g3wq0ncrNWHqsk3xpPUiy1xnYgb3yVWfaDxeF0Zt/Ahsr
	Eyc06LzZ9KCfvEwEWIivVoPDQSUvMMZWZeg0q0eKlQtBPMi3Umu/dTUzH0gGUJOmLCi2gA
	88CBS3hjLB9frMgeob9TPmtqkpObpuY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, david@kernel.org, 
	hannes@cmpxchg.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org, rostedt@goodmis.org, 
	weixugc@google.com, yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v7 1/3] tracing: Add __event_in_*irq() helpers
Message-ID: <aZyrZ5c4dk_eshGM@linux.dev>
References: <20260213181537.54350-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-2-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223171544.4750-2-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 23, 2026 at 09:15:42AM -0800, Thomas Ballasi wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Some trace events want to expose in their output if they were triggered in
> an interrupt or softirq context. Instead of recording this in the event
> structure itself, as this information is stored in the flags portion of
> the event header, add helper macros that can be used in the print format:
> 
>   TP_printk("val=%d %s", __entry->val, __event_in_irq() ? "(in-irq)" : "")
> 
> This will output "(in-irq)" for the event in the trace data if the event
> was triggered in hard or soft interrupt context.
> 
> Link: https://lore.kernel.org/all/20251229132942.31a2b583@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
