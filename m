Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD42C032E;
	Mon,  3 Aug 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746306; cv=none; b=Fpf7MZWMGh3vznmZ1yvcC3Q7dmwW8tlfG7l8SvPHX7lGIBDQG0LRXPtmB7hJSMmqT27sQV/2nrZpFeMs210Nmr6bN1Hh+GrlWwXJNFVt1FteNM4QRK0PFl+Azkdfy0tDjjh5GuR+z69Gx0PaKh7j5etMVSNU7E2cUdJsr4BPwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746306; c=relaxed/simple;
	bh=DTlBALtvmvJcbxjQ/u+Yk6iTQLztMzqGy5WCed9Wd78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKUlOEYYFZJXkqkn72pjU4jeAD4wo+Cwn0cZ1qGplg2j7FhHLflGjmXPwl3ZDjSVZRVuFO8z2uASm4WzfMk/xyhFFV2M84bc9zD73mau87E77KWcs5X5kzn7hNnLkJTpsFuyThR0yRbeq6+vRljJYPpmTpHlRuRIdV7lxKS+014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iGOhIT/r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGOhIT/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8qzlmodlEBIbxJqlmoucNkpiYME5cpAY3OvwuNsbT7w=; b=iGOhIT/rZCy864LHT8ew/VfJLo
	OLuWnwA/E94in/is4ajYmq1OpX0LjjLy9+pRvB3su3w/QlwNEtPcbCebh/kcwZeRHnblHF/txAdGP
	icul/0LVvnbxoMBrGl8S+S3orrIFPE6Iz9tOclMhcMb84nN2W+Bxx359psgjOIckgOny0GXyvcLMY
	ZwP8dcD2eM13KpVOz1jrqyDVbPdwd3T+DyoN5cy+JcQD4/Q80xhSOcG6Ugl/w7DFEcptDVqsc4Iar
	0x6jB5f3BtZOcDUxzOz35yU5NHePIe4qcWjtKh27s0qHS29Q6t7Ft3fwMrcH0+/M6tctvr7znAPe7
	B5ivSTCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqoBE-0000000BI5c-1vwb;
	Mon, 03 Aug 2026 08:37:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2BE9301127; Mon, 03 Aug 2026 10:37:50 +0200 (CEST)
Date: Mon, 3 Aug 2026 10:37:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] tracing: add ref_trace_final_put tracing
Message-ID: <20260803083750.GA49951@noisy.programming.kicks-ass.net>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>

On Sat, Aug 01, 2026 at 06:59:40PM +0800, Eugene Mavick wrote:
> When debugging use-after-free(UAF) bugs, knowing when the object reaches
> 0 references and enters final release can significantly aid the
> debugging process.
> 
> There is currently no universal way to trace this information.
> 
> This patch series implements tracing of the final puts in the
> most widely used refcounting implementations,
> refcount_t(and thus kref which uses it), and percpu-ref.
> 
> The tracepoint records three fields:
> - caller: function that called the refcounting
>   function(refcount_sub_and_test, percpu_ref_put_many)
> - ip: return address of the trace wrapper macro call
> - obj: refcount object(struct percpu_ref, refcount_t)
> 
> Signed-off-by: Eugene Mavick <m@mavick.dev>

I'm not sure this Changelog is convincing me. To me this just looks like
more weight / bloat without benefit.
