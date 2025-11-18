Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4B2DE713
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428379; cv=none; b=s+ZmJCk3Zoipd3NZj9Y6AODV+6VAmyH/R/ypbQ0QgT4O6isk8FxaTs7QLvgm1lic2JcUELwL+WYnw1U/8Pe7uX905+sBX3BEVIhmSviJBtIVgvXh+xQwWn//m7hGV25OCDpPTdUYbVOUXWl+x9Rn5r1k6SoP7LVgrNkKVo0Thbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428379; c=relaxed/simple;
	bh=vprNlNF83I+ZNCi5EcyPPczMmil4BpyVQ+GAJSLz1UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQpRPJiTSU8x2PIUet0YfRLzZJkK3m1rFIVmw3JBfXm06T9g0JZc04maBDFPyfhz4nROF1mqTayYZMUAxJ+9RYnaMIQv+1lW6qs90E/dED0T7P7KRN5Qz7n6Ejo/NlRDql74INc9ncKiy705PuAKa6Mq4Mjbhwe0mGSiX+1bqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdO7XQpW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdO7XQpW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73a9592fb8so228690866b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 17:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763428375; x=1764033175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLypkKedaSatyVf6P7eTHsXDW5pFI6QMWuH1xNayjAc=;
        b=gdO7XQpWrlGfCBM8MSXom9L7om7a/w+xxJYlcTtFvp1dDnWGHoYiLudtVeE36RTYA1
         Oyexr44vi1bHLcqArL49Ulq9caFOeWxobp2H0us1uNB4qGt7kpEp4PkgHrqpQUN3+rJv
         zH5oHs0wPmqPtEQyauFdRmIAsXJpfMFtm3eKh60PcCTRBg12SRTULH01DadotzvtwWs8
         LqGixHlN2nCYYoe3oSliKyPWw68nGkYxCa+qUZOIHtiOZ8N8yJqNxA5m3ss96lmm1q9H
         qQ2RqOQh3uA8wJ0GKEL+6eBs8R/n+iem/56A/CC4jrziYTRAEkUP72PX8nlt3DTDL5es
         /8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763428375; x=1764033175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLypkKedaSatyVf6P7eTHsXDW5pFI6QMWuH1xNayjAc=;
        b=tPVxPCDxyIRLKtS+lwW83aR2fAIZOav67I2f41xJE0YsiuWkFbSY0g+nX3fQ/miv9S
         jmHdxT0tOCO/eslKns9vLndqya+PjKUUKC8q4lBJTyBfCjhUAOEGBDJ7bgb4bS3Y7PFO
         +QiFAq3LSxtUd7Yuws9ppXBFCVNEY0OLSnChMicHnzWIW8wjqcLBX0kN42MpE/Ur8w4N
         on7hw+zLu57XxHBHe6940Uvj7h/XasGxmaRlUhKHmveQeKnV/bRc+N8h9EPYSA6+VL/z
         H5L4HDzXo+nhJMcqymMRQLuG3t3Y1L5Wi/IqyhBjeDX56p8l192GBIES4irJbf2th2/y
         5F6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCBO3fsKAHrPvHCFogQATw270p7GAHL606s21Oivr2lG8LJ3dnYxlKrngZ6htvijfgMgflc4vKJtJLqX28xXsnhQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/ezxx5ef/hPKQwogMsMUjSRDZ4ZBFJcz7+B1iImIIhNEivp1
	Wr9ZbJMmyrfZ/79hmFIFG7bi3FW2rSmNTm4aoMI8+KrUNGGeEgOeXvyV6uSI4z8m5yae5SSqpZ/
	YfDNERnCgQmGD0XLMSCLIs7H9gwSSHp1TePpAJiW7
X-Gm-Gg: ASbGncvT2THmtgCu/hlCaxhuvbQZMyhHARSZzsabIkErQVwWzsGygtWcjz6w1PK8E7b
	43/ifmM0sO6xmdwupmx6Pw6VG8xsE7HSXTXCWM02Cftv7ywdnfGqydu/D0PcReYqsqIVnCEF8ay
	K+hxqIZmrX9EyRRUbMACw7WGGnU17mvpdMy89nDLvEpQtadeEx8zH5L5skXSoBHwbQEcHAYWfzb
	csTCneJoW7KgEBl5Sh3zqB92s47KAc666CPxOhBKV0BUwwIajnGnJSuofMIOzTA2anvnLmMlwGj
	xYdy1ooZ2nn5SdJ5uYUQN9GloF/2Tn36AVzqQT0i
X-Google-Smtp-Source: AGHT+IEhPt97xpM9QAlAaltjDJJJ234wHSpYiikz3yudtwX2qGgx6x9IopSiX/gSigXYd9ESfwNuBAN149k8ySNW59I=
X-Received: by 2002:a17:907:d8a:b0:b73:2ced:9af0 with SMTP id
 a640c23a62f3a-b75a0a94f28mr135637166b.27.1763428375062; Mon, 17 Nov 2025
 17:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112235154.2974902-1-wusamuel@google.com> <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
 <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
 <5pv5tqf24p6ttpydpdegyhyod3m2hmpwbfrzl6otsq3q2gvb2s@gsgcgbcvin3u> <28868c0e-2a46-47ed-9bd7-439056cf94c0@arm.com>
In-Reply-To: <28868c0e-2a46-47ed-9bd7-439056cf94c0@arm.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 17 Nov 2025 17:12:44 -0800
X-Gm-Features: AWmQ_blRuc1oXQfT-0XAwm__1Xp_jZ8h6hqyr5l1p-u5ZqHf4Qn1UqNNSnb93C8
Message-ID: <CAG2Kctq9aTpcC8+Ay-Wbz_6=dTW7HR6NW6+kmc-ebo860nfpDA@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, peterz@infradead.org, 
	vincent.guittot@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Qais Yousef <qyousef@layalina.io>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:18=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/14/25 05:11, Viresh Kumar wrote:
> > On 13-11-25, 19:41, Samuel Wu wrote:
> >> On Wed, Nov 12, 2025 at 10:45=E2=80=AFPM Viresh Kumar <viresh.kumar@li=
naro.org> wrote:
> >>>
> >>> On 12-11-25, 15:51, Samuel Wu wrote:
> >>>> The existing cpu_frequency trace_event can be verbose, emitting an e=
vent
> >>>> for every CPU in the policy even when their frequencies are identica=
l.
> >>>>
> >>>> This patch adds a new policy_frequency trace event, which provides a
> >>>> more efficient alternative to cpu_frequency trace event. This option
> >>>> allows users who only need frequency at a policy level more concise =
logs
> >>>> with simpler analysis.
> >>>>
> >>>> Signed-off-by: Samuel Wu <wusamuel@google.com>
> >>>> ---
> >>>>  drivers/cpufreq/cpufreq.c    |  2 ++
> >>>>  include/trace/events/power.h | 21 +++++++++++++++++++++
> >>>>  2 files changed, 23 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>>> index 4472bb1ec83c..b65534a4fd9a 100644
> >>>> --- a/drivers/cpufreq/cpufreq.c
> >>>> +++ b/drivers/cpufreq/cpufreq.c
> >>>> @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpu=
freq_policy *policy,
> >>>>               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> >>>>                        cpumask_pr_args(policy->cpus));
> >>>>
> >>>> +             trace_policy_frequency(freqs->new, policy->cpu);
> >>>>               for_each_cpu(cpu, policy->cpus)
> >>>>                       trace_cpu_frequency(freqs->new, cpu);
> >>>
> >>> I don't see much value in almost duplicate trace events. If we feel t=
hat a
> >>> per-policy event is a better fit (which makes sens), then we can just=
 drop the
> >>> trace_cpu_frequency() events and print policy->cpus (or related_cpus)
> >>> information along with the per-policy events.
> >>
> >> Thank you for the feedback Viresh. Fair enough, I've done some testing
> >> and a single trace event should work and would be cleaner. Please let
> >> me know what you think of this proposal for v2.
> >>
> >> We can append a bitmask of policy->cpus field to
> >> trace_cpu_frequency(). This way we maintain backwards compatibility:
> >> trace_cpu_frequency() is not removed, and its pre-existing fields are
> >> not disturbed.
> >>
> >> Call flow wise, we can delete all the for_each_cpu() loops, and we
> >> still retain the benefits of the trace emitting once per policy
> >> instead of once per cpu.
> >
> > Fine by me. I have added Scheduler maintainers in the loop to see if th=
ey have a
> > different view.
> >
>
> And IIUC your proposal is to fold policy_frequency into cpu_frequency but=
 then
> only have one cpu_frequency event per policy emitted?

That's right, emit the trace event once per policy instead of once per
cpu- which I think is the most valuable element of this patch. And
yes, the latest idea was to append bitmask of policy->cpus into the
cpu_frequency event such that relevant policy info is encapsulated in
the trace event.

> I think from a tooling perspective it would be easier to remove cpu_frequ=
ency
> entirely, then tools can probe on the presence of policy_frequency / cpu_=
frequency.

This can be handled perfectly fine by the tools I know of that consume
this trace event. The points you and Viresh have brought up are valid,
and as this solution is not in conflict with those points,
"policy_frequency replacing cpu_frequency" can be the frontrunner for
now.
