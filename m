Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8A6FC5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219418; cv=none; b=Z+7i+yFPR2TaTOOV+UG4n7KUFmJi6bEkV7r8GhC1GUSNU2VKF3FRQG5cRRW6uod/lHczBoY1r+tlPWkkVL6PWiuv9HJjEupFgMM6ijI4LL2IpXWnqjmeDDOZklJsp7l1NxsHs6qL8kt2I6DWI6thjv6EbFPbU+Ex3nmjHzFAAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219418; c=relaxed/simple;
	bh=1dltUgI7jYS/eO8oTeSvCnCuOJVoE4a92dtnZd1Fbbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tnwDU8xYbcDK9aBcaTP0Li5akDf8E1x3o0GOc8yGhTbcfZQhr1O6wGa/FduzgzQFiZ5sYW0rnJsHwG3ff2Hjw/8HQVCpQkoHynJaSNbGucVlUa/UBTqY2rNTIMcet2kabzfHHx5s4gJpOH59prklnvhmvwneb8CzQJxuSqO9ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWtrgJvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWtrgJvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B601F000FF;
	Thu, 24 Sep 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219416;
	bh=5JMALgbN6yelKomTM4yO8jDn4aA7Em5cjfBpcLjnq8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aWtrgJvU7ib0iWzJ8m5dfTCpG594QcDYYjven7uxWTJd2d/b0zbJjGVYwrsiF5MI+
	 oX/CYSiT8Z3N6ok8kMmpjk3PaHJ9qyPUcM2A/eaexQQ3KayfbyKnKrSxuUZn3r84UR
	 qPwW3Ujm125pXzLlb9yPUijo2bJhXsiTNYkV0FRQvtff8rZHZcaJCrrVF/hYIj83Nm
	 tmC7/AdmOdIr2c7Xc/BnPBBztmWrAmmaVqR+G1iskMTBCsDTtU5N41KbaiTLrlE4VN
	 IheONoitJ/XOAJ2xovBGjxXbRRR5plxiQVPt8FFnk5MU7bUwJ5qwbCjEfXcu4VTWRM
	 m1tAFbENLANEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ftrace: add max field to function profiler stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260924030108.2673654-1-yun.zhou@windriver.com>
References: <20260924030108.2673654-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:10:16 +0000
Message-Id: <20260924031016.88B601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ftrace: time_max TOCTOU data race clobbers maximum latency spikes
--

commit 9fb82451733a5ec95aac95499945b5c01e39d82b
Author: Yun Zhou <yun.zhou@windriver.com>

ftrace: add max field to function profiler stats

This commit adds a max field to the function profiler statistics to record =
the
maximum single-call duration. This allows users to better investigate
occasional latency spikes when reviewing function execution times.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 53d5db60bfa56..dfd25e3c87f71 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
[ ... ]
> @@ -920,6 +923,8 @@ static void profile_graph_return(struct ftrace_graph_=
ret *trace,
>  	if (rec) {
>  		rec->time +=3D calltime;
>  		rec->time_squared +=3D calltime * calltime;
> +		if (calltime > rec->time_max)
> +			rec->time_max =3D calltime;

[Severity: Medium]
Could this non-atomic check and update open a time-of-check to time-of-use
data race against concurrent nested interrupt context tracing on the same C=
PU?

Since profile_graph_return() is executed with local interrupts enabled, an
interrupt or NMI could fire exactly between the condition check and the
assignment. If the interrupt handler traces the identical function and
records a massive latency spike, it would update rec->time_max. When the
interrupt returns, the normal context resumes and executes the assignment,
overwriting the true maximum latency spike with its smaller value.

Because ftrace explicitly permits tracing recursion from different contexts
like hardirq or NMI, does this require an atomic compare-and-exchange loop
or similar protection to avoid dropping the genuine latency spikes this
patch intends to capture?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924030108.2673=
654-1-yun.zhou@windriver.com?part=3D1
