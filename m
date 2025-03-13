Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961281FAC5A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865985; cv=none; b=brz4thdmaAXuJu1MUAQessmzBwWOfsigbN0IEnDqMC9KZEP1EKwLrC7LoPpV6UmIezGHfdy/wej8LIfDKo/8l6x44MgyLU0IBmmROJU+vS7gUuEYzngaV9gkajuOX6tckapuyfFFyBgeh5TBDSKVc66FmLpOtgKUzqaRF6NtjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865985; c=relaxed/simple;
	bh=WspJSa+WQloTKKzpPKDm4359IcbTRmm/+F3Z5YD0Zi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fru5IzR3H0tSALwTfT3GeUQzXvJRscgrrLj3jKm1SzijHSDVhQDiUDp2VG7qC/JS3+tm1g0R52tTpf1WtOwbDSZ7pUc513frxGl5/Z4nCicxfejGwquqjeKWXjLI6Oow/oCTGVwKls8AxLnKpsEawkBQOqn4IWGeQ95q73V4EOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZKD4Vpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZKD4Vpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741865982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WspJSa+WQloTKKzpPKDm4359IcbTRmm/+F3Z5YD0Zi4=;
	b=QZKD4Vpiwerz/rCNXu/+xQnuYrUg335eeQnAEsSmOkfLzkNw8n4q2VTOIfw35f45PAH/du
	peqd8hLylCdU8rc8jTaShxn4ajcc6l95U0QqSXFBipO9QGkscgkWojVQmw3Mqiczvi/evS
	1SaPkCwJt7FMV12pcwkgos9d1aonqJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-WsmGMJbXN8CU7ChcjNNkkg-1; Thu, 13 Mar 2025 07:39:41 -0400
X-MC-Unique: WsmGMJbXN8CU7ChcjNNkkg-1
X-Mimecast-MFC-AGG-ID: WsmGMJbXN8CU7ChcjNNkkg_1741865980
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cec217977so4346685e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865980; x=1742470780;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBKFPkywWLlyqcwAktL0j35GbM9v3hWST4pP/Wm7RKk=;
        b=QxEsa+KfJEV/SCsqpVhcwQVL2rIZKUNWZ+GTxcV2DjYte0CD1e3ImTwSEMXUsu2P2Y
         wZZI8xsgYqI17YJg6nXVT0MmYc1TD89xgBy0KJb7dcqj5J5gr2dszRWfbMSMFxpvquiV
         20olTjQR9xl1Cz/CJosp0w+zfHc/aigFrLoixYqC5y+hybFhL63Mmo/2EzSYv4TtLldj
         9NtjrOpZncwKMEHc5dCXmtyn3JMRtHKmlz/8SqI2syKep21L5IV5JfUNOFISqJguMWsx
         WLjXyw2mQ4gsmHxuV1xtDchfNqYNHsZ144WT5ZGQ9bAai7DNuZx9KMJGBq9h/Ej74z2M
         il6w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ94viKjVbKL6uhUvNvjlyOE8IVfIA0Hs6SUR+HCAI/xZQEhR9NPd2+bn0grWFfuDjvAxRgmNpWoeGiANRB6tIr24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu++Z4GTzXfN+xpeCLUdW1E9xuc0OllcLODC0vQGwStXG6B6nv
	7HrNieSy7qyb+afz+L21Pjp4wSG1EWNmNKr+9vLkztLl/TCyl1Igl1hLJ5D3Ld+gWmnyIfQGVCL
	mfBmtbq3lRd/tNyA/QwOVBRsVe30CSYSmqlBhZrdzoOOMV1uJycjc+zB8iqwq+BZtTcz9WA==
X-Gm-Gg: ASbGncve5CYJSHSYdYGNCpy1GRpHZIs5pLtbcavrvwAB45LgPyL5pusWTXwaaADiHaD
	1qY/h1ZDK/TBs3FgE++wXZJMYMbLb4tJnAeUvFWIvolaHZ8mYxy8oTQVxgjKKoqraXmsHS9XPeP
	AqrC90Ynk1u23I+er9DOHKboI8Nlg+R6vrmpeQwoOte34yJQpWhbmQIkL68v7TE7LW6uxOKknmP
	ACxVR6E2SUFR65W/jjNPB1IBCSWvl6CTVA8xgEy8e0NbrCr+eBT+Nxp84ZDMv6jzHP2Q8S388cJ
	OIYLb6qz51bVzb/mx/cGLkhXKz64k11o3oSEhSrYhA==
X-Received: by 2002:a05:600c:4ec9:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43cfe154363mr125796605e9.6.1741865980202;
        Thu, 13 Mar 2025 04:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxTTxy7wV75Pg+Ic27UIp9nAkCa7Y0291ZqkbOwBvzG41JZxvnc2mwuuU4wnuQFYwkDO5RQ==
X-Received: by 2002:a05:600c:4ec9:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43cfe154363mr125796415e9.6.1741865979832;
        Thu, 13 Mar 2025 04:39:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b22f4sm18014315e9.1.2025.03.13.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:39:39 -0700 (PDT)
Message-ID: <1bf27354248772fa7b8d15fdb305353f6e212966.camel@redhat.com>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Petr
 Mladek	 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Thu, 13 Mar 2025 12:39:36 +0100
In-Reply-To: <20250313081659.N-X57_b_@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
	 <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>
	 <20250313081659.N-X57_b_@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FSa1fxNbJa-ve6-oMwEwiQqDkUf4r3gcc6ESWx0QPBU_1741865980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-03-13 at 09:16 +0100, Nam Cao wrote:
> Hi Gabriele,
>=20
> On Wed, Mar 12, 2025 at 08:58:56AM +0100, Gabriele Monaco wrote:
> > On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> > > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > > index 510c88bfabd4..c55d45544a16 100644
> > > --- a/include/rv/da_monitor.h
> > > +++ b/include/rv/da_monitor.h
> > > @@ -16,58 +16,11 @@
> > > =C2=A0#include <linux/bug.h>
> > > =C2=A0#include <linux/sched.h>
> > > =C2=A0
> > > -#ifdef CONFIG_RV_REACTORS
> > > -
> > > -#define DECLARE_RV_REACTING_HELPERS(name,
> > > type)=09=09=09=09=09=09=09\
> > > -static char
> > > REACT_MSG_##name[1024];=09=09=09=09=09=09
> > > =09=09\
> > > -
> > > =09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -static inline char *format_react_msg_##name(type curr_state,
> > > type
> > > event)=09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -=09snprintf(REACT_MSG_##name,
> > > 1024,=09=09=09=09=09=09=09\
> > > -=09=09 "rv: monitor %s does not allow event %s on
> > > state
> > > %s\n",=09=09=09\
> > > -=09=09
> > > #name,=09=09=09=09=09=09=09=09
> > > =09=09\
> > > -=09=09
> > > model_get_event_name_##name(event),=09=09=09=09
> > > =09=09\
> > > -=09=09
> > > model_get_state_name_##name(curr_state));=09=09=09
> > > =09=09\
> > > -=09return
> > > REACT_MSG_##name;=09=09=09=09=09=09
> > > =09=09\
> > > -
> > > }=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > =09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -static void cond_react_##name(char
> > > *msg)=09=09=09=09=09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -=09if
> > > (rv_##name.react)=09=09=09=09=09=09
> > > =09=09=09\
> > > -
> > > =09=09rv_##name.react(msg);=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > }=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > =09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -static bool
> > > rv_reacting_on_##name(void)=09=09=09=09=09
> > > =09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -=09return
> > > rv_reacting_on();=09=09=09=09=09=09
> > > =09=09\
> > > -}
> > > -
> > > -#else /* CONFIG_RV_REACTOR */
> > > -
> > > -#define DECLARE_RV_REACTING_HELPERS(name,
> > > type)=09=09=09=09=09=09=09\
> > > -static inline char *format_react_msg_##name(type curr_state,
> > > type
> > > event)=09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -=09return
> > > NULL;=09=09=09=09=09=09=09=09
> > > =09=09\
> > > -
> > > }=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > =09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -static void cond_react_##name(char
> > > *msg)=09=09=09=09=09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > =09return;=09=09=09=09=09=09
> > > =09=09=09=09=09\
> > > -
> > > }=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -
> > > =09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -static bool
> > > rv_reacting_on_##name(void)=09=09=09=09=09
> > > =09=09=09\
> > > -
> > > {=09=09=09=09=09=09=09=09
> > > =09=09=09=09\
> > > -=09return
> > > 0;=09=09=09=09=09=09=09=09
> > > =09=09\
> > > -}
> > > -#endif
> > > -
> >=20
> > I don't think you need to remove those helper functions, why not
> > just
> > having format_react_msg_ prepare the arguments for react?
>=20
> I'm not sure what you mean. Making format_react_msg_* a macro that is
> preprocessed into arguments? Then make cond_react_*() a variadic
> function,
> so that we can "pass" format_react_msg_* to it?
>=20
> Going that way would also need a vreact() variant, as cond_react_*()
> cannot
> pass on the variadic arguments to react().
>=20
> Instead, is it cleaner to do the below?

Hi Nam,

you're right, I got a bit confused, all I meant was to find a way not
to repeat the arguments for implicit and per-task monitors.
What you propose seems perfect to me.

Also for the sake of simplifying things, a bit like you started, we
could have the reacting_on() check inside cond_react and drop the per-
monitor function. I believe the initial idea was to have a reacting_on
toggle for each monitor but since it isn't the case, we don't really
need it.

Thanks,
Gabriele

>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 510c88bfabd4..e185ebf894a4 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -19,22 +19,14 @@
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0
> =C2=A0#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static char
> REACT_MSG_##name[1024];=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09snprintf(REACT_MSG_##name,
> 1024,=09=09=09=09=09=09=09\
> -=09=09 "rv: monitor %s does not allow event %s on state
> %s\n",=09=09=09\
> -=09=09
> #name,=09=09=09=09=09=09=09=09=09=09\
> -=09=09
> model_get_event_name_##name(event),=09=09=09=09=09=09\
> -=09=09
> model_get_state_name_##name(curr_state));=09=09=09=09=09\
> -=09return
> REACT_MSG_##name;=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static void cond_react_##name(char
> *msg)=09=09=09=09=09=09=09\
> +static void cond_react_##name(type curr_state, type
> event)=09=09=09=09=09\
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (rv_##name.react)=09=09=09=09=09=09=09=09=09\
> -
> =09=09rv_##name.react(msg);=09=09=09=09=09=09=09=09\
> +=09if
> (!rv_##name.react)=09=09=09=09=09=09=09=09=09\
> +=09=09return;=09=09=09=09=09
> =09=09=09=09=09\
> +=09rv_##name.react("rv: monitor %s does not allow event %s on
> state %s\n",=09=09=09\
> +=09=09=09#name,=09=09=09=09=09
> =09=09=09=09\
> +=09=09=09model_get_event_name_##name(event),=09
> =09=09=09=09\
> +=09=09=09model_get_state_name_##name(curr_state));
> =09=09=09=09\
> =C2=A0}=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0static bool
> rv_reacting_on_##name(void)=09=09=09=09=09=09=09=09\
> @@ -45,12 +37,7 @@ static bool
> rv_reacting_on_##name(void)=09=09=09=09=09=09=09=09\
> =C2=A0#else /* CONFIG_RV_REACTOR */
> =C2=A0
> =C2=A0#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09return
> NULL;=09=09=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static void cond_react_##name(char
> *msg)=09=09=09=09=09=09=09\
> +static void cond_react_##name(type curr_state, type
> event)=09=09=09=09=09\
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09return;=09=09=09=09=09=09
> =09=09=09=09=09\
> =C2=A0}=09=09=09=09=09=09=09=09
> =09=09=09=09\
> @@ -171,7 +158,7 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)=09=09=09=09\
> =C2=A0=09}=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09if
> (rv_reacting_on_##name())=09=09=09=09=09=09=09=09\
> -
> =09=09cond_react_##name(format_react_msg_##name(curr_state, event));=09=
=09=09\
> +=09=09cond_react_##name(curr_state,
> event);=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09trace_error_##name(model_get_state_name_##name(curr_state),
> =09=09=09=09\
> =C2=A0=09=09=09=C2=A0=C2=A0
> model_get_event_name_##name(event));=09=09=09=09=09\
> @@ -203,7 +190,7 @@ static inline bool da_event_##name(struct
> da_monitor *da_mon, struct task_struct
> =C2=A0=09}=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09if
> (rv_reacting_on_##name())=09=09=09=09=09=09=09=09\
> -
> =09=09cond_react_##name(format_react_msg_##name(curr_state, event));=09=
=09=09\
> +=09=09cond_react_##name(curr_state,
> event);=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09trace_error_##name(tsk-
> >pid,=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),=09=09=09=09\
>=20
> Best regards,
> Nam
>=20

