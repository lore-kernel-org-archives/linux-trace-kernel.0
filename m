Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CC19DF45;
	Tue,  3 Dec 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210519; cv=none; b=Ca2TWjB+2KJvCZ4hm74vDo8hbkrzlLIeEK78Q2Fg9iQQDOQO/8l34N/Qd6o2LNTgMQr7PvbaOqu/K1ZnbYqFRPY+Q4SrszLzFjNdruM+L7ZiABxPjNGL7A5sOx1/1o4VlaU2BSXMkJTbdlpeEt4CDAV59O9OjUiUyigZ1fELPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210519; c=relaxed/simple;
	bh=MNDnIf14ttcW41QceAZpG+KmQb3ywrLXV6fKXU/qXjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEDp0eBXU7s34O/rpU8IvmAso7N8Sdel9izP/DnYDIJJYstaBAKuZSc3uqAqQnK+MWBDNaOgbjJoWiuhWT0glwXGI3GIeBx8oPLLb3n/u4JAdfaTMVNU60EVT3T2qAq4vugyvWwbj59VjWGyHNgmk7fiBzXl6z7gpK9sDO/MsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2XCL3j8nz9sgW;
	Tue,  3 Dec 2024 08:21:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id doaTwbzKneBg; Tue,  3 Dec 2024 08:21:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2XCL2hwVz9sgV;
	Tue,  3 Dec 2024 08:21:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A5CA8B765;
	Tue,  3 Dec 2024 08:21:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ROYUXKmWlZbo; Tue,  3 Dec 2024 08:21:50 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD7CD8B763;
	Tue,  3 Dec 2024 08:21:49 +0100 (CET)
Message-ID: <37824159-8f7b-49ca-80d7-99c6d76e3f9a@csgroup.eu>
Date: Tue, 3 Dec 2024 08:21:49 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
To: Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241017113105.1edfa943@gandalf.local.home>
 <6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
 <20241201150406.17f10247@rorschach.local.home> <Z01Vn8yZv-AlB-Z4@kernel.org>
 <20241202150516.3cf52584@gandalf.local.home>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241202150516.3cf52584@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/12/2024 à 21:05, Steven Rostedt a écrit :
> On Mon, 2 Dec 2024 08:37:19 +0200
> Mike Rapoport <rppt@kernel.org> wrote:
> 
>>>> On powerpc I get:
>>>>
>>>> 25850 pages:14 groups: 3
>>>> ftrace boot update time = 0 (ns)
>>>> ftrace module total update time = 0 (ns)
>>>
>>> Hmm, does powerpc support "trace_clock_local()" at early boot? I
>>> probably can just switch from using "ftrace_now()" to using
>>> ktime_get_real_ts64(). Hmm.
>>
>> The calls to timekeeping_init() and time_init() are after ftrace_init() so
>> unless an architecture sets up some clock in setup_arch() like x86 does
>> there won't be a clock to use.
> 
> Hmm, maybe I should add:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index be62f0ea1814..362a125d7bcc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8588,14 +8588,23 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
>   		return -ENOMEM;
>   
>   	r = scnprintf(buf, DYN_INFO_BUF_SIZE,
> -		      "%ld pages:%ld groups: %ld\n"
> -		      "ftrace boot update time = %llu (ns)\n"
> -		      "ftrace module total update time = %llu (ns)\n",
> +		      "%ld pages:%ld groups: %ld\n",
>   		      ftrace_update_tot_cnt,
>   		      ftrace_number_of_pages,
> -		      ftrace_number_of_groups,
> -		      ftrace_update_time,
> -		      ftrace_total_mod_time);
> +		      ftrace_number_of_groups);
> +
> +	if (ftrace_update_time) {
> +		r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
> +			       "ftrace boot update time = %llu (ns)\n",
> +			       ftrace_update_time);
> +	} else {
> +		r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
> +			       "ftrace boot update time = [Unavailable]\n");
> +	}
> +
> +	r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
> +		       "ftrace module total update time = %llu (ns)\n",
> +		       ftrace_total_mod_time);
>   
>   	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>   	kfree(buf);
> 
> Which should turn the above to:
> 
>    25850 pages:14 groups: 3
>    ftrace boot update time = [Unavailable]
>    ftrace module total update time = 0 (ns)
> 
> Which should at least make it not confusing.

Well. Maybe, but at the end what we need is the measured value, if it 
only works on x86 it is just pointless, isn't it ?

trace_clock_local() calls sched_clock()

I don't know about other architectures, but on powerpc sched_clock() is:

	notrace unsigned long long sched_clock(void)
	{
		return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
	}

boot_tb, tb_to_ns_scale and tb_to_ns_shift are not known before 
time_init() is called.

But get_tb() returns a valid value already so it is possible to get the 
ticks and do the calculation later with tb_to_ns()


> 
> I'm assuming that the module timings are zero because no modules were loaded?

Indeed I don't even have CONFIG_MODULES, maybe the complete line should 
be removed in that case.

Christophe
