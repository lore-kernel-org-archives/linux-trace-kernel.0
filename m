Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0E31AF2D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595151; cv=none; b=aWyyhLSXh2yHfPCdwOh/QXRAM3L7m7HmRLipP18yUUmAsbLuCl5zwqRfE4MZtH18G5ZLsogyOMf8FmfIQkQ6PyZ3BIPTnLvOAbOIzPbxSz2CBXoKx/Ne8EOgJPGwUk4xQNvEROxMMlgLLpeyL4TtML+k2L8iBpRTZxfXRwRnzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595151; c=relaxed/simple;
	bh=PNZgkcdq9TZXxOPe5bvlFXYs2HJi7i9omPoA3uoJNAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aVwJx62uZoTiCOpS7iFuztkZNY5t+D2M0fvPyK3T6BI8mWTGe0Kn0P3xnRZADZpl9FiLiMb0bvJ4A66r+xgIlPnx7YUQ5NU84jrksYqxLg3/kmNHeb6HW6rc4MzdaARnFQV/Q/v0ETB9GuYcStsX8yCEQBcwDNR3A+mRj+pEkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8+A2Jx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8+A2Jx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755595148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWT0mARngxGoK+lyzVNdKRI0J9MEuocADrq+/ReVQnI=;
	b=J8+A2Jx7HwnHLxRbSmgR99ieqqlc9F35SOJuEYh0NlnkfvRg0soNxQYe+HXKaQLV2EsMTT
	Salja9+mEJGa4+3DtHpRLYXPdo7Ms6vKQczYuATkytuKbPGuxzcNyWCeQITTndk6DqWR57
	1MQ4ZdROndZmOZ95LEJhi/bfSh4D74s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-QqGObNEUM-aaSCAmborudQ-1; Tue, 19 Aug 2025 05:19:05 -0400
X-MC-Unique: QqGObNEUM-aaSCAmborudQ-1
X-Mimecast-MFC-AGG-ID: QqGObNEUM-aaSCAmborudQ_1755595145
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c5457cso145401991cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595145; x=1756199945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWT0mARngxGoK+lyzVNdKRI0J9MEuocADrq+/ReVQnI=;
        b=PPcGLp0yVRFOeQEe97Uv49BiCtD95zdcDLM6nYyJrBOt2pHUrt1bnG9rsHh6Yq9ljP
         K7v0fxF6JNcNlwMesqD0eZ8HaXvL3YjkX0KGOmmpPkVNuyU5rYHY2UOJkuFxYTI3I9TM
         b8i7xnwHXLVxZmgzpTrqralDBSZ2EZM/jQaOKjKGkFukIJ54N6f7q3nGD2d0NyQnEoGe
         d4NZOs0UnZJafeKvtzAOqIsM1lNHtgoR6lwh8aVfoXKbnHIDV6EPMimeaS2olCZoJaJU
         Nn+7ssY1YddiaOQFnMopocS7x57sK6wZReIG9IbKtj8oieL7WM3C5EllyTSUQdAEe0I/
         Ztxw==
X-Forwarded-Encrypted: i=1; AJvYcCUzwnY9kU/NDzruAvQiqhbUV8he+JlHvR+lFpfbtbRhLCho5TLQXF9Mf21lUxaLwCslbzm22UEKX55jlyjW5LEsDM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWmqa8kXHtIyOITmb6uwOQXRDnQ/w/SJ5B8pOGrZ/RonvY7er
	GuLGePVBt2z7RaPKGSYlzXuxb4oFT0Hf2mB59RhkMhOHCMBjMThy2vkW+Z8d+MTynxZu70do5Gr
	2tfWChS3/xcmj72r9Daj3EYGEU4C2jhhZ2jso84/USrJbzqVd2YT1CbakoCxJVxXdVqM3IET3bw
	==
X-Gm-Gg: ASbGnctuTl6GhaQ0enqVw4Lxmr7AHkagqtKMeBfgryFrOqd37yHaAcD9urP5tMGOyhH
	o4rMmZfPGnlU5UOgBo5hbQizg5RYX3CNZHauUW2Y420ZJbBx9tFbZp/puzfuaDlDczSd/r3b387
	2AgEatjw6L/VSW31X+SQZbhr0Sf9l+VXGfbavsNEkmldqONsSv2IyuWPYATjvWl9nXd4X9RDLfE
	zRi4rEd6TUdHgXGjNe/l1yXDb1WTxJhg8Cs/1SFQQRsOkExtq7DsV3htf6QXtA2hx4+TR/AGvZu
	FIl1TbRwm+pgqTB1kXEi+qnZMABZn2XVKvZmOVmjv3oc4RI+D5FrZIDWTFs0e08Ev3Gd
X-Received: by 2002:a05:622a:4089:b0:4b1:2457:54a3 with SMTP id d75a77b69052e-4b286d64745mr20784741cf.42.1755595145234;
        Tue, 19 Aug 2025 02:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQlOoIPQxOJBoquQk0HObEu1BaMNH7ziz2yiaTpabR+DwR8fBQONFU8dJTuvHDGGTrWZ0nhw==
X-Received: by 2002:a05:622a:4089:b0:4b1:2457:54a3 with SMTP id d75a77b69052e-4b286d64745mr20784551cf.42.1755595144850;
        Tue, 19 Aug 2025 02:19:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb2d1sm63571441cf.28.2025.08.19.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:19:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:18:59 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814150809.140739-9-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s98mFM7CbaMeMjYDIlUM0RjZy4Pw7XfrsZ699-2ZyJQ_1755595145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 14/08/25 17:08, Gabriele Monaco wrote:

...

> +/*
> + * ha_monitor_init_env - setup timer and reset all environment
> + *
> + * Called from a hook in the DA start functions, it supplies the da_mon
> + * corresponding to the current ha_mon.
> + * Not all hybrid automata require the timer, still set it for simplicity.
> + */
> +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> +{
> +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> +
> +	ha_monitor_reset_all_stored(ha_mon);
> +	if (unlikely(!ha_mon->timer.base))
> +		hrtimer_setup(&ha_mon->timer, ha_monitor_timer_callback,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +}

...

> +/*
> + * Helper functions to handle the monitor timer.
> + * Not all monitors require a timer, in such case the timer will be set up but
> + * never armed.
> + * Timers start since the last reset of the supplied env or from now if env is
> + * not an environment variable. If env was not initialised no timer starts.
> + * Timers can expire on any CPU unless the monitor is per-cpu,
> + * where we assume every event occurs on the local CPU.
> + */
> +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
> +				     u64 expire)
> +{
> +	int mode = HRTIMER_MODE_REL;
> +	u64 passed = 0;
> +
> +	if (env >= 0 && env < ENV_MAX_STORED) {
> +		if (ha_monitor_env_invalid(ha_mon, env))
> +			return;
> +		passed = ha_get_env(ha_mon, env);
> +	}
> +	if (RV_MON_TYPE == RV_MON_PER_CPU)
> +		mode |= HRTIMER_MODE_PINNED;
> +	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire - passed), mode);
> +}

Does this also need to be _HARD on RT for the monitor to work?

Also, my only concern with the usage of per-task timers is that
reprogramming add overhead, so I wonder if this gets noticeable when
running some kind of performance sensitive workload in production (as it
was reported for dl-server). Did you test such a case?

Thanks!
Juri

