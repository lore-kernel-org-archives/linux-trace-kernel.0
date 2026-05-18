Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4743DE420;
	Mon, 18 May 2026 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090278; cv=none; b=RJ03FAkkRn3zDGN8tOmo34vNVVPW9eIrFUt+Faq5Bk9KwdJgrRHY7caVsXdy4T6JeqHTpJXq1VHBlo5+bT47T6FX1TnmmR3q69DwlsHt+742dIu2C1J/HB7DPg9LMsfDzUf5Ln+SH1irJPtZNvurF4ySrgajrQxp0/Xu1ww0ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090278; c=relaxed/simple;
	bh=VIBDwDXx+R8RtI7kKh5S7Q75re4++cafj68zNsyafhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrUD4tx5OwSffHmjRSXEHOb1TW55c5NJpqRWyhNQ5XnV8a77IX+dFWrB9bDmq0eUlxEYf2Jow6nA8jrBxp5ckQs08sz9sg0kfD7GKHcpevAAPHrNuaqh/1AyryEN4wjlk394niMBoLDp3aWOAYSXIdTq4KtKc0GYm/mYMG3ASwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LM0dmYek; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTjk5Uyk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LM0dmYek";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTjk5Uyk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779090276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/wfH2RTX06d+GxH7BNm/vc/yp/WR5+woBhgvPJ/xpE=;
	b=LM0dmYek/v8x5sk2nZ9D+ZXh7fLeDRsIQhxZU3VdcXfT/hXKGcYD/Q+OsQsM38TRTBnA9w
	w1UXLibT1mEM0QjMGE+3M7Ya0UVPPF/6EiaqaKTNMh70+NBaiCk2Y72wwLAvvNoUjJbwEd
	I4X4QrCRpGIOZqEdP51fpgdAoIZjzmIdpC4oZV9xFSr22i+0LECtQ1RzDjwUJE9HdSuG9J
	sPJVo5N9dd6UwoEas1Vo9lve8giBJWobwN0+GXPiywWxZxretlNPenvUmQqe0mrVzeetWA
	6ZqiCK72zj77oGM/2RSKJrCmMUAnlTrupWoeVgJsCy6EDEmZrRCj1IRZzsNr7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779090276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/wfH2RTX06d+GxH7BNm/vc/yp/WR5+woBhgvPJ/xpE=;
	b=QTjk5UykqtcvsNUheeV8z97HI7gd8/yVWpN1sV753m0dcOtcs60Zd+ZUWZcmWLmUnQoHZe
	rTkQB3vA+qGY1EBg==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
In-Reply-To: <ad9ca4916604d3f5ffe7a6683f9b82008784fa0e.camel@redhat.com>
References: <cover.1777962130.git.namcao@linutronix.de>
 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
 <967f1cd8cd6e27aaa65d68194487306bc312caa0.camel@redhat.com>
 <87wlxaupmz.fsf@yellow.woof>
 <ad9ca4916604d3f5ffe7a6683f9b82008784fa0e.camel@redhat.com>
Date: Mon, 18 May 2026 09:44:35 +0200
Message-ID: <87h5o588m4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Mon, 2026-05-11 at 13:55 +0200, Nam Cao wrote:
>> That can work, but not ideal, because hrtimer will not be usable.
>
> Why not? If we have HA_TIMER_WHEEL , we'd use timer and expire, if we have
> HA_TIMER_HRTIMER we'd only need hrtimer with it's hrtimer_get_expires():
>
>  union {
>  struct hrtimer hrtimer;
>  struct {
>  struct timer_list timer;
>  u64 expire; /* Explicitly store the armed budget */
>  };
>
> we already can't use timer and hrtimer interchangeably.
> What am I missing here?

Ah, now I understand the trick, thanks.

We already have an "expires" field in struct timer_list. But I am not
sure if we are supposed to touch that field. Your proposal looks safer.

>> Looking at the throttle monitor again, is it possible to rewrite
>> runtime_left_ns() to read .dl_runtime instead of .runtime? I don't know
>> the deadline schedule very well, but I think .dl_runtime is not changing
>> like .runtime?
>
> In theory yes, but since the runtime is consumed only when running, we cannot
> just set the timeout once. We either save how much was consumed somewhere or do
> some start/pause mechanism.
> Neither looks simpler to me.

Understood.

Nam
