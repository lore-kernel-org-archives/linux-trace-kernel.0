Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D53FE355
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478860; cv=none; b=W2GgN6stMqzhEk19mR2Lm4xEakhoxkBIi2cUMKC3GwlnXFQwU4GR3AzBIfXhEc/LzQX5TlP4fzOUOhg3boznvwzWk3IW0W31wJU/mJnrdqSBxp4/u9qTDb78qUfUA3SocmZCLshjohLTSIZkFY34/v8wVkbDwroXjwaUazBFNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478860; c=relaxed/simple;
	bh=0GYqK2Tr+wz/e04tlFK8Mc3kgcOYulQlGTTuzx1n/7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2Jy90wC501ZAy0nCRgIWDJCtxqUbPjLFLIqouddgojihf/X+FqMtExAlPPW71WRjMhCIazwlTOgrh1JEpGwKoM0+rgclZvpUUMRswx8f+LF+W13aoSoWF08SzpVmLmfFln7AW4Czr9Zpvku3KTlSeFHcrywCtQsE1S5/BBtV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbCmm5WN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbCmm5WN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780478856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GYqK2Tr+wz/e04tlFK8Mc3kgcOYulQlGTTuzx1n/7A=;
	b=XbCmm5WN+dF8oacR1dpIPZy3Veh+BrKiBarxsDnIRkWhPHS+9EXbRNpvROQXzaFkKMwJEW
	8y8NqlCzH9fzBBApjDeIg7SCtQ98FfgHuDwcnHaBPbeL35L+zjIvV6513jnsQaIj1X0lBz
	20ql4QJr1yh6XtIGr9S2A4gdDPWPedQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-t04K9BtJMTa8dM-xMAaTZw-1; Wed, 03 Jun 2026 05:27:35 -0400
X-MC-Unique: t04K9BtJMTa8dM-xMAaTZw-1
X-Mimecast-MFC-AGG-ID: t04K9BtJMTa8dM-xMAaTZw_1780478854
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b61243easo6229995e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 02:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780478854; x=1781083654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg201aB2g0CfhdRUzjaTrOExYQbt1OldzNxV8zTL04g=;
        b=J3J7VhSPFqduTqbhJr+Dn1I0hoLC8B2C4whoZjCWyd726mVghQ69TX/nqlviaWZOOk
         TirNEZXrA1DjJjPj8a1TyqHCOlI7290zQlDiokOySy4UarQ96o/B+Z4q4QjU6MRx0F/X
         l3B5pY1m+N4HgzpUk6EpAP9F9OVwHGb6ALhSxEPMa3bB0ZpfYLydRIPatQQVPdCzbCBh
         u6tFnNyFGdAHKR0cs8lkEIxokzuCenwvMw3dUrGKICaWYcP13a9VNUkTBfasbXBbtoGR
         sSYuPE+16i/m6p8VbZ3EQrbmF9OgGRVQtjoD8EjpGl9deLbPzu+40AMqU+cTwIAdVVve
         r8lw==
X-Forwarded-Encrypted: i=1; AFNElJ8ptHTZIP35an1NCBAEzmOgMaG9WUBOKqZ6oYzBOx0eXchZDxqSyGsSQuHh27UMyQb2o+hrsqh0PJm6l19Bs5NmhV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrIQC0jfobhGHpEhhdwEwp64VphXM4hewrcvmNrAFtJIyHOH5
	Y86FF8SfBdAXFFIENcv3RuCt9Uqpho4bMMk+gFWQF9hneaG6BuoTPB1Ycj1kbcEDy3CMMlzzMdG
	qoAznUPQJuG5B9AC1cyMLUyZHQ71USDusrMJ+OA4IvyoOXysm5GUrSj2IHL3FWupQhyJw/Q8Qp4
	Wq9giaBg==
X-Gm-Gg: Acq92OGkER+GoreFZHsWZvR/a3S5nNhtNk/KFSm/8QNE14m6DZQ1zVzq6TJNKGAk1iR
	sAGMWg3tGee1xVQ0aXKapAlBtZgg2OkFfn73HrfwwOXLRrIw/a1tMKiRO5RVAiyCg/k68QjcIQE
	7kDu8ScSW8HqeYXFYvxOKBNTzAh53zTii+8ukaIFBxvfGR5Cl5sjlUklLbGrZNjppuXE9xc0goX
	jvPpdYajnZXEmGbw2T7+D8ISixa0FSSwvWmJi01UbXB43T7wx8m4MbfvimlXbyvmfZ1WUe6t8+v
	c02Yo9BuUTLjiMfArCSmiOFqxfzxWQW1exbKRBVtox3iygAuYGhhyEiiyfwu4upiPladKGssVAq
	yoNupbh9CIlIcp3KDPfKJi5uigmfI0v8IGYhi
X-Received: by 2002:a05:600c:1551:b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490b5e805aemr44440965e9.13.1780478854051;
        Wed, 03 Jun 2026 02:27:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490b5e805aemr44440455e9.13.1780478853676;
        Wed, 03 Jun 2026 02:27:33 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d64e8sm35546855e9.0.2026.06.03.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:27:33 -0700 (PDT)
Message-ID: <fcb3cf13b1ffdca34354b6f9642c41968030c605.camel@redhat.com>
Subject: Re: [PATCH v2 07/13] rv: Simply hybrid automata monitors's clock
 variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 11:27:32 +0200
In-Reply-To: <ed1719ebe4af8872673af4264fdbf9ad96425b7f.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
	 <ed1719ebe4af8872673af4264fdbf9ad96425b7f.1779956342.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _p5KXpQ3P7CxUDv7EHE2bNIt1ovqRfajwr0Oyvfv2as_1780478854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s/Simply/Simplify/ from the patch title.

On Thu, 2026-05-28 at 10:27 +0200, Nam Cao wrote:
> =C2=A0/*
> @@ -389,14 +357,14 @@ static inline void ha_setup_timer(struct
> ha_monitor *ha_mon)
> =C2=A0static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon,
> enum envs env,
> =C2=A0=09=09=09=09=09u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, expire,
> time_ns);
> +=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env,
> time_ns);
> =C2=A0
> =C2=A0=09mod_timer(&ha_mon->timer, get_jiffies_64() + expire -
> passed);
> =C2=A0}
> =C2=A0static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enu=
m
> envs env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire,
> time_ns);
> +=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
> =C2=A0
> =C2=A0=09ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(expire - passed =
+
> TICK_NSEC - 1), time_ns);
> @@ -438,7 +406,7 @@ static inline void ha_start_timer_ns(struct
> ha_monitor *ha_mon, enum envs env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> =C2=A0=09int mode =3D HRTIMER_MODE_REL_HARD;
> -=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire,
> time_ns);
> +=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
> =C2=A0

You need to remove expire also for ha_invariant_passed_jiffy in the
hrtimer flavour (just set HA_TIMER_HRTIMER in stall and you see it
won't compile). Jiffy granularity monitors with hrtimers are an
unlikely usecase but still supported.

Other than that it looks good.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> =C2=A0=09if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
> =C2=A0=09=09mode |=3D HRTIMER_MODE_PINNED;
> diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c
> b/kernel/trace/rv/monitors/nomiss/nomiss.c
> index a0b5641a1858..19d0e9aa4d58 100644
> --- a/kernel/trace/rv/monitors/nomiss/nomiss.c
> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -57,24 +57,12 @@ static inline bool ha_verify_invariants(struct
> ha_monitor *ha_mon,
> =C2=A0=09=09=09=09=09enum states next_state, u64
> time_ns)
> =C2=A0{
> =C2=A0=09if (curr_state =3D=3D ready_nomiss)
> -=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss,
> time_ns);
> +=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss,
> time_ns, DEADLINE_NS(ha_mon));
> =C2=A0=09else if (curr_state =3D=3D running_nomiss)
> -=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss,
> time_ns);
> +=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss,
> time_ns, DEADLINE_NS(ha_mon));
> =C2=A0=09return true;
> =C2=A0}
> =C2=A0
> -static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
> -=09=09=09=09=09enum states curr_state, enum
> events event,
> -=09=09=09=09=09enum states next_state, u64
> time_ns)
> -{
> -=09if (curr_state =3D=3D next_state)
> -=09=09return;
> -=09if (curr_state =3D=3D ready_nomiss)
> -=09=09ha_inv_to_guard(ha_mon, clk_nomiss,
> DEADLINE_NS(ha_mon), time_ns);
> -=09else if (curr_state =3D=3D running_nomiss)
> -=09=09ha_inv_to_guard(ha_mon, clk_nomiss,
> DEADLINE_NS(ha_mon), time_ns);
> -}
> -
> =C2=A0static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states curr_state, enum
> events event,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states next_state, u64
> time_ns)
> @@ -122,8 +110,6 @@ static bool ha_verify_constraint(struct
> ha_monitor *ha_mon,
> =C2=A0=09if (!ha_verify_invariants(ha_mon, curr_state, event,
> next_state, time_ns))
> =C2=A0=09=09return false;
> =C2=A0
> -=09ha_convert_inv_guard(ha_mon, curr_state, event, next_state,
> time_ns);
> -
> =C2=A0=09if (!ha_verify_guards(ha_mon, curr_state, event, next_state,
> time_ns))
> =C2=A0=09=09return false;
> =C2=A0
> diff --git a/kernel/trace/rv/monitors/stall/stall.c
> b/kernel/trace/rv/monitors/stall/stall.c
> index 9ccfda6b0e73..1aa65d7e690d 100644
> --- a/kernel/trace/rv/monitors/stall/stall.c
> +++ b/kernel/trace/rv/monitors/stall/stall.c
> @@ -38,7 +38,7 @@ static inline bool ha_verify_invariants(struct
> ha_monitor *ha_mon,
> =C2=A0=09=09=09=09=09enum states next_state, u64
> time_ns)
> =C2=A0{
> =C2=A0=09if (curr_state =3D=3D enqueued_stall)
> -=09=09return ha_check_invariant_jiffy(ha_mon, clk_stall,
> time_ns);
> +=09=09return ha_check_invariant_jiffy(ha_mon, clk_stall,
> time_ns, threshold_jiffies);
> =C2=A0=09return true;
> =C2=A0}
> =C2=A0

