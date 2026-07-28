Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AE4772A9;
	Tue, 28 Jul 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276118; cv=none; b=aRm6H6++2wJP9P0YGEnNT2Xu1dTGEbMYBbS9xBj7CbLgGbNic0SOlEj0qcywskb24DLe+u2X0rUq8B2TkN1jC0bqIEhZi3S1aKvor7VtH6oVKxLk4JPLJz6z1P3OVHicCsXe/TCJNEj+wOMX6rRhCpuu3Jjah1Yq4p/iYysFSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276118; c=relaxed/simple;
	bh=DrVylEHDiKI8qzs6jTHO0H+61k/y3iJnY6UeYSu4YXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaYQSSBIGp8MBEtWg1HqyVCuICkQT3VXvbtw4HidoRiSTlLHYxN1VnIp0CF/jr3+8OffArAt18NZsIdMQnN6D/uX9Ly2kcMF5ShxaKFVX+oqV0/T4bQazhXXxtFtVCFcSoptJYcmBMqvdPkfvqlM4WJWVFntrJzntuLRpOtSPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfuEoGnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfuEoGnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9623A1F000E9;
	Tue, 28 Jul 2026 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785276099;
	bh=ecznKoyZ52idkaym97OS10IGOQbXzYxh928piO1MWRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfuEoGnukdvfU2BRIzn9ZvNzfrpUefGZwSSmdUgYq6ri8ouiSR23blUoQ4sjdRby0
	 MbUJQH3dn9gUtnX+8l3Zqs7kKcVnaO1FkhqMf3kWzoVb1Gith2D2YfTrNtTNJWcir1
	 TqPoY5uvGZZQjr6zTViuNwdoIUPWveukS7NYoWmWmx6CDLoNej93KUUs5V/JSr7TXv
	 s7pwxR0s/s3cbiekcLjXuICMXc2ndCswNHCrQMwfXrxyMnzMqU7jGgc159IDhQAQo4
	 4PF5eNxSv/CRliIpnJcTZPqEAg1/4lKJkTiLLCUJ6ZWhIplrxw/2+Yj7e4FfbHvST/
	 8jVzFG98wio3w==
Date: Wed, 29 Jul 2026 00:01:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] Add trace events for Qualcomm GENI I2C drivers
Message-ID: <amkmqdFyxlYsNfuS@zenone.zhora.eu>
References: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>

Hi Praveen,

On Fri, Jul 03, 2026 at 08:38:08PM +0530, Praveen Talari wrote:
> Add a new trace event header providing tracepoints for the Qualcomm
> GENI I2C controller.
> 
> The trace events cover controller bus setup, interrupt status and 
> error reporting. These events enable structured debugging and performance
> analysis using ftrace.
> 
> Usage examples:
> 
> Enable all I2C traces:
> echo 1 > /sys/kernel/tracing/events/i2c/enable
> echo 1 > /sys/kernel/tracing/events/qcom_geni_i2c/enable
> 
> cat /sys/kernel/debug/tracing/trace_pipe
> 
> Example trace output:
> 79.737075: i2c_write: i2c-11 #0 a=057 f=0200 l=3 [00-00-3f]
> 79.737075: geni_i2c_bus_setup: a90000.i2c: clk_freq=400000 clk_div=2
>    t_high=5 t_low=11 t_cycle=22
> 79.737084: geni_i2c_irq: a90000.i2c: m_stat=0x40000000 rx_st=0x00000000
>    dm_tx=0x00000000 dm_rx=0x00000000
> 79.737201: geni_i2c_irq: a90000.i2c: m_stat=0x00000001 rx_st=0x00000000
>    dm_tx=0x00000000 dm_rx=0x00000000
> 79.737211: i2c_result: i2c-11 n=1 ret=1
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
