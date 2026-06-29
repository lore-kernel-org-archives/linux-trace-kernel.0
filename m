Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB93C3C15;
	Mon, 29 Jun 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758880; cv=none; b=oZnt4uQmDXjcFnvGnutUPAb42f2VrIbx6qW6DQosGF/A2s8vJYbbcPU0rUAvUfaFVVydThIKv3mgXziQtGWruQkHf++hUU/gqZHKPBYqRpr2OH7UTxrfLCYDQa5FxWmd1iLzUal3/UNZQDybYaNLtvIT7313p2prdNFiCBenhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758880; c=relaxed/simple;
	bh=wKaUsPjJpGeMfKpYuC4iyNqlvAL/iPh0MiK8ewG7bc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxcloKjMJviCLVNuMmAJTeVcijk6wi2+MV6py+7uFHzlSuyNnimNv4K7rH2sYCwMCco9muZaLuXfHNITG0g0q/ophA9EYE3R0ZusGFLYovbGpfQBKEoKZkrUCxXQRo8n9LQYaMCogDD7J/Igbf2sDo4kHOz+L7n2m8GzLMEz9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9155F4023E;
	Mon, 29 Jun 2026 18:39:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 45CAB20029;
	Mon, 29 Jun 2026 18:39:49 +0000 (UTC)
Date: Mon, 29 Jun 2026 14:39:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com,
 jkoolstra@xs4all.nl
Subject: Re: [PATCH v2] tracing: Use seq_buf for string concatenation
Message-ID: <20260629143947.2216574e@robin>
In-Reply-To: <20260622094623.18469-1-woradorn.laon@gmail.com>
References: <20260622094623.18469-1-woradorn.laon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 45CAB20029
X-Stat-Signature: aptfh4i5r149ds46za3fzkzu6y1t5f3i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UdX3MuGmiVV3BjQtK1+UnHsQyKqT0O+w=
X-HE-Tag: 1782758389-37090
X-HE-Meta: U2FsdGVkX18QUzxvTblpzQCS47wkO+lDIZQ0iluXK9Zy1hVMrp5amtfLymFYuTh9MRCzYYtomV1RKJr+kekZuATvf6nKP1IQ0C8zESXk33hipQDxL0sXEymmrEWdFCRJFdJHmE9wESi810B8Bb373YMYfsPQXf7hmVsiFBxVq77q3WxDAXC1n8pf1WzE9QVLcuL4OXuOO+CW+6h6EYJmidCr7TyIV7LmVWjXxwTPEbVIqsBgdpFn4/eYcaChXjr1OPqHDAmK4Q5iy9tq/orW/doEVk0Lxw5vYUqhQkUOi6r1GvsUAsKl0nJsqvGVS2XzLTP697Zgb2Ms2DR14hPbIqGBydCiEvIv

On Mon, 22 Jun 2026 16:46:23 +0700
Woradorn Laodhanadhaworn <woradorn.laon@gmail.com> wrote:

>  
>  #include <trace/events/sched.h>
>  #include <trace/syscall.h>
> @@ -4500,14 +4501,20 @@ static void __add_event_to_tracers(struct trace_event_call *call)
>  extern struct trace_event_call *__start_ftrace_events[];
>  extern struct trace_event_call *__stop_ftrace_events[];
>  
> -static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;

Keep the above string and just assign it.

> +static struct seq_buf bootup_event_buf __initdata = {
> +	.buffer = (char[COMMAND_LINE_SIZE]) {},
> +	.size = COMMAND_LINE_SIZE,
> +};

static struct seq_buf bootup_event_seq __initdata = {
	.buffer = bootup_event_buf;
	.size = sizeof(bootup_event_buf);
};

>  
>  static __init int setup_trace_event(char *str)
>  {
> -	if (bootup_event_buf[0] != '\0')
> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
> +	if (seq_buf_used(&bootup_event_buf) > 0)
> +		seq_buf_puts(&bootup_event_buf, ",");
> +
> +	seq_buf_puts(&bootup_event_buf, str);
>  
> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
> +	if (seq_buf_has_overflowed(&bootup_event_buf))
> +		return -ENOMEM;
>  
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event tracing");
> @@ -4766,7 +4773,7 @@ static __init int event_trace_enable(void)
>  	 */
>  	__trace_early_add_events(tr);
>  
> -	early_enable_events(tr, bootup_event_buf, false);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), false);

The above then would be:

	seq_buf_str(&bootup_event_seq);
	early_enable_events(tr, bootup_event_buf, false);

Don't typecast a const char* to non const.

>  
>  	trace_printk_start_comm();
>  
> @@ -4794,7 +4801,7 @@ static __init int event_trace_enable_again(void)
>  	if (!tr)
>  		return -ENODEV;
>  
> -	early_enable_events(tr, bootup_event_buf, true);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), true);

Same here.

-- Steve

>  
>  	return 0;
>  }

