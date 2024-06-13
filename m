Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545D399;
	Thu, 13 Jun 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289821; cv=none; b=PS1oML7q8f8unvNgLHE+TkqkyH8r9ovoHmO6Gj2aYmhPkqbpZDn69LNSE6Mg8vnk19aIVjEB32ZBUdqgw7sf/LDIEUSZrg6YP4w7r4kmCyATV8VQv+TAGc0ThCaExJaNVaYSxMvPyDweauVVh3nj81/+VIuw0uxT/nuknSqpKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289821; c=relaxed/simple;
	bh=U2lp9FtQVPZjq8CdUltsKztb3aNzK34AI2dW7bwkUFA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FLZN/ANtZ4GvXfDbmaQ8kVYWeIUEFe7surlh/gG2EdTgktttkM0zH0Kkbdjnd47BoI2eJqfQ8GvfSObuQ/2OuxLpEvyaID6QTDf43klqbrmy0UsxWIiUgePzeg623tTsTBQY/XUMOHu/NLB6d4TGFGdrMnZNAGlx5/m4ekomCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb72+7xO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb72+7xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E64C2BBFC;
	Thu, 13 Jun 2024 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289821;
	bh=U2lp9FtQVPZjq8CdUltsKztb3aNzK34AI2dW7bwkUFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gb72+7xOsUioNvlfIMYnfYpFkYPIAFwYVTWDro3Xhj9C3l6dKw1P+l+FEUMNJVTxP
	 4cCQ6ja8fXMPXI5Ws7i7Bv41+TO1UKMEb27xGC+6xHAOJEolkmVUz13zHajOLyaGcI
	 znLtHPBFvHtTC/XnwYa+5XewLAEzrBd7JFDu01z8hKys+lBk/h5Tz9edw/sAS6bryR
	 QzkyIyvbGLK6nwgv0rL7HCLaZ+fCY1Th30sTehEI/YSh3OzULykG9aFvsqcPT7o8sY
	 00e/ty+6MfKpi0cFYwYyJSCS+tIZSqi5JyPpeNB4YyptYuPsxcDdSB9CIukKnoFjUR
	 58crVjJqaQq7g==
Date: Thu, 13 Jun 2024 23:43:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Naresh Kamboju
 <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] function_graph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-Id: <20240613234337.cdd71759ab3d93d22eef7cf1@kernel.org>
In-Reply-To: <20240613095223.1f07e3a4@rorschach.local.home>
References: <20240613095223.1f07e3a4@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 09:52:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In function_graph_enter() there's a loop that looks at fgraph_array[]
> elements which are fgraph_ops. It first tests if it is a fgraph_stub op,
> and if so skips it, as that's just there as a place holder. Then it checks
> the fgraph_ops filters to see if the ops wants to trace the current
> function.
> 
> But if the compiler reloads the fgraph_array[] after the check against
> fgraph_stub, it could race with the fgraph_array[] being updated with the
> fgraph_stub. That would cause the stub to be processed. But the stub has a
> null "func_hash" field which will cause a NULL pointer dereference.
> 
> Add a READ_ONCE() so that the gops that is compared against the
> fgraph_stub is also the gops that is processed later.
> 
> Link: https://lore.kernel.org/all/CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com/
> 
> Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks.

> ---
>  kernel/trace/fgraph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8317d1a7f43a..fc205ad167a9 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	{
>  		for_each_set_bit(i, &fgraph_array_bitmask,
>  					 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
> -			struct fgraph_ops *gops = fgraph_array[i];
> +			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
>  			int save_curr_ret_stack;
>  
>  			if (gops == &fgraph_stub)
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
