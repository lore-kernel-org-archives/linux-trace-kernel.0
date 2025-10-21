Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A32DF123
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062096; cv=none; b=sUmNtTadPcduMCLJYcqPJE+I3fQw7ndVMjNRftSFR0aHMRfQAGhqVQiDfMKCtnpzmgroJkfUu2PFE9hT+42lwazZ+D4ApAXKOFCQAkbUu3OfqMRZvX3LM0nOSwZY6/edBM44KuhKvU4AqMEibR6OjGKCcrZjEtfb7SwjmfYrhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062096; c=relaxed/simple;
	bh=KJ/pfMx3qXdVsVcloZNfkQKmFrIgt4xIyNBdn4ZsLjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhDT5vF8q/TnxF/z5uq+WqCBs6U84/SDVoYhRz5N9GwTaIOyFLQaPUUZs7Vyjrh1jCW6baBh5MMa/hLvIcEKWb+SDCggdQ0rkEaqNLAwKOfZOz9dPQ/H5jAbN5GtOJk2rL2EZddTB0gAEaK2DWmw9e8N4xPD4clQPbghpBfa1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAerbMOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAerbMOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KJ/pfMx3qXdVsVcloZNfkQKmFrIgt4xIyNBdn4ZsLjA=;
	b=fAerbMOLXRO6xkHLy8octqJoTNYflfBuE6605a0Ln6KkGrJaaLYqal6s/6L0Pb0DcAQIeq
	5IKr+iazp7YKMHUVlNY6ZgSQipa3McBg0N1v3E5G8g5II12rid4309wztzIoIe+3WZWXTH
	MM5atIOxCVYKL1mo6rW8BxUxW6sWCwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-_vLn_t4VMjyFD1tTVQ05SQ-1; Tue, 21 Oct 2025 11:54:52 -0400
X-MC-Unique: _vLn_t4VMjyFD1tTVQ05SQ-1
X-Mimecast-MFC-AGG-ID: _vLn_t4VMjyFD1tTVQ05SQ_1761062091
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so62896735e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062091; x=1761666891;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KICcCCzwh6CAD3LYQzTxrECTgISFOrla0fpaF0z/dPc=;
        b=jXdGCsvUTm/azzgxgh7P9Re7IFDHBtsAaO2rF7rqRIg8qIdy+yy7+NYST9nF/L06Sc
         35yCsiDsXJo4Nhx0YYwIPXp7X21x8e6P/x+xcXDaYd09YnFFUko5S0gijDTlT3sJXK2E
         2J7xeGKU02raSwRbqUppNubwLdhO1C5clGnlpuiepfMcEuuRO8RlHpIV5OjZRtsWJV8G
         /UFibgDDGnzX5OdbWfxdqhdUI/iCVlqfjRsEZ3z4X7Uhzt47od7zFUYZcIFsv3F100zA
         o1vO6rUKi55wfVkzcgDSbaLe9Uy/tzkquAEGl/3Sx6Rxdi3ZWmi3ZlyWl4aI9gWf/AxI
         hnLg==
X-Forwarded-Encrypted: i=1; AJvYcCXLyi8k0mebsTxhc7qikQiu31nUZa8E651YAs1OIzSnBuZEefFLaxFBgJuvqCMoi9LK5z/AxaB/yXkyZE2Q7D9dVMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2iQngtuxWm8yxDIhGErIkql2ZfZdlEzAFGNlV2EUDbrbIyWt
	Oc3m4BilfCcOYzxeM3ZmIIgKltUkr8uAiVXdyICw7saRz7rOE+wP+fwOIDmEFbx0rUJ6phtVXi1
	ASC/MsgjlucuKnCre1SX/AFcqEmn9hR8MRnr8Iagtwa4TKLqhKKbLQuPz6PEHLaOmlOnn021qAA
	==
X-Gm-Gg: ASbGncsWqWrdCXjcqXP2gu0QvOsUHpb7xndnFK82+0ZzQD3zWhg1LoyngAKTSzA0X89
	NgE7NFJZZKPRuyCpOSio46iVnIyRW6DzILhn9kzI0Bn8XJGEw4fr0noQncEksNTtwDl96nq6n/c
	Rb3RnQU0OykXoSjOLHrdsEBiBH00JZ2iaE8LSd5fNY6pjdJDwhLRqZpZtWHTPBn4SF43d5zugku
	7hgiUXvz9qXPKoSJwJ0Wt68DRZRMnTmbJtwqVW9rNBzdBNGqpzt68gttDOL4bChZTsf6LZdAVq+
	TUhkOBGGS6KP88G8lZUZ9+nM1chXHjQd9LTpw0zuXPRa7c9YmfdBD0zjIFOQvQ6KSC8GDavoG4R
	xfP+VdE8GxBUC6ZuBeI0FeCXj
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr121691105e9.17.1761062090903;
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8lxM/JFIrZe0gCiI3+DDDOAAYMMzRvDvH3Q6BMXVzzLrqfeZc4/96Yrfb6Kg7hAmNU9XU/w==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr121690965e9.17.1761062090495;
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm18092205e9.14.2025.10.21.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
Message-ID: <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in
 DA/HA
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 21 Oct 2025 17:54:48 +0200
In-Reply-To: <87plag1nb6.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-19-gmonaco@redhat.com> <87plag1nb6.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wS_q6HClKjf6f64Oj4leokyWM-VDmUs9WSJILP6SBp0_1761062091
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-21 at 13:55 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +static inline struct da_monitor *da_create_storage(da_id_type id,
> > +=09=09=09=09=09=09=C2=A0=C2=A0 monitor_target target,
> > +=09=09=09=09=09=09=C2=A0=C2=A0 struct da_monitor
> > *da_mon,
> > +=09=09=09=09=09=09=C2=A0=C2=A0 gfp_t flags)
> > +{
> > +=09struct da_monitor_storage *mon_storage;
> > +
> > +=09if (da_mon)
> > +=09=09return da_mon;
>=20
> I think this 'if' should be moved to da_create_conditional() instead,
> because the "conditional" part should be implemented in the function
> whose name includes "conditional". I think that would make the code
> easier to follow, because one would already have a good guess what the
> function does without looking into the details.

I get this is confusing and poorly documented, also the _conditional functi=
on is
not more conditional than the other, so I'd really need to rethink the name=
 (if
it really needs to stay).

The main purpose of the functions under da_monitor_start_hook is to return =
a
(possibly new) storage, it's perfectly possible, even likely, that the da_m=
on is
not null, in such case we don't do any further allocation.

Ignoring the vagueness of the name, the two implementations of this hook ar=
e to
call an allocation (yes, always conditionally) or just assign the target to=
 a
pre-allocated storage.
Your suggestion of da_monitor_prepare_storage might fit both descriptions.

In fact, having something like kmalloc_nolock (if it works as I expect it w=
ould)
might save this gymnastics as we may not even care about pre-allocating, I'=
m
going to try it out and perhaps re-think this entire mess.

> > +static inline bool da_handle_start_event(da_id_type id, monitor_target
> > target,
> > +=09=09=09=09=09 enum events event)
> > +{
> > +=09struct da_monitor *da_mon;
> > +
> > +=09if (!da_monitor_enabled())
> > +=09=09return 0;
> > +=09guard(rcu)();
> > +=09da_mon =3D da_get_monitor(id, target);
> > +=09da_mon =3D da_monitor_start_hook(id, target, da_mon);
>=20
> Do you plan this da_monitor_start_hook() macro to do anything other than
> storage preparation? If not, perhaps it is better to name it
> da_monitor_prepare_storage() or something like that, so that this is
> easier to follow.

That's a good point, this appears already only in per-object code, the gene=
ral
name is really just pointless.

Thanks,
Gabriele

