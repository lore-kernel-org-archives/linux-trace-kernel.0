Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA5368264;
	Tue, 23 Jun 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211964; cv=none; b=FNBwK7Pd9VueVDeEpsz+EZOgBsqW63TftzwSYetfJ6oA4wOpE38p0DBjMEgn/JRNd4tjgixQwInB0HBySbpl6Z/uZUsphk1xf4bIcXdEmU/1n5lpzZ7HY98lWhiXQbYU9slKZzFrbiLEgtNAYoXFxXbcW/Y6uEpaCOFLPPdRRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211964; c=relaxed/simple;
	bh=9WzKmySuQAy2N/ifFCthF8yCoFX23Xv3MS24TwSFmJc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MyAl7KQKn0Aas4Gr3yBsagsgXPJBvOSvl9APJXJXaCZi/713/7ERpXhtyJ3yDKOYEX9NRDwHZ00RBCkJIK9kJFR/zrK0oEE65JgmFnKQxtYeiZlgBMkcaygB/NS9aTc6ui3NaYJ116x9Iw0Q91RX0ydAe64Ti8DqZST+x8htww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPjXrjQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPjXrjQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FF1F000E9;
	Tue, 23 Jun 2026 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782211963;
	bh=EsQY7oKaEWWDUacGiSgNdyZjupqHSih8ea/0BBrpwvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XPjXrjQYP3OFnw6qhW4kJzHde4V0gqawMSrhXlGTUNTpMJUQlX742PrVe2p883yge
	 VettDIv4z8FSio4H7pVUElLbF8EDOYB9YNagYRd8rc9LWnW6j8dJpZiwloLzU4/scl
	 r1HtNpk5Y8rd3vdef6N0n0+a88MPADSwEw9ObhvcpdHt8gjBwzuwfrKBepGiFxVgob
	 9sOu8x5iIF4VhU+8x8NXjUso61hXzEad5SeAeeNKFV1GakbX1wIcKKL+S96mzae8ch
	 K4ndvhyUxjZH6AiOhTR2PtlbXovlowP4WpHMEAwIk/dC+lqi4ox8A1aIblgU34pJrO
	 dAaw1kCzlV2eQ==
Date: Tue, 23 Jun 2026 19:52:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yudistira Putra <pyudistira519@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: fix typo in invalid variable error
 message
Message-Id: <20260623195239.4b6f10934311b98749016929@kernel.org>
In-Reply-To: <20260622152304.88345-1-pyudistira519@gmail.com>
References: <20260622152304.88345-1-pyudistira519@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 11:23:04 -0400
Yudistira Putra <pyudistira519@gmail.com> wrote:

> Fix a typo in the BAD_VAR diagnostic emitted for invalid $-variables
> in probe event arguments.
> 

Thanks, but the same fix are already picked.

https://lore.kernel.org/all/20260507081041.885781-4-martin@kaiser.cx/


> Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
> ---
>  kernel/trace/trace_probe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 15758cc11fc6..0f09f7aaf93f 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -511,7 +511,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(NO_RETVAL,		"This function returns 'void' type"),	\
>  	C(BAD_STACK_NUM,	"Invalid stack number"),		\
>  	C(BAD_ARG_NUM,		"Invalid argument number"),		\
> -	C(BAD_VAR,		"Invalid $-valiable specified"),	\
> +	C(BAD_VAR,		"Invalid $-variable specified"),	\
>  	C(BAD_REG_NAME,		"Invalid register name"),		\
>  	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
>  	C(BAD_IMM,		"Invalid immediate value"),		\
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
