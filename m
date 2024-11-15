Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA5188714;
	Fri, 15 Nov 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659174; cv=none; b=K0+9BUvZvfEANzycM+WrR+81F01OEbiUDNxPBifglBDIZQw0qe8xuBCFdaXxJ5jJ1Iqzu9OVnn5Lkug2yUblyyNF8WNQIh9azTTh9cWZqDf5NJahkdSKw5Ky6KY7R4uux7lH60+TdDE5k0y5wL77wvAIkS61OD1zbAAD99vz0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659174; c=relaxed/simple;
	bh=DwAAWgK7n9NOu50kZzQE0PvinQnYmcgpCjZERziVJLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3uKBh3cnAtUrqVPcmMkfZ0hUawmmFd49w59SMoLvABmqm+DvXpqjr+HIsOagwnjMZw6taZJJGOLkgmym8V+FpkX600q5jO8JixXhjwfsFliUBoK+7Ewz0BOFqlgfOfn6jNCgJABC7Fpost/Hqh1BlRdFtY7YJOjzqpgNnLlYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=KzeOzvwc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="KzeOzvwc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1885820005;
	Fri, 15 Nov 2024 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1731659168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMmSMqKmaxOLfX4G/eur8U70AbvSkihlxFiHAAOgjJs=;
	b=KzeOzvwcZ2Bv6VFZVdO15Vcs767TW4NJgFzYG2plmyTsnEjGMLeYzdfLhp3DBFKzIvek/T
	AcxNgCfXQ91QW2vWSjvSc+PyW0mmQOz4NtO6XrnhPiotFbBabH2VCBK/jDu/mhtXYPXb56
	sMu9tH5Tv25lqgqnw6GFlJ1vcySNgu+8ftFSIaE9B4xe1MaVJIGZ4iRnoO17zN2AEiSL+u
	c4kwAiQ+c3uzvbbQ0EtSNlRvKpZWB7oDBU5nbSe+XBEcapJVZO7fMvoPZ6oJ+7iL7kmIwp
	TZnTg261Bq0ghtc748Vm7MUr/C82iS5P6mjetZT0QmYfnFhibLvUEWo59qzM5w==
Message-ID: <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
Date: Fri, 15 Nov 2024 09:26:07 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Ungerer <gerg@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi all,

On 21/10/2024 11:44, Jean-Michel Hautbois wrote:
> In order to debug latency issues, I wanted to use ftrace on my M54418
> coldfire. Sadly, it is not supported yet.
> Thanks to Steven [1] it does not sound too difficult.
> 
> This small series adds basic functions to make it work, and for the few
> tests I could do, it seems to be working well.

I did a few tests (well, a *lot* to be honest :-)) after adding HR 
timers support on my m68k coldfire kernel.

Now, I think ftrace shows a nice issue, but I think my stack_trace is 
not correct ?

# wakeup_rt latency trace v1.1.5 on 6.12.0-rc4-00116-g2f00ff61fd82-dirty
# --------------------------------------------------------------------
# latency: 451 us, #6/6, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: irq/104-enet-fe-109 (uid:0 nice:0 policy:1 rt_prio:50)
#    -----------------
#
#                    _------=> CPU#
#                   / _-----=> irqs-off/BH-disabled
#                  | / _----=> need-resched
#                  || / _---=> hardirq/softirq
#                  ||| / _--=> preempt-depth
#                  |||| / _-=> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
  telnetd-224       0dnh4.   14us+:      224:120:R   + [000]     109: 
49:R irq/104-enet-fe
  telnetd-224       0dnh4.   50us+: <stack trace>
  telnetd-224       0dnh4.   65us!: 0
  telnetd-224       0d..3.  396us+: __traceiter_sched_switch
  telnetd-224       0d..3.  418us+:      224:120:R ==> [000]     109: 
49:R irq/104-enet-fe
  telnetd-224       0d..3.  440us : <stack trace>


Nevertheless it sounds like a really high latency for wake_up().

I have a custom driver which basically gets an IRQ, and calls wake_up on 
a read() call. This wake_up() on a high cpu usage can be more than 1ms ! 
Even with a fifo/99 priority for my kernel thread !

I don't know if it rings any bell ?
I can obviously do more tests if it can help getting down to the issue :-).

Thanks !

> Here is a simple output I get:
> 
> ```
> 
>              bash-232     [000] d..3.   947.629000: thread_noise:     bash:232 start 947.629000000 duration 0 ns
>        timerlat/0-274     [000] .....   947.629000: #51598 context thread timer_latency    409280 ns
>              bash-232     [000] d.h..   947.630000: #51599 context    irq timer_latency    110720 ns
>              bash-232     [000] dnh1.   947.630000: irq_noise: timer:206 start 947.629000000 duration 1000000 ns
>              bash-232     [000] d..3.   947.630000: thread_noise:     bash:232 start 947.630000000 duration 0 ns
>        timerlat/0-274     [000] .....   947.630000: #51599 context thread timer_latency    407168 ns
>              bash-232     [000] d.h..   947.631000: #51600 context    irq timer_latency    108608 ns
>              bash-232     [000] dnh1.   947.631000: irq_noise: timer:206 start 947.630000000 duration 1000000 ns
>              bash-232     [000] d..3.   947.631000: thread_noise:     bash:232 start 947.631000000 duration 0 ns
>        timerlat/0-274     [000] .....   947.631000: #51600 context thread timer_latency    401472 ns
> ```
> 
> I am very interested by any relevant test to do (switch events ?
> Anything else ?) to improve the series (and the platform :-)).
> 
> I am quite sure I missed a *lot* of things, but it seems to do what I
> need :-). I post it as RFC for now, in particular because I added a new
> file, and I am not sure if it is the proper way.
> 
> Thanks for your remarks and improvements !
> 
> [1]: https://lore.kernel.org/linux-m68k/20241018124511.70d29198@gandalf.local.home
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
> Jean-Michel Hautbois (2):
>        m68k: Add tracirqs
>        arch: m68k: Add STACKTRACE support
> 
>   arch/m68k/Kconfig             |  6 ++++
>   arch/m68k/kernel/Makefile     |  1 +
>   arch/m68k/kernel/irq.c        |  2 ++
>   arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 79 insertions(+)
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241021-add-m68k-tracing-support-36c18d2233d8
> 
> Best regards,

