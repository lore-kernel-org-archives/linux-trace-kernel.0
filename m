Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9716289801
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471024; cv=none; b=Bw3WMHyZ5prSne+Tp85JZxwghnvP0x9H5xplUt5ti3j5XxwnqQV6EQA8IUeKwwYvWZaapv5nxtuwqp5f1SssJXMKYgQO+QpO7YgmBkpVdCG8vDVegxe+rbSCQVchANHMI38Wi65spDZhN0LrLXp+/FfyaXccTy0U+BOONK687xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471024; c=relaxed/simple;
	bh=4o0G2/aZCXPexbcTMqVzQwMlCItr3SEb7x1kIGXPAMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Acz85fkFqn4RYCe7OAtagAeCMf+Z4zziUDk7ExOWS8FjPitU9YjUp9RSK6mW412Spn35djeWOZE5DerkGN8VdHeJgC2dS2C8yzg+UYPvweCyGLpgB7n4+BwAsRl6oZ3aedf6kS2/KdS/Meh+iqWUp45b3RjIVfgdF803smq5sYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1ISVm5j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1ISVm5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754471021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4o0G2/aZCXPexbcTMqVzQwMlCItr3SEb7x1kIGXPAMI=;
	b=i1ISVm5jx+xmYoEkxr11U+7Y0KPyx7oxrmftyZ4mtJ9tY/QiK/qAPt9Ah8NR0dQaUlHNsw
	FL0H1ZkhSNy9Fsk1mH8ATEKk5WjCWWWkzCl9U3ceMSpn6fdcFXmUG6nwf8SU2uVF12nywh
	Jzi1oO82WLqyuSQZnIY9WbjSiaTB7Uc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-jf8v8H6JNtGsCyAvPX7zMQ-1; Wed, 06 Aug 2025 05:03:40 -0400
X-MC-Unique: jf8v8H6JNtGsCyAvPX7zMQ-1
X-Mimecast-MFC-AGG-ID: jf8v8H6JNtGsCyAvPX7zMQ_1754471019
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e068b5f4so13131975e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471019; x=1755075819;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMDXUrjjN+aZKpyGySOUHat2GCW28hndsnEnwF8ahyQ=;
        b=wf4JK3FKvqOlJbKgINWQdI2htfH5+TaOOLZnFt/KeDRIBbnbvkACMvV0954k6uwJTa
         i0F0NO2/BKQrdkKe7fipS5zIqaYV1yCbp/1+elRa4ytkuXYtC7hBSVgQG4dJct+TYwAq
         AjeWDWhIekUDBalV5UMt6g8tCDg0xAFA9Ap9HTlwaMujMqqlbqaaelcBCe9CF4NGyf5K
         r9WQps8QqFMAyDIc4B99o8ANT+RIHEhjBWm67T6Sh3Fy7bmddPu7jQeOMNx6Wa6B6aWH
         IuJqkt/7G9IpSOTnmbIUe9Wv/Or0HexzecU7fUDVkEuEJhpgRoZmXbAEvxc3jHXHw5BM
         pb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZz6yEMchN8HHBF2IIHGr9hxQgT2V6ogAog9vPMlBTb09LG/wVHEwlf0XVEwLydwdufmmGDRWfwxEn155fi7PlTUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmkUlSvYri8WSQpqdHOxRfAuA3Te6rlKuupxletkcRG3Zq9LAL
	+OY2dw9CrcxKKooZRxtXDH+emmIOUWxbb29jAFCjnXJUFOjEKBon0YzV9Oje+uU/zIAm3DN3lCr
	0mnH+Y9pnDEVA5pFOd0h+lHyGQAcIL+WJqm0oD1Ih9FfucdWZXZ1LoXQQr0qdRv4fKPtTN5JMEA
	==
X-Gm-Gg: ASbGnctAVK3n8rut+70wHkFqxxhazEsuP6n+ATN05cIyEwRedvMArM0vDEpXrdviPCs
	woReN72f6jlkqfo9NziT0UZOlC3j+erfZYPKtzE8hWhTFOkOTZSeYG4VxLCjvSaBcJtYvapg4ag
	EMYY/FvdyP53nvaApyLWBhCmlPqW0qs8XXmlr8YhVvmIc62mTAF6uGcxjzzxBntbo9aWa2JfD9k
	yOF7w3vBpJLFD/xWsEOJJHll+MfWiSwPj4VzxHPzbhZCc/UhuFJ+l6KHHQNxXXtc3ZbumSF1h/I
	/3v4qchFBk/+V4gHXpzQrFzeMZrU3IYpq75TC8THvcn5R+VtLV/dcHfZlR2c3tI1dw==
X-Received: by 2002:a05:600c:6385:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459e7986998mr14094895e9.24.1754471018868;
        Wed, 06 Aug 2025 02:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsR15hGMt2SbNwIIjv8tKFBBB1MMpXxOBBDG4UoeKhaGX982p4+SKVaQGIl+pz6m7LfaM2LQ==
X-Received: by 2002:a05:600c:6385:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459e7986998mr14094415e9.24.1754471018394;
        Wed, 06 Aug 2025 02:03:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dd85f423sm99624645e9.18.2025.08.06.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:03:38 -0700 (PDT)
Message-ID: <d57a23823996439d5f07150be211f8bf27a0f70e.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 11:03:36 +0200
In-Reply-To: <20250806084652.3TFe1T1W@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
	 <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
	 <20250805122215.hXbwUchz@linutronix.de>
	 <20250805154515.CchJtec3@linutronix.de>
	 <1ddbe4c89a12c6282fa6db19c4649b90ab2fcf9d.camel@redhat.com>
	 <20250806084652.3TFe1T1W@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 6hdoQlOr0EorHnXTyFoWXkSL0v7ovCb7yWljPWaWMx8_1754471019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-06 at 10:46 +0200, Nam Cao wrote:
> On Wed, Aug 06, 2025 at 10:15:48AM +0200, Gabriele Monaco wrote:
> > I didn't make it on time before your V2, I assume you solved
> > already so
> > you might ignore this.
> >=20
> > You kinda have something like the da_monitor_enabled: the
> > rv_ltl_all_atoms_known
> >=20
> > I wonder if you could define LTL_RT_TASK_ENQUEUED only when you
> > actually know it (or are reasonably sure based on your internal
> > counter). Or at least not set all atoms until the monitor is fully
> > set
> > up.
>=20
> The rv_ltl_all_atoms_known() thingy is for situation where relevant
> tracepoints have not been hit yet.
>=20
> This case is slightly different, the tracepoint has been hit. And it
> is not clear how to implement the "reasonably sure based on your
> internal counter" part.
>=20
> > Anyway reordering the tracepoints registration is likely necessary
> > whatever you do, but I'm afraid a problem like this can occur
> > pretty
> > often with this type of monitors.
>=20
> What I have in v2 is a workaround only, by reordering the tracepoint
> registrations.
>=20
> The root problem is not specific to this monitor, but all LTL
> monitors. My idea for the real fix is the untested patch below. I
> will send it separately. It is not urgent, so I can wait for your DA
> macro removal patch to be merged first.
>=20

Alright, I get it, let's continue with the workaround for now, I'm
going to have a look at your V2.

Thanks,
Gabriele

> As I'm sending the patch to you, I realized that the patch
> effectively nullifies ltl_atoms_init(). So I will need to fix that
> up..
>=20
> Nam
>=20
> commit 7fbb9a99f1a95e5149d476fa3d83a60be1a9a579
> Author: Nam Cao <namcao@linutronix.de>
> Date:=C2=A0=C2=A0 Tue Aug 5 22:47:49 2025 +0200
>=20
> =C2=A0=C2=A0=C2=A0 rv: Share the da_monitor_enabled_##name() function wit=
h LTL
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 The LTL monitors also need the functionality that
> =C2=A0=C2=A0=C2=A0 da_monitor_enabled_##name() offers.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 This is useful to prevent the automaton from being exe=
cuted
> before the
> =C2=A0=C2=A0=C2=A0 monitor is completely enabled, preventing the situatio=
n where the
> =C2=A0=C2=A0=C2=A0 monitors run before all tracepoints are registered. Th=
is
> situation can
> =C2=A0=C2=A0=C2=A0 cause a false positive error, because the monitors do =
not see
> some
> =C2=A0=C2=A0=C2=A0 events and do not validate properly.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Pull da_monitor_enabled_##name() to be in the common h=
eader, and
> use
> =C2=A0=C2=A0=C2=A0 it for both LTL and DA.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Nam Cao <namcao@linutronix.de>
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 1aa01d98e390..8a885b3665a8 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -119,6 +119,14 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent);
> =C2=A0int rv_get_task_monitor_slot(void);
> =C2=A0void rv_put_task_monitor_slot(int slot);
> =C2=A0
> +static inline bool rv_monitor_enabled(struct rv_monitor *monitor)
> +{
> +=09if (unlikely(!rv_monitoring_on()))
> +=09=09return 0;
> +
> +=09return likely(monitor->enabled);
> +}
> +
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0bool rv_reacting_on(void);
> =C2=A0int rv_unregister_reactor(struct rv_reactor *reactor);
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 17fa4f6e5ea6..92b8a8c0b9b7 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -74,29 +74,12 @@ static inline bool da_monitoring_##name(struct
> da_monitor *da_mon)=09=09=09=09\
> =C2=A0=09return da_mon-
> >monitoring;=09=09=09=09=09=09=09=09\
> =C2=A0}=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -
> /*=09=09=09=09=09=09=09=09=09=09=09=09\
> - * da_monitor_enabled_##name - checks if the monitor is
> enabled=09=09=09=09=09\
> -
> */=09=09=09=09=09=09=09=09=09=09=09=09\
> -static inline bool
> da_monitor_enabled_##name(void)=09=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09/* global switch
> */=09=09=09=09=09=09=09=09=09\
> -=09if
> (unlikely(!rv_monitoring_on()))=09=09=09=09=09=09=09\
> -=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -=09/* monitor enabled
> */=09=09=09=09=09=09=09=09=09\
> -=09if
> (unlikely(!rv_##name.enabled))=09=09=09=09=09=09=09\
> -=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -=09return
> 1;=09=09=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> =C2=A0/*=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0 * da_monitor_handling_event_##name - checks if the monitor is read=
y
> to handle events=09=09\
> =C2=A0
> */=09=09=09=09=09=09=09=09=09=09=09=09\
> =C2=A0static inline bool da_monitor_handling_event_##name(struct
> da_monitor *da_mon)=09=09=09\
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -=09if
> (!da_monitor_enabled_##name())=09=09=09=09=09=09=09\
> +=09if
> (!rv_monitor_enabled(&rv_##name))=09=09=09=09=09=09=09\
> =C2=A0=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09/* monitor is actually monitoring
> */=09=09=09=09=09=09=09\
> @@ -390,7 +373,7 @@ static inline bool
> da_handle_start_event_##name(enum events_##name
> event)=09=09=09\
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09struct da_monitor
> *da_mon;=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (!da_monitor_enabled_##name())=09=09=09=09=09=09=09\
> +=09if
> (!rv_monitor_enabled(&rv_##name))=09=09=09=09=09=09=09\
> =C2=A0=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09da_mon =3D
> da_get_monitor_##name();=09=09=09=09=09=09=09\
> @@ -415,7 +398,7 @@ static inline bool
> da_handle_start_run_event_##name(enum events_##name event)
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09struct da_monitor
> *da_mon;=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (!da_monitor_enabled_##name())=09=09=09=09=09=09=09\
> +=09if
> (!rv_monitor_enabled(&rv_##name))=09=09=09=09\
> =C2=A0=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09da_mon =3D
> da_get_monitor_##name();=09=09=09=09=09=09=09\
> @@ -475,7 +458,7 @@ da_handle_start_event_##name(struct task_struct
> *tsk, enum events_##name event)
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09struct da_monitor
> *da_mon;=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (!da_monitor_enabled_##name())=09=09=09=09=09=09=09\
> +=09if
> (!rv_monitor_enabled(&rv_##name))=09=09=09=09=09=09=09\
> =C2=A0=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09da_mon =3D
> da_get_monitor_##name(tsk);=09=09=09=09=09=09=09\
> @@ -501,7 +484,7 @@ da_handle_start_run_event_##name(struct
> task_struct *tsk, enum events_##name eve
> =C2=A0{=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09struct da_monitor
> *da_mon;=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (!da_monitor_enabled_##name())=09=09=09=09=09=09=09\
> +=09if
> (!rv_monitor_enabled(&rv_##name))=09=09=09=09=09=09=09\
> =C2=A0=09=09return
> 0;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09da_mon =3D
> da_get_monitor_##name(tsk);=09=09=09=09=09=09=09\
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 29bbf86d1a52..85a3d07a0303 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -16,6 +16,8 @@
> =C2=A0#error "Please include $(MODEL_NAME).h generated by rvgen"
> =C2=A0#endif
> =C2=A0
> +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> +
> =C2=A0#if LTL_MONITOR_TYPE =3D=3D LTL_TASK_MONITOR
> =C2=A0
> =C2=A0#define TARGET_PRINT_FORMAT "%s[%d]"
> @@ -33,7 +35,6 @@ typedef unsigned int monitor_target;
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> -#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> =C2=A0static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0
> =C2=A0static struct ltl_monitor *ltl_get_monitor(monitor_target target);
> @@ -156,6 +157,9 @@ static void ltl_attempt_start(monitor_target
> target, struct ltl_monitor *mon)
> =C2=A0
> =C2=A0static inline void ltl_atom_set(struct ltl_monitor *mon, enum
> ltl_atom atom, bool value)
> =C2=A0{
> +=09if (!rv_monitor_enabled(&RV_MONITOR_NAME))
> +=09=09return;
> +
> =C2=A0=09__clear_bit(atom, mon->unknown_atoms);
> =C2=A0=09if (value)
> =C2=A0=09=09__set_bit(atom, mon->atoms);

