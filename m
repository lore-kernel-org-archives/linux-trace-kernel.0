Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2A158A33;
	Wed, 23 Oct 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673236; cv=none; b=g/VA1Ouafjq/JcP1Y6ku7sO2PPsy6DPqaJ6qFgp24ckCUXpyRBUSZ17+rpNqLloZjqa6dx0wfdaZwF+ksb7tKpgObacLMVDmQUTB1W4xupzmD21771is+QO5uz/7ft9cRk2BronqKNBxpgxJXlQiActivumJDeFkSmqirKYfAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673236; c=relaxed/simple;
	bh=jE+psI9L5oywH/YvfvyfipOHf6eGhY0aBTmDvQ6Tfrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzZje9anW7O/yuA1fSGo2qBzcE0dTxUVBmPCsRT3KyuWcn840CB6xGwoZPu53ZSRig7DT0DLLcBeukjhLY6tPTN0imDo5/mna+PwmbCpQR9yks4QOt8biNJIFcfJsA7IhZlumVoSdgC/qS0yR8yBlW8SAMslFto6tcFNG5/v2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAA2C4CEC6;
	Wed, 23 Oct 2024 08:47:14 +0000 (UTC)
Date: Wed, 23 Oct 2024 04:47:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
Message-ID: <20241023044711.3eb838fe@rorschach.local.home>
In-Reply-To: <2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
	<20241022012809.1ef083cd@rorschach.local.home>
	<075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
	<20241022043037.13efb239@rorschach.local.home>
	<2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 11:21:34 +0200
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> 
> I was not really expecting you to review the m68k one no :-).
> I think I have other issues which might have impact on ftrace too.
> For instance, when I launch cyclictest I have a warning about HRTIMERS:
> # cyclictest -p 99
> WARN: stat /dev/cpu_dma_latency failed: No such file or directory
> WARN: High resolution timers not available
> policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245
> 
> T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 Max: 
>    3516
> 
> The latencies are quite high...

Yes, if you don't have high resolution timers, the latency will be high.

> 
> But regarding ftrace it seems that the trace is not able to give me more 
> than a microsecond precision. I addded a few trace_printk() in a driver 
> of mine and I get:
>   irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt: 
> Received 2 bytes
>   irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt: 
> Received 2 bytes
>   irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: 
> dspi_interrupt
>   irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: TX 
> FIFO overflow
>   irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: 
> Restart FIFO
> 
> Do you have any clue ?

Yes. The ring buffer clock is dependent on the architecture's clock. By
default, it uses whatever the scheduler clock uses. If the scheduler
clock is 1ms resolution, so will the tracing data be.

-- Steve

