Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BF2522A7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091683; cv=none; b=a0csqIoYENrhX0G//flbPodDi/4SMt4akSjyrWdbLma3nVU9WjZtM+GHLD1LqQu3Ovwv594EMWhjflbdhyRkz6XozBJ77sD+BqwVU/djupizGf6FgECRpuwpxC39fC/hu9HN41fagnRLaXf5YjKCb9ogHgNB4DhLDNxU82S/cNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091683; c=relaxed/simple;
	bh=ryJkv6CXUDKCnzbHfLI8c0ggVF219LhtAYHK8re9Da4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bhqxw7suaqWIAEdXs9R+A0N0Jdj2mQ8oSxD4LmXTbqhYySMr6moLmoG4nQoAcAGXjhJ75ylmg7odZSc02nXo+TkQ8qhhOdx6p/DAm9FvO74HqFPj5Tm6a3hBpumh7RIe63hCg83PfnRK+3PuH9v/lU7wC92h5ZY6NO1Dtk0lk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oU/My/0s; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU/My/0s"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b728a43e410so237584066b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 19:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763091680; x=1763696480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFUX25scWe0vWdivCC/Z0SNCPDsp372FpBWwsDMucuc=;
        b=oU/My/0s0O42L35BHoyhQnU2rFUHBQY8UCJn2NYeobFnWdGJVE+8+FAQpu/Gs3L/Uf
         Dq35K5jQauFtGjGzj4cske6Hw9JkdkT2d7BnnK9/Uyyp1k4IHyqqaRhYdpkEJ1xbZupl
         hDfvDChzLIE6S7WxIZ9MuCiZAkSPtcQqaj8KGMksvotAs4UH1fk06FFb7ylxot5c9nZH
         d7Cz/97VZcA7E/S6MwDcNPIti9hewaV1C//HHumyNX9RXPE2EZFlsfREWojJSiU+DPyY
         oV4qsHPWMH6EGz52UwvyWz465zZjQIH+/+6vbBJr68mrhBHbXszmcXKjBCxCteUL3154
         jGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091680; x=1763696480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFUX25scWe0vWdivCC/Z0SNCPDsp372FpBWwsDMucuc=;
        b=j0/p3X3Q/mZAQjBZOfZXOuGbjk40mw97U2B9pgioLfs/yvQWUb4Yz+TQe2N6qek1G9
         UwF7STz1bvKPTdxFEEg91RdxjMd/bbf5fob62VUZ54XpQ8VeLSqx/kPbG5FzBTJyk3Fj
         ok91AyUHSjL55bh4uivRG63awyfWXHG77rsmteh8SajZd8oWUHxUt903G6/AJJkDH5RQ
         vDTR+DCLCSSQFlTp4G27y6FfVX0gTZdygvK87vWMGL5W6U3ogMxxAvGfc3xDjiUAiH+P
         ogI1fqpvG9DEVRjApDjrWsW9wvociO9pecF/YvNk1QKxzXJuEmdUz1KVBvmKm8TKRN2z
         OOzg==
X-Forwarded-Encrypted: i=1; AJvYcCXeX/KrKUADiydgyJlPN7L5yPJSO5atmmEm40UB2QDtt27+/7+WvzAx3/DUAq2pa5PebxtoTCGbVXvX/PgAhWW1YIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwqbd7znSCKWYM3k5zwfDN49lRmo8EIOyq/EmnEs+iQCKiqqsl
	7IchGzr6NAPxN0nQl7imQREDz5JQe7T2IIeV1sxWjw7NGFvAzvf3ovYSZM17IqWxAhnwCm/25r5
	RC8jkXoqxOLia+rfoTNVTDiyhS1f3spZnCoBWoKNd
X-Gm-Gg: ASbGncsTbf25Z0dA1XEqHSJSWw9FkX3CnpwAqPVrbWkTpOuGxgcKw8sxsojkbE43UM5
	5vvK8QOcuxDQlJ1I+sR17HVHLqmfvYYo6n1C2fjNBNMHoU6aiX2l7RC+DUZJxGCrsxrW/a84j4S
	u2SvsE54HjA7ul27Wlt1U+/X9NC1NFsYwxkR0UQGDfy3wn3POLPr5EKKentimqcTG5jQbO0SPW6
	Ezz7QL38d6WXrS4CdEa4LKpuCcQiyq2uBjKamocDs/z+1fYz9K4eX1q4VdaVh8Wn8FvgPb64cSn
	6dhGHH6o8n5rGraj66IjXBZDU60CWTyVX0O7H5uO
X-Google-Smtp-Source: AGHT+IGmXN37NYT5nX9MWTZ/ivh8suRrsT+5MxYlLyGC4+Nt0tPCfIkeO2/qFDCy4N9OVfYMnqUdZ/BFNm6d4PNTQsI=
X-Received: by 2002:a17:907:1c27:b0:b73:3e15:a370 with SMTP id
 a640c23a62f3a-b7367c001f0mr138833066b.57.1763091679591; Thu, 13 Nov 2025
 19:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112235154.2974902-1-wusamuel@google.com> <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
In-Reply-To: <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 13 Nov 2025 19:41:08 -0800
X-Gm-Features: AWmQ_blsgnIrclDDNYVJmf-or7MAjMfT_RTSkXh139GCK3aWgRLgaKjVarod070
Message-ID: <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:45=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 12-11-25, 15:51, Samuel Wu wrote:
> > The existing cpu_frequency trace_event can be verbose, emitting an even=
t
> > for every CPU in the policy even when their frequencies are identical.
> >
> > This patch adds a new policy_frequency trace event, which provides a
> > more efficient alternative to cpu_frequency trace event. This option
> > allows users who only need frequency at a policy level more concise log=
s
> > with simpler analysis.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  drivers/cpufreq/cpufreq.c    |  2 ++
> >  include/trace/events/power.h | 21 +++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4472bb1ec83c..b65534a4fd9a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufre=
q_policy *policy,
> >               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> >                        cpumask_pr_args(policy->cpus));
> >
> > +             trace_policy_frequency(freqs->new, policy->cpu);
> >               for_each_cpu(cpu, policy->cpus)
> >                       trace_cpu_frequency(freqs->new, cpu);
>
> I don't see much value in almost duplicate trace events. If we feel that =
a
> per-policy event is a better fit (which makes sens), then we can just dro=
p the
> trace_cpu_frequency() events and print policy->cpus (or related_cpus)
> information along with the per-policy events.

Thank you for the feedback Viresh. Fair enough, I've done some testing
and a single trace event should work and would be cleaner. Please let
me know what you think of this proposal for v2.

We can append a bitmask of policy->cpus field to
trace_cpu_frequency(). This way we maintain backwards compatibility:
trace_cpu_frequency() is not removed, and its pre-existing fields are
not disturbed.

Call flow wise, we can delete all the for_each_cpu() loops, and we
still retain the benefits of the trace emitting once per policy
instead of once per cpu.
