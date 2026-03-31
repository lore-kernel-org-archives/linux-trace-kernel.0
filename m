Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE013B7B6B;
	Tue, 31 Mar 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970584; cv=none; b=LMwkFIqvyTsmAJrIUD0+yRxVcFp3gHI+tzQIsaGUr0nhj6fc3VnaIVs3z0Y39g9xBFgkXamPwgirKFbpsLaHvwSTS83DYrT0mZqagpQRed234AcDPPF89eqLbNe7YD396G5UfrUJiXEP0d8NU7DOt/7LHLN5MNGHpaib9BFVzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970584; c=relaxed/simple;
	bh=f2vlJ9Sb82eJr0nfuaR+DndbVY1DhQKE1S8vZas6BdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPlSFzonlV78VHAMiUNmdCmri7faVLVWJ3W2bxPvbvhNqsLZMepUHHmmn7vaPTMIyzmVu5B/uq+rpNmH1knitWPg9OnguIKIIsPZtZOw6zLual8NTgsnl8nCqjVhwmMB+ijlYwcyYn55u3lnBEF0NDxHTHIXxp33mNERuD3X/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wVfoluSs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=47rJbbB/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wVfoluSs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="47rJbbB/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774970581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQPWL8FzCxq+CxUtvG+Xt5yrn0HxDRcNAo4HAr3gO50=;
	b=wVfoluSsV5vg0IIUjUpH99SPvGhC2SnIGFss/luMEJywzD+xpVbi0yrUNFds+ksxZkxAR5
	hpBHbMMz0Xr3o8Wj2JxI4ZThJA8dxQY2Ulcr1HKLgaZmo3u3nLfjA/k+0gSXKWrCVrUQyW
	WY4aDhMRP1Y/GO6yU9DRZWGvxDqOsbmOqSEkFDkQCc/icCjmguq6GhiwZYYLjZ3wY7yi7q
	MVY2kZIKzVC6/LBH5Eoj0uboLKWBCrycTkbWMOIW4vgwQAovO8EeIHAsC71OJAvBpP45Ed
	w7xWdYIT4qbRH+eEzMdhrepUMqilKSD3vocHzXNn4JrsvLm2IjgyBPBf4LpKrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774970581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQPWL8FzCxq+CxUtvG+Xt5yrn0HxDRcNAo4HAr3gO50=;
	b=47rJbbB/znF5CSYamRRDu/KAQTY15kti0X6HcAQ6HorKkIrDUyINpsgyBeJxYyMe5BmN1a
	qsOPqVubv0xATaDw==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
In-Reply-To: <58674d7f10c260369f5cb78599ba6ecb3804358f.camel@redhat.com>
References: <20260331104918.2710853-1-namcao@linutronix.de>
 <58674d7f10c260369f5cb78599ba6ecb3804358f.camel@redhat.com>
Date: Tue, 31 Mar 2026 17:23:00 +0200
Message-ID: <87v7ec6n1n.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
>> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
>> b/kernel/trace/rv/monitors/sleep/sleep.c
>> index c1347da69e9d..59091863c17c 100644
>> --- a/kernel/trace/rv/monitors/sleep/sleep.c
>> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
>> @@ -162,6 +164,11 @@ static void handle_sys_enter(void *data, struct pt_=
regs
>> *regs, long id)
>> =C2=A0			break;
>> =C2=A0		}
>> =C2=A0		break;
>> +#ifdef __NR_epoll_wait
>> +	case __NR_epoll_wait:
>> +		ltl_atom_set(mon, LTL_EPOLL_WAIT, true);
>> +		break;
>> +#endif
>
> Sashiko (the AI bot) wonders why this isn't ltl_atom_update() like other =
things
> around here. Is that intentional?

No that's not intentional. It does not affect verification result, but
still should be fixed. I will send v2.

Funnily a colleague just told me earlier today about how good AIs are at
reviewing..

Nam
