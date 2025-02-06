Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D822DF9D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Feb 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839976; cv=none; b=Jcz3tj0HqCiHQCbWAR5T0sSbvPyCfpX4X+jHu+Ch50W4CvxhaX5sljUrTzR6nPXDVtZTZ6yLiqhy7xiClbAV+voqxD1UEBOAWOj4pE5TWasxLs9HXQjU86fvNJnB9q3GNy+ltwWbU2g+SOLwfWC048QL5zCVjU1GQ8FiiA2kc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839976; c=relaxed/simple;
	bh=uSTA4hN/FvLzpYyGHIJeFJQdyDYFG6AA9fA4OzHjNUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR/XQz22f6AxoCX4W3fCXyCD7qkdbtJoSPpFc2P2wr7ZZsYCXDXVKVOFq5QMkMpX9vWBg6eZMsRpcKpVd277pi8ZiFquziJ+Su5klcWuy6LsolBFDKVXeyvztGjJNs9JZOdy2wV6ImNIUPmLsNuEIgifAHz384JPLmBXkwAGUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDKHOZlW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDKHOZlW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca4521b95so1691128a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Feb 2025 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738839971; x=1739444771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mXE47cCWyK4lBa3ePxOl4Tt4nUECCOpvFmKs5qWQUGE=;
        b=dDKHOZlWs0MRD4cnIqPct58ikZBfEQNe/4gqQ8eKQDNd/mnV3aXMDX5UtWzdyH1gmj
         55h63014ib5rYUNtAEmiY8awhsEQPIazNm1KufZpJmLILV/HYtmBTpnNmxybSjtveAo7
         IpXBMwIAQKhHD3Wgp/uWVE58/NaaS4FcheTvsaT0IbeeperJDa4DyzM82cevYZoGaudK
         PXcKgJImpVsMsO9DGREmQ0Srw74TtUbwJaDT57O1ygUaJ1TlZm/q73Ce6XN3z56aX8vk
         w0UQH51aBDzEi5mj81HabwgCEhEQFfJTKQEUwhUXhpk1wcUiPLnfMtv6m8+7HDAW8hgH
         8b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839971; x=1739444771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXE47cCWyK4lBa3ePxOl4Tt4nUECCOpvFmKs5qWQUGE=;
        b=RVq1mnpJnrO+GdSikUbgNOjfOLvg3J+83OaD3HKNUB9Bd6QPSNvOcR/p3F0d59DX3Y
         DMGY5tV9GklBikkhapgMZpFHvZ0XOmnAHMXP7/0agXPhXdzeSEoX5Qqn2Ufz9CR+H2tV
         JeDn1ozBpjZNTP0ykPe4S/kwllJYDtbFdxB6GGjFGhlroS47BThEi7oNhephVctFKGo7
         t7xiu/2oTtmWuXTwkXWRfVQsoIv++6MtcgQN0xDtsn3izHrFbuUNK6GVjzA+LWkQmZp5
         T/ru+lEJa/qEjZZGIolIz+hMM8NVjtM5ENmVc6WZzbLilPifMy99uM5lsI9zMJavdFoV
         eMlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/KlUCeZxrRUndZg4s8cPGbHq6ISA3E5I5A6bcxoVFnIDc1Pp+FhryRkm5QnBpSyNwKnNgHv4OxE5snJ3Y0AlqBbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64XK5p+Qt/C+BXBbWg9P1fzbIEGYtp1iMlBMMeghYOTIGauBt
	haSGyJxq6TEMXntS4QJ/fBzapcLWWSZfDQeHzsEwtPc/eoDue1ahgCOu2ojG/2E=
X-Gm-Gg: ASbGncumxNwpnUOhAdvM4MTaJw0AVNhI9Wzf4pnWd79fN3TFd4mnsSfP+dTli83mof0
	0Tg2jEHLtfTs/jKqZ93ZSDQshwXtUBPs92TVWQL+Tow43+hZhNmr4NU8jOLdiPN1AAg0iHgxMR6
	LPUhF3519+Zt/2S78JHmBTcJ6cfFYo69pECgyNOO9DQ1d1IOTaI4tL+lmAYjmoelvUVnNQuPuIq
	tLiM+HmvjKuzGkaTVRIVb9JTrMT10zne5g90TaZbnnmG15YVVNDa2Uwc33StyIyxglyu9MBibcd
	U3HBb0BYrLIzVj+cGQ==
X-Google-Smtp-Source: AGHT+IHhw5tungS1WCfZTr9LIjTXHvl2yvbkxn0pkpTScc4ZbgAQ2fJW6rcViTk9NZQWzIkYKE9Ysw==
X-Received: by 2002:a17:907:9728:b0:aa6:7933:8b26 with SMTP id a640c23a62f3a-ab75e213013mr687209966b.9.1738839970699;
        Thu, 06 Feb 2025 03:06:10 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7139sm82774866b.102.2025.02.06.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:10 -0800 (PST)
Date: Thu, 6 Feb 2025 12:06:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <Z6SXoLnUw6D0xEqh@pathway.suse.cz>
References: <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>

On Wed 2025-02-05 15:50:14, Paul E. McKenney wrote:
> On Wed, Feb 05, 2025 at 11:37:25PM +0106, John Ogness wrote:
> > On 2025-02-05, John Ogness <john.ogness@linutronix.de> wrote:
> > >> OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
> > >> it, then?
> > >
> > > For !CONFIG_PREEMPT_RT, if there are legacy consoles registered,
> > > pr_flush() will additionally perform a blocking lock on the
> > > console_lock.
> > 
> > Sorry, I was just thinking about the flushing component of
> > pr_flush(). Later in the function it takes the console_lock even for
> > CONFIG_PREEMPT_RT. So please do _not_ have a guard.

It should be possible to avoid this console_lock() when only NBCON
consoles are registered. We take it in pr_flush() for reading con->seq
and potential race with register_console(). But it can be handled
another way, for example, by restarting the cycle when non-NBCON
console suddenly appears.

But it might be done later. We do not have NBCON consoles at the
moment so the console_lock() is needed anyway.

> > pr_flush() should never hang on the console_lock during shutdown, but if
> > does, that is something that will need to be debugged and fixed.
> > 
> > @pmladek: Looking forward to reading your input on this.

My only concern is that kernel_power_off() is called in many
code paths so it is not easy to review all scenarios.

But I haven't found any code path where it would be an obvious problem.
Especially, it seems that it is _not_ called in panic situations.

Also kernel_power_off() calls syscore_shutdown() which takes
syscore_ops_lock mutex. So that is must be called only in
a schedulable context even before this patch.

Summary: I do not see any obvious problem in the end.
	 Except, for some small details, see below.

> Here is an updated commit, hopefully applying your feedback correctly.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 35679c18b062368855e183ee6712ca5c16145d8c
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Feb 5 12:27:23 2025 -0800
> 
>     printk: Flush console log from kernel_power_off()
>     
>     Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
>     and shutdown time, which hides shutdown-time RCU issues from rcutorture.
>     Therefore, make pr_flush() public and invoke it after then last print
>     in kernel_power_off().
>     
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
>  extern bool nbcon_device_try_acquire(struct console *con);
>  extern void nbcon_device_release(struct console *con);
>  void nbcon_atomic_flush_unsafe(void);
> +bool pr_flush(int timeout_ms, bool reset_on_progress);
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
>  {
>  }
>  
> +static bool pr_flush(int timeout_ms, bool reset_on_progress)

There is missing "inline":

static inline bool pr_flush(int timeout_ms, bool reset_on_progress)


Otherwise, I get

In file included from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:99,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/printk.h:319:13: warning: ‘pr_flush’ defined but not used [-Wunused-function]

> +{
> +	return true;
> +}
> +
>  #endif
>  
>  bool this_cpu_in_panic(void);
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -704,6 +704,7 @@ void kernel_power_off(void)
>  	migrate_to_reboot_cpu();
>  	syscore_shutdown();
>  	pr_emerg("Power down\n");
> +	pr_flush(1000, 1);

This should be pr_flush(1000, true) as suggested by Sebastian.

>  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_power_off();
>  }

With the two changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Paul, I assume that you will pass this via the RCU tree together with
the other changes. Or would you prefer to route this particular
change via printk tree? Both ways are fine to me.

Best Regards,
Petr
