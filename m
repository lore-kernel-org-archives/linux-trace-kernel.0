Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C00215F72;
	Wed,  9 Jul 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081494; cv=none; b=mZqxCXBL8W4f8DIO8tyCxLEyKHjbyyZh128sh4CVNZfXigklYIlXCS0Tr2nV3prKGkNzGxVal4CrRnj54hSEwQw9Xvw+ysQSezuuKZFn1HKcH7u2eiQsYRcslOZUfVIOP2iPXdpz2ZZiRbc4AKJBhh0fDWXVhD8HOdewB+E54qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081494; c=relaxed/simple;
	bh=hNNJz+R7CDtYYU7vtvB1TlOJ4ExAOfp7PB4jyWTCE3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHIQNTlm0bu7fmIBCHMF8Ih3ghdREYSGmkYSZIG/kYqjR8e0XarQdTizEtnmNGKlT+7YekHygMZTsSPPL8tl7RcGk3i+RP7XNSavVcMecQjWqhZZjY/dGSmpoIJVwdbmzHvdqUloVztYsHwKSCtWWGVtmcgkq0yR3JdLO6k2OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOirpjOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t0xUJnyw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOirpjOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0xUJnyw"
Date: Wed, 9 Jul 2025 19:18:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752081488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+u6N3WVpXb4su+BZJqmjJzNnENVdSANJwvUYvVQSia8=;
	b=bOirpjOGDfHVBZbWMrHYXc8VkIWVRuQ/UnTa2kD5X8Od/9q330iNxqlfYPpeMNGU9Smh3x
	OdRT7XZC5xUPAZZdVWxuuU3G2BIGl1UnfIzzEilOKLgPxWNTtwki5lx0F3E3qDmhD5s0QP
	gNgbkO3+Z9TDus3oGioutHNtOFtrZl2D7pRZyatxsSwad9KPwgH/EHc0QqSoUcQJYgRuAh
	5Xf4KyJsVYHXnLCTlHjX1qa4XqnDcxVFAfsBYlIRxB0vrzDRg5ZOlvPQ+C7TbyXj6ISBpO
	9EdWcjeLcpu1FJ497MMZUmqnusvrDolPwynQePiICBpaBPEz/8qj0jdfRJdeOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752081488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+u6N3WVpXb4su+BZJqmjJzNnENVdSANJwvUYvVQSia8=;
	b=t0xUJnyw2a4bE+QYCuuB5PTx3vmBSGEFSIR1LUmJs3547NRwcduP4F+ZO44dJ0S7/FGbAh
	NxRPZX+hU+H8xtCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v11 02/21] printk: Make vprintk_deferred() public
Message-ID: <20250709171804.DPvV6FSL@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
 <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
 <eacbe956f6815bccd4110cf3f82ffe76c0c4e09b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacbe956f6815bccd4110cf3f82ffe76c0c4e09b.camel@redhat.com>

On Wed, Jul 09, 2025 at 06:02:23PM +0200, Gabriele Monaco wrote:
> Was just running tests after rebasing and I received a kernel bot
> warning from an unlikely build without CONFIG_PRINTK [1].
> 
> >> include/linux/printk.h:218:20: warning: no previous prototype for
> function 'vprintk_deferred' [-Wmissing-prototypes]
>      218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
> args)
>          |                    ^
>    include/linux/printk.h:218:16: note: declare 'static' if the
> function is not intended to be used outside of this translation unit
>      218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
> args)
>          |                ^
>          |                static
>    1 warning generated.

Arg, I have vague recollection that I fixed this one already.

> I believe this ought to be static:
> 
> +static inline __printf(1, 0) int vprintk_deferred(const char *fmt,
> +						   va_list args)
> +{
> +	return 0;
> +}

Yes, will do. Thanks for the info.

Best regards,
Nam
