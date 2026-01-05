Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021880C02;
	Mon,  5 Jan 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579692; cv=none; b=FGFRokoV+B6hSGwa2QJZ8VdH0TD3TC0DC7baw+pNqAKLW6yhsb2GoEZ2yUNVnyXdvwmfRzPD2Nya51m7QMBdwN3AVk9IsQ11d+lTlNQjlLpyck3m9AFc0ZStuQQj0W8hU621sk8c2VjXU59ZusKotRWfkyTxLp1eYz4b8ds63sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579692; c=relaxed/simple;
	bh=PRqYMdfaPitVU1jWFdieq6wcJDvdgbo6m0C6v6BTkd0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XZgZ1VynTseKDHjPYoMzH4Mp8sSWo7SlPcpHohRH/RrmrnM2+ggFYYe9LITsIHcBxl21XeKjCE5sw7OcDjWCkvyF0rnQSaUgz2bWrHYBhnmRAAmD1MZYZSDXVhHo0GWVjPf2gSJmScwJRwFEYNU/84gN8h8rqWQ+wq4ZZlr06eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK/P6oqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK/P6oqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685E9C4CEF7;
	Mon,  5 Jan 2026 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767579692;
	bh=PRqYMdfaPitVU1jWFdieq6wcJDvdgbo6m0C6v6BTkd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uK/P6oqVfkea3hi+Iba3CLfxSBGUYIqM3BPO4M2IFyFdRRbvak7xXySalK2ARfCgq
	 rQMONXVxeedo6U7EnAxsyYKYT4ZdZmQFuIhd+gmYYK7Hw3Q0aDibb3MkDn70XcVnz3
	 6OyfqZBOGkSk+JrQR71nkugUYYk5IvIt1A7bSpRCIGHfa55WIsC/XvCQ6qiAfSH9Mv
	 OlH8ci7dudJVvIru9/UJ9i4oi9ayxV9EsL2bBUb5bqlT7uxkMDJbvCXv5Y+saMJ044
	 YOAtGL2hXYI8TINW/vVcAStuod5e7AfhUA6PbxoHFJuuzRDBwCRg+fTe4Yq9BTL+WG
	 bwc8xCOLvEMeg==
Date: Mon, 5 Jan 2026 11:21:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Subject: Re: [PATCH] ftrace: Make ftrace_graph_ent depth field signed
Message-Id: <20260105112128.3685d2a94ea154107fe26887@kernel.org>
In-Reply-To: <20260102143148.251c2e16@gandalf.local.home>
References: <20260102143148.251c2e16@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 14:31:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The code has integrity checks to make sure that depth never goes below
> zero. But the depth field has recently been converted to unsigned long
> from "int" (for alignment reasons). As unsigned long can never be less
> than zero, the integrity checks no longer work.
> 
> Convert depth to long from unsigned long to allow the integrity checks to
> work again.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aS6kGi0maWBl-MjZ@stanley.mountain/
> Fixes: f83ac7544fbf7 ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  include/linux/ftrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 770f0dc993cc..a3a8989e3268 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1167,7 +1167,7 @@ static inline void ftrace_init(void) { }
>   */
>  struct ftrace_graph_ent {
>  	unsigned long func; /* Current function */
> -	unsigned long depth;
> +	long depth; /* signed to check for less than zero */
>  } __packed;
>  
>  /*
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
