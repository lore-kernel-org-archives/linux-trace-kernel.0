Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940927;
	b=BKpYrfaDWlMOgigLfuBHuT+ax0W6ctuA3ID3W5B0hTZNeFeHhtEiSdQuVN/PY5PxXczI
	 l8NtTSneQAMTMnzY1EWDLl/RILO8sw/AMkl3SKcJc6zsnrISfd+tmdKMdvP0OHaqnPFZf
	 uKWLacsTksnEpdzunI+9Cd5BHKRuRXpTlQxCx9vqI267U/yQb/b821Of7T9UXFlQiY+Rf
	 1FylPlmlAg4bhxSLA/QdsX9rM/n/WTZ+FFv4BXsfY/wtgFL+xyqIjM0A7uCd93+x1pzt1
	 XM1JZtha033zyVHqllwjh+BIC3TJyYTFgN+T6iOF1U14ZdkZ6S04VBWNyXFH29/vX+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=q383RHQxLs3tFcWE/jVO1EkOF743huGapYVe6AV5mN8=;
	b=0CEdNWFV5dctWbSQhE25S4XBG9+dxlxVUnRHpcjA4A3u6OcP/YNeYjrGsmdHuDVtZcck
	 EhI1VEMM6O4ti5pJ34tk0fPka/MB5xiQIaAy6LFyA4W3GzeRywTcbjnS8Fh4IZ/RCppJ0
	 uDqFtNuTUlNnexDj7BJlj/RDs9IMestiU6CxT22u2hvPofP3A53dSIf4N7OKm3WYkwNvP
	 oa/I9JweInazr8vN95iiCPbE1mqEBNN58k5UVLWDbuAZHYcE24NzZ29scvkpNfebfdTNW
	 4ubhvP+Wyt+QSbvf/GxJ7S/o8/s+f36pzzxIWC6gtWRAaTX1TgRI0jwdmPj3Q2yTXsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bjpUIS5T;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E88606A884
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 18:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E88606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bjpUIS5T
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3acec6677so233145c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794940924; x=1795545724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q383RHQxLs3tFcWE/jVO1EkOF743huGapYVe6AV5mN8=;
        b=bjpUIS5T6KxiEgpy19FlJIaTzo/HYTzIhPGJwTzxh/fiqCFxWgpSNflo4hPvDHfTvZ
         439JPai1Kr+g43n/hizYmGqho2Yfw3Be7UPePnQ8EHUz/PeCTKd+Tqo2P6+5195vSOuF
         gLGPE1z/lUQ52pY37O/rvV5Dp8yRYTRZrIQwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794940924; x=1795545724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q383RHQxLs3tFcWE/jVO1EkOF743huGapYVe6AV5mN8=;
        b=m9w8KFn3211S4IU8Qy6/Ix/FLj8Vfb7SXWXaoAvOFnmhbtjupdRQgq49HJyI8aZ0Es
         W3ctBdRO+FMEjXg86GfbXxMfKgr4PHLfbJFVkbzXsy3Oua35Lq2KQwsoXcUBb73W5CbS
         bgMWBhuILp+xziKItOxTzN9FnzurpQVQ9GEp/ZrKWEdl5Qpf7ty8Wh1UIVRm9vU9jMGx
         LqWDqm8ghJ32G+8YvNPwJK2Pon9TOgC452j1fST3kiCYn6tOhN+xKSEfoSyr4FXBm93l
         88dKZKV2AKtl9mFQ4eDMVqEUa8Pmp7ZeebG2ubrs8mcbN9Kiy0iSXCKDYL9dEXovKUju
         EGbg==
X-Gm-Message-State: APuU4Z88ZhK65GRcG0u0a7MUxZ4yaLNbdG4/b5hQr7v0KapfjZtVXRk8
	4/QXyLfgIAhCg8YYJWTpRy66yojIODuzO9gPx0K+dgFKsM0OGFu9ZpBEOwN6/V5sLKBP3rKPiZY
	KOeY=
X-Gm-Gg: AYBFou3lEOUJ4QCsyeyV+lxuU5fbh/gdksLh+OGYVKBaErgWKlZdF4sJepnznSUsriT
	fiU5zlcv16PSfTCNeH5shl0dUY0YIR9tLPoRssAfatMH0jH7eanjxz5kEBREWDYIMf4MHXa8/on
	4rG4IvnhP6dVIG6rI7WviYlHsQ6ZPEFSBQ2fTs9LwxCLU3zQXpcmpAfxjKXYU5UDR0Ylh9XVnjV
	CLtaqzwOrnC3+gKevBW5aATz3dnpaJrQGrtewJPMi6FvKgBRFMtmUW6d3juHfFFSvYoFygVqX/C
	2lTdnGa+e2K/IYR1Fj75NGAcAUD0YQszjMGaZ2T45wj7/f4zc3hrlKt9qD4cnwRRnQzx3Y3ak+l
	trZIFhStKlucnubpXWx31TxKTCoFMOy/YAll+iLTd2hySC0hopGSyxp4uOhu0nk1cpi4Fw828PJ
	nB5NTUbmm6pdukSA2KE/DRScGYcaAE4n1eTX9nAKYUNFcLGMNcrF9zS1SQxc8IhlqijJZx4rWoW
	eqDOb19sklFs9YgT3b4a/Z2cgN/ZfjJ3IkQMFlqZJfpzo5nfyibdCle7DqNiRTjqMwS1Cz4nDYf
	D1PMkkU+lbvsCBVO62J1cmR62EwoJoceDbP+JME1gUB4ATYWMitMK0jnBGF5+EU2xSK0
X-Received: by 2002:a05:701a:cca2:20b0:1b5:3b83:5374 with SMTP id a92af1059eb24-1b543d29a65mr399616c88.19.1794940923953;
        Tue, 17 Nov 2026 10:42:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5446f954dsm131078c88.2.2026.11.17.10.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 10:42:03 -0800 (PST)
Date: Tue, 17 Nov 2026 10:42:01 -0800
From: Brian Norris <briannorris@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <avyf-arwNO74QFip@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <sashiko-outbox-217828@kernel.org>
 <20261117085552.0e4ef272@gandalf.local.home>
 <avybp3O2zxcLozKB@google.com>
 <sashiko-outbox-219362@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-219362@kernel.org>

On Tue, Nov 17, 2026 at 06:36:09PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] tracing: missing Signed-off-by trailer and unformatted email
>   reply changelog
> - [Low] tracing: ENABLE_DEFAULT_TRACERS stays unselected for direct
>   TRACING selectors
> --
> > Anyway, my point is that it's not exactly straightforward to enable the
> > features you want and get the tests you want.
> >
> > I've appended a diff that seems a bit more user-friendly to me. It
> > makes it more explicit in the menu how event-tracing is forced-on by
> > many other tracers, but is user-configurable when it's not forced. I can
> > formally submit it (in 2 patches) if you'd like.

Well clearly sashiko still points out issues here. But I still maintain
that the config menu here is confusing and hard to use. I'll see if I
can come up with a better solution, or else just accept the
un-friendliness.

Brian
