Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534226;
	b=fQ7uUlZaMT73uzeyXAHop/EQCxiw2t9t52nx0kFjOuXrIzc2ozcZNXKYVkNw2R2Bq5NF
	 7Al93o0b+uHoQVL2M3LHfDPKz6tz83/u5dW0jM+LaF63ftd9d3zb3tGbLvIf/HugtDzoE
	 +CCYXLFXqsROUCIYgmx7S5eedFcLiTLdmnD7dGMIwAFDo9HKZg9TDx0orZIHcmTMYlb4j
	 vI6lCBL2LdOu0SuepWUcb9kEtQf4cMf3tpOx3cegeNMsJ1udtEall4BZrrv6k9UZMdWUs
	 myaPHduzhGUL/1Am0Efr4/U1t3ie3Wq1Q3tWn8gq+NNEnSw+/cd7xtYsGvvPZV9Z99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534226;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=16XWJDbX7mkImoOTQxy5tEsY//wr/EZ/0Fl+xefuhm4=;
	b=FiLRdMNHaXgnOCSB1PzH4r2WJROje1Gktmeh+8GTln/x104quOYoNLlCr5FZnDKQwM7O
	 l3kv6knXkN2wyFpvQkj5QnOYnMU9E2NWh3ZQIsIPtbyPv8xEg2q8vyOIBIQsIK5AizQHu
	 w6dKsk8k5upzrcDnp2ghhgC6mzpqUYcsJ7nLfCBBdllHgqOdvSfUmoYSPKuF0sStp7Iug
	 De9K1XVgQyAuD0FyFwUAYyNusrPmELlvvnqnb/Gd5M2V+5sYltm/L+upTRuNZJkLXqjMQ
	 n8e76I6r8zH2a8YZ9AFcFBrGB0DKRwBGWsW47vNpzoV/VwfFX9Bgmf+454Pl0txZc1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zccZXyxS;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62083606A321;
	Tue, 24 Nov 2026 15:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62083606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zccZXyxS
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 5E8241C470D;
	Tue, 24 Nov 2026 15:30:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 6506B20027;
	Tue, 24 Nov 2026 15:30:21 +0000 (UTC)
Date: Tue, 24 Nov 2026 10:30:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest
 <linux-kselftest@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Make sure trace_printk is set to top
 instance
Message-ID: <20261124103020.708990a6@gandalf.local.home>
In-Reply-To: <20261123145918.0d7f3728@gandalf.local.home>
References: <20261123145918.0d7f3728@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6506B20027
X-Stat-Signature: dbybb87j5gm3rbyikzdipgfzmnkfodcx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GnvZ1Vm2yNa/wFMPFAHwmV9gQ1wsr3tg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=16XWJDbX7mkImoOTQxy5tEsY//wr/EZ/0Fl+xefuhm4=; b=zccZXyxSrCZMSMg6H0ViLYeMx9iYn0jYGlWQdaI4Y0G6BGkqrYk+jFu4z1mBUtoFeSnIeOVXOpVyHAqAMTMkzWqNagQFbyz4P9pAHzO8AmlABU4j04qP/KBEtnj7GcWOU+tIXrDB/+9tdvZ7WGhA1P8Lk2m/TDyL+wrlhRNH3Hs=
X-HE-Tag: 1795534221-241193
X-HE-Meta: U2FsdGVkX1/cI292Mz4fh4i3MZHrJ0mPMTg/M/m8HbAyIP0JhfjCx+bXqd2iuQnwJXXcit4OeeYu04sHaUdd7bzTfmZnxBZZi9+//sLynIA+BzFtPBRIaqLNbcV6K0EaDOJc8MtBA5xkgBx4DTaXV1ksaEP2ijc48q+3U0C2CYMdZswoVXqxbTc3fT1zSQHu3HMuCPJIjaJH3vvEdo/b4J9qN6O+Un3o0ZCz0YgczN0q2UTYM45OvG0IOu93hYDAJP84B1Po7kd+Bs/m4T5LRwAL3lxtouM4RhTao7w61+RGWTFR/2nc+8uLx2ajhMsAGATyb0Bf9Scgt+uDn+KWjJmiUjgWCLs023NFU8+5KC2wMI1I1yFZHHyEzmA83JJNAqEEPIeVhjIGAkX7lLEqjutt33pPbmyK


Masami,

You OK with this patch?

If so...

Shuah, can you take this patch if Masami acks it. It's not urgent and can
go in the next merge window.

Thanks,

-- Steve


On Mon, 23 Nov 2026 14:59:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to debug a kernel crash, the boot command line added
> the traceprintk flag to have trace_printk() go to the persistent ring
> buffer. When the fix was found, the command line wasn't updated.
> 
> Later, when running the ftrace selftests, the direct function tests were
> failing. The reason for this was because these tests would load the
> ftrace-direct.ko module which would add a trampoline that did a
> trace_printk. The test would then search the top level instance buffer for
> the trace_printk output. The issue is that the kernel command line had
> moved the destination to the persistent ring buffer causing the writes of
> trace_printk to go there and not the top level instance and because the
> tests did not find the output it was looking for, they failed.
> 
> Update the tests to set the trace_printk destination to the top level
> instance at the start of the tests to force the output to go there so that
> the tests will not fail in such a case again.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  .../testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 5 +++++
>  .../testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> index d75a8695bc21..359257123e6d 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> @@ -2,6 +2,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Test ftrace direct functions against tracers
>  
> +# Make sure trace_printk goes to the main buffer
> +if [ -f options/trace_printk_dest ]; then
> +	echo 1 > options/trace_printk_dest
> +fi
> +
>  rmmod ftrace-direct ||:
>  if ! modprobe ftrace-direct ; then
>    echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> index e52e470a1f8f..b22e3fb1c468 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> @@ -3,6 +3,11 @@
>  # description: Test ftrace direct functions against kprobes
>  # requires: kprobe_events
>  
> +# Make sure trace_printk goes to the main buffer
> +if [ -f options/trace_printk_dest ]; then
> +	echo 1 > options/trace_printk_dest
> +fi
> +
>  rmmod ftrace-direct ||:
>  if ! modprobe ftrace-direct ; then
>    echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"

