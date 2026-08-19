Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7F43B3EE;
	Wed, 19 Aug 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131503; cv=none; b=uUuDAOdXcvp6DgVCneWA+XpOEJHYCcgYZ8yaLRE5iOJ3zt5NR01QH1yhPORd8qVfbk5xJ/jHwcKK8pEzoTG1BJNoHv+gRJ37qjBLdiS6Mmnjwco9RJ1N5dmlnbkRTfTxL2pu5L3eCyS282A1Dhut8hrdLcoyzThJGXfnpHY+W4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131503; c=relaxed/simple;
	bh=Zi2N4zQQYXmy9BdQg+05IIsZFtTpoY7Gr0HetWwsddo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCh3c0Kp0O2w4ugNq5vsILVRA6P6QjEzyKJH5+XgUSRzwnujOxkUnuBaqHqWqbpYlKHpi5i1TKM4fQfShkuUDZTBA9lnUnIr6gGVbEH8qHz5m5Nx0Jiq+DbJiLYiGIqyBzgk+h0Kvh19WPTcnUVzAg4ULhiHJAcBB0V0tc3PT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ncpNBST; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VpuvEHw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ncpNBST";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VpuvEHw"
Date: Wed, 19 Aug 2026 11:24:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787131489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbXCCguhIstcLAOoYWztpoFy+fP3vBKgr0OMKVLnZxA=;
	b=4ncpNBSTAJXojC7994e5oF1I2+WSFnTW5Lf5zBY2ELQ9KV93FM/6kX0Xk4gw3yol+7MGbV
	2WckOWwvkgfO9HVC2A2Vfeb90+H1SPZHpwsfd/Iu8tOk4ubSrnI57zUov+hNQ0i0/ZSm26
	fnT9jRqRdzNqDh5lxyh9cTCFHAk2p5fXSJXvuAbkFwgS5iadNaSv1JC7FBIdAe9T26N2Q1
	6XoeZ1gYy2HAeDDZ75sAKa3C3mRcwoX4yMlpEeXmYtGjIwlLOcupVVQHXA9C17l6luFh99
	q5PAfGWx3tlt9A1hBDtCMMhDIBccVmufgTCuLxUlzWfuCfyPtaPUujMA/B3pvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787131489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbXCCguhIstcLAOoYWztpoFy+fP3vBKgr0OMKVLnZxA=;
	b=1VpuvEHwPY/5E9/+KRnEqwxDsJLv+E965303E0/V7mcqDaVeGm01RJVUtNoqVIrT3xeSgH
	FpE3KRBlGVCzD2CQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, wen.yang@linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
Message-ID: <20260819112038-e7b033f8-3711-4acd-ba05-dbef015c6fc8@linutronix.de>
References: <cover.1786294920.git.wen.yang@linux.dev>
 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
 <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
 <87zeylnos3.fsf@yellow.woof>
 <b6de8228ee3045104a03ab4754e5ecc50e67f627.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6de8228ee3045104a03ab4754e5ecc50e67f627.camel@redhat.com>

On Wed, Aug 19, 2026 at 09:12:43AM +0200, Gabriele Monaco wrote:
> On Mon, 2026-08-17 at 10:18 +0200, Nam Cao wrote:
> > Gabriele Monaco <gmonaco@redhat.com> writes:
> > 
> > > On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev wrote:
> > > > From: Wen Yang <wen.yang@linux.dev>
> > > > 
> > > > Reactors must not explicitly take locks, so they should comply with
> > > > LD_WAIT_FREE.  However, reactor callbacks can run with preemption
> > > > enabled on any kernel (not just PREEMPT_RT).  If a timer interrupt
> > > > fires during the callback, the interrupt exit path schedules and
> > > > acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map that
> > > > declared LD_WAIT_FREE is still held, triggering a spurious
> > > > "Invalid wait context" warning:
> > ...
> > > Anyway, I'd appreciate comments/acks from the other folks in the loop
> > 
> > Sorry, I do not know enough about lockdep to comment on this.
> > 
> > FWIW, I would rather just use LD_WAIT_SPIN and keep things
> > simple. Context-sensitive code paths "feels wrong" to me. Spinning
> > should either be allowed or forbidden. Making it dynamic "feels like" it
> > will bring further complications down the road.

To me the dynamic logic also feels quite complicated.
We could also disable preemption before overriding the lockdep context
when lockdep is enabled to avoid the observed issue.

> > But that's just my intuition.
> 
> I don't have a strong opinion on this, but since there's no one in the kernel
> using LD_WAIT_FREE as inner type, that feels like a hint to go down the simple
> route too and allow LD_WAIT_SPIN.
> 
> If a reactor ever uses spinlocks, lockdep would already complain on its own if
> that ends up being an issue, wouldn't it?

Only if that reactor is actually triggered by a tracepoint in the wrong context.
This might not happen during testing. This happened to me in my signal reactor
patch, which is why I added the lockdep override.


Thomas
