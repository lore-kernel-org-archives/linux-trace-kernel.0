Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E41D63CC;
	Fri, 15 Nov 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684792; cv=none; b=KI685f+a0ll2xGrRir8oDC5EAeC/Djh9azQANVGgJanZSmxNcxex+mJfQx5xCcnB5ca1nfUckpbq97Aj2WCOTO9WqMDyWgcyIn7MTQi8Ij/kBzaRln8egfb87Z1PTWUJqq2HcZASHwsGjNjnUE9O5biZtzy93FL+VgA900k99z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684792; c=relaxed/simple;
	bh=jJdQO+/RBgdX9OymC9mo4MCwdFL0za3L3NE4QMlzS+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUo9JjXIMBUCRhzVEgoDSWUsRM4Ps2gBNDba8+9Gf+91eirrszf6C5nPG1UsbjUCVuDQGsHwENC8GejasatuJjbJ3n1MY2BIvVqqgw3qOMm53jxO2j2alH3lPWMCbcWmAYO/t+06Lt9TlEmQtYooT0tEbg+te1eP0lir3tQW8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Z1K8KCuB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Z1K8KCuB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C31D6E0005;
	Fri, 15 Nov 2024 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1731684788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrA8wkbxY2YPLcSn7WT4J5s54iW03KbWLpGqQs4TrZY=;
	b=Z1K8KCuBUG2ml/9k2jKo1QgVBkl+qYZLeMtMiv1Hnx7OCBXD/eq4rRIuOyyFw7gYYTASl6
	nacZnD+bg6MSrkUQ7U+OoRtsgLlwZ1dJ3cqom1Lt2OstTa0xd7Gq6UsAwj+UuUhQlXLRjX
	MGNnF8DUS9tHK8HGu4iNuYOVUBbzg+FVsB8Tf7Mqg+HMkzqie4aBJgUttE6xx0B1FXX0sU
	zM1gznyFLmhRFtS963SgAMbOB0gxTLDiYb9bp1bl7jcmBudaFEXcPHCCB6IS8oNNpCYvVN
	As8485jNqCfmx5z3TwTqmQFzH8EPb9ItISiVqsxfZ8152YCX7Ywul0i5JfjbyA==
Message-ID: <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
Date: Fri, 15 Nov 2024 16:33:06 +0100
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
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241115102554.29232d34@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 15/11/2024 16:25, Steven Rostedt wrote:
> On Fri, 15 Nov 2024 09:26:07 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> Nevertheless it sounds like a really high latency for wake_up().
>>
>> I have a custom driver which basically gets an IRQ, and calls wake_up on
>> a read() call. This wake_up() on a high cpu usage can be more than 1ms !
>> Even with a fifo/99 priority for my kernel thread !
>>
>> I don't know if it rings any bell ?
>> I can obviously do more tests if it can help getting down to the issue :-).
> 
> Try running timerlat.

Thanks !
Here is what I get:
# echo timerlat > current_tracer
# echo 1 > events/osnoise/enable
# echo 25 > osnoise/stop_tracing_total_us
# tail -10 trace
             bash-224     [000] d.h..   153.268917: #77645 context 
irq timer_latency     45056 ns
             bash-224     [000] dnh..   153.268987: irq_noise: timer:206 
start 153.268879083 duration 93957 ns
             bash-224     [000] d....   153.269056: thread_noise: 
bash:224 start 153.268905324 duration 71045 ns
       timerlat/0-271     [000] .....   153.269103: #77645 context 
thread timer_latency    230656 ns
             bash-224     [000] d.h..   153.269735: irq_noise: timer:206 
start 153.269613847 duration 103558 ns
             bash-224     [000] d.h..   153.269911: #77646 context 
irq timer_latency     40640 ns
             bash-224     [000] dnh..   153.269982: irq_noise: timer:206 
start 153.269875367 duration 93190 ns
             bash-224     [000] d....   153.270053: thread_noise: 
bash:224 start 153.269900969 duration 72709 ns
       timerlat/0-271     [000] .....   153.270100: #77646 context 
thread timer_latency    227008 ns
       timerlat/0-271     [000] .....   153.270155: timerlat_main: stop 
tracing hit on cpu 0

It looks awful, right ?
JM
