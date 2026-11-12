Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487771;
	b=cHp2fmPEZxyaCKR5gBMrLkMqgBaCc4pYOmjRwLl3cAud8dyCB5B/Qt/VF0l9fXAL38Tr
	 Du0trU/Ne/tL8kSJp77eUsRuQyjV3y+gccz/1Mr7t64on1dqn4WpXuJSJjDgR3gNwqozH
	 5dhxTGBaulNlgmuAeOhnGRtOqOPERxvYG7X19nO+3upBziySWk4d8aAXRrgOXDCiTBm46
	 kbNoR2SZ+LGC8HgwNXKoBPekQP71AKCG8rYLPH2EHg4qtantNUHLXsKkJdRMXWyKOUrev
	 UuhyimG3jyUt1Z+5glU2+abUWY5XA7k1FLR7roFAOJnuDix8loxGbUiUsGn7GUnrtxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=h0ijg/8uzd3pYGV3+WsooetUbMY+nJz4nlPIGNmDd58=;
	b=kwvvrb9tlUGRjGNb6w2Lo7tWdzPRWyZnOyyhfYvKvijr80++r0XtHArXt2UGCtC9vIIA
	 8y0jvNW6ECcqriH6WLBURc3yzouB/wRWrZz5usElvaeJdG9uIPBYOidSXavNDv4Y7Z2Jp
	 4+L+9+G5RapBKePNoAs6vs16N5jmYWVksbYZuQzc7bcm/utEIZDRvXQA2BHTcCBVInF/f
	 UzTK+77EZ3Cp+dDmq04xKV25S0vX0z0lU9bZNDqMSbYa6SqK6XZp3Xtn5fGIfN3IZZaan
	 MIjb/D/hfQ61SVhWV3ezuDJW13VQmwDpTZ6M74HW1Y4ErmOyaDWFoTtWYvQKoYPdY9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEdc6Nba;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EF606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 12:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E87EF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEdc6Nba
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-703e2625ce6so88287eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794487770; x=1795092570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0ijg/8uzd3pYGV3+WsooetUbMY+nJz4nlPIGNmDd58=;
        b=SEdc6NbatGRXRO0gIZZpnqLjfs5FemeTeCoW5PYGXBoF45yLE3AmduS+sXMvbpmfaU
         JUi+gqA1c1dRpeqqWozJldNwbdiqKX/tMU+DAF792U9g+V1Bu63x7NCFgQeqdZDg4a4o
         jL6eUVfgxUmgzaoyN6zutO53wZAE4DfcaDkHNO2gAGw4a+vJszIkQywDzKGrhzaOKhRD
         OMbo0pEh3w9HrDM5eYYBDsv1Q3ZYjrgvI1dXa2SmHhPfuoTUINkMvfi9YcdQHYUy56yW
         bgdvTan7AWYrHbNawXSnKdlUj6FmtjYzS1kN5jGCaNrCgIDuBiKu2SPqpnAoRmobCICr
         H4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487770; x=1795092570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h0ijg/8uzd3pYGV3+WsooetUbMY+nJz4nlPIGNmDd58=;
        b=FQ40ARaSPgIOEPBMTLzLTHhnzlkueMyFBqrhfXSXpr+C31frcHyuqcWk78AN9UmXj6
         MeYHlsj9lZkiQ+wlnmNJC7r54rXFwZasDB4VJ6voQg53QnJt/r3DkXvk5ydCo4QwjVct
         CLvblq10Vexaz8/S/c3AVN/9pK1TF2/Jx05RqWqiPJ7gg1hWGbXSsg1xFRlMw26oRWfo
         c2ATmv/m2Nus6h8lm1VMY3TKZ6q3TbrEZ1p/Gi87RBs/L4G5yQAWFt4evPdcH53dBGtO
         0pezo1rYOs43IRaYlOEIlV1tPnH8qsWhch8i2AAtnTbbqX1fB1yaQoVhT26UGgH5cWdd
         XOxQ==
X-Gm-Message-State: APuU4Z/W5DSrtxoQauwC9AxCYtMUMos3oyuFV15guDgDdoDsLOqDaX8z
	szrqkjpC9wG/FjuBWQlKJIevD5TDS4AfYcrf8zpPxuIuTB6t4kpBEWAP
X-Gm-Gg: AYBFou04FTcVlkx9FjaD21axqikBZ1Re96asvNvYvXDy51hNW1Za57+yeHhXbkosUQr
	jJvHDyGVlUn5VY/l9sB/pxwZrWwyAWzQcsqaB9xxXKFT84a8vhPobTN4U7jx8Ux6Kma/hMDDlve
	z+d4zPi7HjWXEzWP416q/GA003fKRfTz5ofnKarItl0kMA4ofvBSCmndv1UzPRKe7gmzffdCr2Y
	4XvamsuQMiYQzpcB5bATt2u1tk6OLjvkLuAnm/zRl+EgMXbg6TAFPf1p5HzD++dQ8q/Zt9UUFt1
	fuM3h4HqHZHr8YcYCSj6tuANBSQEGZ07M+yRQT+0ittDsX+dKT6v+ATlmJeAk8myy9XtTYLxAK+
	5OwzbTukDWngzzpCs3BOjAv/tX9g5BePTCOdgZDZ+hbYPyFuZJMghrorpU/2VR1Bvk1DUsXsk/r
	/6lCA6guQJoxOqltjq2/HzlCsUitxS1SJPXp/KREjyhqyEV+Z87lTAUggAU/+KMr3FVrX37+jYZ
	vTRnE/NN2o9sK345xBcbyp3jsORWVcQQWVVzjCGDS1M2tdJq0J9gbUUqoK6dtlHP/paZq8VPLNA
	L3QC+6LW7aacIuXBMIW4rf+W
X-Received: by 2002:a05:6820:7054:b0:70a:992e:f3da with SMTP id 006d021491bc7-719172d2fc0mr5072889eaf.0.1794487769803;
        Thu, 12 Nov 2026 04:49:29 -0800 (PST)
Received: from gmail.com ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a6f2a264sm6286182eaf.1.2026.11.12.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:49:29 -0800 (PST)
Date: Thu, 12 Nov 2026 20:48:55 +0800
From: Wenwu Hou <hwenwur@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Do the latency calculations in
 nanoseconds
Message-ID: <avW1t81WLQ9YrylB@gmail.com>
References: <20261112121502.2070755-1-hwenwur@gmail.com>
 <sashiko-outbox-211086@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-211086@kernel.org>

On Thu, Nov 12, 2026 at 12:28:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] tracing/hwlat: get_sample() leaves NMI callback enabled on
>   goto out path
> --
> 
> commit b2b5eb31ef0ca8b02c68fc0666337a94df8c67b9
> Author: Wenwu Hou <hwenwur@gmail.com>
> 
> tracing/hwlat: Do the latency calculations in nanoseconds
> 
> This commit changes get_sample() to perform its latency calculations in
> nanoseconds so tr->max_latency is stored in nanoseconds, converting the
> durations to microseconds only when recording the hwlat event.
> 
> > diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> > index 3fe274b84f1c2..b230cf14de93e 100644
> > --- a/kernel/trace/trace_hwlat.c
> > +++ b/kernel/trace/trace_hwlat.c
> > @@ -203,14 +203,12 @@ static int get_sample(void)
> >  	time_type start, t1, t2, last_t2;
> >  	s64 diff, outer_diff, total, last_total = 0;
> >  	u64 sample = 0;
> > -	u64 sample_width = READ_ONCE(hwlat_data.sample_width);
> > +	u64 sample_width = READ_ONCE(hwlat_data.sample_width) * NSEC_PER_USEC;
> >  	u64 thresh = tracing_thresh;
> >  	u64 outer_sample = 0;
> >  	int ret = -1;
> >  	unsigned int count = 0;
> >  
> > -	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
> > -
> >  	kdata->nmi_total_ts = 0;
> >  	kdata->nmi_count = 0;
> >  	/* Make sure NMIs see this first */
> > @@ -229,7 +227,7 @@ static int get_sample(void)
> >  
> >  		if (time_u64(last_t2)) {
> >  			/* Check the delta from outer loop (t2 to next t1) */
> > -			outer_diff = time_to_us(time_sub(t1, last_t2));
> > +			outer_diff = time_sub(t1, last_t2);
> >  			/* This shouldn't happen */
> >  			if (outer_diff < 0) {
> >  				hwlat_err(BANNER "time running backwards\n");
> > @@ -240,7 +238,7 @@ static int get_sample(void)
> >  		}
> >  		last_t2 = t2;
> >  
> > -		total = time_to_us(time_sub(t2, start)); /* sample width */
> > +		total = time_sub(t2, start); /* sample width */
> >  
> >  		/* Check for possible overflows */
> >  		if (total < last_total) {
> > @@ -250,7 +248,7 @@ static int get_sample(void)
> >  		last_total = total;
> >  
> >  		/* This checks the inner loop (t1 to t2) */
> > -		diff = time_to_us(time_sub(t2, t1));     /* current diff */
> > +		diff = time_sub(t2, t1);     /* current diff */
> 
> [Severity: Medium]
> Can the "goto out" paths when outer_diff < 0 or diff < 0 leave
> trace_hwlat_callback_enabled set to true?
> 
> Previously, time_to_us() passed the delta through unsigned div_u64(), which
> cleared the sign bit and made the negative checks unreachable.  Assigning
> time_sub() directly makes those error paths reachable on a backward clock
> reading, and jumping to out skips clearing trace_hwlat_callback_enabled:
> 

will fix in v3


> kernel/trace/trace_hwlat.c:get_sample() {
> 	...
> 	trace_hwlat_callback_enabled = true;
> 	...
> 	do {
> 		...
> 			if (outer_diff < 0) {
> 				hwlat_err(BANNER "time running backwards\n");
> 				goto out;
> 			}
> 		...
> 		if (diff < 0) {
> 			hwlat_err(BANNER "time running backwards\n");
> 			goto out;
> 		}
> 		...
> 	} while (total <= sample_width);
> 
> 	barrier(); /* finish the above in the view for NMIs */
> 	trace_hwlat_callback_enabled = false;
> 	...
> out:
> 	return ret;
> }
> 
> Because nothing else resets trace_hwlat_callback_enabled, NMI tracking stays
> active while kthread_fn() re-enables interrupts and sleeps, and remains enabled
> even after the tracer is stopped if kthread_stop() wakes the thread before
> another sample finishes normally.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261112121502.2070755-1-hwenwur@gmail.com?part=1
