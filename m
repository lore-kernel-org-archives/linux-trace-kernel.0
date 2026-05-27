Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B2481DD;
	Wed, 27 May 2026 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843891; cv=none; b=DNVUOLKjBNdSB1TvLdPeuPjXCJe6jzPs7bzfBATC2yM4Zk/+UEa23ODcETfgitLuUSQ1zdSEggSc0czTB5Oem8AVydezb1+6yh7v9dSBGyZdeBoLbbOQ46W8lEeMldswy/VVGpdTUncUPEg6nbFzqBQFD+GD6JVq+jNJUmwO8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843891; c=relaxed/simple;
	bh=pPz+b462ThWjoXbK9yZxyzpewrcj55IPvr2zZt7NeZ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jov5HJ5mVl1TBz4QgDzJnW2De5i0g0SN0daG/g+60z8iItEnisNmWDp0SugRUDLse6+LBj715G1KJIMUKyT4FzTCMvjFbVJWrObCbyXoMGpPp6N+BGBHiyjOd2spRa9tB+Kg66oRolqiHKKqRX5RqB4pKVpwvTsEaB6nb2oXE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh0WcNoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh0WcNoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAB21F000E9;
	Wed, 27 May 2026 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843890;
	bh=mBpIOoFAXc6kbOl3FB93pThLZ4IQ9WjwpSvmdCPOwYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vh0WcNohkb2Z2WOlgjKhB68TAc4bk1mc03wHk5AXKxPLN9izzlL+fmVIqsVdsc4Hw
	 HBSvJNNa/HOzjFhojbPPrwMH2DonfcZCu3O4oWROdv5AR3oMkxk0C5uv0Si455gMIl
	 OTYdTdKTtpTPSVSrDo98nHiLhVajKtG+TSG9/z9rvYbguxlwggZoZHVzCHnPtuRpLB
	 R6rgMquXs0hExc1YLSYPvFQtnmSk1dejMdPwQ9BWCYc1EamiTyPy5bUrdmFVz2Cj8w
	 C+IjggJXtr2TwMhcpkPVHMlIqr05fgzxQuIL75F+QDvrXICCAcWUL7EYNsGNaPcc2A
	 K6WmDum5DjISw==
Date: Wed, 27 May 2026 10:04:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix field_var_str allocation errno
Message-Id: <20260527100446.d7e69b7dd8fc8f43f8b66059@kernel.org>
In-Reply-To: <20260526095022.1330107-1-pengyu@kylinos.cn>
References: <20260526095022.1330107-1-pengyu@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 17:50:22 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> hist_trigger_elt_data_alloc() returns -EINVAL when the field_var_str
> kcalloc() fails. Return -ENOMEM instead, matching the other allocation
> failures in the function.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: c910db943d35 ("tracing: Dynamically allocate the per-elt hist_elt_data array")
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index eb2c2bc8bc3d..17fe13e12a4f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1680,7 +1680,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
>  	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
>  	if (!elt_data->field_var_str) {
>  		hist_elt_data_free(elt_data);
> -		return -EINVAL;
> +		return -ENOMEM;
>  	}
>  	elt_data->n_field_var_str = n_str;
>  
> -- 
> 2.43.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
