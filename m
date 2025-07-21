Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D2DECC9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111401; cv=none; b=XpIDfQZR9PP8AwJ/d9i6idSVrqN3OYcLEcLQu5a531XlfBESBAR+zaUZlygMWAGufCPY+guDz1b4eMn2WwsGpFbYPtnIpHcswtck118BpQmHdgqaMNQ29iZDj8pObQ8ZvE43ZDFsQVMb+SjkSDxN5w1BN5twd0X4hbgvHRYd9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111401; c=relaxed/simple;
	bh=7fMrJyTpIVAfAnqciR7KfuGmmog47rgQGOjPiGz3b9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP7cRLSOiFBH2+Gc2TI3O1qgt9pMM6e97nLzRF+MOMm4cicpDpLL0yZRKW+PmCfdAd0W45a2rIAG9CZ4GABmN3KA6qTTAHZm25icN7AsGQpAKNXityzv4V04UzSculRFmlpcvo3cERoAcM4WtfNNSLiVhaqPy87lx08gDZlF+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCyxqQFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCyxqQFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7fMrJyTpIVAfAnqciR7KfuGmmog47rgQGOjPiGz3b9M=;
	b=dCyxqQFdI4w/NP6BldpOhkma1MOzhDT6/8HXcsk0OdPCt1TpQ6MytrnK3hYO5t9+LqTILB
	TczydToBYBYfbKcoBMgjbwXkfBPoxaojMX95ARz9GsxzPy0uIl5IAWOXL+gpdtiIwfz8za
	8DIc4fEN/mYIDuJQy5oNnob+B1vGcUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-s24rc9cGN2Kt90kOo1YCzg-1; Mon, 21 Jul 2025 11:23:16 -0400
X-MC-Unique: s24rc9cGN2Kt90kOo1YCzg-1
X-Mimecast-MFC-AGG-ID: s24rc9cGN2Kt90kOo1YCzg_1753111395
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso1913494f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111395; x=1753716195;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EVN+mQ5R/a5EGRZyA4TrH7zmCdcDhzPMCVO84jmEWE=;
        b=XALFgcrhLjfK0wl8AU7YTa4+qEdLJxZTLCBlFDVqnHuquHPymbN2VhqpTAktwiznr6
         Uu/SFG9j6DcSPvLqvQTXZTmTYg0JBBSeQmARnN5ZYzRfl7ffwqh6IkLGTblahBvQKSAr
         Z/5y4TDlt6UhbPITTdgJ7pHA+uQ+MJ028vM873oguWGNIDFXy92CRy5W3QxtDPytnnVw
         vPgu1MPKGdIHNR+980a7HBzs4BxV8+MUg3mfSkjixmOoSQHCFFxDISKe+8v2JdC2W6SD
         FqhGuMOP8rZ+ExD7avhdUrdKxv4oNSY4GcSNiCAU9X6UFG+8QMzW9f2WOtRU70qh09JJ
         5IEA==
X-Forwarded-Encrypted: i=1; AJvYcCU+IGSdQ94GB7171Pk7DQfQa+yyZuTVLtOzCh7FG3MjvOTkNAudJLi++oz6LaRTzNRX/WhhivK997Wc4wljNQw0C44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1U478XQ3awRXjT2D15MK0dBzzlU4PgiJGFLFB7LUpD8eHR8U7
	mn9mPjkF6C/V7RzSEHLKRkb4z5QkgogIbyzZvWJRYWFmrDdLN+7r3RtMymovhRwLJm5xR6RwM/f
	IuHMZrZoaDecNrM8zgJzU2vh5DPT3V2l6yXd9vB0rVTobzWTKu/OK4OpCEStIWvLBg8r4En0U8w
	==
X-Gm-Gg: ASbGncsXV0u0pXN5V75TMB2SFKtkZuD+oXxvJau4xMjb0fhDTndSuHoWCWK6zmRylnU
	6E6U36Zm8pPBCDBWLWOuBbrnSjQ7ruH45JcDHQ4ClPdpC/m4VrqwlaESFhsZfx9+QXqSZBW1OiW
	5/47M4xWYhdUc2z6iH1rCEHHQzpY0/d5YhoO9Q11XdrPc0XCLRr88Bap6FdFwAqXw2OG2kRNuyC
	hCMo3s7JEKGCdsy/5FDodSpA5f7D7HBK0UZj3FIxbdbWHA/8PEZzBVpcHsGmISp3iInCsdwUTbe
	QkCn2QW9ROwEtKf/v5KLcDZxYzxkKvpNKW47Tuhsg4Gx/muW3UsazyN8ofKiYlBkLQ==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr18160911f8f.9.1753111395091;
        Mon, 21 Jul 2025 08:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4jpDBvB8ticrivjLowJPy7FbEU+blN23cr0WoEPnxY8sSdfnn3cHYyANAFCoWuFvzaB4h7w==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr18160886f8f.9.1753111394637;
        Mon, 21 Jul 2025 08:23:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2548fsm10797741f8f.7.2025.07.21.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:23:14 -0700 (PDT)
Message-ID: <78c60d531c8ec862a0fe5e6ef4a40c1f65fe6544.camel@redhat.com>
Subject: Re: [PATCH v4 10/14] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 17:23:12 +0200
In-Reply-To: <20250721150143.sl2MIKSi@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-11-gmonaco@redhat.com>
	 <20250721150143.sl2MIKSi@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: im9UWPQlj_YLygliSeDI_am1xA39OV5a4azAb5zFeI0_1753111395
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-07-21 at 17:01 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:20AM +0200, Gabriele Monaco wrote:
> > DA monitor can be accessed from multiple cores simultaneously, this
> > is
> > likely, for instance when dealing with per-task monitors reacting
> > on
> > events that do not always occur on the CPU where the task is
> > running.
> > This can cause race conditions where two events change the next
> > state
> > and we see inconsistent values. E.g.:
> >=20
> > =C2=A0 [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
> > =C2=A0 [63] event_srs: 27: sleepable x sched_set_state_sleepable ->
> > sleepable
> > =C2=A0 [63] error_srs: 27: event sched_switch_suspend not expected in
> > the state running
> >=20
> > In this case the monitor fails because the event on CPU 62 wins
> > against
> > the one on CPU 63, although the correct state should have been
> > sleepable, since the task get suspended.
> >=20
> > Detect if the current state was modified by using try_cmpxchg while
> > storing the next value. If it was, try again reading the current
> > state.
> > After a maximum number of failed retries, react by calling a
> > special
> > tracepoint, print on the console and reset the monitor.
> >=20
> > Remove the functions da_monitor_curr_state() and
> > da_monitor_set_state()
> > as they only hide the underlying implementation in this case.
> >=20
> > Monitors where this type of condition can occur must be able to
> > account
> > for racing events in any possible order, as we cannot know the
> > winner.
> >=20
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> >=20
> > =C2=A0static inline
> > bool=09=09=09=09=09=09=09=09=09=09\
> > =C2=A0da_event_##name(struct da_monitor *da_mon, enum events_##name
> > event)=09=09=09=09\
> > =C2=A0{=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > -=09type curr_state =3D
> > da_monitor_curr_state_##name(da_mon);=09=09=09=09=09\
> > -=09type next_state =3D model_get_next_state_##name(curr_state,
> > event);=09=09=09\
> > -
> > =09=09=09=09=09=09=09=09=09=09=09=09\
> > -=09if (next_state !=3D INVALID_STATE)
> > {=09=09=09=09=09=09=09\
> > -=09=09da_monitor_set_state_##name(da_mon,
> > next_state);=09=09=09=09\
> > -
> > =09=09=09=09=09=09=09=09=09=09=09=09\
> > -
> > =09=09trace_event_##name(model_get_state_name_##name(curr_state),=09=09=
=09\
> > -=09=09=09=09=C2=A0=C2=A0
> > model_get_event_name_##name(event),=09=09=09=09\
> > -=09=09=09=09=C2=A0=C2=A0
> > model_get_state_name_##name(next_state),=09=09=09\
> > -=09=09=09=09=C2=A0=C2=A0
> > model_is_final_state_##name(next_state));=09=09=09\
> > -
> > =09=09=09=09=09=09=09=09=09=09=09=09\
> > -=09=09return
> > true;=09=09=09=09=09=09=09=09=09\
> > +=09enum states_##name curr_state,
> > next_state;=09=09=09=09=09=09\
> > +=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > +=09curr_state =3D READ_ONCE(da_mon-
> > >curr_state);=09=09=09=09=09=09\
> > +=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> > {=09=09=09=09=09\
> > +=09=09next_state =3D
> > model_get_next_state_##name(curr_state, event);=09=09=09\
> > +=09=09if (next_state =3D=3D INVALID_STATE)
> > {=09=09=09=09=09=09\
> > +=09=09=09cond_react_##name(curr_state,
> > event);=09=09=09=09=09\
> > +=09=09=09trace_error_##name(model_get_state_name_##
> > name(curr_state),=09=09\
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_event_name_##name(event));=09=09=09\
> > +=09=09=09return
> > false;=09=09=09=09=09=09=09=09\
> > +=09=09}=09=09=09=09=09=09
> > =09=09=09=09\
> > +=09=09if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state))) {=09\
> > +=09=09=09trace_event_##name(model_get_state_name_##
> > name(curr_state),=09=09\
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_event_name_##name(event),=09=09=09\
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_state_name_##name(next_state),=09=09\
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_is_final_state_##name(next_state));=09=09\
> > +=09=09=09return
> > true;=09=09=09=09=09=09=09=09\
> > +=09=09}=09=09=09=09=09=09
> > =09=09=09=09\
> > =C2=A0=09}=09=09=09=09=09=09=09
> > =09=09=09=09\
> > =C2=A0=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > -=09cond_react_##name(curr_state,
> > event);=09=09=09=09=09=09=09\
> > -
> > =09=09=09=09=09=09=09=09=09=09=09=09\
> > -
> > =09trace_error_##name(model_get_state_name_##name(curr_state),=09=09=09=
=09\
> > -=09=09=09=C2=A0=C2=A0
> > model_get_event_name_##name(event));=09=09=09=09=09\
> > -
> > =09=09=09=09=09=09=09=09=09=09=09=09\
> > +=09trace_rv_retries_error(#name,
> > smp_processor_id());=09=09=09=09=09\
> > +=09pr_warn("rv: "
> > __stringify(MAX_DA_RETRY_RACING_EVENTS)=09=09=09=09=09\
> > +=09=09" retries reached, resetting monitor %s",
> > #name);=09=09=09=09\
>=20
> smp_processor_id() requires preemption to be disabled.
>=20
> At the moment, trace point handler is called with preemption
> disabled, so
> we are fine. But there is plan to change that:
> https://lore.kernel.org/lkml/20241206120709.736f943e@gandalf.local.home/T=
/#u
>=20
> Perhaps use get_cpu() and put_cpu() instead?

Mmh, then I'd need to execute them only if the tracepoint is enabled,
I'm not sure it's worth the effort..
I wanted to avoid creating two different tracepoints (implicit and id),
but I might have to. The CPU is rarely needed there since (for now)
per-cpu monitors assume event cpu and monitor cpu are the same.

I'll have a thought about it, thanks for pointing it out!

Gabriele

