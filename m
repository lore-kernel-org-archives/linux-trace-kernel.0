Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C832D7FB;
	Tue, 11 Nov 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848799; cv=none; b=aDqgPuZNMdKqD91nwgtP9mqAE1H8CxezElgAPn/Om2O3vw7iNOIX8ZqRO1iGcXQc2+3csamH3KtsTpcXlqKR8yMnyDuOqTmoUPLT0ztocp+zbMgI9OPrKbvfMYugbvmghtUNt51UanDu2Lms/7lf6Wsvp6XE9QMGPKnLuPuleDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848799; c=relaxed/simple;
	bh=C6lX2ebjlhgLc4iODk+xnNtT3RjNgmg/HTqHxjwGbi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDWocG3cq7GYWunM3KYj1jbVcvXEDv8STGHRR/zj6PHzQIm2dJj9OXAF4UCZFD3kJ0yHugXNfZKswZi1A4dynWtSvCpIuNikPOCar/cS/DrYe8A6KulBB93Hr40QdaYYIkYMI1OBAHp+SlUUiBbpZdBMUA8zXCVQKyCPGDzZEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUVf1kcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYvUMGkU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUVf1kcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYvUMGkU"
Date: Tue, 11 Nov 2025 09:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762848796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iS8bnyQucgWZHN+P0qBErFEEzOWJVzY1QyWkbweNgxE=;
	b=aUVf1kcCVCHExvHK/tI+sTyphZadgPxQzP497SVRJsJmFJyw4gUjGfD/GLJvUnL49YwJ3r
	wfJYp1KuaFxxm8C5MoU+zncsRycyVL2QzhWUo9uwCyhS0nBi54iFOYZDhCy04aZatMFDV4
	VQouPiJzFnRXrJwKuFYyqbhijWmBE7EnOLgW8x8tuD6ExLfv17u5zZaCdN/HCf2o4SjAi9
	Srr46+x/dsXZQXe72yYaVR767Y7/Fe683jfPO4kHJluqJQZeLTW4C3GAaAePjRaosSbVQN
	fU1y767OkjkBkPSVZ/F+3bqRr9mGIIOt7gduTSiviL7FidIpGapgWjl2mSoyYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762848796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iS8bnyQucgWZHN+P0qBErFEEzOWJVzY1QyWkbweNgxE=;
	b=eYvUMGkUyQ3g0u6PYvTWET+qWfmNbyVZoPCGWxJEkIbtbVCaXNHjZ17sUJ/vzoOE+3rZXb
	08K/qqLn5OIyPiDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251111081314.j8CFfAD6@linutronix.de>
References: <20251015114952.4014352-1-leonylgao@gmail.com>
 <20251110183854.48b33b50@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110183854.48b33b50@gandalf.local.home>

On 2025-11-10 18:38:54 [-0500], Steven Rostedt wrote:
> On Wed, 15 Oct 2025 19:49:52 +0800
> Yongliang Gao <leonylgao@gmail.com> wrote:
> 
> > diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> > index 090bb5ea4a19..62082a4f60db 100644
> > --- a/kernel/trace/pid_list.c
> > +++ b/kernel/trace/pid_list.c
> > @@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
> >  	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
> >  		return false;
> >  
> > -	raw_spin_lock_irqsave(&pid_list->lock, flags);
> > +	read_lock_irqsave(&pid_list->lock, flags);
> >  	upper_chunk = pid_list->upper[upper1];
> >  	if (upper_chunk) {
> >  		lower_chunk = upper_chunk->data[upper2];
> >  		if (lower_chunk)
> >  			ret = test_bit(lower, lower_chunk->data);
> >  	}
> > -	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> > +	read_unlock_irqrestore(&pid_list->lock, flags);
> >  
> >  	return ret;
> >  }
> 
> Unfortunately you cannot do this because this is called while holding the
> task pi_lock and rq locks. In PREEMPT_RT() the read/write_lock_* turn into
> mutexes.
> 
> Sebastian, is there any equivalent of raw_read/write_locks() that can be
> used?

Nope, no read-write lock that can be used in atomic sections. Well,
there is RCU.

> -- Steve

Sebastian
