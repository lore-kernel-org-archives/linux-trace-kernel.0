Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C138737E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301162; cv=none; b=NJuawub1UpEWO2FM1ynnV27OnEenTCasd1Jgy1rDBzwcFL8Mdi/wYOY5OQoD1+mrpkTpvIl29PZr/GOz3M35ffGr0kVXqVBRJG639p5Dv3hTeW0sWBYi6LfnT3ld3Jz34iBlRzdgHSYqT5A99D1+3jjXvzn2ZHdsTM+9mqagwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301162; c=relaxed/simple;
	bh=btHkg466wq7R+WyRam2SaMTgDYtmcd+FjQmXbkl5HmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GI43an99890wA8QkzLE8owyHX82oXPmtsggP9gS+rxX3pxugtNdyfaDTGfyCQESiEMgyBDqBMsYc+dYpkutsna8ULphsVlzpF4VHuKtpxZHtP23bVEV57ZoOV3c2ksWlzXW0fOfheiMvLTceFOb2S6NzQbMuQ0TRKsdo+/EufdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+r6M6vr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+r6M6vr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780301160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btHkg466wq7R+WyRam2SaMTgDYtmcd+FjQmXbkl5HmI=;
	b=D+r6M6vrdIPD+s9NDYjwT5vQyObNcR6Q2YxCpSzJ4Yg5dVic7fSq558PHdjupegY0ZUDry
	WVnxtbVr3zbGoxOQRG9pHkFLaAMUd6oUOUpizIr/o/6LujouHtaA/CWjWCIrHeEbmDkdkH
	IKSZ03Z6dkijk0Oxe0lg2jdOA3x6Bxc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-oebR_l7lOp2G7s_C62iaFQ-1; Mon, 01 Jun 2026 04:05:57 -0400
X-MC-Unique: oebR_l7lOp2G7s_C62iaFQ-1
X-Mimecast-MFC-AGG-ID: oebR_l7lOp2G7s_C62iaFQ_1780301155
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aa63daf2a6so1151579e87.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 01:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301155; x=1780905955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/RZ7wJj9UMIWugVWJxqvoVLjTFNGaBYPTyCaZ96To0=;
        b=XfchcasSThrhc1uKtAdVpwZZuVTUS9hJzPfK4imp3B+rPhgTtBQxMFSqILCx/2HUAw
         YsOlSSjKyGmIx+dnlvjcD12W+n+yIbTnDRFqGI+Dk9keOHsSLncjqsNmwvMK6QxOHX2u
         R6kUEqmCMpEmFRybH+lX4VnpXVNdXN7ktARynVA+V6j98SfAAioirIHQlubaLDQx/dna
         57hig9Zqi+XGTCC8LCgwVD8LgT9cfit2r4hGJ3dnafVlWPbem/r6I0dx8yS/3GJFakMx
         h43w/NOg0P6hAgTrHPu6aLB6athrV+D72sTmdnJFnEhg9FAGmCnZmRw/Kh9bPgLN01px
         HGOw==
X-Forwarded-Encrypted: i=1; AFNElJ/v9vRVfWhllty3PcXs3c9emlhN42YqWRzYpsvatFPANlzNgQ3yjliNcN083pEULe8Eo57jo5rT0qITIFk+jzaInDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIVnlSoAz7scNL82H6CXXr0R+jJPimQcV2/ne8Q1oeXzwHTqs
	NwklCaoZPBeyY5UIArslnlVfe30C5e+YhPtjxrWU3iUfbk7x0dsSXH1D55Gi00fbGJRoxVuA0jX
	PQiegYyBASAXBGihNY5k1nSlRtw5AXI08PwHR2hLDHwmuNgZVPgYMpKGZfoE/sgogY7W+kYA/jw
	==
X-Gm-Gg: Acq92OELUOykyq0urCouoivHmcBGIlBtoplhuQ7C4JgoYgJimGauD+uC3UwYycJKIiL
	qE7qXxAjjUpdvubSbmehpjwBeorFQfsaDNSXbIffjS6t/LcKI6Mu64VLjDeWMTHGk+S70ReEQ7Q
	tcmpUhSTEX//bTwi25w5r73q2y1kKUg5A0DGwO3dP/UUnRIUFFyuDB10xPbR6ve0XvzJg9xeB7U
	bTk+ZMBV5nDc0+Kf+VvkVg9zPu/6v3HZpqvizLR5cnGGKDhZ4TZrHcuT5uZYIrdWuts3hhUy58V
	0XunJpOKtcbcAvDIAaHF/MhQOpnXbiTihRiPQRqPN9hAM56qzaxl8IAxz0tqyoX1hPm+Ln83owq
	hiV3Z60dTLyvZOexKI1Mg9/6uriIIMJfJOIwB
X-Received: by 2002:a05:6512:3c9a:b0:5aa:6869:2bec with SMTP id 2adb3069b0e04-5aa68692d92mr1654219e87.27.1780301155088;
        Mon, 01 Jun 2026 01:05:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3c9a:b0:5aa:6869:2bec with SMTP id 2adb3069b0e04-5aa68692d92mr1654194e87.27.1780301154557;
        Mon, 01 Jun 2026 01:05:54 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c50f6sm26121629f8f.16.2026.06.01.01.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:05:54 -0700 (PDT)
Message-ID: <53a0e047a12186b4b9b2c7e4c6715842b7c3bcb7.camel@redhat.com>
Subject: Re: [PATCH v3 08/13] rv: Ensure synchronous cleanup for HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 10:05:52 +0200
In-Reply-To: <874ijmy9xj.fsf@yellow.woof>
References: <20260530141652.58084-1-gmonaco@redhat.com>
	 <20260530141652.58084-9-gmonaco@redhat.com> <874ijmy9xj.fsf@yellow.woof>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vhuqrxzwWQmOst80b8NLaujTkBuaz-Ge26l2nN3rR4E_1780301155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 09:52 +0200, Nam Cao wrote:
> > +/*
> > + * __ha_monitor_timer_callback - generic callback representation
> > + *
> > + * This callback runs in an RCU read-side critical section to
> > allow the
> > + * destruction sequence to easily synchronize_rcu() with all
> > pending timers
> > + * after asynchronously disabling them. The ha_mon_destroying
> > check ensures
> > + * any callback entering the RCU section after synchronize_rcu()
> > completes
> > + * will see the flag and bail out immediately.
> > + */
> > =C2=A0static inline void __ha_monitor_timer_callback(struct ha_monitor
> > *ha_mon)
> > =C2=A0{
> > -=09enum states curr_state =3D READ_ONCE(ha_mon-
> > >da_mon.curr_state);
> > =C2=A0=09DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
> > -=09u64 time_ns =3D ha_get_ns();
> > -
> > +=09enum states curr_state;
> > +=09u64 time_ns;
> > +
> > +=09guard(rcu)();
> > +=09if (unlikely(READ_ONCE(ha_mon_destroying)))
>=20
> Instead of this global variable, can we instead use da_mon-
> >monitoring?
>=20

We already do in da_monitor_handling_event(), this is guarding for the
very unlikely scenario of:

1. timer callback firing (just before guard(rcu))
2. sync rcu, return before waiting for that one
3. reset and free memory
4. guard(rcu) now and check the state in da_mon (freed)

I'm not too confident saying this cannot happen under PREEMPT_RT.

I know the easy alternative would be to synchronously stop timers on
destruction, but that gets complicated with per-task monitors, where we
iterate over task grabbing a read lock.

Am I just too paranoid?

Thanks,
Gabriele

> > +=09=09return;
> > +=09/* Ensure consistent curr_state if we race with
> > da_monitor_reset */
> > +=09curr_state =3D smp_load_acquire(&ha_mon->da_mon.curr_state);
> > +=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> > +=09=09return;
> > +
> > +=09time_ns =3D ha_get_ns();
> > =C2=A0=09ha_get_env_string(&env_string, ha_mon, time_ns);
> > =C2=A0=09ha_react(curr_state, EVENT_NONE, env_string.buffer);
> > =C2=A0=09ha_trace_error_env(ha_mon,
> > model_get_state_name(curr_state),
> > --=20
> > 2.54.0

