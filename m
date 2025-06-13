Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA082F433C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Jun 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784615; cv=none; b=kbPsG8ibJOdQsjpl2c4qoXRSChzC1ekWPsnbVEhu3lFVjdSSQmlogeGtttN1aNVIKR4o+EQuvIROv7dpoHilcwAyrILykZb9N90mcYmvEAfjBKm/BveX+9mRMFmk3RKEGUoGnBKw8xrq5qS4QiGlPnixQ7xnWqC49uobwbI4ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784615; c=relaxed/simple;
	bh=TulGS3xeFhRMM98s6deFwT2NXoIcoFFPD7Ay9V9fBBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdWlcWIsmpYdk1giUvSWd4vwkRPJwH0NwR6CBgUHY69txXTr8xEsp0Z4c8HmyD/DuPlBqWNk56rhjeuiaQ98P8z7f4xh/dWwbCKPsaI/hTY+p71FLjBeBhKaxSHzCbAzdp8dPJWK9Lti/a4W9eRz24Vrb4mztlQEzqVxHT3+iJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YfRTC7l2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfRTC7l2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23649faf69fso16757195ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749784612; x=1750389412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap98I+eDUm9/OncRY5L40akvtMUL2MyqVOzfhknq874=;
        b=YfRTC7l20mMPPz88rdZ7bhGYZXtGVY2nQhj2F5VqjEw748yMrVXeHgyXXrPdpd2QcZ
         hpO3ClaS9YXb5Q4GvRfv23Vkx1Anuj6r0OlkXb9lLLwu3rlcxdzi0naT+AAJ591QNfSw
         kVH/L29AkU/aK8Mh1D0gCnr/KyqrxnU0l3AqUFSpjE2HQx7J2ghiMNRvS2cbSy2sC1wR
         Xe6GhXT/Xm1CvQ+L2yDfR/e1tPLtUqI7m9yFBQaIvypGo+TodIHXBJ+YQjXs4qjUAZla
         NPyHbMNruzisDZe9+4yluatuGbfBaPoPhFqJMC3YdYeX4BoYCnyabpHiNStQFvdSEHea
         rG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784612; x=1750389412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap98I+eDUm9/OncRY5L40akvtMUL2MyqVOzfhknq874=;
        b=JMhy3H1LIHboelEJoFbWnOLoXL2/WaX/Onkz6rCpLxIW18PQl2190UHrvmdSmAnGtL
         4M6zQRSD83DXhhfyyy/FNPpiKvahiGV+hyd+FDmjs4kJ9cdVKDKO0O3pyvY/xhRRcCAJ
         nDLQjtfGndxT0bKdOrNTz0gvnRSJdx7VsJwufc/hJuZXvy0mDPTMb63EwEFkeHaQpXgO
         7dHG6qS/Job+SobkhLG6SVBT0xKoEvhR6J5uqjcbYDBdY9qXtQnSZSb6E06zWE2HBVwR
         3RCCpqcVTXbLOwaJnvOAs49dNuuNc/1TnJEgQf8CcTmdJAXB4KE7dnarV6FxBUtj59Pm
         pzjg==
X-Forwarded-Encrypted: i=1; AJvYcCWfmUuj/QrMBruxC/cClwslFbWqBzT4go+N6YG8PLbaX3+9pMmBxEa4sgtzYS6T7jqxjwNNGjVGlGYQqWYblVrgj4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRV7gTm5xLLgL3wIXNFyUzGUpeM6CcsJSWXOShv/cto6fqOcaG
	XHMMeGTSFGlpOLRFi8UIqT59rrS7yS3TiQB7XWhYhCOSMsPRSNuYZ+j+vkJNUVhBYBU=
X-Gm-Gg: ASbGncvxOPt568QbmTpqHR6Y88W5ppG0BBF9qx9ifyFpQqR/94AapCK9s9/j18+qDA+
	9aEPW5TBCqo4VQCeoela846dK+2e+pZvFJptc0UH9m4M6xAJWAqNTnh8GcUsRa5HcJpQGT3FO+l
	O2hYf71F++zkDLTRX05tvjnfNDSYDHKd5WfJB9024vFXPDqVqBga/X4X6NaSo/YlAbhPkqhLkbS
	e5j9gpbovv7FLDpvrOfNOZsZu35CjScvy1FLo4OSHq20YqTrzvhB4lLQZXFnKip6NxHrKD+fmKQ
	jD8awESPk6pqzkCnEGHusuF6ecSQ6FvzdGjq851QmpjzX8E4Be/RA3Ehlvnw1Gw=
X-Google-Smtp-Source: AGHT+IHNXC3txXNOUer9QYDOQjxZSJ6IgCaYAHTJUBWcCsiS3vra7fop+grtC6B10VdAfwH4GdqnXA==
X-Received: by 2002:a17:903:228a:b0:235:f70:fd44 with SMTP id d9443c01a7336-2365d8bf339mr21709775ad.21.1749784612494;
        Thu, 12 Jun 2025 20:16:52 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8fe6sm4650285ad.164.2025.06.12.20.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:16:51 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:46:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/4] PM: cpufreq: powernv/tracing: Move powernv_throttle
 trace event
Message-ID: <20250613031649.lj5zdvw3wl6dtfft@vireshk-i7>
References: <20250612145310.563358597@goodmis.org>
 <20250612145407.906308844@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612145407.906308844@goodmis.org>

On 12-06-25, 10:53, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> As the trace event powernv_throttle is only used by the powernv code, move
> it to a separate include file and have that code directly enable it.
> 
> Trace events can take up around 5K of memory when they are defined
> regardless if they are used or not. It wastes memory to have them defined
> in configurations where the tracepoint is not used.
> 
> Fixes: 0306e481d479a ("cpufreq: powernv/tracing: Add powernv_throttle tracepoint")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/cpufreq/Makefile          |  1 +
>  drivers/cpufreq/powernv-cpufreq.c |  4 ++-
>  drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++
>  include/trace/events/power.h      | 22 ----------------
>  kernel/trace/power-traces.c       |  1 -
>  5 files changed, 48 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/cpufreq/powernv-trace.h

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
