Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E83271F2;
	Thu, 13 Nov 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019269; cv=none; b=ThYpKNL0nGVb/4TtBg8Gdea6kdVo+y4NCngI8MdQFU+qqOLugbpIqsIwI+dyb9SNQ7n98MLevkwSYTyLgbMRFs1YCeeZ3VXf9DdXin1LTgE+35HmPlKdDzA5B4QHF1iFboKM4B3bw+IeVK78BaIUL0/p1msEoSu8HtPgapMbZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019269; c=relaxed/simple;
	bh=ErrW00zPFsMJic1YBMp6PFR4d2YGk1aFFvZoDBgxAt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICR0DBnDH+n+EJTeI5yrN+sbccF1S52K6te9a9YAiYjBDMV8J3ODOW8BOBHucg5L/3dyFEFmpGqXbK6Po9jZTeibm4EmZKGtlpGrfJhwYyD8UWvw164h2swWSkODO54JZHwGfd0PjdxJ2Utbvb7EiovjN3VKREzKrvBfDJwsDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8iF1h7g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3IjR4oXB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8iF1h7g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3IjR4oXB"
Date: Thu, 13 Nov 2025 08:34:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763019261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcMVfIIaThb3yRE3rsT47vwjHoJGGF8h8MeLWn7WdYk=;
	b=Z8iF1h7g6+4L+iK5bceM3jdE9QZFXH9fI48/TlD3GPUVa81WZIrBrto+6+sY0z500eQF2h
	C+AxgIj5vsx9PQ39BD4ccyr8Yy1NEf1s+zHwvUdYZfB8Z4y3mx4MmGFwmrFVXW6U8Q8Lkq
	0BhbQmZr38UhMtJeKzfJzef6d+1PbCllvcdUFgS6s8hYp6M7aiQR2atmcWetlJ03mvFfOO
	AptTBVrMMRVpCoLE8kD2ASyB0PjJiX6FqpL+m/+JiPRmhnjxT81tONbzJt7DknTf2Wos8E
	G45TRB5hNBijZsj+c4IfrT7sEGBijr0+wEaeWHIKjOT25VhAZGDXFrRMlsJkBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763019261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcMVfIIaThb3yRE3rsT47vwjHoJGGF8h8MeLWn7WdYk=;
	b=3IjR4oXBlBuf7Sc/NWvOKZy6DjqlOg5XgUVOQSAvXFTUQfUdFTd2Hp0ntoBYBev52sWELZ
	qBV63Wn2zDo7tpAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113073420.yko6jYcI@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113000252.1058144-1-leonylgao@gmail.com>

On 2025-11-13 08:02:52 [+0800], Yongliang Gao wrote:
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -138,14 +139,16 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
>  	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
>  		return false;
>  
> -	raw_spin_lock_irqsave(&pid_list->lock, flags);
> -	upper_chunk = pid_list->upper[upper1];
> -	if (upper_chunk) {
> -		lower_chunk = upper_chunk->data[upper2];
> -		if (lower_chunk)
> -			ret = test_bit(lower, lower_chunk->data);
> -	}
> -	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> +	do {
> +		seq = read_seqcount_begin(&pid_list->seqcount);
> +		ret = false;
> +		upper_chunk = pid_list->upper[upper1];
> +		if (upper_chunk) {
> +			lower_chunk = upper_chunk->data[upper2];
> +			if (lower_chunk)
> +				ret = test_bit(lower, lower_chunk->data);
> +		}
> +	} while (read_seqcount_retry(&pid_list->seqcount, seq));

How is this better? Any numbers?
If the write side is busy and the lock is handed over from one CPU to
another then it is possible that the reader spins here and does several
loops, right?
And in this case, how accurate would it be? I mean the result could
change right after the sequence here is completed because the write side
got active again. How bad would it be if there would be no locking and
RCU ensures that the chunks (and data) don't disappear while looking at
it?

>  	return ret;
>  }

Sebastian
