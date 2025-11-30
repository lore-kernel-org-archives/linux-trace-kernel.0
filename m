Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5028C2BF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526583; cv=none; b=uy7h20hr4xKBsy7gf7iEKat7DSS8Co79oW0q5vIwa8KQMyydGCDdF9YP6UiPKATR+xGpcUGGCjfBgvcjr5XK1CuiH9g8h6pO1iAVirDCFNMemgHvfDgsUZEGX75CegDL31CYPpewx8bgoSu1H6Vdoj6E0D5YR49reOiNCz/92EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526583; c=relaxed/simple;
	bh=xMe2StGzK5NX+kq6kKhx0Deffi5L07sCSW856vZYwzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5Q5MeeAGGjwmkp/aluTU190Tno5o11wiluDTf2Vsa5yFhj7GWQcdjEH8VJluHbS7dxe1kSbwezVRei19ckYXqL4uabfUNRfdoUjlNdb8urX9WMqExwfUEjA+pziBnKV7OovMWHVMR/xU9VQFxgZAt+SMJYREQdE5FqydlcNaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAt4cI59; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAt4cI59"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-642f3bab0c8so2664341d50.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764526580; x=1765131380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPTHL8VwtfKfk45TFU08paMyal7EO1gfKoy+e7omzHs=;
        b=eAt4cI59JxPsGjtJ11O+7GH/oETePW6BnD31pPwEe+xo4Ko+0S079pSUzzoJBtfdzl
         bkRcWar8e1ngKub1JmKn8XVrwPU9L2AyUljdDOFnVYuDuqvsJwlRGdLLGUhs6FMf1TU1
         X520Iww3vfK0Q5CpmAsbwR1G5SDoHlpK3TWUksPKx3dVKsU5SEW+yEKrhE87yvd8uorA
         fYT8Xyv1NYoyDYGzFApp8UX+OaLsn8GwiFIf4C0xQfMhQOUP9OhToVffECMlLUj62TNO
         HMfWONadLlZC8QfZ5/Uf9Ayra6tU+ufYTCQgQVK+s8JUnjDLok2J42BwnebyXmDMip+O
         GETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526580; x=1765131380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPTHL8VwtfKfk45TFU08paMyal7EO1gfKoy+e7omzHs=;
        b=ehXBXXL0jgG3mZCMf59teiar/l36Wx+by0zbyZzUZ6BElN0OGTd4JqJHUlCAz4gPPL
         aS6SwhOi0dOZ2CYJaiCCsKmT7uPcOiCRIwhSownf6w7sWAIeCln/DhgRCb7tnVJl124R
         +ktxLKHemcWGLxuytZSEiUAEBU/DziQzLZ6yciC2WVf4mw3SOhOWoEA5Tn+3ufpIeYZP
         A21AMPjjsZKEUmRGRTbfLgnJiNy4wV4XARpjvvMXm1YCzQcfj4NsoyFf7GvAXvnUp7+d
         ZkVkgGp8mrX7ErwzN2ZtBBVJpQ+Y0HxomMzgzGBF2tEDg6ldENtBNMzbN2a4pBurD+hr
         GdQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJd6vCrP0giOiNCPvaTST286eSLYVxVKiQTWc3Ataunyq+T+YduD3kh/KOh9etkNsE3hQBKUZ1ratKjKZ3eQmnn5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZoBvYdguUQesZkxppitCHnl3za0qq7dgM4oBTbmujDvu9TVU
	t4JUYwHRd3OBL44LLFwSvkKw/61dbb8LvljEjg3m5VUCma57lDdeNFvT
X-Gm-Gg: ASbGnctcBvY3w7Pqnu9iEpHDZbvZitXDBYrI/GtzTgAC5D377dMsS+LwXvx8w78zgIe
	qSM2zUwNyjdnd0csheBK/gQj2QdZPoeSGIXAB4TmI2f8zOF5rWeMHKi1+jQQ0JGRVYVjkHI3A5m
	nMj4qZ1uvgPDTyYDnrBXgrsAfG+SPog8aVHHBADQRIpC8xk4o5PjT5yuRyJRxTAMEh7DBkFJDFA
	uGIWHUtz82qRHw4Vvn/QUEjSY8RNCw1ti+kWIeX+t963veYVt0bR+MRrrbIQcAiqRNwes+Jp5B1
	++l4fc9PexublQ5cDUvlaBPC2QO30P8azIwmr6jhqzcxboWxt0MRLRdnZyBXYJZUqLvSQrHmwLh
	qWmFZ+n7zQYICBZZhnvSc7HrbdMB9LLxjw2DI5ydNtFYinuWDhY7KB7kCUM0mIXXrPPgVL9/v3z
	mk1HQBVvElTI28YxQVuA==
X-Google-Smtp-Source: AGHT+IEQcHwA7T6ktmCXafon70hVlddeX9BaPXERtnLHGkMmTox+ufRP6CsVlNJn8W2ToaNF/lgtHw==
X-Received: by 2002:a53:acc9:0:10b0:63f:beb2:9519 with SMTP id 956f58d0204a3-64302a2fb59mr21422815d50.5.1764526580498;
        Sun, 30 Nov 2025 10:16:20 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d603f5sm39289087b3.19.2025.11.30.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:16:20 -0800 (PST)
Date: Sun, 30 Nov 2025 13:16:19 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <aSyJ83v7EEAPHXeU@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
 <aStX3242e3mo5H05@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStX3242e3mo5H05@smile.fi.intel.com>

On Sat, Nov 29, 2025 at 10:30:23PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:02PM -0500, Yury Norov (NVIDIA) wrote:
> > Tracing is a half of the kernel.h in terms of LOCs, although it's a
> > self-consistent part. Move it to a separate header.
> > 
> > This is a pure move, except for removing a few 'extern's.
> 
> Yeah, I also have something similar (but half-baked) locally, the Q I wanted to
> ask is why a separate header? We have already some of tracing headers. Doesn't
> suit well?

Just as said in the commit message - this part is more or less
self-consistent and debugging-oriented. If someone needs to just
throw trace_printk() in their driver, they will not have to pull
all the heavy tracing machinery.

> ...
> 
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -27,6 +27,7 @@
> >  #include <linux/math.h>
> >  #include <linux/minmax.h>
> >  #include <linux/typecheck.h>
> 
> > +#include <linux/tracing.h>
> 
> There is better place for t*.h, i.e. after static_call_types.h.

They are poorly sorted for seemingly no good reason. I found the first
t*.h and just put this header next to it. Don't think that placing it
next to static_call_types.h is any better or worse.
 
> Btw, have you tried to sort alphabetically the bulk in the kernel.h after
> your series. Does it still build? (Just wondering about state of affairs
> with the possible cyclic dependencies.)

I didn't try. Sorting #include's is not the purpose of the series.

Thanks,
Yury
