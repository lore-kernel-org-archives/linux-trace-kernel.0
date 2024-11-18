Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6967193071;
	Mon, 18 Nov 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924721; cv=none; b=jHr8wUSU+Zn5yaLH2kKERXuneou+8qGeRorY/z8FDFaHOMRDLIfOtZNQB/uGEeobySSGtp/PR2ppCur6PiBgo5qpXOiaDoYkyOz0o739ZYvKuSV1ZAtuCkc4tcwxDx9moFN4sVelBDf+NrLH/m4ZuyxPWRV7KLm7szuP85lqduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924721; c=relaxed/simple;
	bh=U8nw4h3WxjfIRfM1kXzgmn15xmJ6v3U/YsCQKiWW/Es=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rPo+cpRD2y6n4kJwUVO2A2RYdkclI2iHIQwjcumx9jPfxix5EF5bIgZaHdQPxAbpNePJ4G8fIYBxQpUuuXxwmIzvJHGNF6PT7C4lgkpUHUzfZH8pzekM2xXSx6TDryJhzJkr6HE1qfUuzFLanZ7MZru5EeotKRGP4PyuCUCr/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=hDPSgR28; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="hDPSgR28"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 969E31C0006;
	Mon, 18 Nov 2024 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1731924710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RufrWCtbGANzxJBJmt6VNTP2weS/VbTSAKxO/0eHr1c=;
	b=hDPSgR28mEPNZXrlklYcO4wnOBbV11x6GnWy5ZUpqHm2Zb8RtRW7sSqIRDNxK32GNaPAxr
	8R1BJ7S4X1Xdo/53+NAL5NuiWmq4v9hIsau96uwP6pjhwPAp9mEwhsUHkhU97eqtc0L7Lo
	7C24lVSqFtdlOziOsk4MYBw1meeyQYevNI1Zw3dKNiA58Tn4v8Bl9NK4nH9X6cIfQ4unuY
	y5buvDrPSYQaKDLkDS8AHnMKEL7lFqg3qrlCpcha9NnUhU4P25DeYgwDJU65hjo5BN+Jkm
	Qu5jiBepDHVjWuNUxljzfO1BcVpMWXnB5BzhXzRLOl/IPuL2yiEmpOr1T128iA==
Message-ID: <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
Date: Mon, 18 Nov 2024 11:11:48 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
 <20241115145502.631c9a2c@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241115145502.631c9a2c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 15/11/2024 20:55, Steven Rostedt wrote:
> On Fri, 15 Nov 2024 16:33:06 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> Hi Steve,
>>
>> On 15/11/2024 16:25, Steven Rostedt wrote:
>>> On Fri, 15 Nov 2024 09:26:07 +0100
>>> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>    
>>>> Nevertheless it sounds like a really high latency for wake_up().
>>>>
>>>> I have a custom driver which basically gets an IRQ, and calls wake_up on
>>>> a read() call. This wake_up() on a high cpu usage can be more than 1ms !
>>>> Even with a fifo/99 priority for my kernel thread !
>>>>
>>>> I don't know if it rings any bell ?
>>>> I can obviously do more tests if it can help getting down to the issue :-).
>>>
>>> Try running timerlat.
>>
>> Thanks !
>> Here is what I get:
>> # echo timerlat > current_tracer
>> # echo 1 > events/osnoise/enable
>> # echo 25 > osnoise/stop_tracing_total_us
>> # tail -10 trace
>>               bash-224     [000] d.h..   153.268917: #77645 context  irq timer_latency     45056 ns
>>               bash-224     [000] dnh..   153.268987: irq_noise: timer:206  start 153.268879083 duration 93957 ns
>>               bash-224     [000] d....   153.269056: thread_noise:  bash:224 start 153.268905324 duration 71045 ns
>>         timerlat/0-271     [000] .....   153.269103: #77645 context thread timer_latency    230656 ns
>>               bash-224     [000] d.h..   153.269735: irq_noise: timer:206 start 153.269613847 duration 103558 ns
>>               bash-224     [000] d.h..   153.269911: #77646 context irq timer_latency     40640 ns
>>               bash-224     [000] dnh..   153.269982: irq_noise: timer:206 start 153.269875367 duration 93190 ns
>>               bash-224     [000] d....   153.270053: thread_noise: bash:224 start 153.269900969 duration 72709 ns
>>         timerlat/0-271     [000] .....   153.270100: #77646 context thread timer_latency    227008 ns
>>         timerlat/0-271     [000] .....   153.270155: timerlat_main: stop tracing hit on cpu 0
>>
>> It looks awful, right ?
> 
> awful is relative ;-) If that was on x86, I would say it was bad.
> 
> Also check out rtla (in tools/trace/rtla).

Thanks ! I knew it only by name, so I watched a presentation recorded 
during OSS summit given by Daniel Bristot de Oliveira who wrote it and 
it is really impressive !

I had to modify the source code a bit, as it does not compile with my 
uclibc toolchain:
diff --git a/tools/tracing/rtla/Makefile.rtla 
b/tools/tracing/rtla/Makefile.rtla
index cc1d6b615475..b22016a88d09 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -15,7 +15,7 @@ $(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
  $(call allow-override,LDCONFIG,ldconfig)
  export CC AR STRIP PKG_CONFIG LD_SO_CONF_PATH LDCONFIG

-FOPTS          := -flto=auto -ffat-lto-objects -fexceptions 
-fstack-protector-strong   \
+FOPTS          := -flto=auto -ffat-lto-objects -fexceptions \
                 -fasynchronous-unwind-tables -fstack-clash-protection
  WOPTS          := -O -Wall -Werror=format-security 
-Wp,-D_FORTIFY_SOURCE=2             \
                 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
diff --git a/tools/tracing/rtla/src/timerlat_u.c 
b/tools/tracing/rtla/src/timerlat_u.c
index 01dbf9a6b5a5..92ad2388b123 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -15,10 +15,16 @@
  #include <pthread.h>
  #include <sys/wait.h>
  #include <sys/prctl.h>
+#include <sys/syscall.h>

  #include "utils.h"
  #include "timerlat_u.h"

+static inline pid_t gettid(void)
+{
+       return syscall(SYS_gettid);
+}
+
  /*
   * This is the user-space main for the tool timerlatu/ threads.
   *
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c..b754dc1016a4 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -229,6 +229,9 @@ long parse_ns_duration(char *val)
  #elif __s390x__
  # define __NR_sched_setattr    345
  # define __NR_sched_getattr    346
+#elif __m68k__
+# define __NR_sched_setattr    349
+# define __NR_sched_getattr    350
  #endif

  #define SCHED_DEADLINE         6

But it is not enough, as executing rtla fails with a segfault.
I can dump a core, but I could not manage to build gdb for my board so I 
can't debug it (I don't know how to debug a coredump without gdb !).

JM
