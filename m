Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8C1DF98D;
	Mon, 19 May 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643352; cv=none; b=t3UsOlIRKA6dRSGRCMOsEDPeO+MUQKsew6ZyHGBPhTFNj+GnmPjI/jXnZ6PW5PUPz4klIkY1OsRTMi6IQMKlsvJmnAFpwuEFgTT/drn3Q95O3pvGXdQR6KSk81hEzw5uPgcmphrYcrsWLE65bw2dZAi1GR4ZkjEpTP5c9Jm6tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643352; c=relaxed/simple;
	bh=qFNFrLL5IqinsRuW6HsrvphkHN1hZTm+Ia7ulkwMH04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHkc8eAM0bQ+VmKRy1BW4pEKFcPnkM2UZy9DydqPbPiyW5DrB9uZE4SplIFL3V+5ET2Uo1jqj0x6RVr0LDV4RWIfROxRNVYoos3x1FvTg8zUHuz1kHK6S7ACm+jvu3NCDkR68LK7efH9qITND9rf7wIwS554zXCx4ucExa0Gqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4DhBIPCw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3Tq+hoq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4DhBIPCw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3Tq+hoq"
Date: Mon, 19 May 2025 10:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVzMhb4xXoLp6Sn2zegjH8TGSBdNSO9R/WTJI9cgJCc=;
	b=4DhBIPCwrkVsDb7v362SqMdsrpV5Et9RhfseGyMA5PP3YH3HNVTbx8bXKXHUsgTEsUp6Vt
	hRzA7s3Nx7ZVx4oEHF3MnY+bTw0nNQ0Wbz568o/+4sluVvI84vyFEcDVy0Vh0HkTKu3MLO
	t6odZYUL2zMLFK+RUrLb5qAKwycl6nhLN5pvQGXCfLbCsoxysX4L+1vo6NO2ZOQNPnmEzb
	Ubcn5zh3p4pZr4d7H1bTWL24rXqeP7JmHdrq8O4O5qXRbBw/+oMrUpXTrcQoYRAZ1nYyn9
	auflFoBwKQ07maHWUK6Zzhi5pxmMWhdq+Jg+7X3oHRvKo7irJuyUfsqMYhD4Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVzMhb4xXoLp6Sn2zegjH8TGSBdNSO9R/WTJI9cgJCc=;
	b=C3Tq+hoqsScdPAlXEEAGj6acttr2Q+rKWqeqMMMbpjl0wEF7A0m89DAF53To0BadftKk7M
	czpGpRQ2j1TvlXDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 06/12] sched: Adapt sched tracepoints for RV task
 model
Message-ID: <20250519082908.Nak_YDaO@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-7-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:08AM +0200, Gabriele Monaco wrote:
>  DECLARE_TRACE_CONDITION(sched_set_state_tp,
> -	TP_PROTO(struct task_struct *tsk, int state),
> -	TP_ARGS(tsk, state),
> +	TP_PROTO(struct task_struct *tsk, int state, bool from_signal),
> +	TP_ARGS(tsk, state, from_signal),
>  	TP_CONDITION(!!(tsk->__state) != !!state));

Doesn't this break the build? Because the monitors still use the old
signatures?

I understand you adapt the monitor to this new signature in a follow-up
patch. But every commits in the series should be buildable, otherwise you
break "git bisect".

Best regards,
Nam
