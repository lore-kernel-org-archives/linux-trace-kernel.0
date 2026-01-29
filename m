Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B2366815
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723422; cv=none; b=WYDYVk7WVkn+PZtDDmSLewTYY0RPrUpbQ4lG3lBnV/H0EuR2rksMQNQppSzyiC8SyMpKWNVIe2c4TPqVWf35pMvBp5QWmuUdn3sk1BGPs6Qu0/JtNQQVIGrxtOHTpny3pE29HqEyJKpn9dbigAPM7gduhY/e8okkZqlLyi7f7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723422; c=relaxed/simple;
	bh=QJB1a5gNqpH6jrHMpEyj+87Z5mH93GBioJQvzPUVeY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7KdQ2boLxYqFpItOEA8IVmLccyYErvxshhtY7anWheVaw91sY955u6t6iOR72KGKACLKJq6ioaVflXgGxM7qttEu7jdmk8cbwrvlS7EKvAqic6H4ym9EpBotLgSZtnqwvQQTXAaoyp1V9w7Hw/wg18LBt/yh856scyc1UVW7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl8XwLGA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl8XwLGA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432da746749so932772f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769723419; x=1770328219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+SMixISY32I4TNkZ6inO6uSY2SNlSvt1Krp91cY5JE=;
        b=tl8XwLGA2yOS0+Fj4a7RqFBo3cgZsJ+34uicDRzKZZDaSC4c/WbZOfIz0TPzjq9nq6
         FR+3tgmboOH/0i+kdzVxi2Q/bRa0R22EmsRUThg2GbOkq8y1/YjrL7G8bMwMMvKQ0X3E
         oBoNdJJlb90xUEJGUgi7ycTrBxqfZiSGTfoBhTk4ns12FvWGDY4AJchx+bICr63aKtbC
         NZAkw0Vt9Mjc+tBOsHisQrid19nzR9UpinG58vJNGx7I4LFytznmIylwNhCChyAeYVpV
         icQQ8hmqRbxtLbk573EThl2rqQXJhWkj5JoTMQKyNQd1cxUuSVpCSnYz+bgWqLpP81Rm
         80sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723419; x=1770328219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+SMixISY32I4TNkZ6inO6uSY2SNlSvt1Krp91cY5JE=;
        b=giBN8sz1u7OT5pnhVztlh1jB0xvM8vMZvUuuZ2p+KcfbfOCYTFyNZjgmzFRQDRQx7Q
         dQPK0kRuUl9OSo4hnQdQg0lpjXGr/l8RfIN7m6y92CFd/h1VnBzrpdRK0nKBgZ58PHVM
         jAa8T24qqIQ0pUDYeal/YYJioSZ01hk9nCPjHMuYhZxrFVrK3321W2AgWmqcy4mhEo6p
         A6sukNKsTwC6aXlWr6u1yNkwiliZ0zpKp5Ou/KlKR+7JaZfTbJNDGXgJPWnKGOWoh20W
         Qi2g2sNBzthIAP70s4mSC1/dPJFdBZZFGsXbuRpBAS24n/h2BdRfhHPTdw/wikeVGinP
         NVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgdCVkHDBPD5QvZNZFSsR2/iMZYs7BE1hoGbUcknQoqDqkST/57KMO1xuijaqkBB4gwl8+uZGkJ5OJfIZBYpV0va4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOPWYUjoYY6fiPnp/w8FhnLxNCC1+dT8fypLxs4sHh33Ly8T7
	k2gEew4PeK0LnBD5so/BPuNnlqLhY1kz4WqAyodjjV6cGjUVYtvnErM+BYK1zt3+Xw==
X-Gm-Gg: AZuq6aKBi5gWf/b/ZoW1rk//rlAzyg9K1IcIeRLd4svdj15I/D8juxBntRiYCS60lN8
	ylB+rQws//n9BHr0EggN2HLXSd4RlaFyGrN79krR0aQATC+eDr7wGYTkeZ1Ufh+z1IzgJj8/2M4
	YhmTrhdxPiI9bTXyTl37StmmyiwN1Dxp7ks3WVynAXs4sB6W3QsE4Zq8AjRusLphyMC+lC19W8Y
	YwsGIIks9lHPxROiLv7QA0CF/k/1ARkDy6hYMup2lfm7++qTL7Io26mozWXiKuFiTd301wpKkFK
	o7RA++C8CUH5sqCxKmRhhZ+3KLnLtzcsZkCLDe5zr2TZYlN/rqxjboOYsWC//zaXQhQbZ1VgumT
	AfeXXEBDXQkHBdSCJ97EmApc82iBN+TyGErbVt/jgvlv0RFewfO6qgHGOy0NU/pDRO7XBOzh8GL
	gSQPstMAnCM7McGzSMOiSIa6KOj+2QxSvx83TD64wmrPl05Y/Rvg==
X-Received: by 2002:a05:6000:26ca:b0:435:e3c6:554d with SMTP id ffacd0b85a97d-435f3abb4e6mr1226168f8f.52.1769723419386;
        Thu, 29 Jan 2026 13:50:19 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm16938883f8f.34.2026.01.29.13.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:50:19 -0800 (PST)
Date: Thu, 29 Jan 2026 21:50:16 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 14/30] tracing: Add a trace remote module for testing
Message-ID: <aXvWGDEx6kMQWyoe@google.com>
References: <20260126104419.1649811-1-vdonnefort@google.com>
 <20260126104419.1649811-15-vdonnefort@google.com>
 <20260129113452.190d4d79@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129113452.190d4d79@gandalf.local.home>

> 
> Where was the cpus_read lock taken?

I am pretty sure that's leftover of when I was reading some CPU mask :-(

> 
> > +	cpus_read_unlock();
> > +
> > +	return ERR_PTR(ret);
> > +}
> > +

[...]

> > +static ssize_t
> > +write_event_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *pos)
> > +{
> > +	struct remote_event_format_selftest *evt_test;
> > +	struct simple_rb_per_cpu *cpu_buffer;
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&simple_rbs_lock);
> > +
> > +	if (!remote_event_selftest.enabled)
> > +		return -ENODEV;
> > +
> 
> You want a guard(preempt)(); here...
> 
> > +	cpu_buffer = *this_cpu_ptr(&simple_rbs);
> 
> Otherwise this triggers:
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: bash/1096
>  caller is write_event_write+0xe0/0x230 [remote_test]
> 
> -- Steve

Ha, of course! And also for a per-CPU ring-buffer, that is way better to make
sure we actually do all the writing from the same CPU even though in that case
the simple_rbs_lock protect us.

> 
> > +	if (!cpu_buffer)
> > +		return -ENODEV;
> > +
> > +	evt_test = simple_ring_buffer_reserve(cpu_buffer,
> > +					      sizeof(struct remote_event_format_selftest),
> > +					      trace_clock_global());
> > +	if (!evt_test)
> > +		return -ENODEV;
> > +
> > +	evt_test->hdr.id = REMOTE_TEST_EVENT_ID;
> > +	evt_test->id = val;
> > +
> > +	simple_ring_buffer_commit(cpu_buffer);
> > +
> > +	return cnt;
> > +}
> > +
