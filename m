Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150893;
	b=KtqdsgO6IcuJLe9Ti8GUpYWlehlflmI1jIr7EiHXx4icmPlt0KqgS41xuJfvd/LBWrNW
	 qrS0LMncrYd3Qznc/ZHVTPZS0MZD05zXnROOvXkU3PDeA378qUFsEUlBDF+YVkwLOsGBk
	 DhMWSyacwOgkSsKnWZquOBD15jDLIgHapkFE4m+xrP6NjGWipl6L5MimY08qoiC4dhpc/
	 +RNpYPTWKxGK00pSc5cqcHRxhaJ0flwJ4bnjDEnUBHajuZypN2uRSif9DyMTUk7ulDOCb
	 oUUw7QrNbO7d7QRe14gqrnIbUl0moUFv9br8Zz4xZtwVK54xE5CCT9wv/oQsAywShUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=89v/919HUnnwHwPTg21ctj+crJf/+BLsEi/S3ziXGGg=;
	b=l8nFRKeAEj8Gws1M/L9FfHcT5iH1KTM5ymjO+rJPvKapmUwjEAEaPXtqRvky1f8qPUVi
	 xw5cUb+VTYHuBa//HLzw1EwCo/Xdt1eg7C5fRlKodh+oh+nAS4sZrQfLAA2wcXcPFu3+Z
	 HTqZeQgQvLXI4/kzIOpeHMT4tsS4TdxIWKhV014/AEccCcAyGxbc+Cj+MJpSyFIiB6JX8
	 P+Cnl8jzMUnJPeVEcUawNPkyZwnF858vVSqnhO/a5raRbw0r7WtQ2Am9zNYQvmQzrT0iL
	 Zoxv2aNH5NRhd3q3RLY1oloo8Afbd6dAJUDAjYsc6FLMQsRQ9S08xaerfDlaRI1y/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZxfc4JV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C9606A32A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZxfc4JV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8CC1F01825;
	Wed, 28 Oct 2026 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150892;
	bh=89v/919HUnnwHwPTg21ctj+crJf/+BLsEi/S3ziXGGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZxfc4JV9vl8ZyLndoYIObyjw4nN/1EVpbvPbaC3fwBQJ0JmqKu62qZVjx3W/dh1U
	 xQiAEkLnAgNrQPgECknaZHDSneDNFuIh2dL6hzBNeEtilzFFGX04uAgkPlW8KDyLdY
	 NHs053wMwWNQSmEgg+SG6L+/GY7bt5+3Knkb5RRCNoTCAuCW0D6ds5hpailhDgsrJE
	 mCD1DlC7BQg/8/Dy81qg+SsLKeUOwYC++bmjBI7iKxgQALMhqVSu9ToKTWNW/XhIkc
	 D/1f/F9wly/YdXQmfZl6iierR0htpc1fDhGAOFCFwPbW2IoT0Smf2zuB1FRcGM3/nG
	 Q223XELVddlEw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/16] tracing/filters: Check for trailing characters after newline in filter string
Date: Wed, 28 Oct 2026 10:28:10 +0900
Message-ID: <undine-1793150890261749864-1d389ec021e6edea@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-187296@kernel.org>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314830681.684037.17927533770192828788.stgit@devnote2> <sashiko-outbox-187296@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 01:00:29 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tracing/filters: in-place truncation on error in filter_check_newline()
> --
> 
> commit 8f43e3c8d713c8d0669d239d3455b033bcd6f4f2
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/filters: Check for trailing characters after newline in filter string
> 
> This commit introduces filter_check_newline() to truncate the filter string
> at the first newline and reject inputs that contain non-whitespace
> characters after that newline with -EINVAL.
> 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 9d1446464058a..f3c18324b07a8 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -2441,6 +2441,31 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
> >  	return -ENOMEM;
> >  }
> >  
> > +/*
> > + * Convert the first newline to '\0' and check that the rest of the input
> > + * contains no non-whitespace characters.
> > + */
> > +static int filter_check_newline(char *str)
> > +{
> > +	char *p;
> > +
> > +	if (!str)
> > +		return 0;
> > +
> > +	p = strchr(str, '\n');
> > +	if (!p)
> > +		return 0;
> > +
> > +	*p++ = '\0';
> > +	while (*p) {
> > +		if (!isspace(*p))
> > +			return -EINVAL;
> > +		p++;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Should filter_check_newline() verify that all trailing characters are
> whitespace before writing '\0' to str?
> 
> Because *p++ = '\0' mutates str in-place before the loop checks the remaining
> characters, returning -EINVAL leaves str truncated at the newline.
> 
> When __ftrace_set_clr_event_nolock() in kernel/trace/trace_events.c iterates
> over matching events and passes the same filter buffer to apply_event_filter():

Oops, indeed...

> 
> kernel/trace/trace_events.c:__ftrace_set_clr_event_nolock() {
> 	list_for_each_entry(file, &tr->events, list) {
> 		...
> 		if (filter)
> 			ret = apply_event_filter(file, filter);
> 
> 		if (!filter || !ret)
> 			ret = ftrace_event_enable_disable(file, set);
> 	}
> }

Hmm, IMHO, there is a bad implementation in __ftrace_set_clr_event_nolock().
It should make a working copy of the filter string and pass it to
apply_event_filter(). Or pass the filter string as `const char *`
so that it is copied in the apply_event_filter() side. The ownership
of the filter string is not clear here.

> 
> a multi-line filter string with non-whitespace characters after the newline
> fails with -EINVAL on the first matching event, but truncates filter in-place.
> On subsequent matching events in the loop, filter_check_newline() no longer
> sees the newline and returns 0, causing the truncated filter to be applied and
> those events to be enabled.

As a better design, we need 2 level of applying filter, the first one is to
parse the filter into an abstract "filter" object, and try to apply it for
each event. Thus the pure syntax error is rejected in the first stage.

> 
> Similarly, in trace_boot_init_one_event() in kernel/trace/trace_boot.c:
> 
> 		else if (apply_event_filter(file, buf) < 0)
> 			pr_err("Failed to apply filter: %s\n", buf);
> 
> the error message logs the truncated prefix in buf instead of the full
> invalid filter string.

Oops, this pr_err should be removed. We already have parse_error()
(and the parse_error also needs to be updated to support this case.)

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
