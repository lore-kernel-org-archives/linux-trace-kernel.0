Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AC3368B7;
	Mon, 22 Jun 2026 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105646; cv=none; b=VK3KQutoSZuYUqZX1BG+GnXeMt41OJLQDqiUBSJS+SVoC8nP57CjbNgYApd/u01UfVKOYXgp7HkoExZ5yecgku78rBVxz6+xnaza2Kog53ITukRRL50xsJa+N3fXR55jGhz5CiipFLajDD+lPCazw4RLUv2A49hKiHlG3TH6HC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105646; c=relaxed/simple;
	bh=FUGyhmgFs0kFqTa0WIscJrsvga+WPhwKNJ/Q6QQ1Q3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2bVRMAe4dlVaw03ocSvGlvauJx4Ho8ejF+A+fPFeBaAuYJla4w9LpB25I4PbryDWmBzAWSkGz+0S25urh0yoQ++aqyl8U4ZOK0JySLcPMqmar6CoslveEM6l3rxR+NAfpq+cHn1+ijgMVpSolu5U4f6QAx0Q9pG/REWCOewEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kSf0QZWm; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kSf0QZWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782105632; bh=g8N60X99d2aVR3z2NaXfeFloP3gSbdhAWhaH2CYENF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kSf0QZWm575QPeLx9wwFsWLRqCNyffgF3uDSkRoRghzEx9rIT1pk4maKFYvpj6NEm
	 GthJJV4yArbVmeUvypBualvvegetgjK9u4z6Xx7I3mfbCRQVQnw1IC64TWMMAdeZRh
	 SlzPnfJZlVZMx18HdDtu29e2TgpagxhH+R02uORU=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 51D0E4C8; Mon, 22 Jun 2026 13:20:29 +0800
X-QQ-mid: xmsmtpt1782105629tugcldrx1
Message-ID: <tencent_1388B255DE88642FE401446B38E546119407@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Ggpn5sZdHH8gXsJS6xOSe46hIoajdW/pWjhwmcou+8+DDJFKU3e
	 4OGU9jQJSmAwPGzRA4yzDIkaAeY7OKdHTGQFMLPQZEBWVOhvW0YCBe+/E/sNE7zVmRzosdtwrH7p
	 db6qsADRvxV4UkPm3BodVGjD68WR0Wvt0SEK2zV3IUZYizTYaJtgz4tg+b0Y0u4UcMnR6yvzWerX
	 7DUr90oaKSijJ2xVZWZdt5/qKdpDzqnrKHIFc4C/hWxKo1GDUb79vN1qn/G/0Jml+aka3XM3IaW5
	 XYHUIH4KOq1lhZw2oCi1146g/cOa+k2NMmX9tXaDqD4NSoL3ICEWWD7hUAfykjOIAYJKlAte6BrO
	 pokitpRF4eDa2r3Vm8aVAsIx+fR9bWqVpIR0nTINUxIYY4ttQ06Dj0cFGS4XZl4Sm6CcjNDrBN8w
	 9n94nENPvLZ3+rL56qTgX/r/JUIwg8O6Fu16H64sTID+MEf3fOoPMbhwk7H0V9mGgsREC2ghTLrX
	 PuoxhdA6e5s2vkQyAYQ1byUDH01zGS8Nn+rfAhd/APOQWXoMHa0RU3dpwfyrH4VpJNah+o2Ha6Ak
	 I1I9bLzEIU8vMe+m00HottXVj4+TZcEU3jZW9b5pVunKDUT9xSz/18QOLVbjijHDkZMR0zBNijmc
	 prI1eRRJnwJ/R6JTGeN0EwNOhNoNjTqmRInnYL+BHplfo9ML/azYuUZ3BNDBnEiNAbJRmlph2XSl
	 ReXUKw3ldwWUoJIEcHShuEJyT5AJGzTkw6xn8fjGZkdeLfJpeNilck4C+jVja/hS8q3e4OIgTFna
	 ZVbCHUwU4xqRcxlNMgVG08TBj0SoM1i+o74r53iz8KkKl05Fc7zcim3DUgHhuyNwuTvZMNAlTMCM
	 2b7TqUnyVhIdZ0sJW/pnseX/QckrOW8hPll31ygEO3YKb/6FXqVRmMo0UN9FTY6VmwwN/TEBy8nd
	 SoMdcW7k92X+jkNXk5HpTWe12mtz0/NmfxGoqVhaWscoA1dJTPysr3ogvwzUpFKtt0XmmMsZSga5
	 Urg0aWnQULltOW2RPeG1MHfOPYJwZdMj1BgHFidI/ywPwSU4pe7w5U5OLyuJgq1+goLI8m4A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <15c9fd4d-dfb9-4648-901d-1a445c71266e@qq.com>
Date: Mon, 22 Jun 2026 13:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Use seq_buf for string concatenation
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com,
 jkoolstra@xs4all.nl
References: <20260620175441.223342-1-woradorn.laon@gmail.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260620175441.223342-1-woradorn.laon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Woradorn,

Thanks for this cleanup — replacing strlcat with seq_buf is a nice
improvement in general, and it's good to see the KSPP goal of removing
strlcat making progress.

I came across an automated AI code review of this patch on the Sashiko
platform[1] that flagged a regression risk, and I was able to verify it
by testing the patched kernel in QEMU.

TL;DR: This patch introduces an unavoidable WARN_ON on every normal
boot (without the trace_event= parameter), which will crash systems
configured with panic_on_warn.

 > @@ -4501,13 +4502,23 @@ extern struct trace_event_call 
*__start_ftrace_events[];
 >  extern struct trace_event_call *__stop_ftrace_events[];
 >
 >  static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 > +static struct seq_buf bootup_event_seq;
 > +static bool bootup_event_seq_initialized;

The new seq_buf and the bool are not annotated __initdata, unlike
bootup_event_buf.  If bootup_event_buf is reclaimed after init, the
seq_buf will hold a dangling pointer to freed memory indefinitely.

 >  static __init int setup_trace_event(char *str)
 >  {
 > -    if (bootup_event_buf[0] != '\0')
 > -        strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
 > +    if (!bootup_event_seq_initialized) {
 > +        seq_buf_init(&bootup_event_seq, bootup_event_buf, 
COMMAND_LINE_SIZE);
 > +        bootup_event_seq_initialized = true;
 > +    }
 > +
 > +    if (seq_buf_used(&bootup_event_seq) > 0)
 > +        seq_buf_puts(&bootup_event_seq, ",");
 >
 > -    strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
 > +    seq_buf_puts(&bootup_event_seq, str);

 > @@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
 > -    early_enable_events(tr, bootup_event_buf, false);
 > +    early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), 
false);

 > @@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
 > -    early_enable_events(tr, bootup_event_buf, true);
 > +    early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), 
true);

This is the main issue: both event_trace_enable() and
event_trace_enable_again() unconditionally call seq_buf_str() on the
still-zero-initialized seq_buf.  When booting without trace_event= on
the kernel command line, setup_trace_event() never runs, so
bootup_event_seq remains zero-initialized with size==0.  The
seq_buf_str() function hits WARN_ON(s->size == 0) in
include/linux/seq_buf.h:100.

I built a kernel with this patch applied and booted it in QEMU without
the trace_event= parameter.  The WARN_ON fires twice on every boot:

Kernel version: 7.1.0-next-20260618-gaa8f0a630773 #1 PREEMPT(full)

Boot 1, WARN 1 — trace_event_init():
```
[    4.339900][    T0] ------------[ cut here ]------------
[    4.340592][    T0] s->size == 0
[    4.340596][    T0] WARNING: include/linux/seq_buf.h:100
                          at trace_event_init+0x1370/0x16c0,
                          CPU#0: swapper/0/0
[    4.344985][    T0] RIP: 0010:trace_event_init+0x1370/0x16c0
[    4.355743][    T0] Call Trace:
[    4.356106][    T0]  <TASK>
[    4.356441][    T0]  trace_init+0x95/0x10c0
[    4.361793][    T0]  start_kernel+0x225/0x4e0
[    4.362409][    T0]  x86_64_start_reservations+0x18/0x30
[    4.362979][    T0]  x86_64_start_kernel+0x11a/0x160
[    4.363544][    T0]  common_startup_64+0x13e/0x158
[    4.363872][    T0]  </TASK>
```

Boot 1, WARN 2 — event_trace_enable_again():
```
[    4.760317][    T1] ------------[ cut here ]------------
[    4.760944][    T1] s->size == 0
[    4.760947][    T1] WARNING: include/linux/seq_buf.h:100
                          at event_trace_enable_again+0x1c2/0x230,
                          CPU#0: swapper/0/1
[    4.765947][    T1] RIP: 0010:event_trace_enable_again+0x1c2/0x230
[    4.777045][    T1] Call Trace:
[    4.777759][    T1]  do_one_initcall+0x128/0x700
[    4.779617][    T1]  kernel_init_freeable+0x398/0x940
[    4.780790][    T1]  kernel_init+0x21/0x2c0
[    4.781862][    T1]  ret_from_fork+0xb2c/0xdd0
[    4.782908][    T1]  </TASK>
```

These two WARN_ONs fire identically on every boot (verified across
three separate QEMU sessions).  On systems with panic_on_warn=1 this
will cause a kernel panic during every boot.

This matches what Jori already asked about in their review —
if the trace_event parameter is not provided, setup_trace_event() never
runs, and the uninitialized seq_buf triggers WARN_ON at both call sites.

Full PoC (compile with:  gcc -Wall -o poc poc.c):
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>

int main(void)
{
     char *log_buf;
     ssize_t log_size;
     const size_t buf_size = 4194304; /* 4 MB, enough for full dmesg */

     log_buf = calloc(1, buf_size);
     if (!log_buf) {
         perror("calloc");
         return 1;
     }

     /* SYSLOG_ACTION_READ_ALL = 3: read the full kernel ring buffer */
     log_size = syscall(SYS_syslog, 3, log_buf, buf_size - 1);
     if (log_size < 0) {
         perror("syslog(SYSLOG_ACTION_READ_ALL)");
         free(log_buf);
         return 1;
     }
     log_buf[log_size] = '\0';

     /*
      * The WARN_ON(s->size == 0) in include/linux/seq_buf.h:100
      * produces a message containing "s->size == 0" followed by
      * "WARNING:" within a few lines.  Search for this signature.
      */
     if (strstr(log_buf, "s->size == 0") &&
         strstr(log_buf, "seq_buf.h")) {
         printf("BUG TRIGGERED: WARN_ON in seq_buf_str() found in kernel 
log\n");

         /* Print the first occurrence with context */
         char *p = strstr(log_buf, "s->size == 0");
         char *start = p;
         while (start > log_buf && *start != '\n' && (p - start) < 512)
             start--;
         if (*start == '\n') start++;

         char *end = strstr(p, "---[ end trace");
         size_t len = end ? (size_t)(end - start + 30) : 2048;
         if (len > (size_t)(log_buf + log_size - start))
             len = log_buf + log_size - start;
         printf("%.*s\n", (int)len, start);
         free(log_buf);
         return 0;
     }

     printf("BUG NOT DETECTED: seq_buf WARN_ON not found.\n"
            "Either the kernel is unpatched or trace_event= was on the 
command line.\n");
     free(log_buf);
     return 1;
}
```

[1] 
https://sashiko.dev/#/patchset/20260620175441.223342-1-woradorn.laon%40gmail.com

Thanks,
Xiao


