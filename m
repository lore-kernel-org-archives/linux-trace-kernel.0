Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB2A2EC563
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136476; cv=none; b=dKGLKBZD/XshyqHlztjJ+7N3JVbtXWFbDXHi2QTRHvoo1Aqjzieu3vsZucyAGZd/GLWFUAfYLxjYqU6n9W5hRdWlhb83Tq6LAuvIjhH+9ospp4/N2XxO0WDnPrlINGn2VecdEwWEI17Tnr/liuVd+enDeWBKDKKXVosUaWQ45pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136476; c=relaxed/simple;
	bh=YAbkYZrQlfJ6U2s9oizGjN7iGoBcBDd5qzlhP1huDT4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eeq8ogf55ArQoTd8j9x+9sW1EN58ruJy/uem/tTamk322T+6JcJmYBKJhfOFLhmUdG8MSZnXwe+IV1R4iSiYPPMc+nlbqXZpKSw3yXUxQHNJztJi3A0NxRZ9FJV4BEUJYv54n3J+pVRhHucRXHIPou0g38pjYtw8D4gXXTRUfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW/KcAQP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW/KcAQP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-431048c4068so875935f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136473; x=1766741273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCGmpPdYb0Ltj1HSEShjNZdXJFFU/MaFibrJ3AqDnRs=;
        b=GW/KcAQPSZXlOmBBlCsV8azEVXhHRt4tWwnjRfA/CgIB5ydGerdd3s6k2YUXPqujL4
         jJmEjCu6AJSxo4OTdKKSmXn/B3Mbdvx7eI9JJHj95OFIIAPPf68jQ7LLQr0E1336fTX7
         OvoE3lQqUfE5fn4cD0zUtTw/GeJX18Lh+HxTUBQYdlSom2Sr3pKwbqHlUbe+kLrjJH4O
         0r9nBNZ4549L4yTYqoQ5x2XcxBGIqp1M8KZuf3ywPOFsiznOROVaIOZgQUg2kjyg641a
         aFtKEG2iVyDcr3r+4d49wfoimLxqt3AmoidF0tH8fHfMv7IyQlyNsoJrqURrpXC/fmpZ
         Iisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136473; x=1766741273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCGmpPdYb0Ltj1HSEShjNZdXJFFU/MaFibrJ3AqDnRs=;
        b=qMCBgtzbZF3JKaPyoZdvgqvaB2e10f1CzYqHuPpixtsNe4oc1rhyRXO1uQosqVJOj+
         NsWkc1DG8EzhEsqNVyEA6rtQx2DaEZg9dfv1XgIlepNPyzc4hn0P9a03xpMSB/28igEu
         6XlHGXp0w921bJgAsnIdPPFNkgrZTUZUniiDjtnYq5Y9zJLyjA7zO607ySS99DPpJp76
         18BmJwcpy1KR7b2FeojDTz2olAqCfsHtsbrdrUZBNFsxX9MGzU0RU2nLXW98WVv/+qcN
         KmOZI9ww316JpofulEW40a++oxLSWFfIBsfrPwti2KOHoSaE3EQtiviT0bsTkpli/Avh
         2HdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAImmrxBaVY8pyBNru0WUBPyq2IA4vO+dxfklwTNIXGaISpOS1ZLHcMomgfQXGxfCfTeJfIV7Z+NwsPYLPQTOe83U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SCjUvboz7KGEpM32TEGmYk65g0wpYb+ooKLMNB+zNTPRsig4
	6dGQor9dOZX0ZjI12wl1b4NVx33EhXg5ioW3RYkfIxcp5NjawZxqV/ba
X-Gm-Gg: AY/fxX6RJdi3z458yFxdUqbrc0JcWVH3+uMwvaggh4sv40t8PvNqcpWQZD6qmtDk14k
	QAz32zYare8WdAFlATH0GNeA5b/vtsyHHmprqSw7kxa3cHQrFK96/tBWA8cJ5HFS5JctyxHDvFD
	TU0ir390awareJWtsfx8B/IS2IhdNd6uFhrN7hutoTxqlIEV10Q8EN4p4Nft1HHqK3jvZlaQ8Lg
	OCue8MGDEVQrNwVblYwnQdA1tJAF+Z/+Ippzz5yxjYpyEzPyjqLJ9rlxAGDpVYNMnNgF7Ls9caK
	PL7SMC3Tmd/bRLuEwwTC9MbhCT00P7uPCvxdXjZs62Tq0531qhQMOyigGdAF5ln1INo66N1Du7t
	r2HSi/tJ4vu3V/FFYmAx6rkI3VQeaN8taF2JoXnHngwucAZSuimWU/8FD1iE+
X-Google-Smtp-Source: AGHT+IE7/VK4y7V4wJuk9vYv49B29c5HQgz1tSNGyKksyWwzYQwHH1FTIr4fJ/PQrOZ1NBe4x1lPWw==
X-Received: by 2002:a5d:5888:0:b0:431:307:21fc with SMTP id ffacd0b85a97d-4324e42e79emr2769680f8f.23.1766136473309;
        Fri, 19 Dec 2025 01:27:53 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2beasm3929064f8f.33.2025.12.19.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:51 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <aUUal38FoUFnndOI@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-7-jolsa@kernel.org>
 <20251218101942.0716efd6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218101942.0716efd6@gandalf.local.home>

On Thu, Dec 18, 2025 at 10:19:42AM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:59 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 48dc0de5f2ce..95a38fb18ed7 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6489,6 +6489,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >  
> 
> Kerneldoc needed.

will add

> 
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	struct ftrace_hash *orig_hash;
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	if (do_direct_lock)
> > +		mutex_lock(&direct_mutex);
> 
> This optional taking of the direct_mutex lock needs some serious rationale
> and documentation.

it mirrors the use of modify_ftrace_direct/modify_ftrace_direct_nolock
when we do trampoline update from within ftrace_ops->ops_func callback

I'll add comments with more details

> 
> > +
> > +	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +	if (!orig_hash)
> > +		goto unlock;
> > +
> > +	/* Enable the tmp_ops to have the same functions as the direct ops */
> > +	ftrace_ops_init(&tmp_ops);
> > +	tmp_ops.func_hash = ops->func_hash;
> > +
> > +	err = register_ftrace_function_nolock(&tmp_ops);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > +	 * ops->ops_func for the ops. This is needed because the above
> > +	 * register_ftrace_function_nolock() worked on tmp_ops.
> > +	 */
> > +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
> > +	if (err)
> > +		goto out;
> > +
> > +	/*
> > +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> > +	 * We can safely change the direct functions attached to each entry.
> > +	 */
> > +	mutex_lock(&ftrace_lock);
> 
> I'm going to need some time staring at this code. It looks like it may be
> relying on some internals here.

ok, thanks

jirka
