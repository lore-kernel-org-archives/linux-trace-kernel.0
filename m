Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949193F7ABD;
	Tue, 24 Mar 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366856; cv=none; b=IvqdX+j/yUELRiEvGhRL0tZp+QuW0Ugeikwp3lNWnJoDppibNesuQONul2+39X6E50xLzvlAYmayfw/+GS0DuiRKARuO3TrBqvdLP5tlzeQd9vHEzKQ3FWeQ5L1AUf1qwVEAvr4JAhQy6yVYJzhoydYkO9xmb0tdSMdNHn7Fk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366856; c=relaxed/simple;
	bh=jWFuQ3Kdo1D0JtKs3AolKcKwxPfsEtZJqWSbcU608hE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yk4J2+yb7VqTVVsPPCOpl39BzKs7Sg76QT8iP1DfTTgmnIhI6ylneU4AIRDmr+SFgC2rSDdob/41h5k0OCThxIoMp1EAfVwV82dUaShyMWsE2lGLpM70WQSyxmsxBdgmTh2wDwtkUnjf9Mr0I5RRU1N+K1iCnkQL4QEfNJBr988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz27DkUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz27DkUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B04C19424;
	Tue, 24 Mar 2026 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366856;
	bh=jWFuQ3Kdo1D0JtKs3AolKcKwxPfsEtZJqWSbcU608hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gz27DkUeBt4CJlk0LdOCTfmZicUy+pCcH95s+Cee0mhqg67sIhlIqTt8F51bLBnCB
	 k/LaWJnCzT+N6tyJkcUNO0fXb3P7oJFsVVxHJyLbQ/7fODylz+p6aUWTLVD+1gJxX5
	 Wv1JChAVZ4OGvlDRTiO+mhReJTsOahWmDVuVcrRJMpTfBEoXHlonhuik8NVsNuDCD/
	 no6vvhkVRmz8cQF9Ez96gCNkB8Bo4wXo3pGMWN1jIXN3AwNuoMsg4WhLBj0x9/dtmt
	 WeqP0AVYXNGMWiO3EeOiS4zb5DhLIOdiwdGpt7iU5k1VNEtzJj6s7nKPUZvANYNI3B
	 +pAefur/kvxEA==
Date: Wed, 25 Mar 2026 00:40:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: do not zero out unused fgraph_data
Message-Id: <20260325004052.6f6629965addb617728eac92@kernel.org>
In-Reply-To: <20260324084804.375764-1-martin@kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
	<20260324084804.375764-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 09:47:08 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

> If fprobe_entry does not fill the allocated fgraph_data completely, the
> unused part does not have to be zeroed.
> 
> fgraph_data is a short-lived part of the shadow stack. The preceding
> length field allows locating the end regardless of the content.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

OK, thanks for update. Let me pick it.

Thanks,

> ---
> v2:
>  - remove the memset instead of fixing the length
> 
>  kernel/trace/fprobe.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a..56d145017902 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -450,8 +450,6 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				used += FPROBE_HEADER_SIZE_IN_LONG + size_words;
>  		}
>  	}
> -	if (used < reserved_words)
> -		memset(fgraph_data + used, 0, reserved_words - used);
>  
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
