Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A115CD7E;
	Wed, 24 Jun 2026 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260669; cv=none; b=Qc0De2bythipJc02cgX/J7rLcP30xbeTKopQDgL/D1OxWdBCW65J3GB1bB3vdvllPnTnM4D0v2hntU/Z6KrcPOFOqIpoCnDcYDKpj2IJkWCvBID3idavuXBKTAV9hKQuybqyGbV8KprBcL/+Ze9gqKZ5o6elFzqPGJz8BwgsD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260669; c=relaxed/simple;
	bh=ryJcHuiZO66/Ss73hYBYx4UJbME4NGgLeAnJIOpi25Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fyd6LCYmbY03gGrwNYQkWXDFVCZBGm7we3YyHZlJaHLWjIFhuMrYVJMMgmjEVztFUykDduGfo7oFYOsdTn6J7DOvsS5g5g7zeuMaV9eQxpSiGuwpN+brQyxzqHHyAgMHfqpJEPTDR8YpqF/f5qdTvLeAd6qUGvSRKiNib0GalvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXvxVxws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXvxVxws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C71F000E9;
	Wed, 24 Jun 2026 00:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782260667;
	bh=SiUdj96eUiyr4BhbzuofJTBJur66o4a/5RL9fSJq2OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IXvxVxws71cSuYcwDCt9WHgUE0RC1ito4yx2mEzslgQd20q2YfN0c4QoHFaOBJCDU
	 Xyo1UQ8aZtgZhdxdQzNuDoubb/ourJyqEhbw9+0/9UOkfruL1ZxSN6qpsqOa4aoRQl
	 5E94eor/272IwG3flshyW9MDAawSKJK+F/EA3CFkJcvQp3RY4LFMbFklC3H5nQK6+X
	 DlWzH0eeIhitQei5fex35WBxUgCzINOuMaexo3vrH8mkH4s9g3SChhLC0yrTYUi4c9
	 +I4ErBepbFxTp8QcvSxBRM02YhB3z7ZCmTWPe7mNSsT/zV4kyTV9cVE84kD5Uo6suK
	 AmF09jqqz6DhQ==
Date: Wed, 24 Jun 2026 09:24:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: ignore id update from
 btf_type_skip_modifiers
Message-Id: <20260624092424.f73dfc7be85f61bd45f0748f@kernel.org>
In-Reply-To: <20260623132937.3494895-1-martin@kaiser.cx>
References: <20260623132937.3494895-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 15:29:32 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> We can pass NULL as id pointer to btf_type_skip_modifiers if we do not
> need the id of the returned btf_type.
> 

Good catch! Let me pick it to probes/core.

Thanks,

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  kernel/trace/trace_probe.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9b3219e755cb..78bca283763f 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -360,9 +360,8 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
>  {
>  	const struct btf_type *real_type;
>  	u32 intdata;
> -	s32 tid;
>  
> -	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
> +	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
>  	if (!real_type)
>  		return false;
>  
> @@ -379,14 +378,13 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
>  	const struct btf_type *real_type;
>  	const struct btf_array *array;
>  	u32 intdata;
> -	s32 tid;
>  
>  	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
>  		return false;
>  
>  	array = (const struct btf_array *)(type + 1);
>  
> -	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
> +	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
>  
>  	intdata = btf_type_int(real_type);
>  	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
> @@ -589,7 +587,6 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>  	struct btf *btf = ctx_btf(ctx);
>  	char *next;
>  	int is_ptr;
> -	s32 tid;
>  
>  	do {
>  		if (!is_struct) {
> @@ -600,7 +597,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>  			}
>  
>  			/* Convert a struct pointer type to a struct type */
> -			type = btf_type_skip_modifiers(btf, type->type, &tid);
> +			type = btf_type_skip_modifiers(btf, type->type, NULL);
>  			if (!type) {
>  				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
>  				return -EINVAL;
> @@ -640,7 +637,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>  				ctx->last_bitsize = 0;
>  			}
>  
> -			type = btf_type_skip_modifiers(btf, field->type, &tid);
> +			type = btf_type_skip_modifiers(btf, field->type, NULL);
>  			if (!type) {
>  				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
>  				return -EINVAL;
> @@ -759,7 +756,7 @@ static int parse_btf_arg(char *varname,
>  	return -ENOENT;
>  
>  found:
> -	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
> +	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
>  found_type:
>  	if (!type) {
>  		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
