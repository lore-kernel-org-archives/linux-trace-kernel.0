Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B535CBC6;
	Tue, 11 Nov 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904222; cv=none; b=mT+aZui7eUO9O5pE0rSxpRkHEYAQoA87Ng38Mi8LPDabfM6S0MTD1mvUD9J3k1krSty+hPVHhsiI0QGP0+5inBrOupZ/xFPWMdXNsajM40m/5cVjFLG7nSWZRCgQqSjlux0+GXZuaaBIU4M0Dc/LWp8rP9+37Og/Hh0x66BQI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904222; c=relaxed/simple;
	bh=WDGfz0ls/y3RrY2YxjLya0viIXr0Sc8Zi8tju40fwzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBiidRsTf9V+QVvDCSvTKpkAEGkYPgYy8jwMi6U6S4W2OQmG6Esb4/FzymkO+xqevu+mV+v40CTsGpU/WpygVcrQP9+IzQWW/or2E3MXMKKsEIjmvpsLCs92Z3pOtV7kSuFJyT/UwOJw9LF35DTKw2Y9KUEsI+tWfI+3qdU8QP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5BB4EB7687;
	Tue, 11 Nov 2025 23:36:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8E76019;
	Tue, 11 Nov 2025 23:36:51 +0000 (UTC)
Date: Tue, 11 Nov 2025 18:37:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Sven
 Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251111183703.0045ca23@gandalf.local.home>
In-Reply-To: <20251111135432.2143993-1-dolinux.peng@gmail.com>
References: <20251111135432.2143993-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ct4g11r7s3mbkmku91fmssq9u7mirj9z
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8E76019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ZZWgIqqT0x7/GFRpbO8xJ/PiUxUgp9v4=
X-HE-Tag: 1762904211-24697
X-HE-Meta: U2FsdGVkX19JN6G2Wfa4iXRK0j8m3NnY89TBu1+935o3JfeA1cGQgYNUp9S7gAH/t5fCIW+1kln3BJLNLZO6Kxl5t1uZ1iDuz2fsLbNuAb00mAbNMDAjgGzJgB5Ubr6NzTmHHzmLDz6THLLfIxS4zQD1/hADhKlL1ChFb8iUqMCxtYEA1x1CRfqxfSOu/iFP97L/n9DO7AoQsf3CLnbyYQ7iDaWOYHTC1I4LlQZA4+bfTNjIdpoJ6CIcKGssxiD4rj1AE4w3YN61tGSrPiNOnjzI7kMbggujKgZ+RNC7IKFSGidlSwq18Hm6plWWJsLVS7Mh09NE0oX5NQLWwcQpK7LIMF24UpJe

On Tue, 11 Nov 2025 21:54:32 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> +	/* Store the retaddr in args[0] */
> +	if (type == TRACE_GRAPH_RETADDR_ENT)
> +		entry->args[i++] = retaddr;
> +
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> -	if (fregs) {
> -		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
> -			entry->args[i] = ftrace_regs_get_argument(fregs, i);
> +	if (store_args) {
> +		while (i < nr_args) {

Nit, this could stay as a for loop. You just don't initialize the 'i':

		for (; i < nr_args; i++) {

> +			entry->args[i] = ftrace_regs_get_argument(fregs,
> +						i - (type == TRACE_GRAPH_RETADDR_ENT ? 1 : 0));
> +			i++;

Then you don't need the "i++" here.

-- Steve

> +		}
>  	}
