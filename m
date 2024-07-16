Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D333C5;
	Tue, 16 Jul 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121340; cv=none; b=LrhmVag57VSNZal4lBygJHxefKzPFOywAFtq47W+zv8A79SRPJP9BZSnUKWtOR00VSVXAbq49cMSt5Y8bBLLa4Kzh9HJbnbgQbym5Edg6bSw8YMSqMVU5XfGDqrRZUbgTKJTmamHD1oMr+X+/rGGfLv+k0L4ODNhKMxnr3iP3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121340; c=relaxed/simple;
	bh=H5HK37QkNLxT1IPUoJzYLAXvCy0/RGtho2IMfDhQSvQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o4UnjSzd1J7WxY3TP/n7HtNMorS8DUxHnAjj/cKNFdFVt2ghh7/3z7DtLJr5WYkQtr3ccmBo2VURi6nD7BGZSPY2emRKL3zly2F8XuiGjVD7O6t+klkO+f0gNBkfJLr/zpwuBwfudKAI36p2El7d5X2YJSuASA58x9BMx8iC6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHZIilrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHZIilrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC173C116B1;
	Tue, 16 Jul 2024 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721121340;
	bh=H5HK37QkNLxT1IPUoJzYLAXvCy0/RGtho2IMfDhQSvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qHZIilrzH5O9XpYos9HbSsS/mcRWVOy8D+GsVZERnWVwhPsJ7R6WPrurt8t0zHXHT
	 2ah3Riqm9qTd3kdpDGiIFEqL/A0KyVvfXt2uM3GElInd7G2YawhnfqdjAWZ6cEB6xl
	 8RdCPfUMZzly6tWhdCTBSA0HdZ8TorI+p+k+w3gzV9+r3bQIJkmRlITglpySV903KW
	 FhKJbDjtRBVMTS+bnTyQSRuosnMhM1oqlq6So+YS5ojM/8q7tLG149+Uu+JguFDpjk
	 /PK+Z2HgizLZGgRFB2DjjubagwQ8D09cEgaogZTNTstRQZQKjUmpzs+h3/OST6mC0i
	 ObbaG8HMnpGxA==
Date: Tue, 16 Jul 2024 18:15:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Clark Williams <williams@redhat.com>, "Luis Claudio R. Goncalves"
 <lclaudio@uudg.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] tracing: Update MAINTAINERS file
Message-Id: <20240716181534.706734253e11290d117c0d64@kernel.org>
In-Reply-To: <20240715144745.51d887a9@rorschach.local.home>
References: <20240715144745.51d887a9@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 14:47:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Gone but never forgotten.
> 
> [ Also moved Daniel's name to be consistent with the alphabetical order ]
> 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  CREDITS     | 10 +++++++---
>  MAINTAINERS |  3 ---
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 88c4c08cb613..d7798910e99f 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -271,9 +271,6 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
>  D: Various bugfixes and changes to sound drivers
>  S: USA
>  
> -N: Daniel Bristot de Oliveira
> -D: Scheduler contributions, notably: SCHED_DEADLINE
> -
>  N: Carlos Henrique Bauer
>  E: chbauer@acm.org
>  E: bauer@atlas.unisinos.br
> @@ -534,6 +531,13 @@ S: Kopmansg 2
>  S: 411 13  Goteborg
>  S: Sweden
>  
> +N: Daniel Bristot de Oliveira
> +D: Scheduler contributions, notably: SCHED_DEADLINE
> +D: Real-time Linux Analysis
> +D: Runtime Verification
> +D: OS Noise and Latency Tracers
> +S: Brazil and Italy
> +
>  N: Paul Bristow
>  E: paul@paulbristow.net
>  W: https://paulbristow.net/linux/idefloppy.html
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e1b8bbacb5e..0b7e4cd4ffd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18895,7 +18895,6 @@ F:	include/uapi/linux/rtc.h
>  F:	tools/testing/selftests/rtc/
>  
>  Real-time Linux Analysis (RTLA) tools
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
> @@ -19529,7 +19528,6 @@ S:	Maintained
>  F:	drivers/infiniband/ulp/rtrs/
>  
>  RUNTIME VERIFICATION (RV)
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
> @@ -22806,7 +22804,6 @@ F:	kernel/trace/trace_mmiotrace.c
>  
>  TRACING OS NOISE / LATENCY TRACERS
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  S:	Maintained
>  F:	Documentation/trace/hwlat_detector.rst
>  F:	Documentation/trace/osnoise-tracer.rst
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
