Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD931AF01
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596890; cv=none; b=HVS/RYfC0fOqWkbDwdYxPBKH6xzTnQ6cNa6SoJ4+bqoiszi0qUMXy4PN0BYmj1Jtd5CaXQUPuSkyR3sZSdtrCKGzdWdzgxqxQC+cYADYmEblbsK9F9w+tYonecKYZDOxc0Qchevpar7DQXyTNyZUu+PSktFvb3DEqSOYj7oMuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596890; c=relaxed/simple;
	bh=CXAzoakGiyPueEF2zUdlRqJE8rAXji6b4FA6f0pN86s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2babR8VxjWawsdmgkDUZa7//B2xL03cOMyFnbvqz5ojZbIo/WghSS/S/QkE7t5a3VHbkvoZEgdJzPtES3AF3U8/drfE7nkIGi+w/sckRkMO8EvVq+bw8e9UcgDa84K0t4T8WaudJSL1RN90KtLjcwlFVkB/KKm+EyehQQ8qjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWUJBgsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWUJBgsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755596886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KmSQau8XRMXIwy67r15o6A1pXxItimAwCNrRbFws7NY=;
	b=dWUJBgsuklEH/ByP4G28R6EtJmhCJl9aMAAzS8kv1wL5h0n04SMxAuVUS9ulR49JiCAqv8
	x63+DT6mS9XULdhpvu/91dmiGSPHGBj1SZ7F7jeOkwq5Fh/46QGPLLK4vP04EsR1M/fZOk
	dxBeP2OdhkKHsan9xhB1rxWDcQIwuD8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-7pVX6EQHOS2VwJ1YBcG-ig-1; Tue, 19 Aug 2025 05:48:05 -0400
X-MC-Unique: 7pVX6EQHOS2VwJ1YBcG-ig-1
X-Mimecast-MFC-AGG-ID: 7pVX6EQHOS2VwJ1YBcG-ig_1755596884
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61a2d6c0585so2392165a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596884; x=1756201684;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEVzF9oT/1hpvRKnmvG6fiGVxNfk5lnVaqv5Ao7G/uk=;
        b=GgAB7B/39vcrvykyXvZkjvNdjLrhCgprdJH9MnzmEzkB8fUyIF+Hxu7jqzv5d9aZON
         YzABOsEyC0HUH8tmBgQk9LhR9V7e0zAJcJ7gATa68porKiedz957hO0ec7zgKrlcmZoK
         wbimwGer0Hc/w1E5N0K5Gaf/jfMVww7EmqoupTTpDFcCsxlflnhPhawXJUJ48RZCTlOE
         jz3/FewZRdsmSWIJduOFLvgU0QKAEDJnKp3ssqU1LhawpfrCsAXNqP+aV2abksu4Mn1g
         qGvdXc77A4hCygpE0d1WyfZZoZKByvzJbYsdJUEUb86+GLAr2QyP9ipKzhR2INs4+sR7
         0c1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXDrqq4/7HxwtID7kLyEM+VTpCFzzEVQ5ko3OworKl455gO/DdAKXwaVx4NzdLjd3kDWSGEL57uo+fWapLse43tfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzIUy2Ltq/G3nn/Xn66Lw9l1CzkfczyoqXRKR7CMjBAANcsyS
	jezgPoLeeIbULmcbuKEmVTmX58pXTL3IaFh6PMQ0PeDoHcIueBdvjFj7DmkaLyJEgT1NFEccQwj
	frsH89F7oJzLU8WWqdENCxEQXQupr9fAM4fE9UP40YgFF4Z4+WuPCAVpsrs3YRoQOS90mPq4snA
	==
X-Gm-Gg: ASbGncszCmXIH3srFGltg2fxSNcqBOfEI1xsJBnDWJAvH6hI3mQkJ/6YbNQNgdXAyn6
	5E6qaEA6+Lh7KaQlLzQXxCFt+IKFPxoI6Wt/jgC4aGdBUSdtZB00KpMFFj7iH2wihFcdF54Bsq8
	CvalBtfqYpdPbHBSfFLVwsniSfjiqOXng2I1DmNfgzd20vv/44UTqsqqd2bZ4i3UmppftXb9hT3
	seQ3z9UO1qUcUCzTa23lQ0X04/bufdYaRpIAZUmr4mz8kRg8S+l0GJZwpcFFzuPQlwpcyUnYtnv
	AC6jId99iRH1sWCcxxCZCsASM6OjOs2GQHIy5n4/vkH9/bKkh34KeUJy8TqxHa+GEZ2H
X-Received: by 2002:a05:6402:3507:b0:618:229d:7076 with SMTP id 4fb4d7f45d1cf-61a7e6d9d08mr1448292a12.6.1755596884458;
        Tue, 19 Aug 2025 02:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGianlZlTSJvsyDj4NNwcANeQwzhSMO1y9TEJ4ddHKW0W9g+a+n0D6BGlgBabUSWl9iNSdJYw==
X-Received: by 2002:a05:6402:3507:b0:618:229d:7076 with SMTP id 4fb4d7f45d1cf-61a7e6d9d08mr1448268a12.6.1755596884025;
        Tue, 19 Aug 2025 02:48:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778cb0sm1399367a12.27.2025.08.19.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:48:03 -0700 (PDT)
Message-ID: <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,  John
 Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 11:48:01 +0200
In-Reply-To: <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
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
X-Mimecast-MFC-PROC-ID: xhaIcg2hGfWUWZnnG4dpxcxHIfEhT59v37j2a3i6cBc_1755596884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-08-19 at 11:18 +0200, Juri Lelli wrote:
> Hi!
>=20
> On 14/08/25 17:08, Gabriele Monaco wrote:
>=20
> ...
>=20
> > +/*
> > + * ha_monitor_init_env - setup timer and reset all environment
> > + *
> > + * Called from a hook in the DA start functions, it supplies the
> > da_mon
> > + * corresponding to the current ha_mon.
> > + * Not all hybrid automata require the timer, still set it for
> > simplicity.
> > + */
> > +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> > +{
> > +=09struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> > +
> > +=09ha_monitor_reset_all_stored(ha_mon);
> > +=09if (unlikely(!ha_mon->timer.base))
> > +=09=09hrtimer_setup(&ha_mon->timer,
> > ha_monitor_timer_callback,
> > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLOCK_MONOTONIC, HRTIMER_MODE_=
REL);
> > +}
>=20
> ...
>=20
> > +/*
> > + * Helper functions to handle the monitor timer.
> > + * Not all monitors require a timer, in such case the timer will
> > be set up but
> > + * never armed.
> > + * Timers start since the last reset of the supplied env or from
> > now if env is
> > + * not an environment variable. If env was not initialised no
> > timer starts.
> > + * Timers can expire on any CPU unless the monitor is per-cpu,
> > + * where we assume every event occurs on the local CPU.
> > + */
> > +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon,
> > enum envs env,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire)
> > +{
> > +=09int mode =3D HRTIMER_MODE_REL;
> > +=09u64 passed =3D 0;
> > +
> > +=09if (env >=3D 0 && env < ENV_MAX_STORED) {
> > +=09=09if (ha_monitor_env_invalid(ha_mon, env))
> > +=09=09=09return;
> > +=09=09passed =3D ha_get_env(ha_mon, env);
> > +=09}
> > +=09if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
> > +=09=09mode |=3D HRTIMER_MODE_PINNED;
> > +=09hrtimer_start(&ha_mon->timer, ns_to_ktime(expire -
> > passed), mode);
> > +}
>=20
> Also, my only concern with the usage of per-task timers is that
> reprogramming add overhead, so I wonder if this gets noticeable when
> running some kind of performance sensitive workload in production (as
> it was reported for dl-server). Did you test such a case?

That's a good point, I need to check the actual overhead..

One thing to note is that this timer is used only on state constraints,
one could write roughly the same monitor like this:

  +------------------------------------------+
  |                 enqueued                 |
  +------------------------------------------+
    |
    | sched_switch_in;clk < threshold_jiffies
    v

or like this:

  +------------------------------------------+
  |                 enqueued                 |
  |         clk < threshold_jiffies          |
  +------------------------------------------+
    |
    | sched_switch_in
    v

the first won't fail as soon as the threshold passes, but will
eventually fail when the sched_switch_in event occurs. This won't use a
timer at all (well, mostly, some calls are still made to keep the code
general, I could improve that if it matters).

Depending on the monitor, the first option could be a lower overhead
yet valid alternative to the second, if it's guaranteed sched_switch_in
will eventually come and reaction latency isn't an issue.

> Does this also need to be _HARD on RT for the monitor to work?

That might be something we want configurable actually.. I assume the
more aggressive the timer is, the more overhead it will have on the
system.
Some monitors might be fine with a bit of latency.

For example in the deadline case, I believe, the monitor is not
supposed to fix anything, but merely report violations. So we don't
really care to react on time, but to react at all.

I'm going to assess the overhead and see how to offer some more
configurability.

Thanks,
Gabriele

