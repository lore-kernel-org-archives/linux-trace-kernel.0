Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D520F7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879568; cv=none; b=CYKI0b5/ytH2xQIrHLhBR/01K3hGU1/rQAfmzKFGLks4IzN6jQ1YB6HaroOwFrv92NqHPNK3Q4QKUyORFFCLsP5zykRlVK8F3Zs1L9LgwF6kpGpHN1d6V0tHrBOFreG0i+EfKATjxkXHICgw+wCgRWoIHT/QSLqf8K7qc9IQ15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879568; c=relaxed/simple;
	bh=2chKkVNyv+a25tr2l19cV9NQvnf2nRozHkVqSiQZ+jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRWo8Uyi5raPvMnIWjr4AHeUfnUgnb5UsIhi0kCWVxzJpt7v8wZGmO3VZLSXJ5V8pYQ7FxPR08JxWCJCuYGceNbNP5kknyyVAyb6fRr/McDZYUI0XIwItQr6V1PHIFBEzy6VtSqn5+ePJfFytp16LKiP4D3yYXtbbuFM7Gc0ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rVtLY-0003u8-4f; Fri, 02 Feb 2024 14:12:44 +0100
Message-ID: <0db9ff92-c643-4559-929b-fb375efab514@pengutronix.de>
Date: Fri, 2 Feb 2024 14:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Boot-time dumping of ftrace fuctiongraph buffer
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
 <20240202150403.7ccc4126dbeaad8bdf77c384@kernel.org>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240202150403.7ccc4126dbeaad8bdf77c384@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-trace-kernel@vger.kernel.org

Hello Masami-san,

On 02.02.24 07:04, Masami Hiramatsu (Google) wrote:
> On Thu, 1 Feb 2024 13:21:37 +0100
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> For drivers that don't call dev_err_probe, I find myself sometimes doing printf
>> debugging inside the probe function.

[snip]

>> I would like to replace this with the function graph tracer:
>>
>>   - record the probe function, configured over kernel command line
>>     (The device indefinitely deferring probe is printed to the console,
>>      so I know what I am looking for on the next boot)
>>
>>   - Dump the function graph trace
>>
>>   - See if the last call before (non-devm) cleanup is getting a clock, a GPIO,
>>     a regulator or w/e.
> 
> What kind of information you prints by the printk()?

Just littering around some:

  pr_notice("%s:%d\n", __func__, __LINE__);

to find where the probe function exits.

> If the target (suspicious driver probe function) is obvious, you can use kprobe
> event and tp_printk. Or, even if you don't know, if you are sure which function
> is the starting/ending point, you can use bootconfig to record the specific part
> of execution in the ring buffer, and dump it as Steve said.
> 
> In Documentation/trace/boottime-trace.rst, there is an example.
> -----
> With the trigger action and kprobes, you can trace function-graph while
> a function is called. For example, this will trace all function calls in
> the pci_proc_init()::
> 
>   ftrace {
>         tracing_on = 0
>         tracer = function_graph
>         event.kprobes {
>                 start_event {
>                         probes = "pci_proc_init"
>                         actions = "traceon"
>                 }
>                 end_event {
>                         probes = "pci_proc_init%return"
>                         actions = "traceoff"
>                 }
>         }
>   }

I get comparable tracing with the kernel command line, but lacked a way to dump
it at boot-time. Sorry should have been clearer.

Grepping the kernel source for `ftrace_func_command' lets me think that
what I am after might be:

  end_event {
    actions = "traceoff", "dump"
  }

I need to try it out. Do you happen to know if the equivalent is possible
without bootconfig?

Thank you!
Ahmad


> -----
> 
> Thank you,
> 
>>
>> For this to be maximally useful, I need to configure this not only at boot-time,
>> but also dump the ftrace buffer at boot time. Probe deferral can hinder the kernel from
>> calling init and providing a shell, where I could read /sys/kernel/tracing/trace.
>>
>> I found following two mechanisms that looked relevant, but seem not to
>> do exactly what I want:
>>
>>   - tp_printk: seems to be related to trace points only and not usable
>>     for the function graph output
>>
>>   - dump_on_oops: I don't get an Oops if probe deferral times out, but maybe
>>     one could patch the kernel to check a oops_on_probe_deferral or dump_on_probe_deferral
>>     kernel command line parameter in deferred_probe_timeout_work_func()?
>>
>>
>> Is there existing support that I am missing? Any input on whether this
>> would be a welcome feature to have?
>>
>> Thanks!
>>
>> Cheers,
>> Ahmad
>>     
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>  
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

