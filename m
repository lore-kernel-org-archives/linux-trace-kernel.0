Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E84446855
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695962; cv=none; b=TtNk5hXsexJEg26VHD24ip8NznEXUkpZXQhzt+RfEzUt2kHJcT10vPrgaxk5iebUi3/ft2jkhpsYqdQLN5WLZxTfatyMhd9zKDjiAJJvEtRP4qE+lljD3DqdsXq5yWtvJ22U2XKx/4wQKqIpMRdM5Pw0XESyHoIsqG3X4ks1/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695962; c=relaxed/simple;
	bh=Ps0zPbYmFmr1PCTK5dolhMfnvmZuycDpsR5AKhe3KfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXisIqC/pJp0W+fHZWTs7VLjRcyK2SHT3fSLjVQOH0d4JM4UB9oH31+SgUIZw/79E6V/Y1qXM39YRHhZNtLljQ3RTf6RzAcev+pGGb7Pw6DDxbIsRYAbzmHhwHGIcPZx3xp1mQZzaWf7Ap8fKr8kLrM68IQYQSU2bQc2A5A8a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1+wkYsL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1+wkYsL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fd66a094eso265617f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786695956; x=1787300756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+iWy9azNUvFD85ODC8trsZsRoeRBZ5dWgI3BFE848Y=;
        b=s1+wkYsL/WbzaiCq1FDe12fW7QbxgwmmfpmaxPTjUNW8bDMcTMgyt5LoghJ6fTYgcq
         /NgzJ+IADwPf1MZMhlcRhDy5db3lDv+vCPX9jAoirmP/mcfMo+aQE5LragENpC3yqBFd
         14HyHjdKpG3I/KLhhytlbTfoPFTDC6W2sR60tUjJrccf0ctpBIB6Hil4LOXQ/ZlZaOnS
         v0VmiqKs1Wbx62W+PGW0jEkehqjOgd4ciLJA6H9/S8xEnGauJLuyxsYK11gfEPmDkilc
         +54NjRtB1GiHPqsUDUIUErFrU+gRyNJCEiCttTXyuY5RIwrS4T5vpwj8LBPqZTJfPfSq
         024Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695956; x=1787300756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+iWy9azNUvFD85ODC8trsZsRoeRBZ5dWgI3BFE848Y=;
        b=if+zjGT+SFLU+gKKdrjOs8Q+Jk9C8b+yxCIbtdqAbNfpy1AjS7ZsT6PdgiSED5HYpG
         vhMjNdSf/ImWFaJz4LGEIbAhX/XrVD/BXZXvrAcn9LPyKP9oyWwb3kwuReQjlDqo57N7
         lIeLw643vA4lHJLxzudxPks9Z58rF6goHjMpsvafAf6ugCz/g304hWIOhTP5RXHTnFZd
         qnfP/slmd64b/QhYvY8j4yaJ0AtCYwohl50MjQMFgveyyHStxPGcvlTPyCyvDvCnhymB
         l5drkWKLXsiJKe/CiL4ABOIM+LRV89AZeBWNNtvG0zDpZ+5st0T+DHA3XDXTIYsOrKkL
         qo7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7WBWI6C0rYN6czum5+h7RRdg06zcdGc99eSYR+CCfj1F8wuZLhSXdA/RqGVBNBdeiP3tPneEYzoygBl0FIjAXM3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0FHt7iD5OAGuBAKhmkOCF7ikXsWMn5cajJ7Iozp+KDkzo7pv
	IdTZxnHuH6DRCWt6oZDySalenY4PLsU77hGyIOt5KLOywMSBDn1Vw9cHzeX2fCu/AA==
X-Gm-Gg: AR+sD11pCMMvfpoxHi/VT9QdNpfeqb3+ItqVsLRbtimg3FKLZpnRf8X0nvEEKe5G4Zs
	B1e0UGxGAo6UwfXbcvRem0DOPp1u/oDgxFDHixmnasJ/R+JzLh1IZcSyRXq2KpJyzqbPOjsGEQF
	isTjl9+9+DrKWN11yaPVyiRGaknrF2/MYS2FdwsSzPgiLbR+pALMaUkjFkDlTZT748iZBzNKZLq
	RTHEX7SUiv/CtGQO7AekXjHMdrKE6SIfIRy3ziaIyGrUTgueNLNb0y6PL4/IqS2GB5U6MHRjj/Q
	YmFXZe2pnTJTfNKeE92mst+x402piTVxwwT9XNUxaEUfZfPHycKdojVB901bmTjv9M2BkADsNb8
	um4m1WykgfpTk14oGc9ZBYvFPbeDSyRXnzl6VVfL9Ufi/U0k3zmuY+KX8dVv/e+OuhgWUeVby5/
	UxT7OHMR4bRe1FpKfbrnWKE53/nmLlcUpHumij8H0pAYNw1/PxBpHaHxuqhmXhFw2NO7J/M+tpq
	Btm3YiU/ua8ebkhNe4CM1jteVSW4S6/
X-Received: by 2002:a05:6000:288d:b0:481:5bce:44b3 with SMTP id ffacd0b85a97d-481607708femr5732525f8f.16.1786695955309;
        Fri, 14 Aug 2026 01:25:55 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1a91sm5960563f8f.21.2026.08.14.01.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:25:54 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:25:51 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ring-buffer: Fixes for subbuf resizing
Message-ID: <an7RD18nj4ytlIfj@google.com>
References: <20260813215230.7aa47950@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813215230.7aa47950@gandalf.local.home>

On Thu, Aug 13, 2026 at 09:52:30PM -0400, Steven Rostedt wrote:
> From: Vincent Donnefort <vdonnefort@google.com>
> 
> This series addresses multiple issues discovered with the dynamic ring
> buffer resizing.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> This is patches 1-5,7-9 of series: https://lore.kernel.org/all/20260813131152.3589632-1-vdonnefort@google.com/
> 
> I'm running them through my tests right now. But I wanted to see what
> Sashiko thinks of them as one big patch. In the series, Sashiko kept
> complaining about existing issues that were fixed later in the series.
> Sending this as one big patch will hopefully have it give better feedback.

And it actually does not look bad!

The only comment left was fixed in "ring-buffer: Make nr_pages unsigned int",
which from Steven's feedback must be renamed as we may want to keep nr_pages
unsigned long where possible.

> 
>  kernel/trace/ring_buffer.c | 268 ++++++++++++++++++++++---------------
>  1 file changed, 158 insertions(+), 110 deletions(-)
>

[...]
