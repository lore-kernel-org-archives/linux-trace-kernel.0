Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584195;
	b=LGLh7KtCDI2UIH+t1moIXfaUxFAkSo1Xx1y8OSqCqAeigX2Y+kUuH10t1y6VUZYocak0
	 j5u4e3xe7GhISsXlJGG/WiwloZlVZysumcP+olCj/gJCzQnseHajQdoPMQbXtgKSGor+q
	 Llypzot21Cu439mHK3+GyBI6ZhYo/+yXxW7Lih9nN8PsNDhM39xgueFhTK/UIsfmth0pX
	 ayKZoqYqFsApr88YKDZZQYQ5lhzpItht0V6MGj/GsXpUcsfit/9apKgChlIQ0h3tBC2Ed
	 RUqpEsGxAhApW13ZWDGX0vndHKRm+7/y89KB5A4fQYIyzSHKKp0+R0N2xAvIbx/bWSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584195;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3E4hoJgeYLkmHhsZ2LNac3QT1JsQyx88dzf4YBG6OZo=;
	b=WAEOT+e6yDubMU6JAjJFDeLKW99HTtEeFWDIQNy3tPPxGdjp3llRXxCP2ClHgBTlZWBd
	 DBK4T/5+rNcl2ujJLUBrsIw5BJrda7Ch32tMqQ7b4ZrrYEEw2tB0qw59Rc61WOCHa/TKb
	 0Gh5YyrleCyoncbnZ1m9C7mlJeyYhuAPELXmdgcobR9/ZQjV7pXjYglp7H8nfXi/JBvoa
	 p5l4dpI2fU2MOfoXlyWxD2+3iYJMfBlKk3Z+irWQ6l7H/uTAf9INGU5RbSJB6591I5iEo
	 40Hz4ZTfXIlTDwbZ0EuFUzBT8PjTW4NqkGMZ7Q7B3Kniv8mFbveD50l0Nb6rPXGzt/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=eVH7VlJk;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=uPtPwYPj;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3A606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA3A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=eVH7VlJk;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=uPtPwYPj
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794584180; bh=3E4hoJgeYLkmHhsZ2LNac3Q
	T1JsQyx88dzf4YBG6OZo=; b=eVH7VlJkHQioJEbas+RiSDumPZMM8UwlJgP6Dc/2NoJuPX+ZXM
	UsO92KtnW5QtOsqYfgOLREmJEWS8lipeyECQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794584180; bh=3E4hoJgeYLkmHhsZ2LNac3Q
	T1JsQyx88dzf4YBG6OZo=; b=uPtPwYPj/vEM2Omc3k4hRCByxodL1Tnc9bP3ws/m3dcgAixJHc
	hSdlHml5KrEeJxE/f5IdsHs9djg7s9rnJxdKKFj9ANTPpXNYrdoyQny9M5rQhOSAcsBJQWqSf6a
	F8NmCCBlqd4lDr7sCp3CaG7dkzvzYocq0IqDdk+ALHiQw80r1D3kppfhK7n01kOdyQd60HU7zsA
	3X9PXN3e91vtGi4excXPzTMsb57Xbs1GxnbASP2Bs9w2PcUvhfRkuCA/kAUzRRGZPS6289Vi4d0
	QKFyWRSJoR0WXgmfUkYJ0OwA7Fbn85t0vwKbc0Fy3lhJFzNNIhLNyQxCu2DB0p6d+qA==;
Date: Fri, 13 Nov 2026 16:36:20 +0100
From: Daniel Wagner <wagi@monom.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] rtla/timerlat: Lock the memory of the user-space
 threads
Message-ID: <4dc4d513-f632-4c1a-a866-51143424c409@monom.org>
References: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
 <87o6bswzj9.fsf@jogness.linutronix.de>
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
In-Reply-To: <87o6bswzj9.fsf@jogness.linutronix.de>
Message-ID: <20261113153620.8p-_TZ1J0o6BLchmVePClKi4b7YVLTUCJfgUfvQd9_w@z>

Hi John,

On Fri, Nov 13, 2026 at 04:02:26PM +0106, John Ogness wrote:
> On 2026-11-13, Daniel Wagner <wagi@monom.org> wrote:
> > diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
> > index c80edaf07b00..5e7a23fb9fc3 100644
> > --- a/tools/tracing/rtla/src/timerlat_u.c
> > +++ b/tools/tracing/rtla/src/timerlat_u.c
> > @@ -37,6 +38,13 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
> >  	cpu_set_t set;
> >  	int retval;
> >  
> > +	/*
> > +	 * Fault in and lock all memory before switching to a real-time
> > +	 * priority, so that page faults don't show up as latency.
> > +	 */
> 
> It isn't because the page faults show up as latencies.

Page faults happened during the measurement.
 
> It is because
> doing non-real-time work with a real-time priority is stealing the CPU
> away from other real-time tasks that presumably have actual real-time
> work to do.

Could be but I think it's more likely the faulting measurement thread is
seeing the latency.

> This program peforms severeal non-real-time activities with the
> real-time priority, which is not setting a good example. But I am only
> reviewing your patch, not the full source.

The only thing I see which could be moved is the
tracefs_instance_file_open part. Not really sure if this is worth it,
though I am fine with restructuring. I don't have a strong opinion.

Thanks,
Daniel
