Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D586329;
	Thu, 21 May 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373826; cv=none; b=l+3fH2Av0k6KDSrpoIPNH5ny2rk3eDvja+6cLAtFtnyuLFbwqMvYCvqmVXfVnv2GJFHNzCrwDTkAu0NIXeMjyLcJonW4yFrYri+8ZkdzAT0fJAyVzRYCekJ5j7igyUaIJ/YcS+Koqj8ilYeh8ThT/Ie18cYcE58/VOHOyj+HhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373826; c=relaxed/simple;
	bh=u3n5Cnm1bLNXTDndnViTeatSM9lnROZ/1rp1No3paXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLgRkEa1fAJZeaMVinCks+p1LsSnzm4FIbQiP1LWPaMi5IliBVCNb1WHIc/Rk8zFB7tvW5ZjciCRF9xQG4lQguT4uhh7pIYfAF6T+R+IICTWyLwuprXQi+10vQW4BJ1u1XJhPhtte+PiAk0Lx28JA+bUFEtwpLbq8v2mBbD15fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 9CC2C140679;
	Thu, 21 May 2026 14:30:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id D6D0517;
	Thu, 21 May 2026 14:30:15 +0000 (UTC)
Date: Thu, 21 May 2026 10:30:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Return ERR_PTR() from expr_str()
Message-ID: <20260521103036.22765b79@gandalf.local.home>
In-Reply-To: <20260521022817.38453-1-pengpeng@iscas.ac.cn>
References: <20260521022817.38453-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D6D0517
X-Stat-Signature: ekqkuieqhcfh8cyx441zb1uz6tbiqudb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PDuUaDVlHqBM0GEkBaPWTvTP345iU4Q0=
X-HE-Tag: 1779373815-705771
X-HE-Meta: U2FsdGVkX1/TNlSfhchnLnjifYkWiIKh9HI1o+nGXJoMOCeAg1E+aRr/fBh1XOPYJ6MkKYF/4rqimceAUjC+Ws7JqMdSz2U7P+87O5gapH01ceaFgUOXTrhMN18LYONm0+GzNEcFqnLFXUglwqhgFQnMs8Ba2xTQ4QsC6oURMJmyA1/T1vrEpxgBvyalM4v1TCLT8Z4it+xUFMOk/Zp/j6nmBVh4jx30JXoski4srBz0aOE5zsPUQKI+BkUaKmUnKxRk1f2yPeDf5BmTT+OXiYLCtstaoGLCtZNn+MLwiYO5+FyfBGPuo/Zbx8jlMFBo

On Thu, 21 May 2026 10:28:16 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0dbbf6cca9bc..0b33bb8ef6f7 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1769,18 +1769,18 @@ static void expr_field_str(struct hist_field *field, char *expr)
>  
>  static char *expr_str(struct hist_field *field, unsigned int level)
>  {
> -	char *expr;
> +	char *expr __free(kfree) = NULL;

Can you split this into two patches.

1. Change expr to use __free(kfree)

2. Update to use ERR_PTR()

as they are two distinct changes.

Thanks,

-- Steve

>  
>  	if (level > 1)
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!expr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	if (!field->operands[0]) {
>  		expr_field_str(field, expr);
> -		return expr;
> +		return_ptr(expr);
>  	}
