Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC32EB5B4;
	Thu, 26 Jun 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952105; cv=none; b=MQizZPjKxBU3bEftJp4/kv2VeRZ93U+Q7Q3NbtmD7Jh+hjoIaAhvffm2w5TKCbz1LEb/Jo68nugXcz4jshRjs0sZHm3wDntQUdW75eA+Zq4JOUibm9HhDVKAB1ipQTQPMS4tVGT6ZrQq8/zUYnVwwvfjKhquTRDfFE3alvmeF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952105; c=relaxed/simple;
	bh=Mm62k2XasOS+s2Wom0/lDqlqaISmC/ws1fOPSwt/rAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReqGAjZJMcZC1tPZWe713UNeAl52qW6bH/PT8JIU39p8AE6HZvI59otDMtJI733hRoQaBXaEm2wD5T3ltzs2uIF1OQ6UYZHHoG8TFrbrMF6590fPNEIo/YHbmC8TJXjfhQlIcHlVdISmLbWsAJ7Rd6VLPJTthja+lcSrlPDdmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 69B4380286;
	Thu, 26 Jun 2025 15:35:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 730E820016;
	Thu, 26 Jun 2025 15:34:59 +0000 (UTC)
Date: Thu, 26 Jun 2025 11:35:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
 john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250626113520.315db641@gandalf.local.home>
In-Reply-To: <20250626151940.1756398-1-namcao@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r3f3kb31c494bit8r9mpjnc6989ha1yz
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 730E820016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/E56kneddSyxlwBYewPNePiT05QtFmRJE=
X-HE-Tag: 1750952099-920767
X-HE-Meta: U2FsdGVkX1+l/0Ie1xFcwA/qm4MKjh5VyaeKDkQGZAMEPRuxtjHIsBA6BA2d0UXzW1XG+BySH5rSinJuyTAj+53s5LwQ/Q19wlkJlFwhHMETqQ3+qpPXSILY18OLswUtGywed+m90HNOBYCJHwSISYPXVu5HDueHz2i8JNSwkbn6WfxhcijbmYrU6pG4s5kWMRPMIJUDmUEPEtTrWZzGgxQUkQvqamg9iyHzJrmrixlGoHt5aoavAX5ueCChuZUIQu1snpl6br9G3ByIO/NycdiyO3cS/ln1UJAN5+xO775ASwEwiXFjiwZUvArCkpov

On Thu, 26 Jun 2025 17:19:40 +0200
Nam Cao <namcao@linutronix.de> wrote:


> However, the memory barriers I see in kernel/trace/ do not resemble the
> above pattern. Therefore I think they are redundant.

I'll focus my comments on the trace code as that's what I understand more.

> 
> Please let me know if there is an unobvious reason for them.

Sure!


>  static void turn_monitoring_on_with_reset(void)
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 95ae7c4e58357..0dff4298fc0e5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -936,7 +936,6 @@ int tracing_is_enabled(void)
>  	 * return the mirror variable of the state of the ring buffer.
>  	 * It's a little racy, but we don't really care.
>  	 */
> -	smp_rmb();
>  	return !global_trace.buffer_disabled;
>  }
>  
> @@ -1107,8 +1106,6 @@ void tracer_tracing_on(struct trace_array *tr)
>  	 * important to be fast than accurate.
>  	 */
>  	tr->buffer_disabled = 0;
> -	/* Make the flag seen by readers */
> -	smp_wmb();
>  }
>  
>  /**
> @@ -1640,8 +1637,6 @@ void tracer_tracing_off(struct trace_array *tr)
>  	 * important to be fast than accurate.
>  	 */
>  	tr->buffer_disabled = 1;
> -	/* Make the flag seen by readers */
> -	smp_wmb();
>  }

The above three interact with each other. Without the barriers, the
tr->buffer_disabled = 0, can be set on one CPU, and the other CPU can think
the buffer is still enabled and do work that will end up doing nothing. Or
it can be set to 1, and the other CPU still sees it disabled and will not
do work when it can.

>  
>  /**
> @@ -2710,8 +2705,6 @@ void trace_buffered_event_enable(void)
>  
>  static void enable_trace_buffered_event(void *data)
>  {
> -	/* Probably not needed, but do it anyway */
> -	smp_rmb();

As the comment says, this one actually isn't needed, and yes, it can be
removed.

-- Steve

>  	this_cpu_dec(trace_buffered_event_cnt);
>  }
>  

