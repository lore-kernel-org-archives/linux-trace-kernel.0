Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE021F30DE;
	Mon,  7 Apr 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037173; cv=none; b=p0M27UJsF7yb4F0Rf+nml9YEIvaoowHkcl9+OY0aNBSFNaZMvadr4QLOud6/waMwBiorRk/PQtmLb89rJde2wmeU7+aMF3YBR1RIztXM4kV1ZbGG4mcpH2gfkjGVluY67lqNLTXrCRX3k8V19j5jhHnj5kd1H/LXIu/hmG90zpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037173; c=relaxed/simple;
	bh=pdZC+n3I/tFEuvosD6rfBo76t/HztMAlcqp68U2CG7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMUgyGP/R+cDM0CHVqhFhW4Iad6e/c1rJfaotJXcrOnr2bxO7N6WJvPFMaEyAJQ+sNBSBnI7BARHIW5fVs6xQRch8Qz57RPxUWhd2GV8HqLYFdkrMSLeLZQ72QYz8oeE1P03ym+2VLmFwyIZh4FEDENDk27lDGeLZ7NrT0sw8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF64C4CEE8;
	Mon,  7 Apr 2025 14:46:12 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:47:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] tracing: Move histogram trigger variables from stack
 to per CPU structure
Message-ID: <20250407104727.32c1eada@gandalf.local.home>
In-Reply-To: <20250407111551.507e6e2a683a5028bcf62a2c@kernel.org>
References: <20250404144008.0c47e4d7@gandalf.local.home>
	<20250407111551.507e6e2a683a5028bcf62a2c@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 11:15:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +static int alloc_hist_pad(void)
> > +{
> > +	lockdep_assert_held(&event_mutex);
> > +
> > +	if (refcount_read(&hist_pad_ref)) {
> > +		refcount_inc(&hist_pad_ref);  
> 
> nit: If this always runs under event_mutex, do we need to use atomic
> refcount_t?

refcount has a bunch of debugging that will trigger if the refcount
goes bad (negative and such) so that I don't need to add those checks.

Basically, refcount is for refcounting, and this is a ref counter ;-)

It's a slow path, so I don't care about the added overhead from using an
atomic.

> 
> Others looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve

