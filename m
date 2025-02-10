Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA53231C93;
	Mon, 10 Feb 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196488; cv=none; b=KnuISCdwMY8baIXGF5IeU1w1Vn2M+g/8CcLyim7b2Ki6U1cr39aIBnQUcV6u2lOGRK2VVIMUeXgWMAtZ2dr8dSZ6EnAlSLbq9y2IADiOW9kp3qqHKzMmjT5vXOWEgichNdcASBbSf7J16lJBkSW/XeuOrNDtsjyuzDGjXtayKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196488; c=relaxed/simple;
	bh=5qakHaALKLsOB+vcC6ycI0FYINkz1vC62D8Nb9BJAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+WALU89ewdl7BQW1BJ2EpE3xeXZNKOzmNoaT0HiTMAXGgcmhcxWzFFf5j+WU53dHZG1w9NzpOg9SYtN+OofjRq7l3Hof3C+alxFaPYBp5go68H/aLQKFBU0vq3l8t3cp3okA3rO4iW7gg0rvmx+aseAfie0x6ytdz/w9lyn1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ja26NgX0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/93SeBLK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ja26NgX0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/93SeBLK"
Date: Mon, 10 Feb 2025 15:08:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739196484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zOssjLjrkY6BJ3wqKjlN1VufX0Of1JYjkgwNs2mmKAE=;
	b=Ja26NgX09VkPaOE+vhW6eQr/hdpGw/DuDK3AHunYmgnMLNu8U6tHQidt+jNptSbVLmTYrH
	4SRYEF/1l/hdl45NxgipBp8rV0f3sbO4y+IAroEryYggPl+pmciwdPf0YK4G0CF9iTQul+
	6yBgDcvaIAtI5NTba6KfWO7ynTHXu8WmFFccML+iUJs2f476LJ5a7+P8IZdoJtwWeRyXrO
	Lfe2E/+R2GSwKhCFoyI2T1Lkthmt3u0DYgEeGrOPMQZhN7JonUQWz6fyKeDSKpvpnnXYEt
	ocyIjxGPmrfpfyGdH/+EG11m7ar84RUhWTb9rts79ifkXkB8754U4EZcM78qzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739196484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zOssjLjrkY6BJ3wqKjlN1VufX0Of1JYjkgwNs2mmKAE=;
	b=/93SeBLKh22ONlv6A+rCsDY76VFQG7VMnkrll8mGJcg5RYZ59N8PN6QYRBrX2N9+pMpdI/
	gVRzBGhZFPp3pvDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <20250210140803.yAy54W0Q@linutronix.de>
References: <20250205225031.799739376@goodmis.org>
 <20250205225103.760856859@goodmis.org>
 <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
 <20250206102720.0fd57129@gandalf.local.home>
 <bfe05b54-9714-46bc-9b59-ad091897c62d@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfe05b54-9714-46bc-9b59-ad091897c62d@suse.com>

On 2025-02-10 14:04:35 [+0100], Petr Pavlu wrote:
> >> BTW, do we really need to disable preempt or is it enough to call
> >> rcu_read_lock()?
> > 
> > Bah, as I expected this function to be changed, I didn't spend too much
> > time on looking at its implementation. I just cut and pasted how the other
> > loops worked. But yes, it should not be disabling preemption. In fact, I
> > think the module code itself should not be disabling preemption!
> > 
> > I'll have to go and look into that.
> 
> The series "module: Use RCU instead of RCU-sched" from Sebastian Andrzej
> Siewior cleans this up [1]. It is currently queued on modules-next (for
> 6.15-rc1).
> 
> The new function module_for_each_mod() should then use "guard(rcu)();".

So the removal of the preempt-disable statements here already pays off.
Nice.

Sebastian
