Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AE24A074
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 May 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447896; cv=none; b=osUWFzD0uE20Jy4xWQYDNEcRG0E/F27+2pV8Yw7BBI3x4zQSrTQw9FU3Qm0L+aFVoOtoUf8HSaAjAJ7sajsOnQh7Gt+FaXcI1Abhw+geTcPLaapa6ZLLQ3i0BimPTlo4pvUGu0o76sGe2C6CFVssAm2aQaUR+Ju2ysZSubSYKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447896; c=relaxed/simple;
	bh=5mcW+2YvEmD8YxWkF8mwyimHSVkqId5kgoD9s500qSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvBv+vvUuTgdwDCoF8roxNuD+EfRpQE+Rq97YTbpGlC8eFYgkhUGVwxWyDSZ55w1s/HJd2+9jYOaxGHTaYYpJG0D7MYY+MfCOys0CqRB+f7iLBTl05m4eN0rzQ7u/OQGMAkB8qsfSJs6rmDn3Sbm1WSGnY7x/HxdCK2wa3XUNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XvfZe/KV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XvfZe/KV"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so713408466b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 May 2025 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746447892; x=1747052692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCJYSXV9aqquN0sqWVxTNHYONiHzEvamUGNz+jF30PE=;
        b=XvfZe/KVXxnulSrkmjrUA3AmHGaM5j5vAsEcBAE/dGEdJGhcA/evP+2fCRhDHsQu6L
         YtSr1AE5L2UJd68MpHt02WY3bR2BZFIzU2b76VFTpH+AVo06O3h38zVI7CJat19Z0l9A
         FjSqd76S9kP52azA+vTAmWMTGu2NwUd1NM3Ru71Ky1H0oaxTVZkPI+bR6gdBkZDN+nGE
         VqKJzSTTMSsf15k7y75eZdTXrdfca5gqPCHW/ke9YsiAgfW7JUBgPiDnVF2WlMuon2tL
         Ic4HdtuoE36gepSlVqYBHj1VfeAGG64nfvQByqwVNVvO3iQxe0mBr8TV1spF0zzUqgoK
         wQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447892; x=1747052692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCJYSXV9aqquN0sqWVxTNHYONiHzEvamUGNz+jF30PE=;
        b=Io+veAj2AZWe1fyyfYonMDBG4K0366yDlGspALGv3KuQu0YiVXKouwm5sq81vADn08
         8b7i7Zcr/Q9k4Flp9eh0ND0OUm7QD6LL7ZSkOG1WT+NkuFQnzEfFL6k0uSD4r339RdT+
         y32B1LkfGVh3Ame0CAYfPjmE5mfm+Tlbf3zdrtfuJzXmC1uOCPVFOpa9EFkyuw4eDw7z
         8SWoUQkXlwm3HQ0oIH/nUvgJ3Pi5OCr2uDqOkkyxMVtopRsXOdhiPQLxazgTlV5L31C5
         6Uf91FI1K85LARqD/Peg09NnRD11VxYphOs7iGClEdkSdyM/K+KU05TFHYjlxd7w1pdp
         JpdA==
X-Forwarded-Encrypted: i=1; AJvYcCXRAS6bhgHx8Nrf9EWI+qzIlYlqweRQG8xwNYCXCvoUIqjER8Nrm1cYmodB6kccOS9/1G0lQHShaLP3mNsB1PvHNDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+E/7ceP5Dd9FTDG/Wp8RUMfJMfs3x07ya5s7QoXXdDuqM/B9
	KJGcPpz/cXzZPpjkSkJAHtqOYHBO+Qkz9sI3koEnpY82Emd/yaSkX6kz3ki/dMw=
X-Gm-Gg: ASbGncvavnDwpJ0nmsYs6+7xrmxHUiQ2P4ay/1c58Fkh5grgpJh5RuSktEYi8W3Uvp4
	vacXqf2VYgBmX7F1PaUSW+ASsUuDT5IcALuYACZZpcJ7N4+vsm24Uhllr6mhTK29IgRy+yZriZy
	DpWHi5kTpuS2U2euTnFQae0TzZ+lQjWas1qrtWzHTUvnyA+pSt8VkTIQTjfCTTW/Dt9+R6MXWGV
	i2rhJJVsVsZL/rscTb1oiMrk4sInTMU3XHcJQU1wx2/WpRojb6DI6XzkVz4DWSyVhXbitiq66Mr
	bH53LfWteDuVmd/6u/1VKAD3/MpjV3szkzEjqQ4a8gaiGUx5s8s=
X-Google-Smtp-Source: AGHT+IHzMkid4QQ+TxtQuN2mNUWpCWLUm2rIHKQh2Iec3VYNpus1/zEyfeq1TuxjFvz9zpIW1ANtsw==
X-Received: by 2002:a17:906:f5a4:b0:ac7:81b0:62c8 with SMTP id a640c23a62f3a-ad1a4973136mr706008666b.31.1746447891922;
        Mon, 05 May 2025 05:24:51 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540d6esm482969166b.185.2025.05.05.05.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:24:51 -0700 (PDT)
Date: Mon, 5 May 2025 14:24:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v6 03/22] panic: Add vpanic()
Message-ID: <aBiuEnSg7ijbBtwB@localhost.localdomain>
References: <cover.1745999587.git.namcao@linutronix.de>
 <390d7357d9b24362fde68d7c9f0fbd5ba740398c.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390d7357d9b24362fde68d7c9f0fbd5ba740398c.1745999587.git.namcao@linutronix.de>

On Wed 2025-04-30 13:02:18, Nam Cao wrote:
> vpanic() is useful for implementing runtime verification reactors. Add it.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/panic.h |  3 +++
>  kernel/panic.c        | 17 ++++++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 54d90b6c5f47..3522f8c441f4 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PANIC_H
>  
>  #include <linux/compiler_attributes.h>
> +#include <linux/stdarg.h>
>  #include <linux/types.h>
>  
>  struct pt_regs;
> @@ -10,6 +11,8 @@ struct pt_regs;
>  extern long (*panic_blink)(int state);
>  __printf(1, 2)
>  void panic(const char *fmt, ...) __noreturn __cold;
> +__printf(1, 0)
> +void vpanic(const char *fmt, va_list args) __noreturn __cold;
>  void nmi_panic(struct pt_regs *regs, const char *msg);
>  void check_panic_on_warn(const char *origin);
>  extern void oops_enter(void);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb2..df799d784b61 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -277,17 +277,16 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  }
>  
>  /**
> - *	panic - halt the system
> + *	vpanic - halt the system
>   *	@fmt: The text string to print
>   *
I wanted to double check the __printf attributtes and compiled this
file with W=1:

$> make W=1 kernel/panic.o
  CC      kernel/panic.o
kernel/panic.c:288: warning: Function parameter or struct member 'args' not described in 'vpanic'

So, we should add description of the new @args parameter...


>   *	Display a message, then perform cleanups.
>   *
>   *	This function never returns.
>   */
> -void panic(const char *fmt, ...)
> +void vpanic(const char *fmt, va_list args)
>  {
>  	static char buf[1024];
> -	va_list args;
>  	long i, i_next = 0, len;
>  	int state = 0;
>  	int old_cpu, this_cpu;

Otherwise, it looks good.

Best Regards,
Petr
