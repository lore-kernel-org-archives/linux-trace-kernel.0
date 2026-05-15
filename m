Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48B3F44CC;
	Fri, 15 May 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862263; cv=none; b=oPF+TrsOb2pjgfZYlqCxob5wLDe7v6fTyPMgLxYZ988OzyHk8l1ShlYTzhObXq1+XGrrTjgtpOKaXDqLvw0HXHyNcv3skJQ3bSMJKw75rPPopC/GGYEQkbh/DWX+BmTS949wBIGZEp493LOtRICziwWeDa21kCvEF7W9d4IkQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862263; c=relaxed/simple;
	bh=IIlaSnF+PUo+KOlxc/Uw2xGlmtprytTAEZ3UIIv0qZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIejwYHOxFEP43OfoLdyxx7MN9LEhWzPs8WS72GN3WsVAO2ykmQB5CZyf/3gwl5WpMawoytrsU5/Hxd7zehFuKZmvFsIvRr38+5B2J0e5Md0x+sMtNHNLXjHhpEn0ZYJpgyqEWM9l7PenEa2SxSiSLx/++8Hisvv8DleevNb/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CB9791A0173;
	Fri, 15 May 2026 16:24:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id DA52A2000E;
	Fri, 15 May 2026 16:24:18 +0000 (UTC)
Date: Fri, 15 May 2026 12:24:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Return ERR_PTR() from expr_str()
Message-ID: <20260515122426.1507354a@gandalf.local.home>
In-Reply-To: <20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
	<20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
	<20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7pxhsre6e6wt7kinb77wqw76h1j7joo8
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DA52A2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/RGKtcx+ksRb6A/8uzy86Omnp7GUBunMw=
X-HE-Tag: 1778862258-265188
X-HE-Meta: U2FsdGVkX1/i+fX8LELGrpgD5AwiDDxyAOGEqli6BZUtn8QQsq0dzwFQjcF/eBozBylm3oO2toyuN7rIc+BSzum4qAAnMzKe0UJm987yYFVlLOYGmJP7VF31oV0orm+Q8Lg5+PXsTtiep/1Kezr7aSYoajtBnB4usBV9e001b/yNrQfZjBgWJ9G2mgIo45iq+Zg2LMzv5QIK4oPI5v18XKC/xJWex0y79iYY1rHAJv76ePhVsJawdseLdUbVUpxfJROdiyURgqfmTtA78lYZiUsDk886giyPakyxQgB8zMIi5PoVd9nOAcY3issndeVe

On Fri, 17 Apr 2026 20:24:00 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..954e0beb7f0a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1764,13 +1764,14 @@ static void expr_field_str(struct hist_field *field, char *expr)
>  static char *expr_str(struct hist_field *field, unsigned int level)
>  {
>  	char *expr;
> +	int ret = -EINVAL;

No need for the ret value, use:

	char *expr __free(kfree) = NULL;

instead.

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
> @@ -1782,9 +1783,9 @@ static char *expr_str(struct hist_field *field, unsigned int level)
>  
>  		strcat(expr, "-(");
>  		subexpr = expr_str(field->operands[0], ++level);
> -		if (!subexpr) {
> -			kfree(expr);
> -			return NULL;
> +		if (IS_ERR(subexpr)) {
> +			ret = PTR_ERR(subexpr);
> +			goto free;

The above could then be:

		if (IS_ERR(subexpr))
			return subexpr;

>  		}
>  		strcat(expr, subexpr);
>  		strcat(expr, ")");
> @@ -1810,13 +1811,16 @@ static char *expr_str(struct hist_field *field, unsigned int level)
>  		strcat(expr, "*");
>  		break;
>  	default:
> -		kfree(expr);
> -		return NULL;

This could be just:

		return ERR_PTR(-EINVAL);


> +		goto free;
>  	}
>  
>  	expr_field_str(field->operands[1], expr);
>  
>  	return expr;

And the above would be:

	return_ptr(expr);

> +
> +free:
> +	kfree(expr);
> +	return ERR_PTR(ret);

And the above isn't needed.

-- Steve

>  }
>  
