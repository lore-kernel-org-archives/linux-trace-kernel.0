Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD623DE87
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843491; cv=none; b=FoYNqFXWIXS3oP1Q4rDwIIQqYbjKpoUBX1A5z6Hcw0hc0hFIi4ez4ZupDaD42I7A6pTEI1E9dtT2dbSfDXwrzXK4K+NqywusOz6b4WJT/pVzHUuViEfj6MwQy71Ga2beTOoOPT6ueP2YYJhV9zX/OCTM93/YFkBLrQOwk1FxfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843491; c=relaxed/simple;
	bh=lEm+3aopJoKQMql16KzGFjs3gJoP1xspnmUFB1eTvTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH+l8Zab3uvzzKAajHJ3Y48SlKnLhuDIo2CjMvPjaEikZv0CbhOV1CY8BIskvx2gRN01Yh+4qnKkDkKTQlRj5llt010JILCA6V4TmHV3Q4YHI0X4QOBFr+qfKEWiIIpilG7ldpRj4LURy7qfmXLSnY4wp8uPgyazIYqU55yJr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOpoz8Ut; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOpoz8Ut"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3a227b82so3202671e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733843488; x=1734448288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEN1d0OnLQcbT4xueqG7SoZg37x7ROyZS7rk8Ls8Os8=;
        b=WOpoz8UtUZghzvK7zPXitFC4t8yZ3TrHb3Xt+nhrcZEuqJ/l+zJ6OY9dU4/tQiSZdL
         q+2NfQ7y7VuGz85IFy8F49gz7zaiGtI6DofMBvNM3b1adm0TlXnRWgecoMvvSKCW7zq4
         MhflNK4NTF/0H0wyMSIwMYZmVSGwPCPKugUAUR6FCur1DwkuYj2jRVnukajDYWwYKFWW
         aiYM9sT3kDhMUMG7FIz6vCsJGV1moaqS5od2RGoPprCFzYQTz2o+LEX8EjXlx/UJXbAA
         F88R6aWiHtxHUAa1nL+eQvvRKdSu0OEtJ+xk6YwECLYj1IhUd6eXxyDPZvkdzIBWjFHK
         tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843488; x=1734448288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEN1d0OnLQcbT4xueqG7SoZg37x7ROyZS7rk8Ls8Os8=;
        b=NFrSZi42mjCFP/KucczxJJBEP0xsSHpFvDK+CTAiYonlsc9OOY3dq1OLTKOloC1qNl
         DDwepYax5Eg+aKtwWznbiZnBTNIRFgFQ7kQtgkUJwxIrXs+n4rHEIbjSWH27uoAvGWBI
         PSuPoWO98nZWF1/YGQRHUt9h3JTYjE1nToht06B0pu3jPvUVD7yAHy6FZq3i1jwFCrWs
         KuhDdG3/vz4A/lXKIe8O/0evPZPoveNMyr7GUtim71IOYvexDo92lsehORv/Fa9bo3oW
         eXiZPPkkycE1kbjoGi7Rwg9OMYq3jnKjSyt/3FddFbA31XZmqvaqRLL2YiZwLHO3ZJl5
         SXSg==
X-Forwarded-Encrypted: i=1; AJvYcCWQt7p+pTs3tBW330DGQq+3XIgDtq6LqYiaZmVnpsAliPstI5p8/oiFkJWGkNAsEUsMDpG50kx92HG18XFD28r0DvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZTp4N/klJ1U1q2azEOWYcuthIySJy2QQEP3gPF3OXDo1FzDS
	soxbPdwxowGqR8ICZNhfZCTcyevKN/eqJ8YIHp7IRg4k67cYuEOB3uJPlT45cX5MNTk4GVntewG
	0dPlc8TNgVIkbtAqzOBp3+TgOyi12AShWAfu4VkG+HFQ0vCbrhgI=
X-Gm-Gg: ASbGncvypvXhbm5a3SfnOwbPoqgzA/5oAlkDLQvL0ufT2C1ssoQ0PEwf9Ip2YktJtIq
	GxAHFtzT/hSlD3uKwI/JZuaJiBZFOm/yomw==
X-Google-Smtp-Source: AGHT+IGJm0Y6WmhhOsiFiI6WYV9RIpRbGC3+UR923jjT1xBUygkszZymmfEJR2CbAWdHwlnFwSK/M1aoJCQV2MQUYPE=
X-Received: by 2002:a05:6512:68e:b0:540:1be6:f16a with SMTP id
 2adb3069b0e04-5401be6f4cbmr3387362e87.0.1733843488006; Tue, 10 Dec 2024
 07:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018214300.6df82178@rorschach>
In-Reply-To: <20241018214300.6df82178@rorschach>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Dec 2024 16:11:16 +0100
Message-ID: <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sat, Oct 19, 2024 at 3:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:

> The function graph infrastructure allocates a shadow stack for every task
> when enabled. This includes the idle tasks. The first time the function
> graph is invoked, the shadow stacks are created and never freed until the
> task exits. This includes the idle tasks.
(...)
> Cc: stable@vger.kernel.org
> Fixes: 868baf07b1a25 ("ftrace: Fix memory leak with function graph and cp=
u hotplug")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This patch regressed boot-time tracing for me.

How to reproduce:
- Enable CONFIG_FTRACE, CONFIG_FUNCTION_TRACER,
  CONFIG_BOOTTIME_TRACING
- Pass command line
  ftrace=3Dfunction_graph ftrace_graph_filter=3Ddo_idle
  to make ftrace trace this function all through the boot process.

Before this patch:

cd /sys/kernel/debug/tracing
cat trace

gives a nice trace of all invocations of do_idle() during boot.

After this patch:

cd /sys/kernel/debug/tracing
cat trace

Gives an empty trace :(

And:

cat current_tracer
function_graph
cat set_graph_function
do_idle
cat tracing_on
1

So all *is* set up, just not performing

I tried to figure out why this happens but I'm not good with tracing
internals. Any ideas?

Yours,
Linus Walleij
