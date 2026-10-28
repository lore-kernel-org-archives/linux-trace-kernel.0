Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149830;
	b=PRuH9LFBJhAnyKn3lTwrH1b+FlrnzoHMIaNGDJlrMufV9TBxAI4ZQ+o+XrShpFDhY1Cp
	 xYz6nnvIqsYj8B/gzopWRr25EvVikWKtf9qfBhAAZOpepe9deGHALS5YHiVuzWtPtB9dh
	 MGL6NpeplzhYTX9rJeLvL9w/kWcvYbaBKuGrUGQjqbhb18tow3ALVMg7GV6flyIPpm4Db
	 AvN8lEkBiAV/1k7YD/4cfAZkwIuPypHcwNo/y0/vrBfWTFzfvIPktu7oEJEpzKnvFx9rW
	 r1ifrm7y26q1X+QogUxbBF2N/lH2eI0tr7qBtbdN01kayuW+T3G6JoUPo7hweSIZXeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NjSoHOfUnNDWhF/lyLrAHPx5DTs2zM7cOPoI9FmQ7lY=;
	b=lvn4is/gEOWEeL5DakxYEPt7Bma0zFoSLbpwxhYpock83A8ybL9/8GmgRvDuXXtEAF4W
	 eiF8lZLWNRFVBQsbAdO/2XInpUDpgtuCj794t7ovvbBuhDC5mwhIc03fFx74z8kK4Ma9h
	 +xXhxsKbDvF5LjElfw8lH/EDhyFYSW1IV8GpeWD1C7IVuRiH1Ke5diqPAADCfLOaIOnH4
	 BAJIwbUY26b/wzacUmdx42rxpIrtDZ/8lUt3UNe+6LkCxnoLi/30cdpRWYe7iFOrIIZA+
	 JXnJRsm0fLvjvutYoAIT1RZvr4D54tbVeSOQh3Cpvk6C6YMO9rlcAKLlM9KbemHIzmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyPFxY4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F8606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyPFxY4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EDD1F01825;
	Wed, 28 Oct 2026 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149829;
	bh=NjSoHOfUnNDWhF/lyLrAHPx5DTs2zM7cOPoI9FmQ7lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gyPFxY4YgcuOTNHTMHDU01H32/m1IpW00TsaFfUfNwSBiGnL3Fgm4vMpKuM7H5/2H
	 MdJak7bZP6ZjMjPPTcxt/B4qOv1i6ox9WGncDlq32MxSA0XDRMLZ9yNtkiWfbKtoCi
	 putoq4diy2bNaxTzpIbQF03T0vMxPugwbPFOXprEnTjBIJA1lJ5NbKNGMEF8wErkr8
	 hNXATCOQ83U0mqXUtLBQmWayzW2RzAWgSyYZz/Fm3TminyRqhd1VNEFJeYpyYl7zeF
	 3Xls8xaOvMpd9WnJDanRh/l89h9Oogyit/dyX4xmPY5XjjDICZvhHwysbNS7tKWKcQ
	 1i0f0RHS8hW0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] tracing/filters: Fix regex_match_end() for zero-length strings
Date: Wed, 28 Oct 2026 10:10:26 +0900
Message-ID: <undine-1793149826898272434-1d7f8bdc916ef70f@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-187295@kernel.org>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314821463.684037.6329696159956371930.stgit@devnote2> <sashiko-outbox-187295@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 00:59:33 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tracing/filters: redundant check in regex_match_end() makes patch a no-op
> --
> 
> commit 8e400c22f46c7fff9d91b8c8e837ab24dfa0f5cd
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/filters: Fix regex_match_end() for zero-length strings
> 
> This commit adds an early return in regex_match_end() when len <= r->len to
> avoid underflowing len - 1 and accessing the input string when len is 0 or
> smaller than the pattern.

> 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 5e74d2dae40a3..59a0d3ba72740 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1075,8 +1075,12 @@ static int regex_match_middle(char *str, struct regex *r, int len)
> >  
> >  static int regex_match_end(char *str, struct regex *r, int len)
> >  {
> > -	int strlen = len - 1;
> > +	int strlen;
> >  
> > +	if (len <= r->len)
> > +		return 0;
> > +
> > +	strlen = len - 1;
> >  	if (strlen >= r->len &&
> >  	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
> >  		return 1;
> 
> [Severity: Medium]
> Does this change have any functional effect in regex_match_end() in
> kernel/trace/trace_events_filter.c?

Oops, right. Please drop this patch. This is my fault (I suggested).

> > +	if (len <= r->len)

and

> >  	if (strlen >= r->len &&

are the same...

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
