Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284C1F0994;
	Mon, 19 May 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638277; cv=none; b=NR3COktftyEh1mYllcoIW+FDX7dGETbWFWJcWgFLgBtHoZWFkcT87mDgr2DLgHK3AaTPO6qkq2QiLX1Boc+PRwE5WkBzV7zkZLCIjs5ypREdIof5qa2InnkP1sjH2MhjRU7/ieFx2PDSAReFVVqlArenZF9U17g95cmt8dCWFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638277; c=relaxed/simple;
	bh=5E3h4RaQgBVntlceQfylPWnfv/0GBMosi93LwWHwrU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1eAhIClNsJ1ibJNmCMNBoy30/lBBwTsQapJQ+Y2nQJfS4uzUJUOyetzzw9gOvDF0hq2sHgEcsKXXD4S8z4Bg/ELPY5PxydY5bBVr7GUvQrWVXxRKO4Ve8CDB9RlnN3Ap5s5Ky2iYrnvcsuDaRAB4sCQTQRQfIQprShf+NQIYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhbW2i0o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMJ812Pw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhbW2i0o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMJ812Pw"
Date: Mon, 19 May 2025 09:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747638272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYDHwH7urvXioKWTExMFnaxkBNGWVvHftZf4gJ0+Nc0=;
	b=lhbW2i0oDxsGsW+6jQNHPrWi5UetZItpV6wk5ooRjk4TEWuHZY/vI4wqtjXZZj4qFBHTsg
	iWFLg/3GqlYmsyIsSmuKinzW35DS8pCYPb8JC/4HerU0jrxkb5LGJhFeHCofbz4GSt83Sp
	9IPjZZzCtnV98CjrPKWyf+FifX+q2Dbf0B1XUSLCAYv8zGSPw6TZC7+TFTka/C6czPErF7
	1f6SN5hqGD5zDumY957Dx+86K1yWOF77ZPmABrgQ/G0KBwB8fZcDR+4ptxHfNAmHH0ZjyD
	me3nVCy4dkxAe8EayQI3Z0FKuSa6R6MWRX8fCG5r/qtqr8IDdeGJepxq18j7Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747638272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYDHwH7urvXioKWTExMFnaxkBNGWVvHftZf4gJ0+Nc0=;
	b=ZMJ812PwLwFxtiKGd0/XDy/AneQHL1xBjVS+ujKg905mEnw2n7G/UyRvcad/DT4WE3udp+
	POqE53VJttJlIKBw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v8 20/22] rv: Add rtapp_sleep monitor
Message-ID: <20250519070425.xDEPNyBe@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
 <3199656a35cc8a7acc2e30d320defa778acf8532.1747046848.git.namcao@linutronix.de>
 <06d48208-686a-4d33-95ca-4e4d5991a42f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d48208-686a-4d33-95ca-4e4d5991a42f@redhat.com>

On Fri, May 16, 2025 at 04:31:03PM +0000, Gabriele Monaco wrote:
> 2025-05-12T10:56:30Z Nam Cao <namcao@linutronix.de>:
> > diff --git a/kernel/trace/rv/monitors/sleep/Kconfig b/kernel/trace/rv/monitors/sleep/Kconfig
> > new file mode 100644
> > index 000000000000..d00aa1aae069
> > --- /dev/null
> > +++ b/kernel/trace/rv/monitors/sleep/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +config RV_MON_SLEEP
> > +   depends on RV
> > +   select RV_LTL_MONITOR
> > +   depends on HAVE_SYSCALL_TRACEPOINTS
> > +   depends on RV_MON_RTAPP
> > +   select TRACE_IRQFLAGS
> 
> I had a different approach towards those (the preemptirq tracepoints)
> under the assumption adding them introduces latency. Besides me picking
> the wrong config (I used IRQSOFF, I'll fix that) I considered the monitor
> should /depend/ on the tracepoint instead of select it.
>
> This way it looks easier to me to avoid making a change that introduces
> latency slip in when distribution maintainers enable the monitor (e.g.
> TRACE_IRQFLAGS may be enabled on debug kernels and using depends would
> automatically prevent the monitor on non-debug kernels).
> 
> Now is this concern justified? Is it only a performance issue for the
> preempt tracepoint or not even there?  I'd like to keep consistency but I
> really can't decide on which approach is better.

Both approach is fine, I don't have a strong preference.

I doubt that the distribution people would carelessly enable anything new,
and these monitors are disabled by default. So I wouldn't worry too much.

I will do some measurements on the runtime impact of having these monitors
built, so that there will be a recommendation whether to enable them in
distribution kernel. But for now, just like any other debug configs, people
should expect some performance hit.

> Also curiosity on my side (I didn't try), you require TRACE_IRQFLAGS to
> use hardirq_context but how different is it from in_hardirq() in your
> case?

There is a wake_timersd() in __irq_exit_rcu(). This is a wakeup performed
within interrupt handling, but in_hardirq() doesn't say that.

Best regards,
Nam
