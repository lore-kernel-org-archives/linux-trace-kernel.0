Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC301CC8A0;
	Tue, 19 Nov 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026248; cv=none; b=olqIVTw6mWvnn1piKTcoTq2hnw2+UbMRlGtLPOUop1crs9FX4HKdddLYlJr4RvU3p9F7AGig2HCdvJmKHjBEE09vSiEkR2eUjmx9tJ4iyn5TD/8+GX3EmQHARUBtAe2g/mlT+vyn7bnqCj/VlFWzHZBB1x7R7B+lZtYWgmQ/Fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026248; c=relaxed/simple;
	bh=I+RQjzCvAy5yXICFQwsvOhcvUC8jzz/PiP41uPebjxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3B1whImolRLS54HEwSStfQWHOh2pR98lY65+ICE2VluGvZIiShVX4Yb/WlU13tpYZTs75Cne5uTCN+oDRzFSoqotR0U2xZeEUwtf3itvvrqfgmGNbfHHA82/3ja4APho7lz1G3Y+S2ChRqzee/hGwJz4kiNfAUwQMgHQHiWXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=bM7T+Jw7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="bM7T+Jw7"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B3D7FF814;
	Tue, 19 Nov 2024 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732026242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOrBNdpqCu63uMjsBgXZUlLowF58/yilyYWntoqR9TE=;
	b=bM7T+Jw7G5jEjq1oBNJiIIUZFcOdKVsJJ+zsYoDUFfk+tXPsdO8x+EmtkMM5nKoObR3POG
	udpd0kMb0WbaLBsvheO8PPmlZRPtv9sNHf+Q6mv209rkY8BpHPgiy8ycs75g0gcqlIAoDG
	BgcalUR4v1WuUtdV6GxYfDZigAuZpUTbh07Qu/3yO17+554yKWr2uyCK0whfGRbxYpjseG
	RVpmW+d39h5bnfHXmtl6ss2qwsDgB0UZTaTJQm9it/DwXFzX2bCt5N3IgCPOKQWVoH+apT
	sW//2uLM/kVHdxWPlxyhy+radnFLWr31HFrFil3N24LEr4ISxnXB1r1oZ4xnOg==
Message-ID: <22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
Date: Tue, 19 Nov 2024 15:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Tomas Glozar <tglozar@redhat.com>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
 <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
 <20241118152057.13042840@gandalf.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241118152057.13042840@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve !

On 18/11/2024 21:20, Steven Rostedt wrote:
> 
> [ Added Tomas as he knows this code better than I do ]

Thanks !

> 
> On Mon, 18 Nov 2024 11:11:48 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> Hi Steve,
>>
>> On 15/11/2024 20:55, Steven Rostedt wrote:
>>> On Fri, 15 Nov 2024 16:33:06 +0100
>>> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>    
>>>> Hi Steve,
>>>>
>>>> On 15/11/2024 16:25, Steven Rostedt wrote:
>>>>> On Fri, 15 Nov 2024 09:26:07 +0100
>>>>> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>>>       
>>>>>> Nevertheless it sounds like a really high latency for wake_up().
>>>>>>
>>>>>> I have a custom driver which basically gets an IRQ, and calls wake_up on
>>>>>> a read() call. This wake_up() on a high cpu usage can be more than 1ms !
>>>>>> Even with a fifo/99 priority for my kernel thread !
>>>>>>
>>>>>> I don't know if it rings any bell ?
>>>>>> I can obviously do more tests if it can help getting down to the issue :-).
>>>>>
>>>>> Try running timerlat.
>>>>
>>>> Thanks !
>>>> Here is what I get:
>>>> # echo timerlat > current_tracer
>>>> # echo 1 > events/osnoise/enable
>>>> # echo 25 > osnoise/stop_tracing_total_us
>>>> # tail -10 trace
>>>>                bash-224     [000] d.h..   153.268917: #77645 context  irq timer_latency     45056 ns
>>>>                bash-224     [000] dnh..   153.268987: irq_noise: timer:206  start 153.268879083 duration 93957 ns
>>>>                bash-224     [000] d....   153.269056: thread_noise:  bash:224 start 153.268905324 duration 71045 ns
>>>>          timerlat/0-271     [000] .....   153.269103: #77645 context thread timer_latency    230656 ns
>>>>                bash-224     [000] d.h..   153.269735: irq_noise: timer:206 start 153.269613847 duration 103558 ns
>>>>                bash-224     [000] d.h..   153.269911: #77646 context irq timer_latency     40640 ns
>>>>                bash-224     [000] dnh..   153.269982: irq_noise: timer:206 start 153.269875367 duration 93190 ns
>>>>                bash-224     [000] d....   153.270053: thread_noise: bash:224 start 153.269900969 duration 72709 ns
>>>>          timerlat/0-271     [000] .....   153.270100: #77646 context thread timer_latency    227008 ns
>>>>          timerlat/0-271     [000] .....   153.270155: timerlat_main: stop tracing hit on cpu 0
>>>>
>>>> It looks awful, right ?
>>>
>>> awful is relative ;-) If that was on x86, I would say it was bad.
>>>
>>> Also check out rtla (in tools/trace/rtla).
>>
>> Thanks ! I knew it only by name, so I watched a presentation recorded
>> during OSS summit given by Daniel Bristot de Oliveira who wrote it and
>> it is really impressive !
>>
>> I had to modify the source code a bit, as it does not compile with my
>> uclibc toolchain:
>> diff --git a/tools/tracing/rtla/Makefile.rtla
>> b/tools/tracing/rtla/Makefile.rtla
>> index cc1d6b615475..b22016a88d09 100644
>> --- a/tools/tracing/rtla/Makefile.rtla
>> +++ b/tools/tracing/rtla/Makefile.rtla
>> @@ -15,7 +15,7 @@ $(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
>>    $(call allow-override,LDCONFIG,ldconfig)
>>    export CC AR STRIP PKG_CONFIG LD_SO_CONF_PATH LDCONFIG
>>
>> -FOPTS          := -flto=auto -ffat-lto-objects -fexceptions
>> -fstack-protector-strong   \
>> +FOPTS          := -flto=auto -ffat-lto-objects -fexceptions \
>>                   -fasynchronous-unwind-tables -fstack-clash-protection
>>    WOPTS          := -O -Wall -Werror=format-security
>> -Wp,-D_FORTIFY_SOURCE=2             \
>>                   -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
> 
> I'm not sure what the consequence of the above would be. Perhaps Daniel
> just copied this from other code?
> 
>> diff --git a/tools/tracing/rtla/src/timerlat_u.c
>> b/tools/tracing/rtla/src/timerlat_u.c
>> index 01dbf9a6b5a5..92ad2388b123 100644
>> --- a/tools/tracing/rtla/src/timerlat_u.c
>> +++ b/tools/tracing/rtla/src/timerlat_u.c
>> @@ -15,10 +15,16 @@
>>    #include <pthread.h>
>>    #include <sys/wait.h>
>>    #include <sys/prctl.h>
>> +#include <sys/syscall.h>
>>
>>    #include "utils.h"
>>    #include "timerlat_u.h"
>>
>> +static inline pid_t gettid(void)
>> +{
>> +       return syscall(SYS_gettid);
>> +}
>> +
>>    /*
>>     * This is the user-space main for the tool timerlatu/ threads.
>>     *
>> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
>> index 9ac71a66840c..b754dc1016a4 100644
>> --- a/tools/tracing/rtla/src/utils.c
>> +++ b/tools/tracing/rtla/src/utils.c
>> @@ -229,6 +229,9 @@ long parse_ns_duration(char *val)
>>    #elif __s390x__
>>    # define __NR_sched_setattr    345
>>    # define __NR_sched_getattr    346
>> +#elif __m68k__
>> +# define __NR_sched_setattr    349
>> +# define __NR_sched_getattr    350
>>    #endif
>>
>>    #define SCHED_DEADLINE         6
>>
>> But it is not enough, as executing rtla fails with a segfault.
>> I can dump a core, but I could not manage to build gdb for my board so I
>> can't debug it (I don't know how to debug a coredump without gdb !).
> 
> printf()!  That's how I debug things without gdb ;-)

Indeed printf gave me clues !
It appears to be a bug in libtracefs (v1.8.1). rtla segfaults when 
calling tracefs_local_events() in trace_instance_init().

Debugging libtracefs pointed me to the load_events() function, and the 
segfault happens after tep_parse_event() is called for 
"/sys/kernel/debug/tracing/events/vmscan/mm_vmscan_write_folio/format".

Going through the calls I get to event_read_print_args().
I changed libtraceevent log level to get the warnings, and it says:
libtraceevent: Resource temporarily unavailable
   unknown op '.'
Segmentation fault

JM





