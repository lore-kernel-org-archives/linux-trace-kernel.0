Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E331F2BAB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612133; cv=none; b=Ztu8PLIR57lfb/JCSIBkYWyK9oNVCliFoAwoleYfCOlWTKpQOSVHXs0I3+yQuyYmIG+5YgzeRKSWn50/oaEL5j1xE15NhZb2DhlPGyb8baJsshDmItjMLSAbAamsFPlbTYMXQdS0cUV8hNaOag2xZa28JaloN+3IogeAutjabIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612133; c=relaxed/simple;
	bh=sdLSZHE+YDb6j4NUPbiZkZNvbBcm8s32KKgkk41wlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qkGkvCNItvQcLZ9XDlCJcO5Lamk2ClWyQ1+fikM+x2DyXdKSNC0stikdezlB6DZBwunBP928EYWtxmecjl9xMbWcnN1Sbx8UYZ0UdisDriVFqWBjRziprRJ5TfPvSzt358jxvqfumDcCMBERWDguGAeNxx/6BUlkrBgJFMHC+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRZFCm2E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRZFCm2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755612131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jL4DCYjUTrqfa8AuGeCkz9uDEXcPC2wDOnFYU02zZ4o=;
	b=RRZFCm2E9nNNoBVYqOXpzFoXTfMTDTUAjM28FDXdFmD5VuC10oVVWzuXShD+4U+Ro9m8Hs
	/ak6eRVhjXJaM2WDVJrR/fCmVxcwG0hkK1eCz8uctgKprvew65FdnEJhqhunePRYQFKV/M
	CE2/SBJ6l+Tza8dPk2zR6j5tZDPSH0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-EKJOpFvdOuyMZNZoYvfoqw-1; Tue, 19 Aug 2025 10:02:09 -0400
X-MC-Unique: EKJOpFvdOuyMZNZoYvfoqw-1
X-Mimecast-MFC-AGG-ID: EKJOpFvdOuyMZNZoYvfoqw_1755612129
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4166a7bso2686353f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612128; x=1756216928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL4DCYjUTrqfa8AuGeCkz9uDEXcPC2wDOnFYU02zZ4o=;
        b=W2Ubzirx+Nc6PhkDdrHYM1bau12dzsboFY90QcQr+K6hsZoHXoKSNAS/OIAPBHtByM
         eBsG5Mf7GULor20tC6kW8kavAaDdoeGZQvOvZpQu39FfCJZJFF5N6i5UmDXQ4oNRBqjR
         eHNJEQV5jD4Lt832UM5MNBX0knGMvDD/2UiOndAsblhCLhmIQeJSeGE/R/Adpz6Ngd37
         kCLfGqEl2hcW8fudewWxUXpBiv1R09W8HNX/DWamfK94aoDt5XMSJQK28pGg/tALEn/X
         CfA0URjT7n9r/sQJTt40gxHLhohYSIsP7IzOHjbfVrm65CfYx+0QBh//JcAP88M/8zhW
         3wJA==
X-Forwarded-Encrypted: i=1; AJvYcCU3GnqsxQsaYFMgc2DDyjblklC2jVFJtR3G5yLQJcp8Z7x2QVPWQPrsgXCbGj+hhnOJXgV4AFkK38JdjXC3arIoHTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H02b4/1LAwdSoZeZM5VSZ9M2QwG4Yatjg82FP2EIZ4DI899G
	drsq+cd3PRkcLy+RXDXq8cLTVSUHBQcW6Z9yELdXv7QegEE96+j4t1rVHkaWFNbP5ROo3vyRYS1
	2nEXMPXHEfPzD7zN1dtbFfCQzDx7lO7uV2LXpefSli7gvFqrXNLNiF30wnSEGnJqPJR/PsVZ6bg
	==
X-Gm-Gg: ASbGncuQLqAqtyz5fMhjzU1WzTxPklXturAGkBSGsAmXs7kZK6pdN5cT4+WQg/Dv7rw
	Kqumfh01FS+886gcGVrq2hLvlREp/ZjVBwJWLsEBrjplbesUrd/SdZLcTyHx7UxIC/j/2nWaA3S
	G6Hx1duxktnNNfgFvi9fBzxDYCFVutI/xEJF5y5/cD3kQ/hQBX7wIvH9vFq0PmkIp+QFeuBh7tX
	nnYTev+eBLsdNqSTbdz6VMlUznytFvWtyfi1ACyUdQQkegslCJSK+5LPK3PHX6KNShZojxWBapP
	z4F3+PYGhipZgUK/fO4dQqCderRls9rREayleORDQQuh7EZQfbIg4JlChz17Hs9BgKmH
X-Received: by 2002:a05:6000:2310:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3c0dffac9f5mr2475147f8f.10.1755612128210;
        Tue, 19 Aug 2025 07:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5N1I1AcneaySadyW04OkCHGfpwFLPFglPcwgnA3c0/PhMkULX/Yz4XNz/AjzbHNPRbbcP6w==
X-Received: by 2002:a05:6000:2310:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3c0dffac9f5mr2475113f8f.10.1755612127649;
        Tue, 19 Aug 2025 07:02:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789c2asm4140604f8f.57.2025.08.19.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:02:06 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:02:04 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8fkdAD9Ph1djaNnijbgm3hkIUwWcEY12BawLz9lJM5Q_1755612129
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 19/08/25 12:34, Gabriele Monaco wrote:
> 
> 
> On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> > On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > > Hi!
> > > 
> > > On 14/08/25 17:08, Gabriele Monaco wrote:

...

> > > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > > *rq, struct sched_dl_entity *dl_se, s64
> > > >  
> > > >  throttle:
> > > >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > > +		trace_sched_dl_throttle_tp(dl_se);
> > > >  		dl_se->dl_throttled = 1;
> > > 
> > > I believe we also need to trace the dl_check_constrained_dl()
> > > throttle, please take a look.
> 
> Probably yes, strangely I couldn't see failures without it, but it may
> be down to my test setup. I'm going to have a look.

Not sure if you tested with constrained (deadline != period) tasks.

> > > Also - we discussed this point a little already offline - but I
> > > still wonder if we have to do anything special for dl-server defer.
> > > Those entities are started as throttled until 0-lag, so maybe we
> > > should still trace them explicitly as so?
> 
> The naming might need a bit of a consistency check here, but for the
> monitor, the server is running, armed or preempted. Before the 0-lag,
> it will never be running, so it will stay as armed (fair tasks running)
> or preempted (rt tasks running).
> 
> armed and preempted have the _throttled version just to indicate an
> explicit throttle event occurred.
> 
> We might want to start it in the armed_throttled if we are really
> guaranteed not to see a throttle event, but I think that would
> complicate the model considerably.
> 
> We could instead validate the 0-lag concept in a separate, server-
> specific model.
> 
> Does this initial model feel particularly wrong for the server case?

No it doesn't atm. :-) Thanks for the additional information.

> > > In addition, since it's related, maybe we should do something about
> > > sched_switch event, that is currently not aware of deadlines,
> > > runtimes, etc.
> 
> I'm not sure I follow you here, what relation with switch and
> runtime/deadline should we enforce?
> 
> We don't really force the switch to occur timely after throttling, is
> that what you mean?
> Or a switch must occur again timely after replenishing?

Hummm, yeah I was wondering if we need something along these lines, but
we can also maybe leave it for the future.

> > As per the whole _tp() thing, you can attach to the actual
> > sched_switch tracepoint with a module and read whatever you want.
> 
> Yeah I believe Juri referred to model constraints on the already
> existing events rather than new tracepoints here.

Separately from this series, maybe we should put such a module/bpf thing
somewhere shared, so it's easier to use it when needed.

