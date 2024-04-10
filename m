Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914717A931
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783592; cv=none; b=dn2TTKJ3nVPcsJ1Cv3sQnEJqm1lFRztUvt0ucAEyFpri8cbbOqAZlRPoFAxBMfxS76Ta562t79JB57aMF20VcSTQZBXg+dQmjtvhWvN1m0XJ4umqhu5uIvUR+i/Xe7JGFf224q6Lw/wMJNMXxD16p5GNOT82c+gAXAIEV+Pnhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783592; c=relaxed/simple;
	bh=5ydEIu4NwxWWsRaT80Gi5impoOhDMVhIgWRTaHPvrF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K87PYAqPZ/ZG1c8pUCUnGYcoyNpoBE3wlRqkHH1StUi+x8t5K0V+qKmqc8bQCwjdpBf6PzYQdnYWwGk6H85mjrt1/VnMiyCRQjNqG0xI55gGbD2JiVdS2UJq81pX0DG35ajIQJamZplfusj+pyLBm7p5TmRrwsmV+8xJYWGfVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R92RmeCb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R92RmeCb"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0262036afso286547339f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783588; x=1713388388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=R92RmeCb5yhxFGYN312O93Wo/4zEIe8uEBtC4ciwNzxVyAr/G3JoKr9/Biaja+4HXT
         u5f5D2WIVSWD26WmHHZzeNYORd3V6QQPvH9NE66SlEGaXCO7zGAxowZSzudmEmAvGKqr
         +MA0E4paqzINR38VwPQhPlB5696MaqNm8zMmXGxGXLPoeU7nwZBKWTPilVAFIQB+PLuU
         1o+/BFREv0VkiRjUPJj4IV05dvNqCJL8bc3x4nFeDfFUEpFu5A5n0RH1pyEGs6xSRKTO
         /gQqs9AaXX4nY+E6fejGWJJpHQwdaTnGoW3JpZMN/WZ2nscwB/6f1Yx7d4ws/UJEsoCJ
         VFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783588; x=1713388388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=acnqbx0MsRv9hblV/dq6DheXk/kAs6bY0L/T0qgSKgU3QDtimojaEyn3S1QJyUhCzO
         pUSxaauy89RTXNx9kQh3Anvg0UQRSpRWkI/GDQ5WC1mx6mahfRd3RlD1ypysi7LHVy3l
         S+dlWoiGNkFyn5YtR2Rrp4bWm1X1QcfHLSM06El05gnDXt4L4dtdiXrL71afOEq05vk+
         MKRAMSUcVKZhQyUaBITTM+dby8vZo3G8bQV9MQidoKrwlFsN2BxnuI4UxnufXmLoqYKE
         hCzYwDWT3myZVjX29UNuOWDRCIrUYIS7JTE4X07YxIXBdcvtzalpfiDOnHbn4CTPgwdu
         eRQA==
X-Forwarded-Encrypted: i=1; AJvYcCV3lJEtcyuI6O+dZN8M/2YThjXdG9QVzOFqzef6AbxY9UC8d/+6KWLK2c2Yumoai2G/XL3eHglPjCBaCzINzexewFhoL0Go7DM0f7TmTX1HMQyr
X-Gm-Message-State: AOJu0YyDpQHWFbO3N/WlyBRbUTncU/LsCEBD6/HSkAC/ILMQtCrFyWYc
	A58z+qkqU356oieekYg77BHowVZ1iidCBlO4KAOBoGpXe1i6lYffuUjEpO0tmg==
X-Google-Smtp-Source: AGHT+IGpHuPTnJ+wxQMsV1XcgPUkjimJl+2RrlfGnCAGUQlqpTB1RQcYuHk2y6FkjRIkT4ntypW3jg==
X-Received: by 2002:a05:6e02:1d88:b0:36a:1eed:f105 with SMTP id h8-20020a056e021d8800b0036a1eedf105mr4448912ila.1.1712783588250;
        Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id fg1-20020a056638620100b00482a9f7066csm1313094jab.151.2024.04.10.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:13:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:13:05 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] [v2] blktrace: convert strncpy() to strscpy_pad()
Message-ID: <ghua3jruo4xm3tj55wafwok4aveter2ychgu4lmw3k5rzkg656@np4aozq7mhbl>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-5-arnd@kernel.org>

Hi,

On Tue, Apr 09, 2024 at 04:00:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 warns about a possibly non-terminated string copy:
> 
> kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
> kernel/trace/blktrace.c:527:2: error: 'strncpy' specified bound 32 equals destination size [-Werror=stringop-truncation]
> 
> Newer versions are fine here because they see the following explicit
> nul-termination. Using strscpy_pad() avoids the warning and
> simplifies the code a little. The padding helps  give a clean
> buffer to userspace.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
> v2: actually use padding version of strscpy.
> ---
>  kernel/trace/blktrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..8fd292d34d89 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> -	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
> -	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
> +	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
>  
>  	/*
>  	 * some device names have larger paths - convert the slashes
> -- 
> 2.39.2
> 

Thanks
Justin
