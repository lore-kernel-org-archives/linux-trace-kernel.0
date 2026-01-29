Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AE35DCED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722764; cv=none; b=Vupq5hW1OTFEGcDdVgN9XvVziyQp0iMTVN0QmY1sLa6u6CyTN9L3ZAtmlJC8+bgms1lXalizmTfz/T+Yob7/KSsdQdgPLUoi++VvJnescEeiYAOaMsoeDOtOzRjH2rF0UN9KPgp33gM7O4ues8+za2q0wgNGwM0qQSln+wFlpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722764; c=relaxed/simple;
	bh=FTzxGJtugdKjao+qMiaidJcp9/vBaAtySKq8E304Ljg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXEjruj1r/ySloCrG/q8UW3XIyATBZ8lYK0WBb2itbdC86AA5oh20wNPjrfkL2mKLoqMD1HTHKOkKfXLujdd4MWZqpXVVI0QyZs78yYZ2fPkz1o64ysDxgFBS9eGo+/QNhdigoDP2L3pLEn7sI4MojVOpZwpvDRgD+SeycOiTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB74BPw6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB74BPw6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801bc32725so10946715e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769722761; x=1770327561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+w81DyXUE0b55CwrLCwC7XYX50M/2QX/b1Gp0d2KP4=;
        b=CB74BPw6ypQkLynPD23eT612MXDhr8xgoni31jppeH9Fl6A99Q7h1X+Cz6+ycDVOa4
         zFJkzZqWsyPgitFqqWsQHzjxbnADrANODjP8IhKS+ihg8V+T42/oCUsSw651uY6YXwt9
         CpRdSMxP/mMVDQ0l4ZtLnYeu3K+M7nJu3Bx4x2Dha2O94LtmDyFGUhmqkj4+Ew4pzRHB
         36DKD5jrBZrY66epU+Q14O6yt+6xZ+FPs3CpgNCAE0vsdxvYv758TDLXVi4W07fpRfU6
         TWacr656wcs8iFWAiz3uDI1N/vTvlaX5KcDchoRindsl3KFZ9h2LEY+fqK7alZE+0Pis
         TfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769722761; x=1770327561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+w81DyXUE0b55CwrLCwC7XYX50M/2QX/b1Gp0d2KP4=;
        b=qIOXF5TnMjXJb62R+c5i1CMI3fj14gLZenyyLOzMsvHI4j+CLwKWvAeRNgajTiCL0Y
         stxjJ2FS2E1KbwDBZvJqjYyVUayOTCJCemo5CCB14b+Ive6aattZN2m6m8LEykrC0YUz
         IfqyY70JxoLaXqe3KljifQcqatLLjqbBAZTzEhZFos9vCfu7akeqRHrLZOczQEXM1uAT
         41URfDcobMkYQeQ1pF8qEb8wSs+sBsr/s4DA0xRY8lZIeUDnRM9JIa+ZXtGSS07ZPecK
         xSFr6hJe7NGnvn2KH2t9SGVnU9jFsshN8nT80AEagFIs+zSs4oJ1BxfG/6KyJuVnuKJ3
         9dkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqrZflXyEnzoIvZE0L9Mh1L64WAbBg9kzluJE9Ft66O3fanlZm1n2XOlMUwYvJzu6tcvlP5pMms0xpWQIV213RkxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIF5CH1O/K2t/ihRN4kFwkR6oG84AK25tR10wtSzr+ssVnLTzC
	/AizBOsEs4roehLXEMDEESkQForKIQildYeeV18yqjiw2c9YIZDS2+EHpqEcFJnuYg==
X-Gm-Gg: AZuq6aJiHgzm/f6NNZm0BrA7w2T4gYOTnBJRaMfhsEXj5dGZtkpbXza2mcL3B5h+hPP
	IJcPb5z80EeCjeBZE2tXU7Icoov8HyB3UkWIQhnsf7xTMJcy5WNMnhRtqWSeUPao53qNCOa/LiD
	CAyKUBrw4DVKEuNZZsLNBwV1ZIOBhoEyeAb55jbY8o52DQfBsygKGoxMzKcnI1eD40WEYm6Tw0v
	BPK4r9OC1CHx1cVLeUgWX3Jwi6k7XV7GQL5sTcMV8tm68P/cKOkyh5NwFnWL/lEJrjGpHXmZxlX
	8OBga8dLNuRhwzCdL0Z9ZPr6oFDE9it5dmliI+cqlIubH/pTnj1BHuUhCkqUJbhZAJ253N/EDSY
	EKAqgLNSaLvQ+vmKkasSYunu7JcBuVZnFTRUJE5iTEit2KIo34d2Vq5fKlKxnUKvDeW56CJhELT
	upNtFX1HBEUsth15IVP2f/I2CqN8ClRZVy8iaIlTBH3H9FqzyBuQ==
X-Received: by 2002:a05:6000:40c8:b0:431:104:6dc2 with SMTP id ffacd0b85a97d-435f3a674f5mr1361562f8f.8.1769722760913;
        Thu, 29 Jan 2026 13:39:20 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm18781379f8f.13.2026.01.29.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:39:20 -0800 (PST)
Date: Thu, 29 Jan 2026 21:39:17 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/30] tracing: Introduce trace remotes
Message-ID: <aXvThRcUhuBreMPv@google.com>
References: <20260126104419.1649811-1-vdonnefort@google.com>
 <20260126104419.1649811-6-vdonnefort@google.com>
 <20260128153725.56e801c0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128153725.56e801c0@gandalf.local.home>

[...]

> > +static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf, size_t cnt,
> > +				    loff_t *ppos)
> > +{
> > +	struct trace_remote *remote = filp->private_data;
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* KiB to Bytes */
> > +	if (!val || check_shl_overflow(val, 10, &val))
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&remote->lock);
> > +
> > +	remote->trace_buffer_size = val;
> 
> Should this be allowed to change when it is already loaded?

It would only be effective on the next unload/load. 

But now thinking more about it, this is probably not clear to a user and
returning -EBUSY when loaded might be a better solution?

> 
> -- Steve
> 
> > +
> > +	return cnt;
> > +}
> > +
> > +static int buffer_size_kb_show(struct seq_file *s, void *unused)
> > +{
> > +	struct trace_remote *remote = s->private;
> > +
> > +	seq_printf(s, "%lu (%s)\n", remote->trace_buffer_size >> 10,
> > +		   trace_remote_loaded(remote) ? "loaded" : "unloaded");
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_STORE_ATTRIBUTE(buffer_size_kb);
> > +
> 
