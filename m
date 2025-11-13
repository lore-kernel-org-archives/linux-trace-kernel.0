Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A169320A0E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016302; cv=none; b=Su0tFpZdEeqObxZgTczT1UeppXrfIG9LE0avbtBApHbaGPBaAHnpTlDYBSZxVrRNX2eOsTP4lu7DSWA0v1kQK8StnMC7hssbhhrazrvcScT9dWd5UtMvpZpMSs/lzvK3wz0gLCt562u+jmbS6/HkTlE1YMPnO1uPkRFAwQqUCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016302; c=relaxed/simple;
	bh=zW0U/Jj9Zj5cp+rpQ/nb/eNOgY0kP5K/zUMpKvWQ5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE/uDz7+ORkUHDM+ejM6SdkKtPdfrZDNf4OFcbd4CyfbJ3zGrNpVEIxGZoGFLjXsETa9IlzXl+2oEQOetj87ixsLKZWdHz6FUZIUZcLQbtAfL/jKpJafr+CKvY/zgkHQV+zkxmDp3ydS8cn2H8vkSiuC/PUvQKDL3WucIIZiKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0CLmSqu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0CLmSqu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so512642b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763016300; x=1763621100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=t0CLmSqu4ffwnPQ+SDa6MBbM8gxpaZrCgkTr9I5CJJd/J1XhteI4XZ/+k78ZhMpZvn
         XV2wDgApqtAxc0e/Q78cGSpmBk6xdRjX42mcEy9k0mesoe5oexQR3sZZAwk4ffx0eVkA
         ef1WmUpEdGubidEDPTLiXWD6hOcOexkspSH5FzyNalJiE2sB70HmBtHZXlarFBiDnQ3U
         WZtphv6LBBovuTEBBGhh5Rf1RXc/eoPRhEcfYoPhCaKAE2LOM8EjkzBz4GqvZodbplGg
         b3FJMG6/OiYMbKNG8Ft89XlYouuwcwlEhwOunbhNWSrRwcaGOP9bAsrCBkS0V9eFlYdw
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016300; x=1763621100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=lvmn7OIuu69RdKPSuNahWqdWafGlc+GDojwj3DQskPjvkjN+HWaYaXtK1UdTawQpVZ
         G7x0EfrwoA+bt+8Se2EMJGtI1qCGYvYUtzZ660vreHywJLmvnhMuJbow3ntsv7BtBUug
         Wc35O6bHLTJEtaRZVOKP4hsDMfdjTiX637yzQgYGQUtRMC/JcziM/FdNv4cD+GKZRR6V
         Uh46MNds23QoL102zo+UXx5y3WLPPfGaqhBjwp4RTQcP6y0y2Ej4rOrXWmUJxukrjFwc
         I2ij9IVt6VlBIy/17vKjYTgUSDxiS0qOYQN00dyiZWDBK7zI4pMRYxVu6L59Cn75jw6H
         P/kg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqkIRPJ68+qZ5sCwy0G2bjk5P8dTe7xqTiGcmD1gzajGN7psZXtZjsENmYi05j0s2H4QyrKQD/FOb2vqouhRFgGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUYGtQsn655WXsYcDtpJPNTLsbuyXPZBPTAQdjFbT1zwrbORD
	ktl9uOtKaEvAT9HFUhE7q9HdCTKpfMBzk4w0dfrikoP6yg7S6A5dAbBbqnfm20S88KI=
X-Gm-Gg: ASbGncuN10L8F0HGr8TfHIq92/rlIA7YFrFwE3E6dEADpJZT3VZNJd4Gw30MiJNkqd3
	7f8A3cK0AT7Qfh3tUXQ/kYbKIkLzJrkOCpwCeIci3SMisfMcICwsXXzFWfAVq8yI8GaxKTUpLj3
	mrg5lIDTE0umTQhPYtr+FMJcfMm0LtG8a8ANkyzu3N5lTxEx+4DKdrq5DUTvq/jIAECMUJZbpSE
	KHRb90W1vMKHneRlWykpcpNE9//3apTv1T8cwvhhiTG26gwcYzJWxW2rIlK4eFvCq8gTTaiLTGp
	ZEkV9pQzT2SZj/OSokOpvjDAjyzlK1mrUNzTw/4BqARH8ktIrv241NBGt9Pus8VmsIPDKDihEfN
	ByA5bYg1nypnMdKJ4ewz4F8PNlA8g6+KzUA0EoAGVIkOxUSEClGHShwtZbJfoqS8u2Bv1lYTwhl
	Dm
X-Google-Smtp-Source: AGHT+IG/YrAEmV2pNfg3Yz0x5My5Rp1QA12LboDz6ew0EMfuz/CKACL8CP3RpYoJ2sNr09LmKQyELg==
X-Received: by 2002:a05:6a00:3a0f:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b7a2d91dcdmr6725319b3a.10.1763016299642;
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151380sm1099354b3a.38.2025.11.12.22.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Date: Thu, 13 Nov 2025 12:14:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
Message-ID: <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
References: <20251112235154.2974902-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112235154.2974902-1-wusamuel@google.com>

On 12-11-25, 15:51, Samuel Wu wrote:
> The existing cpu_frequency trace_event can be verbose, emitting an event
> for every CPU in the policy even when their frequencies are identical.
> 
> This patch adds a new policy_frequency trace event, which provides a
> more efficient alternative to cpu_frequency trace event. This option
> allows users who only need frequency at a policy level more concise logs
> with simpler analysis.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/cpufreq/cpufreq.c    |  2 ++
>  include/trace/events/power.h | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..b65534a4fd9a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
>  			 cpumask_pr_args(policy->cpus));
>  
> +		trace_policy_frequency(freqs->new, policy->cpu);
>  		for_each_cpu(cpu, policy->cpus)
>  			trace_cpu_frequency(freqs->new, cpu);

I don't see much value in almost duplicate trace events. If we feel that a
per-policy event is a better fit (which makes sens), then we can just drop the
trace_cpu_frequency() events and print policy->cpus (or related_cpus)
information along with the per-policy events.

-- 
viresh
