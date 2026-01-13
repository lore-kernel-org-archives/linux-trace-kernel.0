Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D51D5CD9;
	Tue, 13 Jan 2026 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265337; cv=none; b=neQMwL1fEkdBCjk3BQU+OWoly2eqljqfXybacSn4+Doyx3dFFGOdzh/vPy4G7R4PL7+asLEJ93d8Y5TSupZydC8wzmZnPrCUzReZ1S6GbriOsHOTiIch4rzS1ZZOHAi3Ln7KtA34wvys+fwceNhIOjuuAvf6q/HR/pZXXidBvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265337; c=relaxed/simple;
	bh=Aq+gnmQ0zLEGsgWSYK5yNjW0gXYlYepejDzECrI9N6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cQZmfqoCIWcPMdLVHj4SwuvEgnNZqbOzQFoHFdR8IjJ4QaFQkXhcDSmVfl5meBuudGX2laB8MY4zSQ2alSNy5+lCerNbls08Hx5ZHLPNGfEBgtq/exClLg3JJ9bVPnYQ0fokrSCQA+xlwiIVz+rVdjne6NZ+6spVlbes6ZPckvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V133pyQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V133pyQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB73C116D0;
	Tue, 13 Jan 2026 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768265337;
	bh=Aq+gnmQ0zLEGsgWSYK5yNjW0gXYlYepejDzECrI9N6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V133pyQekU7i2aCkMi2P8j9CMpcyua80qKFpEEGZal1I/hERzuwPrx09IIwriE0Ud
	 5rI8PUPzxkpDmg2iPAVl3Uakh0O7hQMvq0JWwq2OwBO7QREMoO32Pn4Mg/y/3gHgcB
	 BiKeVdl2VsLvSho8E6hpLzPm2VtIF5rtPfh4lDI5oO1Bjm0k6jjfLXkPJUTz+cdI0/
	 TeJXiqPYVxE538IxZVb2umeE81RmdduvNsCIe/jmctmSzjz+Uxs4kAcBRVMjDyS7kU
	 f+JVEQShP731gFAevHjS3S0fWeZkRviu8wmSKXoKClf4LbxO23mxyYa8BHFHCGtw7T
	 kn+rp1Q/1rNog==
Date: Tue, 13 Jan 2026 09:48:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Donglin
 Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH] function_graph: Fix missing FGRAPH_ENTRY_ARGS() call in
 print_graph_retval()
Message-Id: <20260113094853.743c53e5c1d3e2b2ab79b24d@kernel.org>
In-Reply-To: <20260111143318.917945-1-dolinux.peng@gmail.com>
References: <20260111143318.917945-1-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 22:33:18 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> Call FGRAPH_ENTRY_ARGS(entry) to retrieve the correct arguments pointer
> when displaying function parameters in print_graph_retval().
> 
> Fixes: f83ac7544fbf ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>

Looks good to me. (other print_function_args() using this macro)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/trace_functions_graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index b1e9c9913309..1de6f1573621 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -901,7 +901,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
>  		trace_seq_printf(s, "%ps", func);
>  
>  		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> -			print_function_args(s, entry->args, (unsigned long)func);
> +			print_function_args(s, FGRAPH_ENTRY_ARGS(entry), (unsigned long)func);
>  			trace_seq_putc(s, ';');
>  		} else
>  			trace_seq_puts(s, "();");
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
