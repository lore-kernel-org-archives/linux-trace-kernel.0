Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53327242922
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709570; cv=none; b=aqJ+M7sFT2wNkOCEFCrhKzS1j0xc3NPf2UaYFjLS9/lcb+vuds9LUdSWYdYNGZu0UqHtj5WP5f7n9+8SAfBkPbWA43wAK42USCMsLeB9+hbJ+hrBi3/Caimsw2/Yf1mFzEdjPd/H3bVhz5ccyQ+bWXpMtL1dKIjgHKNcOpLRAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709570; c=relaxed/simple;
	bh=lOiRTAybYayb9gL8oPxlmFEgR3nBNh/2YNLccv8btMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+kM3fM+gjrKIjf9VahG53ebZAjpq8bC15gZif7gHNjltRJJGsz8914IP8XlOLIwCzYvqvXbauSafr/J5dnH0CCsws8PQRPSqApHHjaNaCk6sFdpHZtzXUsDG7cAiXYUbCbWUNVuO9334KUtIlMjChGr5e6+LbPUhGyMqivtrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H9HEHjdz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H9HEHjdz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so58052025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744709567; x=1745314367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ChKRr0CjrlXB651WgPg2zkL245D+bFasqL3VFnfqBY=;
        b=H9HEHjdz/BRXLwHJSMBh7G7zPlpZPO4vZk2A2tQLwsV8qjXGhHdNkNC3/e8sb1GG6S
         /A4r7mdQJ0i6dEM1gcjBg/c65o4Yq6WdPo904QWydEVZPrTWzG6Tr00YCuaPuSxsKm7t
         lEomD5l32s0F8TXMNPVnjH76Tk/70gKzQmEfroDYRP/39BTh9ZTxiumwp2z85D8nsfJM
         4MX6US+9GffYbo5Ye3z60/FRi1wJ/SHdwkWSRWI8SydBuktg+vL7xWGxwh3Ri2eyrfNV
         KTcInNvuM9Ne7Ue4JV62JPuUpfNc/qJCJPrBM+1RgUvxHaeoXRanwbYheNaarhZCLz24
         yjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709567; x=1745314367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ChKRr0CjrlXB651WgPg2zkL245D+bFasqL3VFnfqBY=;
        b=Zl2eGvCFLgMG4Lrg3yLv34ctS9qXSLH1xzml34JiQ9JEGOdq0GGV8MFMaky3RK96j7
         XtUJ3c+URy/SDrDtQgxI3mjsikhOkUjW2WOkq6JmpvaElf392nIawtvqPt9Y+rJ9wdAr
         19TJSrJ95gRcjBT/6PpdSRfbe6QfkHjR9qOw7VqVjiCRRHqxfo7lYgbWTS3wTfMSEla6
         E+f446AZ0S0dT6h9HcrIXhRo7obIRFesG13siM3EDtmQ6f3JzIj3lKyhtkyB0I206RAi
         0GMpywnQCL7Xixf5ZdhrtILXII6URxig4dktHG8Uw9IRPwt3FmBNA1Ycnx8+dABVpgNS
         uf4A==
X-Forwarded-Encrypted: i=1; AJvYcCXPKb+GnXAGgKabnLiwykfjVFBIzMs00NmyhIQq0x64KTpF9jbY8AmrB3RQov80CFCAhuv/aGFrz8RrnaJ+ozwbFJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTJBFjCf9PdkTwYRfDqHRCVX+M6/YcUo1LBH9Mj8pZOZEyl5P
	75ROS3dvWnueWDSGgLAM9+xoj6jIjiF6CkCnFqWtm0faMW28rNEydsfKQcvyjE4=
X-Gm-Gg: ASbGnct7O/HXdYb7oyExB7yX0O4a/LfKAQLGMuHW2z172uuwie55s91KzAu8Lr7Gwea
	VJKMnBoNt1Z0u+hVCUY4VGfdVgrDq2W2vrRD+PXuwTughpYyG1ui3TDB19j7QzHo3+g4Zy2P0jA
	TSnP/iHQrKaoKrvZkOp/NPnXJgiG/eAV7woJMWtPfK78n2X4sBbEaVgQ5Q44PvalGtFetjgs3nb
	l133bgPjkOd+1JMhOju5ve7bKPCv/PbPmIS/dRzMF8/3fIS7qLytEZBHdNDN+/1g8GIeIy3J7Uo
	Cjn1yqsRlpfjls95luIdaqyXBAKMDzdop4YCrKd/d48=
X-Google-Smtp-Source: AGHT+IEGMxNjBijRd5ZIgU9ekSNtXsFNAXAuAYjOiFrUbssXpLTKzHUZ7y47I01Bc0l8S/SL3FcMWQ==
X-Received: by 2002:a05:600c:1c8e:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-43f3a95c43amr120754165e9.19.1744709566592;
        Tue, 15 Apr 2025 02:32:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e90sm201822225e9.38.2025.04.15.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:32:46 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:32:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 03/22] rv: Let the reactors take care of buffers
Message-ID: <Z_4nvJEB-RXX9T0n@pathway.suse.cz>
References: <cover.1744355018.git.namcao@linutronix.de>
 <fb397e38b56f3eab7b7f662fef4860ee4fbda873.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb397e38b56f3eab7b7f662fef4860ee4fbda873.1744355018.git.namcao@linutronix.de>

On Fri 2025-04-11 09:37:19, Nam Cao wrote:
> Each RV monitor has one static buffer to send to the reactors. If multiple
> errors are detected simultaneously, the one buffer could be overwritten.
> 
> Instead, leave it to the reactors to handle buffering.
> 
>  include/linux/panic.h            |  3 +++
>  include/linux/printk.h           |  5 ++++
>  include/linux/rv.h               |  9 +++++--
>  include/rv/da_monitor.h          | 45 +++++++-------------------------
>  kernel/panic.c                   | 17 ++++++++----
>  kernel/printk/internal.h         |  1 -
>  kernel/trace/rv/reactor_panic.c  |  8 ++++--
>  kernel/trace/rv/reactor_printk.c |  8 ++++--
>  kernel/trace/rv/rv_reactors.c    |  2 +-
>  9 files changed, 50 insertions(+), 48 deletions(-)

For the changes in the printk and panic code:

Reviewed-by: Petr Mladek <pmladek@suse.com>    # printk, panic

I have just briefly looked at the changes in the rv code.
I wonder if a __printf(1, 2) declaration might be needed
in the printk and panic reactors code, see below.

> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -38,7 +38,7 @@ union rv_task_monitor {
>  struct rv_reactor {
>  	const char		*name;
>  	const char		*description;
> -	void			(*react)(char *msg);
> +	__printf(1, 2) void	(*react)(const char *msg, ...);
>  };
>  #endif
>  
> @@ -50,7 +50,7 @@ struct rv_monitor {
>  	void			(*disable)(void);
>  	void			(*reset)(void);
>  #ifdef CONFIG_RV_REACTORS
> -	void			(*react)(char *msg);
> +	__printf(1, 2) void	(*react)(const char *msg, ...);
>  #endif
>  };
>  
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -12,9 +12,13 @@
>  #include <linux/init.h>
>  #include <linux/rv.h>
>  
> -static void rv_printk_reaction(char *msg)
> +static void rv_printk_reaction(const char *msg, ...)

I wonder whether "make W=1 kernel/trace/rv/reactor_printk.o" would
start complaining about that this function is a candidate for
‘gnu_printf’ format attribute.

I am not sure. Maybe it is enough that this function is later assigned to
the .react callback in struct rv_reactor.

I wanted to tried it myself. But I was not able to compile the
code in linux-next. I got something like:

./include/linux/rv.h: In function ‘rv_ltl_valid_state’:
./include/linux/rv.h:55:43: error: ‘struct ltl_monitor’ has no member named ‘states’
   55 |         for (int i = 0; i < ARRAY_SIZE(mon->states); ++i) {
      |                                           ^~
...

I am actually not sure against which tree I should apply this patchset.
It did apply on linux-next after skipping the 1st patch.
But it does not compile there.

And there are more conflicts when I tried to apply it
on Linus' master.

>  {
> -	printk_deferred(msg);
> +	va_list args;
> +
> +	va_start(args, msg);
> +	vprintk_deferred(msg, args);
> +	va_end(args);
>  }

The __printf statement might be missing also in the other two
reactors (panic, nop).

Best Regards,
Petr
