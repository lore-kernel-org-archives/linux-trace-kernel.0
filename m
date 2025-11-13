Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FC1946C8;
	Thu, 13 Nov 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043319; cv=none; b=pGve/p52pdwhvKgGGzsXyPsMFiTiA/qgNQFA4IaBJlSTPl+CY3iRMPaZiRkRHGTnJPhmCatsakBeIMrez70xDUENVo6LQIZ3D+fQ3jFiArheHVzhf2GNIDmea2HkDjdq+Nk1tivFfFbF6gvowpeWoetCM79nUyFZsRt4JEa+Lyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043319; c=relaxed/simple;
	bh=nWMhQRjakyXKC4rTkqBZ5NopTYYleHzJwHoDbpGBUhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jomwyN6LHOgZgMmkz4DNUA+n/N5rrs8pjwqcBuU5RPBGwrqbnUrs1XBUdQL/yU1PXWAZ+sSk+PqujNZ36wE1C3nUHZAltFwgo0FO9Vn9RamI2w+/XHpKGnaG8RAXXD6+FAHXbFX9Iqk9ZSB/RVkwkRN2a82o6AbtaMKLot21mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbT+ZjWl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFw0neMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbT+ZjWl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFw0neMO"
Date: Thu, 13 Nov 2025 15:15:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763043316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SiruBdR++j5tVUStoBtH3b0TZxEBb9tGVfS5KkiuCyE=;
	b=dbT+ZjWlYzH5DvbWfZBk0lM29niWzWpkLhd5TAZTyazT7jTMK05q9XW0SVidJ1RYxdPYOc
	J6daknsORyW7fzzbuWSagl/+IqGBdFWarF+BSarXCnmunLGsbodITAbA8s1CBcEadDiNXh
	tDpSgHHUMz0KajgXELIrq+UucEvsFbKWn1UmAPPzKrHQLeaYXqjI3BHKDYbf5zpuCVYihV
	kIKVKf7rn6qUPHb2yztp/Vp85csuNEZbm5IEo1nNE5+iIe7C8NKZXbFrE05ghGVVl3jvgJ
	hD3JKRSCwUttqJ2ZuVnMnx2ZK9NhGWN4v80hrRKrG3E5eDaM0ORwzOUkPXF+Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763043316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SiruBdR++j5tVUStoBtH3b0TZxEBb9tGVfS5KkiuCyE=;
	b=ZFw0neMO1x/Ijtzi3YWRMDCsFa9VFqudEboNgWo3fl/iHGKJfYw6j72TYKcY4imSyDy9n6
	NjAuh4j1z5y40OCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113141515.iZSIDK0T@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
 <20251113073420.yko6jYcI@linutronix.de>
 <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>

On 2025-11-13 19:13:23 [+0800], Yongliang Gao wrote:
> Hi Sebastian,
Hi Yongliang,

> Thank you for your review and the thoughtful questions.
> 
> 1. Performance Data
> We encountered this issue in a production environment with 288 cores
> where enabling set_ftrace_pid caused system CPU usage (sys%) to
> increase from 10% to over 90%. In our 92-core VM test environment:
> 
> Before patch (spinlock):
> - Without filtering: cs=2395401/s, sys%=7%
> - With filtering: cs=1828261/s, sys%=40%
> 
> After patch (seqlock):
> - Without filtering: cs=2397032/s, sys%=6%
> - With filtering: cs=2398922/s, sys%=6%
> 
> The seqlock approach eliminates the pid_list->lock contention that was
> previously causing sys% to increase from 7% to 40%.
> 
> 2. Reader Retry Behavior
> Yes, if the write side is continuously busy, the reader might spin and
> retry. However, in practice:
> - Writes are infrequent (only when setting ftrace_pid filter or during
> task fork/exit with function-fork enabled)
> - For readers, trace_pid_list_is_set() is called on every task switch,
> which can occur at a very high frequency.

See.

> 3. Result Accuracy
> You're correct that the result might change immediately after the
> read. For trace_ignore_this_task(), we don't require absolute
> accuracy. Slight race conditions (where a task might be traced or not
> in borderline cases) are acceptable.

I don't see why RCU work shouldn't work here.
If a pid is removed then it might result that a chunk cleared/ removed
then upper_chunk/ lower_chunk can become NULL. The buffer itself can be
reused and point to something else. It could lear to a false outcome in
test_bit(). This is handled by read_seqcount_retry().

You could assign upper1, upper2, to NULL/ buffer as now and the removal
(in put_lower_chunk(), put_upper_chunk()) delay to RCU so it happens
after the grace period. That would allow you to iterate over it in
trace_pid_list_is_set() lockless since the buffer will not disappear and
will not be reused for another task until after all reader left.

Additionally it would guarantee that the buffer is not released in
trace_pid_list_free(). I don't see how the seqcount ensures that the
buffer is not gone. I mean you could have a reader and the retry would
force you to do another loop but before that happens you dereference the
upper_chunk pointer which could be reused.

So I *think* the RCU approach should be doable and cover this.

> Best regards,
> Yongliang

Sebastian
