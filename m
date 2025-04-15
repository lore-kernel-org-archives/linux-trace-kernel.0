Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0312820DA;
	Tue, 15 Apr 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710827; cv=none; b=IiQIgtGPHw3vrVew8meKc2fFEfhK1ERgQpqbvYQsta1aWjXvgfZJzOWNBivH3TJaScQ9WVdPr5r/jBfvE2AVt1HDD5nKqozc7Sc3vwm4+Ix+ESOIpBBhaAsl9y5E4Tx9/ccX1MLOR2On3/KAOuS9ZlQtB+tRg27Ono4oak/2RDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710827; c=relaxed/simple;
	bh=66TnW4SOtGzp5v6VIUNe9BjzhFVkjEi7U5Kmf7WsX1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONklbUMmImQSbO6Fg1UpFmmZlHLLB2xIrcWhY2dlXXTQLAQwVCaKQqpzpvABw9J6AKvBEa0sQTSbjcOPNEn7MPK9iGASuVRHFtMirZ1vCE+Qux9CR2eJuzC8FxSrFIGDx0zk2MFfILEHW/ydge3SfhtSo9b3cQKhuWTzv2omFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWtCgUS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pz0Ku3Qr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWtCgUS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pz0Ku3Qr"
Date: Tue, 15 Apr 2025 11:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744710823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzJBTlMzPXw0a7LzFKrBuI48h6PPHoSnzloyT7nn9xU=;
	b=fWtCgUS1INPtNPp6mg/xKVo/qWfa6g21rKC/tqk/10NGKqCbhKRvg+pUwtYnGiCqXJVMmk
	K0LuSo8dsQ3l6wRcUBea5VLA5mRctEhlFNKerEn5o7ruAjre6wkGfV1v3cMhNRttSvtlGs
	iY46uQRf3PByP8sEbJUX5mzNPm4z0ROA32/NWsmAZ9AjD33hLXa0byaBTVaWW3/jIJSOdm
	MEDz9TF51IM2q9z39VzqIVtvS6hv+CCE8Vn7BX3tOvvXjO1UFCWju2I1bZAuhBlQTv9fFp
	5b3am1UbLbSxisHReRA70rTAThiitxyM8zW/y3m2gUIoNTyc1omrb0x3jx8sQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744710823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzJBTlMzPXw0a7LzFKrBuI48h6PPHoSnzloyT7nn9xU=;
	b=pz0Ku3Qrlkki3PoAnVtysKkBI4boV4cM+TigLDvAzA+XPfPZlD06YRsCAT4VNcZ+rPfEY6
	zHDWp5kSikEnIHAQ==
From: Nam Cao <namcao@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 03/22] rv: Let the reactors take care of buffers
Message-ID: <20250415095337.oB4AYRA6@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <fb397e38b56f3eab7b7f662fef4860ee4fbda873.1744355018.git.namcao@linutronix.de>
 <Z_4nvJEB-RXX9T0n@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_4nvJEB-RXX9T0n@pathway.suse.cz>

On Tue, Apr 15, 2025 at 11:32:44AM +0200, Petr Mladek wrote:
> On Fri 2025-04-11 09:37:19, Nam Cao wrote:
> > -static void rv_printk_reaction(char *msg)
> > +static void rv_printk_reaction(const char *msg, ...)
> 
> I wonder whether "make W=1 kernel/trace/rv/reactor_printk.o" would
> start complaining about that this function is a candidate for
> ‘gnu_printf’ format attribute.

I checked, it does. Thanks for pointing it out.

> I am not sure. Maybe it is enough that this function is later assigned to
> the .react callback in struct rv_reactor.
> 
> I wanted to tried it myself. But I was not able to compile the
> code in linux-next. I got something like:
> 
> ./include/linux/rv.h: In function ‘rv_ltl_valid_state’:
> ./include/linux/rv.h:55:43: error: ‘struct ltl_monitor’ has no member named ‘states’
>    55 |         for (int i = 0; i < ARRAY_SIZE(mon->states); ++i) {
>       |                                           ^~

This is a problem with the series. For now, you could "fix" this error with
CONFIG_RV_MON_RTAPP=y. I will fix it up properly in the next version.
> ...
> 
> I am actually not sure against which tree I should apply this patchset.
> It did apply on linux-next after skipping the 1st patch.
> But it does not compile there.

linux-next is supposed to be fine. It doesn't build due to a problem
introduced by this series.

> The __printf statement might be missing also in the other two
> reactors (panic, nop).

Yes. Will be fixed.

Thanks for the review!
Nam
