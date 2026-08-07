Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C441A785;
	Fri,  7 Aug 2026 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097128; cv=none; b=DYbT+UB8jFPLdUg1W4boLLlwuwjDXYsR/T9BIe9e88H1Hv/NJyyXMw2gXDe6wcl683iZrt9/xrRODkw7vgCUf+yZsVewdr5zwSmrvpFgfSi/aGfU1qYMIQVWrijb9s9ixftc82eOzzdpPeDoKKPSA1BfngG0GkU8bqPnOGMKLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097128; c=relaxed/simple;
	bh=pWhzPz9pG8V/xnwbSxJnHEv7J8ONdvCcvoOMqxX4X7I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n6k6UskNJeX8fGajI03MURJEiGToMpXB3F2AX/lr0B5R2TeviPFlFYFXfwl7lh2NqP9FfOxe+dGcKsxaOKxmtk+JriT2D56HtEW6GKe9KVgJgbdqHDIbAjpvy0oyXocqNl2isuYM/j2N1GiURVXPF9ZPuQpCCVRYQbFAVn4WpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ve+zfq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ve+zfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC56E1F000E9;
	Fri,  7 Aug 2026 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786097124;
	bh=XRsVCEY3RFLcrC1FneE2x9oeKtYU3MiMWQt9TiuNQno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U+ve+zfqkMqbpasdhyn46vbhY5YKyyYw6h2HH1QwtS4Nkw89RVJQNLGtZMzd5F5PS
	 q8AJmj2Pc3duqZ1Q8ktNOeRAXnmxX9iaojMEAulCB1klirLiOmm/nDyxD4SYpqvyvt
	 2zjXVsVRGplesZhOmtzaiDQbCFeC4C+cJUepB7bLusTRlaVOVpJUYvbvsAt4JUQErj
	 +Jyiu9/giAkkB8qge8U1C1fJTg9prTIX2p6wJZqAHw4+z9OK3MiMyhn5pd40GyF34d
	 lJkwNrBeA1ntpjBdq9WQTGEs2tAtmj8G01Xq2vvonJDwlCYT6bQXPOs8sqr5Xo3nW1
	 Bct5bApm7k6KA==
Date: Fri, 7 Aug 2026 19:05:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix logged instance name on creation failure
Message-Id: <20260807190514.bfcdac0afee5c155031da2cf@kernel.org>
In-Reply-To: <20260807085423.4175161-1-vdonnefort@google.com>
References: <20260807085423.4175161-1-vdonnefort@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 09:54:23 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> When boot instance creation fails, the kernel incorrectly logs "(null)"
> as the instance name because strsep() consumes curr_str entirely during
> parsing.
> 
> Print the properly parsed name variable instead. And while at it log
> the error code.
> 
> Fixes: cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 01a5e87af299..26ae682021c8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9726,7 +9726,8 @@ __init static void enable_instances(void)
>  
>  		tr = trace_array_create_systems(name, NULL, addr, size);
>  		if (IS_ERR(tr)) {
> -			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
> +			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
> +				PTR_ERR(tr));
>  			continue;
>  		}
>  
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
