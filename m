Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BF327BFA;
	Wed, 27 May 2026 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849676; cv=none; b=Nvxq2R+uixk+yZq96+peab9/Ugg5qJ/1L/K/iL3/A+v8i03OrqvGbydGtCXrnnmIYw6diLSc4TWHhQrbtjXNnELrypL0UwdCldRWFNbiyZTOa8aUUtvTSg5dZYj+edKsWcvsyqbxgbd6MsoFndeX/dNEUBcGCjXvvJzsgwRf5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849676; c=relaxed/simple;
	bh=XujwC3PYIxYomenjqTAXiO6L1WIKnXfT40LHEEYD+2Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UjvGtCg5TZzp4DuLKOv6Xw8m8VeRLw42d4hqk93qeK0dGkbNWU36VJ7XSUwPZau91l0K63zzlYI1vXHj88gKxhIszTKmZeArQhPpswuD/35audsGWxxh8tZT/5t/Zt3alRbZdoPQWy8yjoz8NLx4XbYLbaL+9ufJE++X6XPPoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5caHmMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5caHmMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33BC1F000E9;
	Wed, 27 May 2026 02:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849674;
	bh=qOoRqpG9lcpnkF8H2ezO2g/hmDABcA5auCdOP78TrKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g5caHmMWVohcrVoF8Zn9RApO8xwoLdXq1XYHrjy0GER45ctxN/EQKf887zKEwmJb3
	 wgz9UmAth4XHHKjvqXXA7bNxfhUeeCofYf65E4XK4agHfnjoN9PDTxUH2tKNLS8vpx
	 hwZjJZfm0sOwIHXtwDKN7hcSZh8wwILbgwiEtWCRSwjj1WG3qSAqwpL0BYBV1PM5q7
	 lwgoCes4abxCbCFJVvno2un4vO0tBlhQid3m5o9NlbcilXwcMgvnjckd2biEcYOyf8
	 BF1EtI9pOoYGrsnDIDVhPepL7HjwxyAIXGYA7lN38R39czr62smJLZGf9FND9LC0HN
	 mEnFqEfLIr6Og==
Date: Wed, 27 May 2026 11:41:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org
Subject: Re: [PATCH v2] tracing: Point constant hist field type to string
 literal
Message-Id: <20260527114111.e104c4b27a6d0ba5022bdad0@kernel.org>
In-Reply-To: <20260527023450.2137639-1-pengyu@kylinos.cn>
References: <20260527023450.2137639-1-pengyu@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 10:34:50 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> The HIST_FIELD_FL_CONST path uses the fixed "u64" type string.
> 
> Point hist_field->type directly to the string literal, matching the
> HIST_FIELD_FL_HITCOUNT path. The release path already uses kfree_const(),
> so no duplication is needed.
> 
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> Changes in v2:
> - Point hist_field->type directly to "u64" as suggested.
> 
>  kernel/trace/trace_events_hist.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index eb2c2bc8bc3d5..b50f2bd5ff771 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1992,9 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>  	if (flags & HIST_FIELD_FL_CONST) {
>  		hist_field->fn_num = HIST_FIELD_FN_CONST;
>  		hist_field->size = sizeof(u64);
> -		hist_field->type = kstrdup("u64", GFP_KERNEL);
> -		if (!hist_field->type)
> -			goto free;
> +		hist_field->type = "u64";
>  		goto out;
>  	}
>  
> -- 
> 2.43.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
