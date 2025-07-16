Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2015B54A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654046; cv=none; b=fBmHey8qTUxhrKt9CZKJkrJ60jsTtyFw7Tzi6axtw5soOAYkiPDfWThUQ0+t7Hb6juBOWdXFP0SaCRHlKLeHljcqC9IVO82mJyEYKcfHNHdSGCmd1o+1QbwsatxHZ2tfG98ZmF8dYNwUjRpJREU1NSqWiyJMJeMc65JXWkglQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654046; c=relaxed/simple;
	bh=23lfkwhvMlpAguc3PjTIcGWLLS0Zeo1BFWz/IatVVAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLZd4WhWh5g/0dAeCjHtUUfUu+B66P/fQydn1yQWU1uJC/MocHQZGpG7aPzum58uWw7zHef59z9dleUvomzJqIPH/onZNcRDh6oRqVu1fRN3dkG+otlPL1H8JI3/eNnngVdHwQfTda/ad+d72oeSIqi7+XYLsQSIYkt6Ig2z0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gtc0ZWWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtc0ZWWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=23lfkwhvMlpAguc3PjTIcGWLLS0Zeo1BFWz/IatVVAU=;
	b=Gtc0ZWWnVKaI8uXhuD9Q6Fq0PYtLVQo1VPqYo5H9/JiKVGFRqPCmCq3AneP9Hy8VwsAn+7
	FY8QnoOfdYANHUzJ60hPddiIFJQLbOpfxE9fUBdSTj7YvbGJSidhIiIQjnmRsnGnv8+xxT
	Us8VIuvzoZWA7i7TFhhNfvdhIpf8R2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-O_L2QWRSOiWN5DvVV6jQJg-1; Wed, 16 Jul 2025 04:20:42 -0400
X-MC-Unique: O_L2QWRSOiWN5DvVV6jQJg-1
X-Mimecast-MFC-AGG-ID: O_L2QWRSOiWN5DvVV6jQJg_1752654042
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561c67daebso2222315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654041; x=1753258841;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1PstcO+u1wqs0BunJ8+c2Z9ZKN5Z+UyDqsIxKyzBg4=;
        b=hQLKk0a6qCZqio1NJl5TmkA5rAYKCY1qfMTz1OCbBzmxMx8Vuxgj9Ne8CICQkKku9t
         O/XEsSc7HpvoLORY99MzVz8u0TZJGR337Ut4lh4W5l77Fr0W/4kAvBthKbyb7Dl6VMsG
         KJ9YFf4VBVaViHFUsGERgAEXuu0g08zsp0YN9heuBjToOUeJYw+pqdl/p4a0X6pXW7PY
         3SJplUuR/mBjDvoOlGp0oMyY1J53y9Vvy3NWLi7N9Tc2Ew/9LJpr8+92e2oqKQHbsI/8
         I5w9RMxbDzVKJGPu0ySmhjSceqoENZuxx0kl2RAypk718mOB83biUwsrCnRctZ1NsUUQ
         jZeg==
X-Forwarded-Encrypted: i=1; AJvYcCV0MtqVBO60nhF3s95wnnQbiIg71E6ssqwqiCktR7FLjnlSmcXf0UpD4sGWukKmVKi81QIYSIJ6f/yREb13Rq7hIxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VFyzy3j/7Jw190NqRqbSyL0ibtGTgZ4tTsXmBt1txRH4jYmv
	nFtnB58GzYP+/qyesNnql3ZtSTcc5XSH/mZjZEHeMdVyV7OV+bLXhVt2QFjo1DkacOmr+eeun0y
	bJhXttOvqGvhEECvNRUmvqoyNnC71EMQf1Q4SVVECFaCj18cXQf7HgAdyZbCgRB/1tby+pDsoKA
	==
X-Gm-Gg: ASbGncuNy4hpB3d9a9rAMmYLe9L4mvB/oiQHp4v+39mP5uImbgbbq+vwYBN8cAKrtY5
	BBQU8Pt9o5QrrOYUP5jUoP79CqbQkj+mtO/A3HvyEucPa0z7+Bgmk4q3f85ixGCIUAbWQXOxbx2
	zYPo1o85Lx0Ms9Zf7wsRKNUjmerWgC/CcLkuwczYUThWwGLhyeaRHS+QmAt1sPWLufbI8jR8jQR
	F1C3aoJ7ObXMiJer45DkaSlU9pDQ9xqST2HfNQN5WnwZNKD6MHzVvJvL8JXoz6PfyxmP0Np3iZV
	z3tl/2V1E+ekMt7GG6w05bap3UaRevQKuNbn2hLxBtxDyWkSxwdoKaL0e6gVLrAbEA==
X-Received: by 2002:a05:600c:4d88:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-45625e8a225mr45136245e9.15.1752654041599;
        Wed, 16 Jul 2025 01:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWkWCHJjMY/myYk22StZdJs0ukLJ/nMqa3agTLjrAQaPWBsJTzFUh42lf3aHQpm/gQUOAuhg==
X-Received: by 2002:a05:600c:4d88:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-45625e8a225mr45136025e9.15.1752654041084;
        Wed, 16 Jul 2025 01:20:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e5780efsm13699155e9.0.2025.07.16.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:20:40 -0700 (PDT)
Message-ID: <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:20:39 +0200
In-Reply-To: <20250715152322.Os4lDq_B@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: lUdDyeNE7q2OZ47UpW61zm4m430-t9TQyl8cMbBGcoM_1752654042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-15 at 17:23 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:28AM +0200, Gabriele Monaco wrote:
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
> > +=09=09if (next_state =3D=3D
> > INVALID_STATE)=09=09=09=09=09=09\
> > +=09=09=09goto
> > out_react;=09=09=09=09=09=09=09=09\
> > +=09=09if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state)))=09=09\
> > +=09=09=09goto
> > out_success;=09=09=09=09=09=09=09\
> > =C2=A0=09}=09=09=09=09=09=09=09
> > =09=09=09=09\
> > +=09/* Special invalid transition if we run out of retries.
> > */=09=09=09=09\
> > +=09curr_state =3D
> > INVALID_STATE;=09=09=09=09=09=09=09=09\
> > =C2=A0=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > +out_react:=09=09=09=09=09=09=09
> > =09=09=09=09\
> > =C2=A0=09cond_react_##name(curr_state,
> > event);=09=09=09=09=09=09=09\
> > =C2=A0=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > =C2=A0=09trace_error_##name(model_get_state_name_##name(curr_state)
> > ,=09=09=09=09\
> > =C2=A0=09=09=09=C2=A0=C2=A0
> > model_get_event_name_##name(event));=09=09=09=09=09\
>=20
> If I understand correctly, if after 3 tries and we still fail to
> change the
> state, we will invoke the reactor and trace_error? Doesn't that cause
> a
> false positive? Because it is not a violation of the model, it is
> just a
> race making us fail to change the state.
>=20

Yes, that's correct.
My rationale was that, at that point, the monitor is likely no longer
in sync, so silently ignoring the situation is not really an option.
In this case, the reaction includes an invalid current state (because
in fact we don't know what the current state is) and tools may be able
to understand that. I know you wouldn't be able to do that in LTL..
By the way, LTL uses multiple statuses, so this lockless approach may
not really work.

I don't see this situation happening often: I only ever observed 2
events able to race, 4 happening at the same time is wild, but of
course cannot be excluded in principle for any possible monitor.
Yet, I have the feeling a monitor where this can happen is not well
designed and RV should point that out.
Do you have ideas of potential monitors where more than 3 events can
race?

Perhaps a full blown reaction is a bit aggressive in this situation, as
the /fault/ may not be necessarily in the monitor.
We could think of a special tracepoint or just printing.

> Same below.
>=20
> Also, I wouldn't use goto unless necessary. Perhaps it is better to
> put the
> code at "out_react:" and "out_success:" into the loop. But that's
> just my
> personal preference, up to you.

That could be done if we do a whole different thing when retries run
out, instead of defaulting to out_react.
I liked to avoid excessive indentation with those goto as well but
yeah, it may not be quite necessary.

I'll have a deeper thought on this.

Thanks,
Gabriele

