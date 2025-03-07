Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DB2AD18;
	Fri,  7 Mar 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306446; cv=none; b=odWWJVti43Zyvc0rhm5FvEZ3fjG76BGRdYUyh6uzGaYKcHAX9a7dDYHbhOqvAV3FGhAPTB25lGRedJpooAQMjjacM6rjGJsXKV0qe/imVwIDsl7sxm/UZQ88QGP9CQF/InVQJxkfAUl3+Tsxx03vf47Z0Iw6XSWIaEtehAIz3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306446; c=relaxed/simple;
	bh=eHKuGCqpF2pqQ1dNX8P2lIGDyo11OwdSx/LGLEM87Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1zK9gg3TERTODh7a3OEbirXNrgBWKlH+ie9JBL1e1Ub20zndEtSLjFBms5VSpwyjG028CaIQmOnWK7dE9yea4zPJeDg/z7e41RRXBjbInyKeTZQ8ySHNUovxdwKLVSIISMpk6JkN3WDMyIF3fiv3FAcbDCov7v5hcn4oSezMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04BFC4CEE0;
	Fri,  7 Mar 2025 00:14:05 +0000 (UTC)
Date: Thu, 6 Mar 2025 19:14:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probe-events: Cleanup entry-arg storing code
Message-ID: <20250306191404.69b0877e@gandalf.local.home>
In-Reply-To: <174099254917.619976.17555764627143910556.stgit@devnote2>
References: <174099254917.619976.17555764627143910556.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 18:02:29 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +	/* Search the offset for the sprcified argnum. */
> +	for (i = 0; i < earg->size - 1 && earg->code[i].op != FETCH_OP_END; i++) {
> +		if (earg->code[i].op != FETCH_OP_ARG || earg->code[i].param != argnum)
> +			continue;

I wonder if you can save a loop by changing this to:

		if (earg->code[i].op != FETCH_OP_ARG) {
			last_offset = earg->code[i].offset;
			continue;
		}

		if (earg->code[i].param != argnum)
			continue;


> +
> +		if (WARN_ON_ONCE(earg->code[i + 1].op != FETCH_OP_ST_EDATA))
> +			continue;
> +
> +		return earg->code[i + 1].offset;
>  	}
> -	return -ENOSPC;
> +	if (i >= earg->size - 1)
> +		return -ENOSPC;
> +
> +	/* Not found, append new entry if possible. */
> +	offset = get_entry_arg_max_offset(earg) + sizeof(unsigned long);

Then here you could use last_offset instead of running the loop again?

-- Steve


> +	store_entry_arg_at(&earg->code[i], argnum, offset);
> +	return offset;
>  }
>  
