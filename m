Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lfc5doqQ"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529E10A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cec976b197so4566828b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702544085; x=1703148885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=Lfc5doqQYTSO3iZ1t4glMeEIbfVbUgGoDBdKF3BfalCUJ0aPbMhz6RzCxzXr45+Ycq
         H2xe/iBBS60GUA/r8+xa8d23GshQlyxXvPh9ON1b8rVSVRzdnS0snp4+BowcKqZum/v9
         HF3TUphGcgwAxCoEbMIcBtoKUFUWDTtFtR517N74ZJ2DhqtlfKqYyqYYQUDeRYE1irqj
         XDypx8kr88tXxGzrbakIO9JDQlHf6swdCrVAZxzw0rze4WkuCxpC9AHGdMsEwqcaLdgr
         ENBl2ZtxulWz+6NN+Mviwh1Ig1pUBBdZT3PSgG66nJWRDh9L5SErQbaqsh0RZ4d6Zc0s
         kw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544085; x=1703148885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=MnCU3eXnsdUQhfE4J8x6i1edpoRXpu9m+OyxdVPajx4O5CD7w7QedIIuGm0TXt3fP7
         v2xdTKwgheSWaRgrhj+o4KBm8aWvMx49maMn2uixpITuzex6kw9HUWa47yD9TLZw6q69
         iQ1hFEqPaCXcc5XoAuXJik8BsWKvy9/oDlayKoFVknlxEgk+z3266KPo7vBZEaLZCZ8D
         HxaepAv46Ly1shWcnYTuG0z8gbMwmEk3Wj6hLWphTVINBLX7csfiUteYLTv8bs8SZImL
         VOJ7lsVtEv9STCEzO/ggUo1MqJ2wd+Q/hlF4gC7l3q+KcHhVAqliPP7QE8qbJ7B/daO+
         OMFA==
X-Gm-Message-State: AOJu0YwJyUTWQ8W9reKlB+Ma0Oa/D9NI8KOi5sYdZSwNVGsjKB/ZgKoA
	IAJiJQPVnn948OH3s8HIcoLZr8sUs2enr5+caPAF4w==
X-Google-Smtp-Source: AGHT+IGdI7/50FpKOUbpLtBvbGRJ2DilAJ+uakzY6Pk1C1l4dP/sR7vPujANsmVVA5EQ4ejpPjKjBk8CHE5FPrBpAJg=
X-Received: by 2002:a05:6a00:3a1d:b0:6d0:8b0d:b8c6 with SMTP id
 fj29-20020a056a003a1d00b006d08b0db8c6mr3981164pfb.34.1702544085168; Thu, 14
 Dec 2023 00:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-5-vincent.guittot@linaro.org> <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
 <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com> <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
In-Reply-To: <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 14 Dec 2023 09:54:34 +0100
Message-ID: <CAKfTPtAU2ryefu-4cJ7YSV6Ji8Xofa-6=yAZ+EmUJ+qbsFCfZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: catalin.marinas@arm.com, bristot@redhat.com, linux-pm@vger.kernel.org, 
	juri.lelli@redhat.com, agross@kernel.org, viresh.kumar@linaro.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, 
	dietmar.eggemann@arm.com, mgorman@suse.de, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, konrad.dybcio@linaro.org, 
	andersson@kernel.org, rostedt@goodmis.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, bsegall@google.com, vschneid@redhat.com, 
	will@kernel.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org, 
	mhiramat@kernel.org, amit.kachhap@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:53, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/14/23 08:36, Vincent Guittot wrote:
> > On Thu, 14 Dec 2023 at 09:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >> On 12/12/23 14:27, Vincent Guittot wrote:
>
> [snip]
>
> >>>        update_rq_clock(rq);
> >>> -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> >>> -     update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> >>> +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> >>> +     update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> >>
> >> We switch to task clock here, could you tell me why?
> >> Don't we have to maintain the boot command parameter for the shift?
> >
> > This should have been part of the patch5 that I finally removed. IMO,
> > the additional time shift with rq_clock_thermal is no more needed now
> > that we have 2 separates signals
> >
>
> I didn't like the left-shift which causes the signal to converge slowly.
> I rather wanted right-shift to converge (react faster), so you have my
> vote for this change. Also, I agree that with the two-signal approach
> this shift trick can go away now. I just worry about the dropped boot
> parameter.
>
> So, are going to send that patach5 which removes the
> 'sched_thermal_decay_shift' and documentation bit?

Yes, i will add it back for the next version
