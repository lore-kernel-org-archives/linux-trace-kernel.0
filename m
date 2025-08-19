Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCC3112B0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597428; cv=none; b=HoK6IFlyeack/y7TYGopFi98JtlZ7i+TPvhjWISoh+4MYbTrVSMPqcriLDIrljldXQEsHO0pcFst4DuislXQwqeMwmMMmK2qIvV/9tH7qtEOEJ4rebSS5WeNF+FmxeV+udsOjGMXnamHymJvgGANu7onlBxksBux1DeUPYToIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597428; c=relaxed/simple;
	bh=1ubucLddQMJmUq8vjtzNlVwWTiogh6llKgtEaT/i9oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q/50+eEtXsHMgXfYlxezRM8ASQ5h4vWlTv0pKfwd1px+RqqdK9taKqV2+sktURuGLj1z9PL3LxvVj/1j6qlNPL1aJF+omLij0Dfb9ko/QgPFMv+PoYuAM6lnTkzqQFiJ3Zg8nHxfqKPg/ZW8NMQi3gUp24AhaiON6nXCdR6z60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZI3vuYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZI3vuYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755597425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovO3/gXHZDqtkD72WJKDDP7JTR3a7GhFon9JbVq5pdo=;
	b=GZI3vuYC3kDsf3PkLjyKefAtmldAqAtn3aKSXCKegUVX08A/JvG2DaTZXi7OwTptPWqxoD
	CH0LX2FpBWI6pEzq8eQ0kli4kih/5gixOuVQweBFa+UqdqWo+Q8ZGjS6Aw1pZrO8vCdHGi
	f0koweIInN7jHRh9Hpmzb0WsBq6ZA38=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-3HM7P9WaNvKeS5Vwad4EOA-1; Tue, 19 Aug 2025 05:57:03 -0400
X-MC-Unique: 3HM7P9WaNvKeS5Vwad4EOA-1
X-Mimecast-MFC-AGG-ID: 3HM7P9WaNvKeS5Vwad4EOA_1755597423
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109be525eso139956061cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597423; x=1756202223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovO3/gXHZDqtkD72WJKDDP7JTR3a7GhFon9JbVq5pdo=;
        b=bWCjG5A/BY7X6sadJOsR4WKvJkFc1RJnPSvm2I3xwLryLEGN86mtqft84QG70i5RiI
         Mc1Ajtm9qutvOlj+2SyPcGb9KHNYrcVUPfAodDypHq3okK08RojkOVVHw4iDmXz89eL4
         49bvDbzWGUE/9AltWI+FVU+3cucsaBcDBZlHxpzi81rcw+IChF5TYrWtgraXKYicTQ2b
         3yL9QBd4PbQKz5gQPlaW5GAwz/Nu7+7M677ruprgwutHi+smmEx/qBdUtA0rJNII+lqA
         NkUKTLZ3UJ9Gy8jjXHF7IyKTXQDVI81QFcYAgC8YSohcCiDXA+KTe/33mQC5TEydx2yO
         bA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgwi2pej7xmVZFptTwOEEWbvfUow6E9POy3xAJKgw4DrR8YPV/TvA6aAAliYvgbllEOW4D826qX2pCpDHkYB0ikQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1TcHOA8ZhmaStYjC48UusXtE6IrggJylD5ItKK50IpkOl4Oz
	S4EruJOCU7kusrstdB/l3ABua5447pNFKVLW71QYMcd3G4oguUfgXTgAj8Rvcr4m8CT61amNRhx
	elWaHSygDIyCBmrnUk2qr4HcD32AqWPeTS9IH+R2iZ51ryQWmx9MKXbeQG+REPvZ+NxnBg1KByg
	==
X-Gm-Gg: ASbGncvs3bF3j8iRv5glnwI21XgpXwY/xIRYiWkBZmTPEupuWSmz6qtydNRCpf2Ihf9
	J7/vG96Z3gBX7FMpI2ZT239PtSHR7lqBFgLjPwJJTDPVPj6ABYAQunQGYUyOtBNv05Zvhi3XEwr
	kF3kXrLXOrJmPgt1DtN0XkiQuCDGqtrULVch52pT3S3ulNkph1xc0AUT5xzMVgsxNeuFpJAg/Bb
	00Ukg/S4ogMMHFVWx1ZmcMXQLNFqc88K/9MBhGskRw/XHNd9Qu6D/Lf+BbdP0w95BSfV0jkMP4W
	YKeqbYdp7+E1yUioc9GLoGOy6hDgyayRGK26PCPbM8dEwOAAl4IUQW9UoVZuYXFXS5Jl
X-Received: by 2002:ac8:5cc7:0:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b286ef3974mr18223131cf.56.1755597422856;
        Tue, 19 Aug 2025 02:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPOnJ8MWq8N3ISVkEuPgun5DwRV+bNUHYaZl50LdgymHYzejrD/IRP5r0A6M+wbxfPykgqiA==
X-Received: by 2002:ac8:5cc7:0:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b286ef3974mr18222921cf.56.1755597422408;
        Tue, 19 Aug 2025 02:57:02 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5d069sm65369421cf.21.2025.08.19.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:57:01 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:56:57 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814150809.140739-15-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pv30vBXPjhHYSXkYTxW71MGAuKtlTpgzwxT7_3ioH1U_1755597423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 14/08/25 17:08, Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_server_start(dl):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl, hard):
>     Called when a deadline server is stopped (hard) or put to idle
>     waiting for the next period (!hard)
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/trace/events/sched.h | 55 ++++++++++++++++++++++++++++++++++++
>  kernel/sched/deadline.c      |  8 ++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..f34cc1dc4a13 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
>  			__entry->oldprio, __entry->newprio)
>  );
>  
> +/*
> +DECLARE_EVENT_CLASS(sched_dl_template,
> +
> +	TP_PROTO(struct sched_dl_entity *dl),
> +
> +	TP_ARGS(dl),
> +
> +	TP_STRUCT__entry(
> +		__field(  struct task_struct *,	tsk		)
> +		__string( comm,		dl->dl_server ? "server" : container_of(dl, struct task_struct, dl)->comm	)
> +		__field(  pid_t,	pid		)
> +		__field(  s64,		runtime		)
> +		__field(  u64,		deadline	)
> +		__field(  int,		dl_yielded	)

I wonder if, while we are at it, we want to print all the other fields
as well (they might turn out to be useful). That would be

 .:: static (easier to retrieve with just a trace)
 - dl_runtime
 - dl_deadline
 - dl_period

 .:: behaviour (RECLAIM)
 - flags

 .:: state
 - dl_ bool flags in addition to dl_yielded

> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(comm);
> +		__entry->pid		= dl->dl_server ? -1 : container_of(dl, struct task_struct, dl)->pid;
> +		__entry->runtime	= dl->runtime;
> +		__entry->deadline	= dl->deadline;
> +		__entry->dl_yielded	= dl->dl_yielded;
> +	),
> +
> +	TP_printk("comm=%s pid=%d runtime=%lld deadline=%lld yielded=%d",
                                                        ^^^
							llu ?

> +			__get_str(comm), __entry->pid,
> +			__entry->runtime, __entry->deadline,
> +			__entry->dl_yielded)
> +);

...

> @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  
>  throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> +		trace_sched_dl_throttle_tp(dl_se);
>  		dl_se->dl_throttled = 1;

I believe we also need to trace the dl_check_constrained_dl() throttle,
please take a look.

Also - we discussed this point a little already offline - but I still
wonder if we have to do anything special for dl-server defer. Those
entities are started as throttled until 0-lag, so maybe we should still
trace them explicitly as so?

In addition, since it's related, maybe we should do something about
sched_switch event, that is currently not aware of deadlines, runtimes,
etc.

Thanks,
Juri

