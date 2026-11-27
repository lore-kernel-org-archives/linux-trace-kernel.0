Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787868;
	b=SJu0t7A4e8Crih9NDOtqD+yxQhXVDfeHyojP0kKffSvmVMpPIuZVnHnlln753qByybFf
	 CuLTT2o+ALxylnGtsFlys7fwsIkOZbTOQ2kLZfZN3pu+BiQQPVyBBV1gh7iAclRp/LnOC
	 MtiKj0yz4phudmUdBAx7bG1g7U2BQtBuTToEz6ZeEOv+WNTBmC/wdcovZl+8PAhqafKsz
	 /URCEJAHL/6TVCxWnah0EDiLc27pVzKH3rI948v8PmzsW/YSnJAHH3E8n4WDHS7FgvlY8
	 LMpb4apxu6hk0wv59uB5QOWZVOSKVGIxUtuMpMyjgZ6iwdbRotVcr+bAuZYinm/J77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787868;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=3oP3CW/xz/aHM7zel7M/7IDDZYm2mTSBClBR98IIqkA=;
	b=2xmQdD+JodFJpV4IeGRUqbaUT3OCCMNYuGQiSHt7HRpliJd7aYZliHgGkwXUmf2kzUfg
	 xV//k+KPnHle5bsQqoxW+U7x21ZrIrto4tkH7OHiYjjx0kATmr1/s6YWv9zuOS9RET19s
	 zGZmt1Kd4RRF4tS7coVSa2Ur6aXQ3BwAku35dmklpn2RheDBNS2U0d8pu/8WvLRZn98kg
	 kDGPJdGtNhE9rMTWEwgZDpJYwNmWP6pV9vO1cpY9nOf6xdwHIEYxnz8YKT+DaTCvXxxrO
	 br+HI59ubBOad2hsRW5g+n8cWu9qBBshYPoHR2DygQuV6WDfd6/HTOBH8D0bkHioSOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="h/SKOEax";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21520606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 13:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21520606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h/SKOEax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795787867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3oP3CW/xz/aHM7zel7M/7IDDZYm2mTSBClBR98IIqkA=;
	b=h/SKOEaxCPsyyGbpY+bBx86VuXtzqlioYHh1XhMvmzqjqZmnpEUDdMPwJY60g4Fdy68//j
	xm2iLX9L6DzRY86yLcgkWx59lUdfz0RnsZiyLtZ8rIiec4SF7tksDup/eIuyU9qEYEOe7a
	wnw4HhdVj6L1iac23u2yfJB04vsoDs4=
X-MC-Rep: binary re single
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-lODyProvM1eNn7ivs8r43Q-1; Fri, 27 Nov 2026 13:57:45 +0000
X-MC-Unique: lODyProvM1eNn7ivs8r43Q-1
X-Mimecast-MFC-AGG-ID: lODyProvM1eNn7ivs8r43Q_1795787863
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a7c864000eso4835463f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 05:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787863; x=1796392663;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3oP3CW/xz/aHM7zel7M/7IDDZYm2mTSBClBR98IIqkA=;
        b=FhY46/shj60QS+LQHFXbXhKH+kjYHdHj8w9FpV99gAekADWtcGgNqaSBDdgpywrLpi
         6ecQ4MQv9n5yx8/IUyaxwLq3IcOx8QTlxcB76EgsbXmTQ47BQ9PiZR0lpT1NPcm3kjM2
         EhbTCUSAtHNTXdOglLiSJS6CRAM0TY/RkDsAl3aJsxMXlC/Zpkx9+FL3DGlBrNYL09Lm
         HQsQMggjJWMvAyHngIC1ouSrmavfmYJOdrKfhnPicVfy8xaJKlcuzXI41nwcHP1AVDqF
         F4YIK6paa90RLP0kLr0U6pMC8B3JbWWNK4PsfgQaSfuMwzfrK60LrnLDEPPF56mP3TGc
         ZAoA==
X-Forwarded-Encrypted: i=1; AL+hErHrMLhEgLWqWyjOubDOWrwNdAUSgpUwRKycAJEUkh2r4W+bQHUVy98CV0QYNlc2Kg+mKFW/rKdUqCSNPreWLa+ixCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z80XmbRtumE/sRVPAnJOPRY4+UdUB5C9SIv6TnK9MwFbZOlXqm4
	toIvjjdF++V9hmFnp1xyk+chVlwgAwQC62fIdbaK0PsVE+ipQQ8hYQQLwk6yyUzBh0BLtilBhw9
	K9dVIkndli4NyC19c+MMzCUJzxbOpOVIndQ1Lwow+b1XoogGkD6hJ7Zwd+gy0LWQEuOB9jE0jfQ
	==
X-Gm-Gg: AZFdTZfcA7s/OFuMZPMWgA9YYGvkYgSin5pMU/1YfsslAJbNJ3IQAND+gTs6+PzmiXu
	muE1byHRwgBLeArHLROdXbbm46k3nv4tgKe0qqwEoQwZSL4BcsPyJ0jhNzFXY+DzzFcIPmvoNfd
	vC24sAwC3l6lswM5YjdtW90btRIpy99VIPQ9D8o/DQdPSlJvTlv6ugxl5rFDtbUtyyYUcBObVWk
	QAXXj7FpjfRZ8Q1w3PlKdhehXur5vssC++kCyU1pMIYKjiMlYjrsVtCdxlZswUDiIWIQkyIBF4H
	9ymK3qAEbIsYTw7PBBxCGFHIskB6xicwvlZlYevXlooc2JJ+NwYIiyIzbSimWKfP0sX6KsfnvTC
	ZqamwEJYVoGuS/1cq+M9Mh6PEKFoFZZIELR1SIkPbCxKT6tb77ADnNjO8FB7nSxZT5cBh815hrD
	UV
X-Received: by 2002:a05:6000:2883:b0:4a7:a52f:a2be with SMTP id ffacd0b85a97d-4abb3678d88mr42566709f8f.13.1795787863447;
        Fri, 27 Nov 2026 05:57:43 -0800 (PST)
X-Received: by 2002:a05:6000:2883:b0:4a7:a52f:a2be with SMTP id ffacd0b85a97d-4abb3678d88mr42566654f8f.13.1795787863040;
        Fri, 27 Nov 2026 05:57:43 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm46662344f8f.37.2026.11.27.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:57:42 -0800 (PST)
Message-ID: <edac7605937c5fd1a02458e171ddfa4d5e6c1a36.camel@redhat.com>
Subject: Re: [PATCH v5 3/4] rv: collect per-edge dwell time for per-cpu
 DA/HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com, Shuah Khan	
 <skhan@linuxfoundation.org>
Date: Fri, 27 Nov 2026 14:57:40 +0100
In-Reply-To: <20261127113609.650286-4-tobias.schaffner@siemens.com>
References: <20261127113609.650286-1-tobias.schaffner@siemens.com>
	 <20261127113609.650286-4-tobias.schaffner@siemens.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AgFDik_G9ZqYlWAKAPiAsuOS0ELI4Ah7vRBAq0Rh3sY_1795787863
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-27 at 12:36 +0100, Tobias Schaffner wrote:
> Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
> automaton monitor also reports how long it lingers in each state.
>=20
> Account a transition as soon as its state change is committed. An HA
> constraint that rejects the transition can therefore reset the monitor
> without leaving an accounting window for nested events.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---

Looks good to me, thanks!
I'm taking the series.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0.../trace/rv/runtime-verification.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 30 ++++++++++++++
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 40 +++++++++++++++----
> =C2=A0include/rv/edge_stat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
> =C2=A0include/rv/ha_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A05 files changed, 69 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/trace/rv/runtime-verification.rst
> b/Documentation/trace/rv/runtime-verification.rst
> index c700dde9259c..ac16b5532e86 100644
> --- a/Documentation/trace/rv/runtime-verification.rst
> +++ b/Documentation/trace/rv/runtime-verification.rst
> @@ -229,3 +229,33 @@ For example::
> =C2=A0=C2=A0=C2=A0 nop
> =C2=A0=C2=A0=C2=A0 [panic]
> =C2=A0=C2=A0=C2=A0 printk
> +
> +**monitors/MONITOR/stats**
> +
> +Present only when the kernel is built with CONFIG_RV_EDGE_STAT=3Dy and
> *MONITOR*
> +is a per-cpu deterministic or hybrid automaton monitor. The file exists =
while
> +the monitor is enabled and reports how long the automaton dwells in each
> state
> +before leaving it, timed with local_clock() and accounted per outgoing e=
dge
> and
> +per CPU.
> +
> +- The first line is a header naming the columns.
> +- Each following line describes one edge on one CPU::
> +
> +=C2=A0=C2=A0 cpu edge label valid count sum_ns max_ns
> +
> +=C2=A0 *label* is "state:event", *valid* is 1 if the model defines the e=
dge and 0
> +=C2=A0 otherwise, *count* is the number of times the transition was comm=
itted, and
> +=C2=A0 *sum_ns* and *max_ns* are the total and worst dwell in nanosecond=
s. An
> +=C2=A0 invalid edge always reports a zero count.
> +
> +The counters are reset each time the monitor is enabled. A monitor that
> starts
> +on an event leaving its initial state does not know since when it was in=
 that
> +state, so this first transition is neither counted nor timed.
> +
> +For example::
> +
> +=C2=A0=C2=A0 # cat monitors/wip/stats
> +=C2=A0=C2=A0 # cpu edge label valid count sum_ns max_ns
> +=C2=A0=C2=A0 0 0 preemptive:preempt_disable 1 4210 95501200 183200
> +=C2=A0=C2=A0 0 1 preemptive:preempt_enable 0 0 0 0
> +=C2=A0=C2=A0 0 4 non_preemptive:preempt_enable 1 4208 3812900 42600
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index bf75cf2300ee..d83d1a98344e 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -33,7 +33,7 @@ typedef unsigned int da_state_t;
> =C2=A0 */
> =C2=A0struct da_monitor {
> =C2=A0=09bool=09=09monitoring;
> -=09unsigned int=09curr_state;
> +=09da_state_t=09curr_state;
> =C2=A0};
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_LTL_MONITOR
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 6fc5ef8142ac..942b35428ccd 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -17,6 +17,7 @@
> =C2=A0#include <rv/automata.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0#include <rv/kunit.h>
> +#include <rv/edge_stat.h>
> =C2=A0#include <linux/stringify.h>
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> @@ -105,6 +106,14 @@ static inline void da_monitor_reset(struct da_monito=
r
> *da_mon)
> =C2=A0=09da_monitor_reset_state(da_mon);
> =C2=A0}
> =C2=A0
> +static inline void __da_monitor_start(struct da_monitor *da_mon, da_stat=
e_t
> state)
> +{
> +=09da_mon->curr_state =3D state;
> +=09da_monitor_init_hook(da_mon);
> +=09/* Pairs with smp_load_acquire in da_monitoring(). */
> +=09smp_store_release(&da_mon->monitoring, 1);
> +}
> +
> =C2=A0/*
> =C2=A0 * da_monitor_start - start monitoring
> =C2=A0 *
> @@ -113,10 +122,18 @@ static inline void da_monitor_reset(struct da_monit=
or
> *da_mon)
> =C2=A0 */
> =C2=A0static inline void da_monitor_start(struct da_monitor *da_mon)
> =C2=A0{
> -=09da_mon->curr_state =3D model_get_initial_state();
> -=09da_monitor_init_hook(da_mon);
> -=09/* Pairs with smp_load_acquire in da_monitoring(). */
> -=09smp_store_release(&da_mon->monitoring, 1);
> +=09__da_monitor_start(da_mon,
> da_state_entered(model_get_initial_state()));
> +}
> +
> +/*
> + * da_monitor_start_unaccounted - start monitoring without accounting
> + *
> + * Like da_monitor_start(), for a monitor that has been in its initial s=
tate
> + * since an unknown time. The first transition is neither counted nor ti=
med.
> + */
> +static inline void da_monitor_start_unaccounted(struct da_monitor *da_mo=
n)
> +{
> +=09__da_monitor_start(da_mon, model_get_initial_state());
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -276,6 +293,11 @@ static inline void da_monitor_reset_state_all(void)
> =C2=A0 */
> =C2=A0static inline int da_monitor_init(void)
> =C2=A0{
> +=09int retval =3D rv_edge_stats_create(rv_this.root_d);
> +
> +=09if (retval)
> +=09=09return retval;
> +
> =C2=A0=09da_monitor_reset_state_all();
> =C2=A0=09return 0;
> =C2=A0}
> @@ -287,6 +309,7 @@ static inline void da_monitor_destroy(void)
> =C2=A0{
> =C2=A0=09da_monitor_reset_all();
> =C2=A0=09da_monitor_sync_hook();
> +=09rv_edge_stats_remove();
> =C2=A0}
> =C2=A0
> =C2=A0#ifndef da_implicit_guard
> @@ -689,9 +712,11 @@ static inline void da_trace_error(struct da_monitor
> *da_mon,
> =C2=A0static inline bool da_event(struct da_monitor *da_mon, enum events =
event,
> da_id_type id)
> =C2=A0{
> =C2=A0=09enum states curr_state, next_state;
> +=09da_state_t old;
> =C2=A0
> -=09curr_state =3D READ_ONCE(da_mon->curr_state);
> +=09old =3D READ_ONCE(da_mon->curr_state);
> =C2=A0=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> +=09=09curr_state =3D da_state_of(old);
> =C2=A0=09=09next_state =3D model_get_next_state(curr_state, event);
> =C2=A0=09=09if (next_state =3D=3D INVALID_STATE) {
> =C2=A0=09=09=09react(curr_state, event);
> @@ -699,7 +724,8 @@ static inline bool da_event(struct da_monitor *da_mon=
,
> enum events event, da_id_
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model_get_event_na=
me(event), id);
> =C2=A0=09=09=09return false;
> =C2=A0=09=09}
> -=09=09if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state,
> next_state))) {
> +=09=09if (likely(da_state_try_commit(&da_mon->curr_state, &old,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_state, event)))=
 {
> =C2=A0=09=09=09if (!da_monitor_event_hook(da_mon, curr_state, event,
> next_state, id))
> =C2=A0=09=09=09=09return false;
> =C2=A0=09=09=09da_trace_event(da_mon,
> model_get_state_name(curr_state),
> @@ -752,7 +778,7 @@ static inline bool __da_handle_start_run_event(struct
> da_monitor *da_mon,
> =C2=A0=09if (!da_monitor_enabled())
> =C2=A0=09=09return 0;
> =C2=A0=09if (unlikely(!da_monitoring(da_mon)))
> -=09=09da_monitor_start(da_mon);
> +=09=09da_monitor_start_unaccounted(da_mon);
> =C2=A0
> =C2=A0=09__da_handle_event_common(da_mon, event, id);
> =C2=A0
> diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
> index 8b99e8520e1e..16c28aedabdd 100644
> --- a/include/rv/edge_stat.h
> +++ b/include/rv/edge_stat.h
> @@ -145,7 +145,10 @@ static void rv_edge_stats_remove(void)
> =C2=A0=09rv_this_stats_file =3D NULL;
> =C2=A0}
> =C2=A0
> -/* A zero timestamp marks resets, which can run on a different CPU. */
> +/*
> + * A zero timestamp marks an unknown entry time: resets can run on a
> different
> + * CPU, and da_handle_start_run_event() starts in a state entered earlie=
r.
> + */
> =C2=A0#define da_state_entered(s)=09da_state_pack((s), local_clock())
> =C2=A0
> =C2=A0static __always_inline void
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 6e1c7fe5449a..78d1bb80aefd 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -312,7 +312,7 @@ static inline void __ha_monitor_timer_callback(struct
> ha_monitor *ha_mon)
> =C2=A0=09if (unlikely(READ_ONCE(ha_mon_destroying)))
> =C2=A0=09=09return;
> =C2=A0=09/* Ensure consistent curr_state if we race with da_monitor_reset=
 */
> -=09curr_state =3D smp_load_acquire(&ha_mon->da_mon.curr_state);
> +=09curr_state =3D da_state_of(smp_load_acquire(&ha_mon-
> >da_mon.curr_state));
> =C2=A0=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> =C2=A0=09=09return;
> =C2=A0
