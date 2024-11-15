Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12630165EF8;
	Fri, 15 Nov 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700479; cv=none; b=opCH+CvfwSu+F9NtR4Mkkj/j5oM20PqthEuwH3Y8Px5U/0LnNeROZXRlGol2GKSMN+SKkrChyckClHQtkS3NhusdH7Z4oqL9fSpkcjd9YFvkjfE1N28HL3ZLFXu645+Cw1nM/S2iAVCMImPgpjWZr6ouSRrYbH1L+Hi80udXULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700479; c=relaxed/simple;
	bh=fupS4Vyrgv6gZJfN1UagwtFJMoUw5Oo/wpHPWIT+8tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTLimZWuYnfQvFINKYKlWiC3c9X8jpAzJFR0OfG2E6MhM6fbQFkTl38TEHZSO3cDSU3wX8JdgPpbeNjpUGmSkdZRCyMpsAFHsztY5T45OhL1FOB0tTwa8sUzg3dLp16J3mIJdOhLmfqdsQCF9FHyVsgBpmNngJHwGHCp29zpvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD266C4CECF;
	Fri, 15 Nov 2024 19:54:37 +0000 (UTC)
Date: Fri, 15 Nov 2024 14:55:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241115145502.631c9a2c@gandalf.local.home>
In-Reply-To: <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 16:33:06 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Hi Steve,
> 
> On 15/11/2024 16:25, Steven Rostedt wrote:
> > On Fri, 15 Nov 2024 09:26:07 +0100
> > Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> >   
> >> Nevertheless it sounds like a really high latency for wake_up().
> >>
> >> I have a custom driver which basically gets an IRQ, and calls wake_up on
> >> a read() call. This wake_up() on a high cpu usage can be more than 1ms !
> >> Even with a fifo/99 priority for my kernel thread !
> >>
> >> I don't know if it rings any bell ?
> >> I can obviously do more tests if it can help getting down to the issue :-).  
> > 
> > Try running timerlat.  
> 
> Thanks !
> Here is what I get:
> # echo timerlat > current_tracer
> # echo 1 > events/osnoise/enable
> # echo 25 > osnoise/stop_tracing_total_us
> # tail -10 trace
>              bash-224     [000] d.h..   153.268917: #77645 context  irq timer_latency     45056 ns
>              bash-224     [000] dnh..   153.268987: irq_noise: timer:206  start 153.268879083 duration 93957 ns
>              bash-224     [000] d....   153.269056: thread_noise:  bash:224 start 153.268905324 duration 71045 ns
>        timerlat/0-271     [000] .....   153.269103: #77645 context thread timer_latency    230656 ns
>              bash-224     [000] d.h..   153.269735: irq_noise: timer:206 start 153.269613847 duration 103558 ns
>              bash-224     [000] d.h..   153.269911: #77646 context irq timer_latency     40640 ns
>              bash-224     [000] dnh..   153.269982: irq_noise: timer:206 start 153.269875367 duration 93190 ns
>              bash-224     [000] d....   153.270053: thread_noise: bash:224 start 153.269900969 duration 72709 ns
>        timerlat/0-271     [000] .....   153.270100: #77646 context thread timer_latency    227008 ns
>        timerlat/0-271     [000] .....   153.270155: timerlat_main: stop tracing hit on cpu 0
> 
> It looks awful, right ?

awful is relative ;-) If that was on x86, I would say it was bad.

Also check out rtla (in tools/trace/rtla).

 # rtla timerlat top

                                     Timer Latency                                                                                       
  0 00:00:23   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #21515     |      580       573       599       827 |      598       585       641       860 |      606       589       659       889
  1 #21513     |      461       452       477       506 |      480       315       521       561 |      488       384       539       575
  2 #10827     |      962       961       988      1016 |      983       805      1026      1075 |      989       940      1045      1081
  3 #21512     |       68        61        86       313 |       87        73       128       190 |       95        79       146       338
  4 #21510     |      254       246       271       464 |      273        70       315       473 |      281       183       333       477
  5 #21509     |      397       388       414       441 |      416       215       457       649 |      424       338       475       655
  6 #21508     |      496       496       522       566 |      509       322       563       605 |      515       424       579       611
  7 #21507     |      658       648       675       702 |      676       471       717       757 |      684       627       735       763
---------------|----------------------------------------|----------------------------------------|---------------------------------------
ALL #161401 e0 |                 61       472      1016 |                 70       514      1075 |                 79       532      1081


Or on a virtual machine running on my x86 server:

 # rtla timerlat top

                                     Timer Latency                                                                                       
  0 00:00:19   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #4600      |        4         3      3104      3223 |       41        41      3131      3262 |       46        46      3143      3304
  1 #4589      |     3678         3      3675      3742 |     3705        15      3703      3814 |     3718        22      3716      3828
  2 #4571      |     3118        56      3135      3233 |     3145        79      3162      3260 |     3157        91      3175      3275
  3 #4579      |     3509         3      3514      3625 |     3535         7      3540      3665 |     3547         9      3553      3702
  4 #4676      |        2         1      2912      4016 |       10         5      2940      4044 |       15         7      2952      4060
  5 #4572      |     3446         9      3458      3517 |     3475        32      3486      3562 |     3488        41      3499      3576
  6 #4692      |     3948         0      3767      4002 |     3984         5      3794      4079 |     4000         7      3806      4108
  7 #4580      |     3141         2      3144      3269 |     3168        20      3171      3296 |     3180        30      3184      3332
---------------|----------------------------------------|----------------------------------------|---------------------------------------
ALL #36859  e0 |                  0      3339      4016 |                  5      3366      4079 |                  7      3379      4108

That has some really poor numbers.

-- Steve
