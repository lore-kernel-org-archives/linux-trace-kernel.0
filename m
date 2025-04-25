Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE5235355;
	Fri, 25 Apr 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572997; cv=none; b=bfVDnFyrNv62ua06XF4al/ru4IEj9m5xp+RgnhrSovgrxQ6lYBKr08ZLxUyp7HbZy9zPyNXSZry4wnUgVgYYzc0+k5Hv+PJSaMa+mvPfXqSr+GrmI00aAewTN6ULmEIe1Rd/gXZP998OEFjvyMWIdWwYohTy+Qr3O7ke2MLiDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572997; c=relaxed/simple;
	bh=ffY7Q4rlrmxii2Prj1cpCmRIrpTO+xhsuf3ZLnjbGNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8C2U1oJVVVDeGJAtWPjD5/wz20q5wplyXeKeoASjJ7KIiSxdaW0WIoq8XFoQgR3HMEnCg3V0EiPYAQqXRoJ4Ja4Zj83nCbJ8l6zyMXlufcQOK8likGk/U3uT016enN0eklnQd9sO6OerQmF1Qa6QiFGrM4bxjPJf5qu9XZ2JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4mVCVUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgmjdXyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4mVCVUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgmjdXyM"
Date: Fri, 25 Apr 2025 11:23:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745572993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ih43SeP3AvPws8Ja/DpJaS10rdIhAj94U/C//bSlS88=;
	b=H4mVCVUsKX3mjoNRoMadHyALmVXQDcP4T7TmwkGNTLPXa2pFOGeh8sbKFsPHHgQOTnUPmn
	Fbu1GsJAg3e+whF7MSkutyHX9hyci44/Cr2f1nVmEdMoVeoxsVRYaAA60Q66tGJkrWn9NT
	+QS3kcuSOmOHWEHd8sb1ZDoYCC0jEg5r/sVx7xQxsMrmLbenACwYfwzFzMGnaQPUBtbUvZ
	fvVtI7jxy9r3pOXWXY3xexl3H9O1wA2x7EZlKxFiCE/hAqHnXGLEDnV0An5GjO9HeTKRok
	hP/da6C015GbKnCAhvx7IPhakzLzkaXw0caaefq4ZsOoUINq0XShyB425XI7UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745572993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ih43SeP3AvPws8Ja/DpJaS10rdIhAj94U/C//bSlS88=;
	b=VgmjdXyMqBedxFuLonmwfkc8/An+9VnsTUk3ZRQltRv6R9s42B/F3MxXjjY7uxVGuv8FLX
	EXb/rwQl8tHhXKBA==
From: Nam Cao <namcao@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
Message-ID: <20250425092309.nuWnAPa3@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
 <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
 <20250425063456.NBE35YHR@linutronix.de>
 <84ecxgit04.fsf@jogness.linutronix.de>
 <84a584isvo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a584isvo.fsf@jogness.linutronix.de>

On Fri, Apr 25, 2025 at 09:54:27AM +0206, John Ogness wrote:
> On 2025-04-25, John Ogness <john.ogness@linutronix.de> wrote:
> > If I understand this correctly, trace_sched_switch() is reporting
> > accurate state transition information, but by the time it is reported
> > that state may have already changed (in which case another
> > trace_sched_switch() occurs later).
> >
> > So in this example, the task did go to sleep. Why do you think it was
> > preempted instead?

You are right, the task did go to sleep. Scratch what I said earlier.

The monitor checks that if an RT task going to sleep, it will be woken by a
"RT-friendly" source. The problem is that trace_sched_switch() may appear
after trace_sched_waking(). The monitor sees the task sleeps, and waits
until the task is woken and checks the waker. But the monitor doesn't see
the task being woken, because it has already happened before the task
sleeps.

For correct ordering, we could:

  - Use trace_sched_wakeup() instead of trace_sched_waking(). This would
    have correct order, but information about the waker is gone at
    trace_sched_wakeup(), so it doesn't work.

  - Use trace_set_current_state() instead of trace_sched_switch() to
    determine task going to sleep.

The latter option works, but then "sleep" would be defined as task doing
set_current_state(TASK_INTERRUPTIBLE). This new definition is probably not
precise? But for the monitor, it's fine.

Btw, while testing this, I discovered another bug. Real-time thread may
"legally" sleep by a 'restart' syscall after 'nanosleep'. The monitor
doesn't recognize this syscall as valid sleep reason and flags it :(

> On 2025-04-25, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > Peter's fix [1] landed on next recently, I guess in a couple of days
> > you'll get it on the upstream tree and you may not see the problem.

This patch fixes stale prev_state due to signaling. It doesn't fix this
case.

Best regards,
Nam
