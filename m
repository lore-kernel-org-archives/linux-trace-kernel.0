Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EB2D63EF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763097069; cv=none; b=sXoatiPsbeOGZjMyTEiHtw4QHJC0ZGnFv7WJNwcC63YJMSvH3sGYqgPHBuFoyaUWmBbvJgv8D6uHVK/1seKR1BNw/gIZDbY5vv7prZ9wU1OCQa45KlsWh0+8LJjEL3/+iav+fSX5q7ALbURQTBg8gHNzlUlghuEwFczL8ldwWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763097069; c=relaxed/simple;
	bh=VDRfarJF+3U5Aetyq0P+8gmVWOWRsfQtOVKokJa2PRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8db8HHA3TO/ofa5gASlhUcnlDBPw+0SRi0qPXQ/yMyZ3XzfNkCboGDBM3SIhJQ+DjgGpzNbbhZ8A9gvvQO8VH6FkvCwZn1dxU6pEfiOxMUg6GRoBjZwvUyb2QkOJlcgxPuw4PMsW/+HRo9BJEhyMrB5dSW2vDYkhU91xLESmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2d7BQOp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2d7BQOp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298145fe27eso18879795ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 21:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763097067; x=1763701867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsBGcCiz3WCLrT7j0Nta57r0BhtlxHqhVrvzURlT4hY=;
        b=f2d7BQOptmnbAMamPzNdKpp3djS5Dxc1G5d09XJuNi8TKKnzUjPr5/hjVpTSJOv16l
         V2FlpJvHaJDCBJHZ0cIvP0eadjcvtAOpHx5uP6csAC0eLr4kSdFE1Rin7np/KgBuH36a
         B8jALDJcadAQaHmO/1es8JrA24DhRf9pSiB0dLBtAlF4Vl4nhNx1PQbfedLe2ozspsst
         omM7VMFkMUf8J55o43f2y0IUEOhavvtFKQ6TpklLQskPmohHd9c/KIL1x0bc6Ta4bMCS
         KrqOmxVXj3HamPAkgckumuV4SjDXN4bQQzNZiEaoIZZ8maWpn1KIoqAfFD8VdOKfeiyH
         j+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763097067; x=1763701867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsBGcCiz3WCLrT7j0Nta57r0BhtlxHqhVrvzURlT4hY=;
        b=f3kjnvCqybmSCWVBoOl0172tIZQI/aEDhoGucpXh21T+HqvXmKMZ33YN2ulqymOvUn
         uEt88TbDunZlkYk58fAByWxhXBhYBSvJoEcFwKiO2pWRPtRx2VHRWuzjAFMFZ8LL6Vqp
         yXJjMy3bnHutjNvr2M00Qv/TJtdPnIrgL4y+0ez/y1j1UDC4nuFsIkl7t+RjGe2e51w7
         2PsWNc315DJ+PXd0qj5HVAiYKFc4rvfJ6eif6RTAIkB4wkZ8byXktCXbboxFYKZVy8Ma
         j66INefYyzTaPrY9qOqvsk2M9YITK9WpUI7vUfAllh1WIt62sU4MtUNL6BZI78WKWktG
         vkDA==
X-Forwarded-Encrypted: i=1; AJvYcCWe7EwgL6N3yQs24sm7/g0oD9nnqoU6B62a4QiyhiG9PlT+HsG07ER15Ef7gW6hpu3ZdbhACoLae/QNR4D5AOSzcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rlWqnAi4sSDo4RpukwwDhR7cPUHO3CSpjYnxNkHR5p6VOYHX
	IpkRJ20s0LTu+1HLVS0C9aZPmRdGsirJY+lunkpz9s1McXHCrUhr2t2uYSgRgKmuS9I=
X-Gm-Gg: ASbGncsdjUux4ltMuEmXsFXPspL7lm0lZ5EoYAUOISWL8s5Tv6VQ7kPZC3W0J5vk5Ms
	5GDru/RwEa+W87PyCmEieT24arnokY50khw7Xx3sYLj1c8k10zCAvN/PEOhhFrF5SGMWmLt8N9S
	c1Er9UQGaI6+NR1P50SDcICL0qo8gWCwZS7W1m0IvFi86MzVkFKRIg/iq/aTh4y36GaJS36XO1a
	iAIS4FYmtu3imqsWSxmO0SMkWBqP0IDlGq42Xw3QAox2iYqSV2DXYdxFYJMQccypKh3QM3aoQVK
	UmNxFr3hjrC2DxV1roKM73SmOLERvR3ZWN53pQ4S/lT01fcHMoRWXBSZ6A3qu8VcIc2bwKxiq4w
	UMnxN1zTigHZ6Px2X4L4JvGD1wuwjjJ2MhmVYw+/7FST6M3XgEG7G+iCi7QIfSAFj3ggf6qlTr8
	Ac
X-Google-Smtp-Source: AGHT+IHK3glqlR+Y94++dOJU6BWTmSCTX38wLmtdNb6tG6CAcPvZ3ICP81xPkge9KCI41/KwV9HdVQ==
X-Received: by 2002:a17:902:e84c:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2986a76b624mr21805015ad.56.1763097066392;
        Thu, 13 Nov 2025 21:11:06 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1055sm41351205ad.59.2025.11.13.21.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:11:05 -0800 (PST)
Date: Fri, 14 Nov 2025 10:41:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>, peterz@infradead.org, 
	vincent.guittot@linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
Message-ID: <5pv5tqf24p6ttpydpdegyhyod3m2hmpwbfrzl6otsq3q2gvb2s@gsgcgbcvin3u>
References: <20251112235154.2974902-1-wusamuel@google.com>
 <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
 <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>

On 13-11-25, 19:41, Samuel Wu wrote:
> On Wed, Nov 12, 2025 at 10:45 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 12-11-25, 15:51, Samuel Wu wrote:
> > > The existing cpu_frequency trace_event can be verbose, emitting an event
> > > for every CPU in the policy even when their frequencies are identical.
> > >
> > > This patch adds a new policy_frequency trace event, which provides a
> > > more efficient alternative to cpu_frequency trace event. This option
> > > allows users who only need frequency at a policy level more concise logs
> > > with simpler analysis.
> > >
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c    |  2 ++
> > >  include/trace/events/power.h | 21 +++++++++++++++++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 4472bb1ec83c..b65534a4fd9a 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> > >               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> > >                        cpumask_pr_args(policy->cpus));
> > >
> > > +             trace_policy_frequency(freqs->new, policy->cpu);
> > >               for_each_cpu(cpu, policy->cpus)
> > >                       trace_cpu_frequency(freqs->new, cpu);
> >
> > I don't see much value in almost duplicate trace events. If we feel that a
> > per-policy event is a better fit (which makes sens), then we can just drop the
> > trace_cpu_frequency() events and print policy->cpus (or related_cpus)
> > information along with the per-policy events.
> 
> Thank you for the feedback Viresh. Fair enough, I've done some testing
> and a single trace event should work and would be cleaner. Please let
> me know what you think of this proposal for v2.
> 
> We can append a bitmask of policy->cpus field to
> trace_cpu_frequency(). This way we maintain backwards compatibility:
> trace_cpu_frequency() is not removed, and its pre-existing fields are
> not disturbed.
> 
> Call flow wise, we can delete all the for_each_cpu() loops, and we
> still retain the benefits of the trace emitting once per policy
> instead of once per cpu.

Fine by me. I have added Scheduler maintainers in the loop to see if they have a
different view.

-- 
viresh
