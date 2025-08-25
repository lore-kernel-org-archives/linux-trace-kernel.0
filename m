Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0428CF5F;
	Mon, 25 Aug 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109041; cv=none; b=tgSns0srBLgCEQPtoVpsJs15rr6fVLEaEOPRu6hDKMBVbLMc3RIGA6xXw82uaT/n8RPViDsVkyG66qoPkoOIxk8hR1BA+OsBVkvhS5W8QZIt2BITKW+sjDeVZc8qF+Zrknp151T0pvagbCth+tvHlR+BYuvmyzAFdQ3aB9IGvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109041; c=relaxed/simple;
	bh=dw3CBLRrWK4mJIlC3s88BsZNO0LmaZGmrT2p8QPgBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbP5TWm6SB/NmP0yibRbnlpBYOWoUzHc87a/1FKAi5dbYbe63to29y6lLswfRPX8Gvzsdd7lc84UtAJkOp/32YgKerzULwxEe819/99DY7BO+FX3zI4o9mp0lj9wqLKVSOqoRCLtb4MkxFghMSXUEogUjW3d5aJPYw+ozErcDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZpA1743; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8uOkEfYL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZpA1743";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8uOkEfYL"
Date: Mon, 25 Aug 2025 10:03:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756109037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Xx+e1Ihw4PZ+dDnYVImDCCdM/CTodXvc11zucdGncE=;
	b=hZpA1743KBgteEbHFOMGJX+QUboEFCmZ8hGziffBoGh44zqoLUyR1WYxiPI+ESev6pGhJu
	j5ZvbIK9RQUxydhyQLWQrWiwUrvNWsnHECQkfBGpNsxqrmbZtIbzsuVFJbL8vqr2uuEXO4
	LaBK8CoMFcTMXD6WeK/i/VdOcBMvWf4+DGVoD1vGSFn6QjZVMCAalyBrKYo6iTWW3V4HA0
	7d2dExza9von7GOG1HG5ELwy7knafNutB54mqM4xNELOE1z+jKKF92n77RxAOuQysmDvq7
	ggGpBLHBQUzaDHJG4KuvP/30yNSBCyyyOWEkmtTjqd5bADXa2tk5egdAqqwi2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756109037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Xx+e1Ihw4PZ+dDnYVImDCCdM/CTodXvc11zucdGncE=;
	b=8uOkEfYLLNda2+9L5HpSjlQueBqyT35BQHivZSejzeOHBV/lLHay9kJQmZFDkJBukmSF+7
	8SMgdOcH+SJS9vAg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
Message-ID: <20250825080356.VOaAyf_7@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-2-gmonaco@redhat.com>
 <20250821081405.RQhrWVKp@linutronix.de>
 <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>

On Thu, Aug 21, 2025 at 10:49:05AM +0200, Gabriele Monaco wrote:
> On Thu, 2025-08-21 at 10:14 +0200, Nam Cao wrote:
> > On Thu, Aug 14, 2025 at 05:07:53PM +0200, Gabriele Monaco wrote:
> I think the reason was mostly laziness / wish to change less things.

Laziness is contagious, maybe you got it from me.

> > > +/*
> > > + * model_get_state_name - return the (string) name of the given
> > > state
> > > + */
> > > +static char *model_get_state_name(enum states state)
> > > +{
> > > +	if ((state < 0) || (state >= STATE_MAX))
> > > +		return "INVALID";
> >
> > Just notice that this probably should be
> > 	if (BUG_ON((state < 0) || (state >= STATE_MAX)))
> >
> > You shouldn't do it in this patch of course. I just want to note it
> > down.
> 
> Mmh, I'm not quite sure about this one, sure it's not a good thing when
> we try to get an invalid state/event, but isn't BUG a bit too much here?
> We're handling things gracefully so the kernel is not broken (although
> rv likely is).
> 
> If you really think we should note that, what about just WARN/WARN_ONCE ?

I think that if RV is run, then the system is just being tested, and
therefore it is not a big problem if the kernel crashes.

But WARN_ONCE is fine too.

Nam
