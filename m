Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10B3D4123;
	Tue, 28 Apr 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369831; cv=none; b=StZmrxTAYDi1cBGjGVtVQZLVgG3/VGGNcHTBRBU/hTRYA25TqsRi/MgJLn0N4Qfr1qUNkZDssY2tWp+aSoWsf4JWhzPeYTkyndGiMKNEOHJ0AlOr/Ai32LFClKGjllYXEj4PuSgUjHc6muJvVKLYUjOyDj0TYjjkrurtDfLE444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369831; c=relaxed/simple;
	bh=71r5PCoyKE2q6CjGvtlENM/Tn18UAB8o/79zayB5am4=;
	h=Date:Message-ID:From:To:In-Reply-To:References:Cc:Subject:
	 MIME-Version:Content-Type; b=a+svyJ23O1+ap40iMwbz76NIgcfxInlMGlIiUtsZbQbGVDG2sRn80x/PrvRPQRhhFqPcsYLKBa1MbjQRGOIu/CrOXiymVaDe0qMPRLQG/p66oUVvBFqgO6kWTGVGvU2+oYBp/8qVdNk1MjdzsSwwYn0jhxXuayjEmNGtSm73YSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=ZCmOshS5; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ZCmOshS5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Subject:Cc:References:In-Reply-To:To:From:Message-ID:Date:
	Reply-To; bh=puMIIGNSAbNeV6wpOztNjxLzxg4uw3qbrjqOibpKvTg=; b=ZCmOshS57pYBTDVZ
	HrFvOuMsqstaN9Agfb/IXg+fVolQjH8eyICjuPeOmSwrgQ259oUmQbL3s9IeQLWnf/4jhnwG3lYzL
	L9T0rmwIodaQW0Bnr+FZBdxWJNcoeLKXcQYAAAZjiWjLc2m3fukbh5aa1oRPlaM+9+8OvfFEuAlyy
	GwAbt3a0ICQalbwEs5O7siiSP6JXVh2prYl2Dr6JdmJu1wO9yn1t3fauML5m6iGvs+EJ0Qv1t6sBL
	6U1SB9xbpywglYf1tifwKZykyu6aXtpyJMCzwIEOncnjdbi63AEKwmGpxCgPs4sAj59QJilL7mHzw
	yl1ASelV0Ww05p9S1g==;
Received: from host-79-43-52-27.retail.telecomitalia.it ([79.43.52.27] helo=localhost)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wHeTm-000MMJ-Fj; Tue, 28 Apr 2026 10:11:42 +0100
Date: Tue, 28 Apr 2026 11:11:41 +0200
Message-ID: <d0a66f985640388ab13fda6f7d66c5ad@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
To: Gabriele Monaco <gmonaco@redhat.com>, rdunlap@infradead.org, Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260427131709.170505-2-gmonaco@redhat.com>
References: <20260427131709.170505-2-gmonaco@redhat.com>
Cc: skhan@linuxfoundation.org
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: matteo.martelli@codethink.co.uk


Hi Gabriele,

On Mon, 27 Apr 2026 15:17:09 +0200, Gabriele Monaco <gmonaco@redhat.com> wrote:
> The sched monitor page was linking to Daniel's website which is now
> down. The main purpose of the link was to point to a source for the
> models from the original author and that can be found also in his
> published paper.
> 
> Replace the link with a reference to Daniel's "A thread synchronization
> model for the PREEMPT_RT Linux kernel" which can be found online and
> includes the models definitions as well as the work behind them (not the
> original patches but since they're based on a 5.0 kernel and are mostly
> included upstream, there's little value in keeping them in the docs).
> 
> Fixes: 03abeaa63c08 ("Documentation/rv: Add docs for the sched monitors")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> V2: Add link to the PDF and fixed RST references
> 
>  Documentation/trace/rv/monitor_sched.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
> index 0b96d6e147c6..d3ba7edc202f 100644
> --- a/Documentation/trace/rv/monitor_sched.rst
> +++ b/Documentation/trace/rv/monitor_sched.rst
> @@ -36,7 +36,7 @@ Specifications
>  --------------
>  
>  The specifications included in sched are currently a work in progress, adapting the ones
> -defined in by Daniel Bristot in [1].
> +defined by Daniel Bristot in [1]_.
>  
>  Currently we included the following:
>  
> @@ -365,4 +365,7 @@ constraints when processing the events::
>  References
>  ----------
>  
> -[1] - https://bristot.me/linux-task-model
> +.. [1] Daniel Bristot de Oliveira et al.:
> +       `A thread synchronization model for the PREEMPT_RT Linux kernel
> +       <https://www.iris.sssup.it/bitstream/11382/533630/1/Elsevier-JSA-2020.pdf>`_,
> +       J. Syst. Archit., 2020.
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0
> 
> 

Thanks for addressing this. FWIW this looks good to me, however I've just
noticed that the same article is also referenced in rv/runtime-verification.rst
with a slightly different format and no link. I think that it might be more
clear if we had a References section in rv/runtime-verification.rst, add links
to publicly available articles, and then let the other pages point to that
section when needed instead of duplicating the references like in this case. But
that could probably be addressed as a further clean-up patch.

Acked-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

Best regards,
Matteo Martelli
