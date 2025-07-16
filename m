Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50342F1983;
	Wed, 16 Jul 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658710; cv=none; b=Wy30KSkYF2ZnCieRlmOz7Q0YfJBESR6Pd2vmhRpse8mG+zIXsv6uGmYn79r86ES96dcqHLnHZ8TepGBDHazxE9LXsAlfCiQibcGMUYaox01Jlip8eq36b2GiX28Hpx0ja1ZNAheZnVRI7BFaMjWHOn2E4sWlG8S3X0VqI5Uzljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658710; c=relaxed/simple;
	bh=Tj1BFTRNqGXbBlcXHYlnrb596gQZP8ySHesKylUR+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGA2cnyvfHmL54XO4jJtGGSvecCdYn758D/cuKpQnnNqIJQg7ySMqspnkTOYJ3FYo3XVCmMFTXUTorfQeO2oGXlovcFgsDEDvqxl3VOmwKPnqw+XaMtuy8XqtmNbnXLdFKiAejt9Q4ES8sR2cgsU1GwMDJtg3szstbuk6pGCWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gDuXdmW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bThNE/mY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gDuXdmW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bThNE/mY"
Date: Wed, 16 Jul 2025 11:38:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752658706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZJgktThbWGbxyTtpRlDy8v1yDEBaNNxxxlctLY4gf8=;
	b=2gDuXdmWvomUDAXd1h0c6lZ5tIAzHDBrAUKmDXdm98Y2qmQoG5OaWptolDsQc/Ip3MXDdH
	0KbRwD/ol2rPIveMZNfbf8ePjMlgJ2J+oPNqVu+gaZLzYMtNwqZ1/46g055bAvE05qN3t7
	cXuwKkGp4IOqtPXt7lFGfQ6RvBSysZgvs5WTeKUWzhdyh8jIOkhqp1tOHAiOS9ljaghfZP
	aDwFXLhG1D7zITuhZieZtQYvNrHe69itED1NDQtArhZFH0/SbG3CLkvgIRz+ecrF3qqZsu
	x2WhnA+up0bZ8QH3S9WWfDkXsu+WxZSQOjOZwA2Yv3jRghTRi9YgcfUprHJ8wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752658706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZJgktThbWGbxyTtpRlDy8v1yDEBaNNxxxlctLY4gf8=;
	b=bThNE/mYqHR4yQPyNtcs82CR8o2lqtXnl/PMtJBVeCe9YHPcOkz1UPisyHGbD0JbGcaybw
	8HRJvmxpp8cxnfAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 17/17] rv: Add opid per-cpu monitor
Message-ID: <20250716093825.rWXnBtv5@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-18-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-18-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:34AM +0200, Gabriele Monaco wrote:
> diff --git a/kernel/trace/rv/monitors/nrp/Kconfig b/kernel/trace/rv/monitors/nrp/Kconfig
> index f37ff70e8d204..a175c430d351f 100644
> --- a/kernel/trace/rv/monitors/nrp/Kconfig
> +++ b/kernel/trace/rv/monitors/nrp/Kconfig
> @@ -3,7 +3,7 @@
>  config RV_MON_NRP
>  	depends on RV
>  	depends on RV_MON_SCHED
> -	default y if !ARCH_ARM64
> +	default y if !ARM64

I think this is not supposed to be in this patch? It has nothing to do with
the opid monitor.

>  	select DA_MON_EVENTS_ID
>  	bool "nrp monitor"
>  	help
> diff --git a/kernel/trace/rv/monitors/opid/Kconfig b/kernel/trace/rv/monitors/opid/Kconfig
> new file mode 100644
> index 0000000000000..23b43d2704153
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/opid/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_OPID
> +	depends on RV
> +	depends on TRACE_IRQFLAGS
> +	depends on TRACE_PREEMPT_TOGGLE
> +	depends on RV_MON_SCHED
> +	default y if PREEMPT_RT
> +	select DA_MON_EVENTS_IMPLICIT

Shouldn't we add "depends on PREEMPT_RT"? I tried this monitor on
non-RT x86 kernel, and got some errors. That could confuse people.

And the monitor reports some errors on riscv64 with PREEMPT_RT=y:

root@riscv:~/rv-tests# uname -a
Linux riscv 6.16.0-rc6-00054-g7590637d9ca2 #87 SMP PREEMPT_RT Wed Jul 16 11:26:00 CEST 2025 riscv64 GNU/Linux
root@riscv:~/rv-tests# stress-ng --cpu-sched -1
stress-ng: info:  [452] defaulting to a 1 day run per stressor
stress-ng: info:  [452] dispatching hogs: 4 cpu-sched
[  614.390462] rv: monitor opid does not allow event irq_entry on state in_irq

Best regards,
Nam
