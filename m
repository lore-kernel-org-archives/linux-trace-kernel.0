Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AA25B311
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573334; cv=none; b=biHaO9cZqJ/SGvn0TBiCXTa4PbpjrnCc2+1mHLUBJ/a6xuu4Il9VpKZ9tpGzv/RSPm7s/metcZ3Aw2uYZc25YZ9vo1DW50u2OXjPibRZfjSS2ScvOSriqV8dGgqZLHaSZq8bSMUcwzw3BRdjhvf9x69c95+ablvTVVt+k9gUSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573334; c=relaxed/simple;
	bh=bI8iAEh60uZRgqSPrdw5B9I+S5dgekP21HagESySQPI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5gzWm/svRFJ72xrbJgmhAIdQO6ba3ztrylRJ1UrTLo3xnkTlKM+263iZMDq54phEKeVPUuwQ3aoUgCafAwbm8jkVUeJBAJYcU8qndu3mE6mx8xZRJhx2p7puNrypP5zT0Q0AmrF7HbXp2QFuz/IFnQwRJ4yzJKNUpZbv3guNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoW72JDY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoW72JDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bI8iAEh60uZRgqSPrdw5B9I+S5dgekP21HagESySQPI=;
	b=LoW72JDYbkI9yr2kGHnZ+t0ieByi55VvFb/cjieSI31pEdz4hGwiKkYyXj0sxdhTIv1xtM
	adBHhJnmPprme70cpykbozC+rQAwaVggdeJ/8oqjWXxnbAZlAoankoQYwupwQqQvTc82p6
	537PJgDTkiwdF9B1xkk2GCj6b1zRyE8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-706GhqEcN_GSSKm7ArD9DQ-1; Thu, 07 Aug 2025 09:28:50 -0400
X-MC-Unique: 706GhqEcN_GSSKm7ArD9DQ-1
X-Mimecast-MFC-AGG-ID: 706GhqEcN_GSSKm7ArD9DQ_1754573330
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7074bad0561so30035986d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573330; x=1755178130;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5xwSvCoF6TIRBA5wgVSUg6aFNp3Rr7VfLIXicuNjQY=;
        b=vIAAtEIAoOiHm/vT+zRwBDd7HABJmu1l8MvNM05nPpDc+J0knwEuY7bFDe6j3YTZ4T
         YahCMZTENU0i2SjdjNI5G+899kwqNcgQvWVvllpv9Sbk1/1ADRUQIR1UInsIGXIWMBMs
         Rw2olZ8Cs8HZrIjMLpf9rAjkRu0QgDPFtysZzxxRP8rFjMoLLWZRUw4Eq0jP/X9qZ+/x
         3CVjt3v3hyk6dLm1N2jV0YilrkuxjBoXj3q6RfgrMYVgVdHHT4+KWLaVKPm9guv43M5P
         R4YRuyezT6XI6DmJMq5zUWxX/yfaoy7Rwum1xeJFF4pADwBK2iibnte9s7piw6MvR2Jt
         guBw==
X-Forwarded-Encrypted: i=1; AJvYcCXX9PQJViYzPBMgKRfOvl2sJwd2if3FMHUD1ocM+4UKasXANfn3HPAMBBXXMS7vtDZJupnDtW3sIBGqDNepBZEHn+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSpy63TFt+XTf8JTrunt7FL0WdbHeZO1NQN0j1jlHLpheTBhU
	+oLxmjihWqol5iqF86Mi6+XVb/HAZGpI31n7Hq/ET2PfkjoUfTdLVcacNSxG4bob5LxHVkRqhS0
	o30yjYx/+2xcNP0f+4RmXyqxTwn9oCqswCyKvpgrqbGSAbGWp12RENqMnnjXf79dhQcWM34TCl2
	HlLrBQfWhE
X-Gm-Gg: ASbGncu9clsOt+ybuQYwAC7mvxU7cq2xn9/axPN9tn8YYG6c8UQSfcAOiSgxmjF0RDL
	X6irCp6zqWM2oh0A8jMqT2nKzi0aUORJzz2PjgZZwAR/LlnGPgFFqShH96PwZpQHDVDq2xbvoP2
	uOq9HdMdS6hNtvgCOGRRFgJc1sLOcnmJI8PjYMGK0eOu6sH+SBYxZLW6RZtyt3/88SApOjv+O2d
	woFEsDiso9ZKxi1jmnr+WuFceRG6FAHTfp3JO2/xeAa9npvgFh3AczbyJ+cKm4XgRHIvpBi06bd
	E2fwiQkljkYVFRfDzqz9Oy5R+EYwj4tb9Du9BKGuozpH4RD1d/b7JwoDmnc9kIFhIg==
X-Received: by 2002:ad4:5dc6:0:b0:706:ea6d:e161 with SMTP id 6a1803df08f44-7097966daf2mr102842956d6.32.1754573329774;
        Thu, 07 Aug 2025 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9u4O9j1s3L/rokLiFtLf2hoWRa81S/BHfvNB2TK04cCsaj75pcgxG5grJPq4cYwLx59tJg==
X-Received: by 2002:ad4:5dc6:0:b0:706:ea6d:e161 with SMTP id 6a1803df08f44-7097966daf2mr102842666d6.32.1754573329199;
        Thu, 07 Aug 2025 06:28:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c716effsm98789026d6.0.2025.08.07.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:28:48 -0700 (PDT)
Message-ID: <918e887ec5f0832623b9fb7b8a23559aaa66e3db.camel@redhat.com>
Subject: Re: [PATCH v2 2/5] rv/ltl: Support per-cpu monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Aug 2025 15:28:46 +0200
In-Reply-To: <8e2b9d37f0543b1c0f78119d459d2294d99c8d4d.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <8e2b9d37f0543b1c0f78119d459d2294d99c8d4d.1754466623.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UcxM0BY7UX7xiH2tXpWvV1CD3INwScGjWjvumdyI2pw_1754573330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add support for per-cpu run-time verification linear temporal logic
> monitors. This is analogous to deterministic automaton per-cpu
> monitors.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: Rename "implicit" to "cpu"

Looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0 | 32 +++++++++++++++++++++++++=
+
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0kernel/trace/rv/rv_trace.h | 46
> ++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 82 insertions(+)
>=20
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 9dabc5b133a3..4ad08b5b9f2d 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -23,12 +23,21 @@
> =C2=A0
> =C2=A0typedef struct task_struct *monitor_target;
> =C2=A0
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +
> +#define TARGET_PRINT_FORMAT "%u"
> +#define TARGET_PRINT_ARGS(cpu) cpu
> +
> +typedef unsigned int monitor_target;
> +
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> =C2=A0static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0
> +static struct ltl_monitor *ltl_get_monitor(monitor_target target);
> +
> =C2=A0static void rv_cond_react(monitor_target target)
> =C2=A0{
> =C2=A0=09if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> @@ -54,6 +63,13 @@ static struct ltl_monitor
> *ltl_get_monitor(monitor_target target)
> =C2=A0{
> =C2=A0=09return &target->rv[ltl_monitor_slot].ltl_mon;
> =C2=A0}
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +static struct ltl_monitor *ltl_get_monitor(unsigned int cpu)
> +{
> +=09static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
> +
> +=09return per_cpu_ptr(&ltl_monitor, cpu);
> +}
> =C2=A0#endif
> =C2=A0
> =C2=A0static void ltl_target_init(monitor_target target, bool
> target_creation)
> @@ -108,6 +124,22 @@ static void ltl_monitor_destroy(void)
> =C2=A0=09rv_put_task_monitor_slot(ltl_monitor_slot);
> =C2=A0=09ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
> =C2=A0}
> +
> +#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
> +
> +static int ltl_monitor_init(void)
> +{
> +=09unsigned int cpu;
> +
> +=09for_each_possible_cpu(cpu)
> +=09=09ltl_target_init(cpu, false);
> +=09return 0;
> +}
> +
> +static void ltl_monitor_destroy(void)
> +{
> +}
> +
> =C2=A0#endif
> =C2=A0
> =C2=A0static void ltl_illegal_state(monitor_target target, struct
> ltl_monitor *mon)
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 5b4be87ba59d..7ef89006ed50 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -16,6 +16,10 @@ config DA_MON_EVENTS_ID
> =C2=A0=09select RV_MON_MAINTENANCE_EVENTS
> =C2=A0=09bool
> =C2=A0
> +config LTL_MON_EVENTS_CPU
> +=09select RV_MON_EVENTS
> +=09bool
> +
> =C2=A0config LTL_MON_EVENTS_ID
> =C2=A0=09select RV_MON_EVENTS
> =C2=A0=09bool
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 4a6faddac614..bf7cca6579ec 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -177,8 +177,54 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
> =C2=A0#include <monitors/pagefault/pagefault_trace.h>
> =C2=A0#include <monitors/sleep/sleep_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> +
> =C2=A0#endif /* CONFIG_LTL_MON_EVENTS_ID */
> =C2=A0
> +#ifdef CONFIG_LTL_MON_EVENTS_CPU
> +DECLARE_EVENT_CLASS(event_ltl_monitor_cpu,
> +
> +=09TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +
> +=09TP_ARGS(cpu, states, atoms, next),
> +
> +=09TP_STRUCT__entry(
> +=09=09__field(unsigned int, cpu)
> +=09=09__string(states, states)
> +=09=09__string(atoms, atoms)
> +=09=09__string(next, next)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__entry->cpu =3D cpu;
> +=09=09__assign_str(states);
> +=09=09__assign_str(atoms);
> +=09=09__assign_str(next);
> +=09),
> +
> +=09TP_printk("cpu%u: (%s) x (%s) -> (%s)", __entry->cpu,
> +=09=09=C2=A0 __get_str(states), __get_str(atoms),
> __get_str(next))
> +);
> +
> +DECLARE_EVENT_CLASS(error_ltl_monitor_cpu,
> +
> +=09TP_PROTO(unsigned int cpu),
> +
> +=09TP_ARGS(cpu),
> +
> +=09TP_STRUCT__entry(
> +=09=09__field(unsigned int, cpu)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__entry->cpu =3D cpu;
> +=09),
> +
> +=09TP_printk("cpu%u: violation detected", __entry->cpu)
> +);
> +// Add new monitors based on CONFIG_LTL_MON_EVENTS_CPU here
> +
> +#endif /* CONFIG_LTL_MON_EVENTS_CPU */
> +
> =C2=A0#ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
> =C2=A0/* Tracepoint useful for monitors development, currenly only used i=
n
> DA */
> =C2=A0TRACE_EVENT(rv_retries_error,

