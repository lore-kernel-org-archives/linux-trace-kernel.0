Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296217578;
	Wed,  9 Jul 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087220; cv=none; b=e1TifkzoEcaHJLHRVTka3y+3oULmyLNKydrItPi20Fqnc65EOrr0Akcld6MILwVnyRztTqsFbHXjX0PgTSJpeAL1e0fVuDSVcVaYB9JJAiQBR1T2jXOrqVkKuQPKZ4/S34wH38pr8I6Ju62ZWC1v1BBbZbZPLOg1O90HZrNs/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087220; c=relaxed/simple;
	bh=BN3mtDzxVB2iGxxlm+nkAm5v39MBQkfNZvK/aTpf8ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGTVFsXVKAxGQlmY9MNnlv70fqH+7tzmVzB3P3hcyjRtAh+w6jCMa/iOSmW+WqoQqO/9VVztkUo/CoRkmhTwQ0wuEDw+7hOk18EIOHkcWs9UTXUYK6YZAFgEiBeZ7WEcmYO0j+0fvhrH/pgM/2QGfYHdatCKtCmwPsw7prBOqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0weHw0Ct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8JJYVvzQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0weHw0Ct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8JJYVvzQ"
Date: Wed, 9 Jul 2025 20:53:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752087216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny3YNgA368QW1zK105gvSo/FvXrhNd+6fnSQnIJmkec=;
	b=0weHw0CtjIt26BzPYsQ/IG2xpIozXS3gRrZF8H9TYwXkU7eqfDGvlDGZi5X986xpZi6iSR
	kyX0eVM/sEwTxMW+NUJlXFdKal+9d1wD0YMOaVuWsjxKPrvQWJVfK79TiTE2G1dUG6nCy6
	nSNClWDXwDPCmJrXYXgons2nlEYKtsRiA3ycW1FhlFrRIpvrqplVF+PxnRNGaqVArmmJ1w
	uAOIcTGgj6/aj1U7zJqyalsTsYKFIgRZBh4W8blrmF2+Qla4Y/VnLCdcRoDN/00OHvuOEf
	qUjwD+D8Yw/tUrRA8ASoOqB77vLj7Oa20FepcKvpErhzAEUn+amMXEfO6HvzuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752087216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny3YNgA368QW1zK105gvSo/FvXrhNd+6fnSQnIJmkec=;
	b=8JJYVvzQWBGwC7fQtG0iBC/MPSHznhfbn35gwn4hN1vtxXI7XJ+AIL5W3gwlKUER6M2sx0
	IlMFUN/0dGB9JyCw==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Message-ID: <20250709185334.uFpAU2mC@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
 <25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
 <20250709144914.6ee7199b@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709144914.6ee7199b@batman.local.home>

On Wed, Jul 09, 2025 at 02:49:14PM -0400, Steven Rostedt wrote:
> On Wed,  9 Jul 2025 19:56:19 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 5b462029d03c..d886ec98fbbd 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
> >  
> >  asmlinkage __printf(1, 0)
> >  int vprintk(const char *fmt, va_list args);
> > +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> >  
> >  asmlinkage __printf(1, 2) __cold
> >  int _printk(const char *fmt, ...);
> > @@ -214,6 +215,10 @@ int vprintk(const char *s, va_list args)
> >  {
> >  	return 0;
> >  }
> > +static inline __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
> > +{
> > +	return 0;
> > +}
> >  static inline __printf(1, 2) __cold
> >  int _printk(const char *s, ...)
> >  {
> 
> All use cases I've seen throughout the kernel has the __printf() macro
> on the line before the function. You're introducing a new formatting.
> I'm thinking we should stay consistent:
> 
> __printf(1, 0)
> int vprintk_deferred(const char *fmt, va_list args);
> 
> static inline __printf(1, 0)
> int vprintk_deferred(const char *fmt, va_list args)
> {
> 	return 0;
> }

Yes we should.

It is possible that you make this amendment when/if you apply the patch, or
do you prefer me sending a new version?

Nam
