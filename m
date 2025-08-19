Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A74311583;
	Tue, 19 Aug 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590102; cv=none; b=Q3pvzc6nELBR02ua7gvl3YJ5hgzpwzG55HvqM9F4kKBhSw7hRmI49DgcNrNIf9nEf9EkltgAehJT8v+ZYHN6/npUOlKAysbo/cwYTcDGnw0qs+iRhFaumqoIWCX63mSAtHH0TteF06UyKsHNYev1evblLmW3QVowZegFBiNLSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590102; c=relaxed/simple;
	bh=OY+sicMelY1hnYn/pM29XhqhuTFCJs6xvuX6JR7m17A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdvBDoirTIvFboGGUyfRlHVu/KVRImnVmMbCweztrH6WwVJdvwCaNkwAMAyheJWtzHSwCZulqUVyxsQPZuwaWLF5ZC53jrBAUuinTNdStpLs12GF/wnxGhH0WfJFoFV6zWd32PEFEC9G49Rhmdt8WKM0MQrpa3EO8dPOGshXdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AylmN7UZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMhilJ6l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AylmN7UZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMhilJ6l"
Date: Tue, 19 Aug 2025 09:54:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755590099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVaDSb142K8hJ7jox21NKb4hwtUDlG1LZQOLiyezwT8=;
	b=AylmN7UZHmZMbQK+pP0GxYCm1+2oG6kw0SKTDlPl3S2BVsFMZYOyhNu1Sh3GjAS0ah0fkk
	CqGFMtG9paOstBCMk4kQALOPSxTWtGTYPft5yqfWoXBXyoCjfNZdp1xGr8Bt2U1YNut/3f
	lqG4VM75ZmSHct/BFrKGWb+lgP/YTX9LmmKwPOlyqbB0sYWG573PKHYVTNTgD+gqL37oDg
	Q+WmOofFuDJ7ZotRxMFT6mC8Q0o712n4H+lFuk6HCrhvqbp0w5zPfywagrBFuXRcgYkGid
	O9irwC/El3Dj7ZhLKhwK/eFrsCjvkyLYY+30VHZUWjWsfJsVIu0F0sS2fevjlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755590099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVaDSb142K8hJ7jox21NKb4hwtUDlG1LZQOLiyezwT8=;
	b=nMhilJ6lv08VOGu/ZnawL6+3VoGEGaJEb0d9hBns1kpUuPnDjFU2/oCVmZADXCa2SXehEh
	GyuHB7S03rgJrSDA==
From: Nam Cao <namcao@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
Message-ID: <20250819075457.AqRdkkvf@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
 <20250815134851.GC3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815134851.GC3289052@noisy.programming.kicks-ass.net>

On Fri, Aug 15, 2025 at 03:48:51PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 06, 2025 at 10:01:21AM +0200, Nam Cao wrote:
> > Add "real-time scheduling" monitor, which validates that SCHED_RR and
> > SCHED_FIFO tasks are scheduled before tasks with normal and extensible
> > scheduling policies
> 
> The actual monitor seems to know about deadline too. Surely changelog
> and document need updating?

Yes.

> While there, you should probably extend to cover at least STOP class,
> but possibly also IDLE class, no? Validating: IDLE < EXT < FAIR <
> FIFO/RR < DL < STOP.

Right, I forgot that idle and stop exists. Thanks for the reminder.

Nam
