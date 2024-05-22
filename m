Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF143AAB;
	Wed, 22 May 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387129; cv=none; b=agXqB6KSZ3i4SGZiCpPEuNmjE8UOVeyhBuTsbReiatQ6odt8FJk3mzEKpd1zkdFcYAAaGlIGGlD2eAQlRDlWrmqmqTzwLtXKexE/3fuSoQSJYCVfeGtjExynTnqQc22BbPvqfALz3BPLoQ8aVrgLTNjEEo9NalBs0SX6R52rq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387129; c=relaxed/simple;
	bh=DDbjOB44ewZWIRltYmOU003Ll0k98hPAJ99V/6Z7rjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFud3ziE6eA+pf20YxHIt/PKg/ot2r/RGEsTWvIlTaaZ1cXU756H6Zrv+RpBPp7P0mutUzPlhQnrTTy03XaaUsyooq/PHEVOuY5MaRkSHORgZiPp+Q+h8YvApejwWYMmFEzc/26dNAtPEgP1FYQ7Qd0227NzAcEPFMAGaFAqpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uEqWCsrX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEqWCsrX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DDbjOB44ewZWIRltYmOU003Ll0k98hPAJ99V/6Z7rjA=; b=uEqWCsrXiGnYASDuZAU5ot6tQN
	XjK1e6Gll8ojSe+3yON3pJfsrV/kkCYvTRBFnNjTzHHovDzW76TQ9M7XXcZxJl+XUGSqoBlf16Z3/
	ws/+xgLky5OQhAsn3kwnQvcJk+AupZuZZKMGcHUQ05G2fM4NbUT1MU27yCBL9e5yt9wzfYdeqEd7f
	5SIqFwucxPtY6LnnqhJj2qtrW01//jNhVTzviw0Z1MPuZJaUsj5V0MODpVAWb0q6O41TT4558Mtr5
	UpW6InBw16BU72NmZLAcfB3Yne9fkNbuFw5e8QnUXbXOmcXrCJHk0h3tgJGNj8infSgJrpr7NDIjU
	ASpsxliw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9mgx-00000000iS5-2uBa;
	Wed, 22 May 2024 14:11:43 +0000
Date: Wed, 22 May 2024 15:11:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Improve dump_page() output for slab pages
Message-ID: <Zk39H2C_wxnbAvvU@casper.infradead.org>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>

On Wed, May 22, 2024 at 04:46:27PM +0900, Sukrit Bhatnagar wrote:
> On the other hand, the struct slab has kmem_cache which maintains another set
> of flags. It would be nice to have these flags added as a part of the debug
> output, and to have a convenient way to print them.

I don't understand why the slab cache flags are the interesting thing.
Seems to me it'd be more useful to print slab->slab_cache->name and
then you'd be able to look up the flags from that, as well as get a lot
more information.
