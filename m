Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEC1A2C32;
	Sun, 26 May 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718632; cv=none; b=TK83paJzC9exjiY2PuQx88S2kGwcYIj1Pfy7MvK0sv0oojqkrjE72lheqS6QAfhn14/X259NxGOvxjYShRNI8SkOTkx0llK/2GSBG8So0MhuAqL2zhkdOQiGkKwZJA43/fwdh8sKs+I1wTuyvV/1qUtolclGJzo0kyremA9xDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718632; c=relaxed/simple;
	bh=QKjuM6qyhhJojJ3NC+Cer9ULUtQ6PLmygGkAhHO8PFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W7rNBN9fkym5vlv/j5llIay8i0LibjbdiraaIOlMEBN3YdCKJ5mw9s77iZu5zSVp8zYMXgjBQMDbgM8SppR0pqGyoQLt5LIVnBacyAPeDZvlCJri6p3qAxLZSwlotTE7VHSD6pFbC420gHPzDwM/hJf8c3fhyaOeUMutRb/uapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIsCvxAs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIsCvxAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB7C2BD10;
	Sun, 26 May 2024 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716718631;
	bh=QKjuM6qyhhJojJ3NC+Cer9ULUtQ6PLmygGkAhHO8PFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIsCvxAs64g72Z0RyzjJMvqvGss61cn42Obg0UKT9kraQHQKi2FiYa+X+i0c4Az96
	 Ixaj76lUfJVzxEWSX9XTnWsRh9JKm28tw6SHEIuF/T3s+FamqouIqbwb/P2bL14C+p
	 CG+qiYOW/0aQYwu8YSAVnlftbVXvvDVwYYEEQw2ymHAb5xl4xdOKEveuBCSXv1BPf9
	 jODMz1r7WukDaoZme7p7uQCvQd3RNv0ZBDerrBKitqC66VkYOPbLicLPp3zlukPqp5
	 WzqKr+Q2qEBx9teqt2Hg2/5vvEA8rYFxioCjy3efruLcK3ssocvYKnXCA3fPOKUI8P
	 +IxrpKxgfWCOQ==
Date: Sun, 26 May 2024 19:17:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Alan Maguire
 <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] tracing/probes: fix error check in parse_btf_field()
Message-Id: <20240526191708.860651c915600a535cc2e579@kernel.org>
In-Reply-To: <20240525182131.15740-1-clopez@suse.de>
References: <20240525182131.15740-1-clopez@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 May 2024 20:21:32 +0200
Carlos López <clopez@suse.de> wrote:

> btf_find_struct_member() might return NULL or an error via the
> ERR_PTR() macro. However, its caller in parse_btf_field() only checks
> for the NULL condition. Fix this by using IS_ERR() and returning the
> error up the stack.
> 

Thanks for finding it!
I think this requires new error message for error_log file.
Can you add the log as

trace_probe_log_err(ctx->offset, BTF_ERROR);

And define BTF_ERROR in ERRORS@kernel/trace/trace_probe.h ?

Thank you,

> Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  kernel/trace/trace_probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 5e263c141574..5417e9712157 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -554,6 +554,8 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>  			anon_offs = 0;
>  			field = btf_find_struct_member(ctx->btf, type, fieldname,
>  						       &anon_offs);
> +			if (IS_ERR(field))
> +				return PTR_ERR(field);
>  			if (!field) {
>  				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
>  				return -ENOENT;
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
