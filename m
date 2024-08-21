Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD7405A;
	Wed, 21 Aug 2024 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274119; cv=none; b=bCRnpziRH2o4a39Geiu9blBWiSzbskYAwedHKlYEBNFcY96N24t4qNvm8XcoMCYrr0S2ycdb33y9WF3EexA7MtgOhwBAiAe+WlILWxQfLy6JGAwKwAUqVApZ7k/XbP8qN2RumHsDmDw8lIWCJIrNEK1o+SoIqJLOVnUU6o08jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274119; c=relaxed/simple;
	bh=axJBu3CUhWokrQ9Xfcw1QiyMu4W37gK/cV9/3xY2h24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r9mia5XSJRfGPkKnEYse/mnfG1dLE41XlsNmSyvNHc2D/mTA9NG1GQOLnqsCLtNPI1ZBCHU+zpjC26rBi0ICmO7lGigr6hQHch2gEX+lpKTY6TWb1yVaul60SRbnSIAfXvxA/oyFEwl5aXBvdeMWaZRp00O0kNaPRjHTqfDqheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4d2.dynamic.kabel-deutschland.de [95.90.244.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68D1661E5FE05;
	Wed, 21 Aug 2024 23:01:39 +0200 (CEST)
Message-ID: <9de8ebd1-53fc-48d7-af11-b5c1ed828b3d@molgen.mpg.de>
Date: Wed, 21 Aug 2024 23:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de>
 <87o7ak411y.fsf@somnus> <256fdb2e-9b83-4837-bd31-0c34e4267c31@molgen.mpg.de>
 <87sezv7ytw.fsf@somnus> <1cf78f6f-af21-48bc-a9d8-755dd7bf8503@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <1cf78f6f-af21-48bc-a9d8-755dd7bf8503@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Added URLs for files.]

Am 21.08.24 um 10:20 schrieb Paul Menzel:
> Dear Anna-Maria,
> 
> 
> Thank you very much for the support. I was finally able to collect the 
> data you asked for.
> 
> Am 09.04.24 um 09:57 schrieb Anna-Maria Behnsen:
>> Paul Menzel writes:
> 
> […]
> 
>>> Am 08.04.24 um 12:10 schrieb Anna-Maria Behnsen:
>>>
>>>> Paul Menzel writes:
>>>
>>>>> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux 6.9- 
>>>>> rc2+
>>>>> built from commit b1e6ec0a0fd0 (Merge tag 'docs-6.9-fixes' of
>>>>> git://git.lwn.net/linux) the external USB-C adapter Dell DA300 stopped
>>>>> working (only the Ethernet port was used). Linux logged:
>>>>
>>>> thanks for the report. Can you please provide a trace beside the dmesg
>>>> output? The following trace events should be enabled (via kernel 
>>>> command
>>>> line):
>>>>
>>>> trace_event=timer:*,timer_migration:*,sched:sched_switch,sched:sched_wakeup,sched:sched_process_hang,irq:softirq_entry,irq:softirq_raise,irq:softirq_exit
>>> Unfortunately I haven’t been able to reproduce it until now. Should it
>>> happen again, I am going to try your suggestion.
>>
>> Thanks for letting me know.
> 
> I wanted to configure that in the running system, but wasn’t able to set 
> all of these at once with `set_event`:
> 
>      echo 'timer:*,timer_migration:*,sched:sched_switch,sched:sched_wakeup,sched:sched_process_hang,irq:softirq_entry,irq:softirq_raise,irq:softirq_exit' | sudo tee /sys/kernel/tracing/set_event
> 
> For some reason setting them individually also did *not* work:
> 
>      for e in timer:* timer_migration:* sched:sched_switch sched:sched_wakeup sched:sched_process_hang irq:softirq_entry irq:softirq_raise irq:softirq_exit'; do echo "$e" | sudo tee -a /sys/kernel/tracing/set_event; done
> 
> I then used
> 
>      echo 1 | sudo tee /sys/kernel/tracing/events/timer/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/timer_migration/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/sched/sched_switch/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/sched/sched_wakeup/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/sched/sched_process_hang/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/irq/softirq_entry/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/irq/softirq_raise/enable
>      echo 1 | sudo tee /sys/kernel/tracing/events/irq/softirq_exit/enable
> 
> and also had to increase the buffer to bridge the gap between the event 
> and me noticing it:
> 
>      echo 96000 | sudo tee /sys/kernel/tracing/buffer_size_kb
> 
> Then, with Linux v6.11-rc4-11-g521b1e7f4cf0b, I was able to get the 
> trace for the event below:
> 
>      [ 7542.706299] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> 
> $ sudo cat /sys/kernel/tracing/trace
> […]
>   MediaPD~der #28-14000   [000] d..1.  7542.703768: hrtimer_cancel: hrtimer=000000008d2c9f3f
>   MediaPD~der #28-14000   [000] .....  7542.703810: hrtimer_init: hrtimer=00000000c6f259e7 clockid=CLOCK_MONOTONIC mode=ABS
>   MediaPD~der #28-14000   [000] d..1.  7542.703812: hrtimer_start: hrtimer=00000000c6f259e7 function=hrtimer_wakeup expires=7602581538204 softexpires=7602581488204 mode=ABS
>   MediaPD~der #28-14000   [000] d..2.  7542.703821: sched_switch: prev_comm=MediaPD~der #28 prev_pid=14000 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dN.2.  7542.703931: sched_wakeup: comm=ImageBridgeChld pid=6041 prio=120 target_cpu=000
>            <idle>-0       [000] d..2.  7542.703937: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ImageBridgeChld next_pid=6041 next_prio=120
>   ImageBridgeChld-6041    [000] d..2.  7542.704041: sched_switch: prev_comm=ImageBridgeChld prev_pid=6041 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dN.2.  7542.704174: sched_wakeup: comm=Renderer pid=4113 prio=120 target_cpu=000
>            <idle>-0       [000] d..2.  7542.704179: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=Renderer next_pid=4113 next_prio=120
>          Renderer-4113    [000] d..2.  7542.704245: sched_switch: prev_comm=Renderer prev_pid=4113 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dNh2.  7542.704260: sched_wakeup: comm=IPC I/O Child pid=6029 prio=120 target_cpu=000
>            <idle>-0       [000] d..2.  7542.704267: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=IPC I/O Child next_pid=6029 next_prio=120
>     IPC I/O Child-6029    [000] d..2.  7542.704340: sched_switch: prev_comm=IPC I/O Child prev_pid=6029 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dN.2.  7542.704786: sched_wakeup: comm=Compositor pid=4123 prio=120 target_cpu=000
>            <idle>-0       [000] d..2.  7542.704791: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=Compositor next_pid=4123 next_prio=120
>        Compositor-4123    [000] d..2.  7542.704944: sched_switch: prev_comm=Compositor prev_pid=4123 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dN.2.  7542.705943: sched_wakeup: comm=Compositor pid=4123 prio=120 target_cpu=000
>            <idle>-0       [000] d..2.  7542.705950: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=Compositor next_pid=4123 next_prio=120
>        Compositor-4123    [000] d..2.  7542.706105: sched_switch: prev_comm=Compositor prev_pid=4123 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] d.h2.  7542.706328: hrtimer_cancel: hrtimer=000000009bbda66a
>            <idle>-0       [000] d.h1.  7542.706329: hrtimer_expire_entry: hrtimer=000000009bbda66a function=tick_nohz_handler now=7542584007490
>            <idle>-0       [000] d.h1.  7542.706333: softirq_raise: vec=9 [action=RCU]
>            <idle>-0       [000] d.h1.  7542.706338: softirq_raise: vec=7 [action=SCHED]
>            <idle>-0       [000] d.h1.  7542.706339: hrtimer_expire_exit: hrtimer=000000009bbda66a
>            <idle>-0       [000] d.h2.  7542.706340: hrtimer_start: hrtimer=000000009bbda66a function=tick_nohz_handler expires=7542588000000 softexpires=7542588000000 mode=ABS
>            <idle>-0       [000] ..s1.  7542.706345: softirq_entry: vec=7 [action=SCHED]
>            <idle>-0       [000] ..s1.  7542.706359: softirq_exit: vec=7 [action=SCHED]
>            <idle>-0       [000] ..s1.  7542.706360: softirq_entry: vec=9 [action=RCU]
>            <idle>-0       [000] ..s1.  7542.706362: softirq_exit: vec=9 [action=RCU]
>            <idle>-0       [000] dNh4.  7542.707672: sched_wakeup: comm=irq/51-DLL075B: pid=194 prio=49 target_cpu=000
>            <idle>-0       [000] d..2.  7542.707685: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=irq/51-DLL075B: next_pid=194 next_prio=49
>   irq/51-DLL075B:-194     [000] .....  7542.707708: timer_init: timer=00000000630ae178
>   irq/51-DLL075B:-194     [000] d..1.  7542.707710: timer_start: timer=00000000630ae178 function=process_timeout expires=4296778179 [timeout=250] bucket_expiry=4296778184 cpu=0 idx=121 flags=
>   irq/51-DLL075B:-194     [000] d..2.  7542.707718: sched_switch: prev_comm=irq/51-DLL075B: prev_pid=194 prev_prio=49 prev_state=D ==> next_comm=swapper/0 next_pid=0 next_prio=120
>            <idle>-0       [000] dN.2.  7542.709072: sched_wakeup: comm=AudioIP~ent RPC pid=6671 prio=120 target_cpu=000
> […]
> 
> The trace file is 320 MB big. If you need the full trace and log, please 
> tell me, and I’ll upload it somewhere.

https://owww.molgen.mpg.de/~pmenzel/20240821--linux-6.10-rc4+.txt
https://owww.molgen.mpg.de/~pmenzel/20240821--soft-irq--trace.7z


> Kind regards,
> 
> Paul

