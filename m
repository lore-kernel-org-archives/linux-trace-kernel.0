Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B266355046;
	Thu, 13 Nov 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050064; cv=none; b=HGdoiW4dRPrI3kRtIU44skuopMQDdaUVQRgxVLfy8bPWfLofqXDlZ7V7u4U0jcYin+LmLtuGueTJrsmYfY4Sr0q2Xc8BxtArJOFmADM2TAlB2Tg1BwtSLyHckku0XfmPbbr2h90EzPwFHLSHj+g1uUU6Lj9Z3wGv1bYvWa3GHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050064; c=relaxed/simple;
	bh=q0+L/lLIcVNBX5fc3fh1/xOtwybgUXpbT5ypcGBWn30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUdXWetmsG2v+BWSvWNliBom33EK9++WQZSDIzJ8XmIu2Koz0lhjLMmIMwwSL+IKH6VuUlVwctklUEcwKYCtDdWLImnJHVqNFUmOayyA25g0kYWXHked1qrA7yyIafee35OQeaN+BqYZIeFj60EcWAHpS0rshvhShqXym4+jtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+xBkTHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kilGL2jT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+xBkTHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kilGL2jT"
Date: Thu, 13 Nov 2025 17:07:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763050061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocxj8oRuKdUREIAybisCmjT8Dxwm585IWb8bi8Dx5qI=;
	b=k+xBkTHu+N/YmxcFt5h5cFgxwJtjnoALTv8eC+8UyjfUfFgeWI4pXfIB+GaXkZtns283z8
	wrLlJMXBQzGPtRIyeW2nvUkx+8lr9teTXgCu1/JIRoN9y19FKf1eXrb2rrTq34f6Xyd9GS
	01ngCsNW/Qrv+HJ9wAappU1Re8GDFhD02dJD87NfXy6qFZ5hwTPGJNafmFR5zrqcKDxK9X
	H0CmJBFwAxIsQybznVQg9LBKr2OY1ggipWGzIipwFumjs4+gFx+FpvKkXSwC7CY1k5AFow
	4PKqlPEnQW2pQuBd/9fcZ1XOfgRwCyaZ1dlj6gKsDmf0iVVBGbRMtSSkuMeJmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763050061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocxj8oRuKdUREIAybisCmjT8Dxwm585IWb8bi8Dx5qI=;
	b=kilGL2jTXxUZ1d2renTkcJH/ubnwkzLBbZ3k5A1WGQ4F6PfH+ZKVmK0q0J/kgERtwKp/KM
	pLLWvG+ZbVoBwrCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113160739.DUvh9i_o@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
 <20251113073420.yko6jYcI@linutronix.de>
 <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
 <20251113141515.iZSIDK0T@linutronix.de>
 <20251113100524.5c5f6bdc@gandalf.local.home>
 <20251113151729.4Zky6d-t@linutronix.de>
 <20251113102445.3e70c1ec@gandalf.local.home>
 <20251113153508.9mYBNQlL@linutronix.de>
 <20251113105106.4270f6ac@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113105106.4270f6ac@gandalf.local.home>

On 2025-11-13 10:51:06 [-0500], Steven Rostedt wrote:
> Yes, because they are only tested in sched_switch and fork and exit tracepoints.
> 
> Although, this was written when tracepoint callbacks were always called
> under preempt disable. Perhaps we need to change that call to:
> 
> 	tracepoint_synchronize_unregister()
> 
> Or add a preempt_disable() around the callers.

Please don't. Please do a regular rcu_read_lock() ;)
I tried to get rid of the preempt_disable() around tracepoints so that
the attached BPF callbacks are not invoked with disabled preemption. I
haven't followed up here in a while but I think Paul's SRCU work goes
in the right direction.

> I'm very nervous about using RCU here. It will add a lot more corner cases
> that needs to be accounted for. The complexity doesn't appear to be worth
> it. I'd rather just keep the raw spin locks than to convert it to RCU.
> 
> The seqcount makes sense to me. It's simple and keeps the same paradigm as
> what we have. What's wrong with using it?

I'm fine with it once you explained under what conditions retry can
happen.  Thank you.

> -- Steve

Sebastian
