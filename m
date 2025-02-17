Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86651C5A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799907; cv=none; b=ttzVKyPxM/h64O2MLAHy7sxAbReG/9WikUadOdF0dFeQDEWjH7QwFgL3T4n2/qYeLShm8OjEG4XxugrbdGco+h7xiOY3FYiqkRuCSuwU7vOyaJytf3G9VSDCAz0r6n5KttyLms7bCEv2ot7e1oE701JciimWthOHyqU0wyfmQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799907; c=relaxed/simple;
	bh=mz8Ai43z2T4C3EljPqnyEAPpcR/9p6r3VDn8veM6B78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB3d0d88Mg/1vwghy2cHO0N5baE+EdWWYPF6KTyFKkAafko5Pg8+CdyhLdBC+pvRDVvO8YukzXn0SHYLg7Z+cyjzoKK3k4qzKNf9CFhbQqCxFJbzkit7Vp+rCrzR1guEfdYBOeyf7uIvCrZ3lYOD3wLJ8HdkW4wWlI21LTQO7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2qgLDaz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2qgLDaz"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5dd164ee34so1401487276.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739799904; x=1740404704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+UsSXYo2ga0Tyi4tOLZzBPl69neKftwGKEChrHrVkU=;
        b=N2qgLDazdpBf5eLpgVGll9FejGrVxcRGfVnDDgGUQ0g+rDwDRQRHb0MdW48/z3Y/Hw
         QjVbWb5qJ+15yJHcwChM/dDT9rfFbXTuFiXACB4nK05sUWICJG42C42UWxUxWGfTmFsQ
         Jkbc/+1v02ifHypaBBP3qsQJAn9c95Td4uhs1Hd1pKnQOksfm2GFUPie7CLQXO7fF612
         tcEJFJWQ9vZYySr5kaqQqv8KeG5de+6W1v0jor0h69MSvOBkbVDX62SZOghpqXOsAIeE
         Mykmg4iwf8dlmux21IeHEegDm164fD2DqrGmeL74ySrTRohkzpg81mczgklZpWBxuPj2
         V3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799904; x=1740404704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+UsSXYo2ga0Tyi4tOLZzBPl69neKftwGKEChrHrVkU=;
        b=v7zNCZ6Y//RrKGwE3wRLqbRivx10EOf9dhh5xgJ9KOPo83zTQgSCsiYMFMl6kZGwza
         ZxQXqpN3/8fB8WpHfn6zEb5w5HSzJECIj63+86eY0PpW5HhM+hAoYY+0V6dqrVAJ/iuN
         H3gGEW/J+/cw4BdG4JHJIZIt56n8sqL5wtfyzBoyQxQuoEaFA3XZ6r9EGGYYLRTuwe/b
         2SUEFJwoFeweE8KuYj0mvGU2ryd6NST5F7D4ANIzhV4Vr/+C8kc11SW493JayBQafGIP
         siIfH7VksnjB63IaxPneDyLTgCJJR5Wf/xUw2fyoMF2xEmPvOK+6mCo95mI0zsS7SclZ
         2hgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzqShaVuWp3TJ9a3OMOS3brbn89Tr17ZsmoWUyu1xmP0W5ZrH3MW4W4fCg1vd0wPGe0j0gaB3F8pWWAQ50nZFwb9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YybbrXyQu9PnOH/hqBX9P8UMc4h0T1wCU8PUbWqOU0+xmqt67Ur
	T/C2kil1Q8AR3KqgnRsSMwMy71z/dTgaNvc3OUccAsXufaiHlmHsG8EoLhIpLRqcXQkeL3tIf8S
	rmWwYQiHEWugRkMo9L5EWNn7ZS6MRjoeazWjdig==
X-Gm-Gg: ASbGnctSKWZ6/CJpjQzDsgfVM3EvshC9NtwDjyrPW854Il947SFbqNlRMojNjUUNa4Y
	JJc3XYwzEEhl4jWeEvyoRLeyQ8XUxDxWxgi+94JRaNocg8tyThazlS5mUVM8pssfyrqmA2jhBEA
	==
X-Google-Smtp-Source: AGHT+IFwm/mDqHth8/B/J2U9h8dFtorqOZBoT4t+LjnjdnozWXFMI7irJv+LBN7mF0tOQfF16XjitkQjg935Mk3+pG4=
X-Received: by 2002:a05:6902:27c4:b0:e5d:ce4f:66ba with SMTP id
 3f1490d57ef6-e5dce4f6a09mr4587750276.46.1739799903844; Mon, 17 Feb 2025
 05:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210055828.1875372-1-keyz@google.com>
In-Reply-To: <20250210055828.1875372-1-keyz@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Feb 2025 14:44:28 +0100
X-Gm-Features: AWEUYZkhcOiOPHPRB32A0szYwISzmq1cUWV_OtOCbi8uCd62e9ysZ4rFpLd2LWo
Message-ID: <CAPDyKFor_kP1hcNC1YwLBjH=eaLG9qSyvOYvj+FQrNu8Piu2Dg@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
To: Keita Morisaki <keyz@google.com>
Cc: linux-kernel@vger.kernel.org, lpieralisi@kernel.org, sudeep.holla@arm.com, 
	rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, aarontian@google.com, 
	yimingtseng@google.com, Dhruva Gole <d-gole@ti.com>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 06:58, Keita Morisaki <keyz@google.com> wrote:
>
> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
>
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
>
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
>
> Signed-off-by: Keita Morisaki <keyz@google.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
>         and rephrase the commit message accordingly. Rebased onto the latest.
> v2->v3: Add "Reviewed-by: Steven Rostedt"
> v3->v4: Add the Tested-by label
> v4->v5: Add "Reviewed-by: Dhruva Gole"
>
> Hopefully this patch gets attention from maintainers of
> drivers/cpuidle/cpuidle-psci.c too.
>
>  drivers/cpuidle/cpuidle-psci.c |  3 +++
>  include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..dd8d776d6e39 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -25,6 +25,7 @@
>  #include <linux/syscore_ops.h>
>
>  #include <asm/cpuidle.h>
> +#include <trace/events/power.h>
>
>  #include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
> @@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         if (!state)
>                 state = states[idx];
>
> +       trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
>         ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +       trace_psci_domain_idle_exit(dev->cpu, state, s2idle);
>
>         if (s2idle)
>                 dev_pm_genpd_resume(pd_dev);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index d2349b6b531a..9253e83b9bb4 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -62,6 +62,43 @@ TRACE_EVENT(cpu_idle_miss,
>                 (unsigned long)__entry->state, (__entry->below)?"below":"above")
>  );
>
> +DECLARE_EVENT_CLASS(psci_domain_idle,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle),
> +
> +       TP_STRUCT__entry(
> +               __field(u32,            cpu_id)
> +               __field(u32,            state)
> +               __field(bool,           s2idle)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu_id = cpu_id;
> +               __entry->state = state;
> +               __entry->s2idle = s2idle;
> +       ),
> +
> +       TP_printk("cpu_id=%lu state=0x%lx is_s2idle=%s",
> +                 (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
> +                 (__entry->s2idle)?"yes":"no")
> +);
> +
> +DEFINE_EVENT(psci_domain_idle, psci_domain_idle_enter,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle)
> +);
> +
> +DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle)
> +);
> +
>  TRACE_EVENT(powernv_throttle,
>
>         TP_PROTO(int chip_id, const char *reason, int pmax),
>
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> --
> 2.48.1.362.g079036d154-goog
>
