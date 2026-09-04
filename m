Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B343F4A2
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513907; cv=none; b=I7rVhMnvOfo8HJRToL8QIuiIrj9GhVYbi0HFAa26NgONUqJRai8w7W09vAQRWyqRH3+Nv+B6SiXE1UHIscEE50ZnJyRFqwVuHAfiWXTJJL73ndjNBFzAwxh/mgYLAUGnm2iWoPAQXqAt0+3w0m5tjsDEnHa2sQsve2HIjKIxZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513907; c=relaxed/simple;
	bh=2X6NTd5o5cahP7ikmbjYlSQ9HSpozpUrhg4lY0w+n/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl37FoXhK4UhJA5oqxWJEK2H76PjlFJP5NmIZ6cwg3GnlVed22Muu+o4vy568h6s52xcC/Q7Ly4W4r2eeX5vyO3e8ibJRiOHgC26lDYEGbkS4dxVYf568rJ2R1EUHwBI93zeBB40JakaGs/m21pzLZHq9bdp8RIOS9SrhFYnWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PmqGs3Jf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PmqGs3Jf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so8330675e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788513903; x=1789118703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juEQFS8o8HO1Is63IJWO2O6D58EgoESYis0VW0w9IIA=;
        b=PmqGs3Jfjcm9RsIObXqIelgKvAwX3JWpJvG+mRoBbpCUVMAZkBfkukImAGg6duqEXF
         2/NotoUTM9I9ejF13/4eUmF3m5xFuBTTNIQi6wWO8Ex6PoPY1PbHzGYW13x8Ee5jKIJf
         5DkcdCWxjvwqaS//asktGFgdKxwZf7T1amMonkktp2BydnZW87DoFc3k9M5a73/vYknx
         RkV0UK3cJAk0qkF8uOGpFm4bjoWrn0gu/1rVkutXIXFWouC6GlpfoSv+exiWDmCmHzM3
         p58D6orPCFIJo/yLxXr0vvqLQvARpXLvsbNvlBN+yQ+Xdpu1OWofk+WziZClvMyDfYD2
         jSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513903; x=1789118703;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juEQFS8o8HO1Is63IJWO2O6D58EgoESYis0VW0w9IIA=;
        b=fU/DTD+aTWyhaohtH/sLI710amhhVmt1g+GK8zHeGN+LxgDbRi9BvwSQWkvg06L9gO
         dv5oXhg/V7pCkMoAuMRJzPQM5tCw5D0CA8XjgEiKiH11SnmjNY2VfASMEU06N41TaBOv
         Sfa78I+SG6XCRG1O6vgwd7g+gvi2jOl0XvgkcngLBLVmhkwnHtQkH02RflJ7nLgZen0q
         emXQbGf0lpD4I/eP+GRTvc9YZKWZEMtPqFjZbyoHPr8zmvm4h4XM5yz4KOSXx317+ya9
         bWjnFmfEff1IDYXuEcqkei+/p0nJSg2l/bE9/YN52ZbgZ+0PQ8wW/k3R6hPJEFDn3sKc
         yz0w==
X-Forwarded-Encrypted: i=1; AKwUvBwiESJ9H/vUQrPsmiVpdTmAZc/BjohyinJge/o9g/HU0lOUKxObEuStBN8N5TAlHt58NyfJYcOMn085IgQq6QhILMw=@vger.kernel.org
X-Gm-Message-State: AFuF++kpQPz8Vsq3wEz794SuU+HvAbA2Oqxgc5vS6oKKJXB8cXg29hI8
	zHMMxnsiK7xdN1qEMc7rxl1AFxpU7Enrb/81J2M38Q3UoNIJZ2KZ7k3d/jYMh+fEk2E=
X-Gm-Gg: AYBFou3Z7ZSIvXzUjdjFg/YIRzawHfpNp9FAb+YY3WhnmSnQPZOmYjHSKxsEyNlI5Kv
	Az7ZxsPlZ+CLD/LMmguM9L187VhMQ6lQRU+yLQBL54xbiG95Rkj1/Zz43ACX4dOcuEug1sLeicF
	eW7afSGQ4592avDUFJJ4DC3ThiVCxpRCi9v+ahzpGkPbyA1agXcaNbl4EIOFpljJZC7BZJ2XCSJ
	fo0k7kPmLm76QoFPAumHTxNXljMZ0HsHpV+cngQq9n9rvMql/LAiC0zjKnKOFSMh7WUuJ2juE71
	4hD1i/3rDZBIJtJgm4FmPf4xTX6dStemxYEP2xjOmFqhLcDllsfsWzMzqi52wiAVKwmmoRue4nA
	Zb2ui19lsIfmlryC4S3cClRPcZsCp/zCRvfYMLqJC7FmS/GRu75Fk74/PlWJymEiuXaOPaSA+mV
	TeaknqbTNFiILfVcjayBYUgyQTsL4k5Wo6OCaA8d6YgXK9Ld0aVrlKODnbQqNOCbBk73/hK9txk
	hO38czkGkOO+NU6gXHFPk1Ukv3AcH338U0=
X-Received: by 2002:a05:600c:474a:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49cf825d722mr44304815e9.10.1788513903166;
        Fri, 04 Sep 2026 02:25:03 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm52989345e9.6.2026.09.04.02.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:25:02 -0700 (PDT)
Message-ID: <a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com>
Date: Fri, 4 Sep 2026 11:25:01 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] module: pull out add_taint_module() to be public
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 7:10 AM, Greg Kroah-Hartman wrote:
> Other kernel code might want to call add_taint_module() so pull it out
> and make it global.  If modules are not enabled, this defaults to a call
> to add_taint(), so all is fine.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/module.h | 10 ++++++++++
>  kernel/module/main.c   | 16 +++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..f6f90cd88f15 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -29,6 +29,7 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/dynamic_debug.h>
> +#include <linux/panic.h>

Note that I'm working on cleaning up linux/module.h to reduce its
preprocessed size. The main motivation is to shorten the compilation
time of all the small *.mod.c files. Since linux/module.h already
includes linux/panic.h indirectly, adding this include explicitly seems
fine to me for now. In the future, I think we should introduce something
like kernel/module/stubs.c where the CONFIG_MODULES=n variants of
add_taint_module() and other similar functions can live without bloating
linux/module.h.

>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module *mod)
>  
>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>  
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok);
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *mod)
>  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>  {
>  }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag,
> +				    enum lockdep_ok lockdep_ok)
> +{
> +	add_taint(flag, lockdep_ok);
> +}
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..444d990c9983 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct module *mod)
>  		return -ENOENT;
>  }
>  
> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +/**
> + * add_taint_module: add a taint flag if not already set for a specific module
> + * @mod: pointer to the module that caused the problem
> + * @flag: one of the TAINT_* constants.
> + * @lockdep_ok: whether lock debugging is still OK.
> + *
> + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> + * some noteworthy-but-not-corrupting cases, it can be set to true.

Nit: The final paragraph is mostly copied from the description of
add_taint() but I don't think it is quite right. The parameter name
should be lockdep_ok, not lockdebug_ok and the values are
LOCKDEP_STILL_OK / LOCKDEP_NOW_UNRELIABLE, not true / false.

I suggest updating this part for both add_taint() and add_taint_module()
to something like:

 * Use @lockdep_ok = LOCKDEP_NOW_UNRELIABLE if something serious has gone wrong.
 * For noteworthy but non-corrupting cases, use LOCKDEP_STILL_OK instead.

> + */
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);
> -	set_bit(flag, &mod->taints);
> +	if (mod)
> +		set_bit(flag, &mod->taints);
>  }
>  
>  /*
> 

Otherwise, this looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
