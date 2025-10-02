Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A21A3165
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404652; cv=none; b=hnaFlylsbcKAaYLxwrJHA9n/kArOAMB/l+LW5nYLhEX90zDWr1mmT5qeZdZVslRxOqLjFMiScvUimWWM4yIFooqQLLzY6+VnzloN3ZnGXyTxQifKQEggHxxlSnKaV4o52O2DHr670ClGEB6htr4tH5J75nM4naPDV3pctYafbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404652; c=relaxed/simple;
	bh=vG2+ZptMubD68MvcsbqOeaoxJCqaY9G6AXJT9ec+wjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBjGOdaq/hy+JH6n0Or8k1m/CRgOeMxbHDYHha2J7icWGcL0yXGeygmFHcwsnRTr3J8cByW1daXinYBDX0ktNzuSUrO27z7wvnUzeYoyswN596ns3g+S61ZYiLs+59UdZrbLvD3CgBIXfdOY2DW4Kkd+QMtsxHoou08U4ii0B7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU21bd0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU21bd0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759404644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vG2+ZptMubD68MvcsbqOeaoxJCqaY9G6AXJT9ec+wjM=;
	b=QU21bd0uGWu2ICmBxZiVuZ7zuCD2+cSmx45W3ukoKRNP7l69ez3R1ydBaOP3IDHpwxXfN5
	uHU1Hukm0rWuWxNSuhVjE2WZjVHPaYu5uGej1pc6Nb0FQz7wsd8ixWkfTeqCdQoIVuTkWw
	mmJFFve2KEfdZPGuQ1qeUI6r+BPQPSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-_bV-ZVhCNneLxwOV0CRfnw-1; Thu, 02 Oct 2025 07:30:43 -0400
X-MC-Unique: _bV-ZVhCNneLxwOV0CRfnw-1
X-Mimecast-MFC-AGG-ID: _bV-ZVhCNneLxwOV0CRfnw_1759404642
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42421b15185so1064917f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404640; x=1760009440;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnKlLoouS3JtpeFvZfGtYcXm2a9bedZ8zcilOwZLtg=;
        b=eVtRWKYpboh9qofGh/hq+mEJET7n40UHOe06G+do8mVHWrWRJUHOS7YICiGS9zmscS
         bdbPK0XbRuEDsafxpR0AKMD7uz9DKrMOa34NcBeOEiPvcvFLg38dDw13bHwcCFGHjHrO
         JRmx+p+NtaNGShVbtLaBTmeaJUADrfdOZk7e4WBfPlU7P1YCPzMqhZqKHk6VUpFhnNDb
         zwsj1GIP1CuQr4HCAMSJGUX64vdoKLAMKPH+cF5vHi+jAmXxoe1DjCCIc3Kf+E93Uj88
         WyC0whEJ2ARfbchTgQnLHyePSimG0iOGvE+3V/gBdaGr8fYNkinhFQmBZk8A3/Pf+MEh
         DXzg==
X-Forwarded-Encrypted: i=1; AJvYcCXCczYbvG7VNijkW9tGin8OvMhoW39ge6P5b+52aWpvxCKDeDRJyiP3kyJUU7W1r9DYZqBnfLTvb/thd1Wf/LSko7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXIDbNn/7Y+EhGbxkAkCUOecJuxlu3TcmOPbT8BHh0iJDWnE+
	ws/pP/WWeaSFbVDgB9iB0xgeZVXHj5/JUC7bQFbwCT4i6JACmj7k5nIKd3bS8eOYFZdTZMgC4zl
	ztyMgczXOzip5IfYhbSsgGgpiJInAmNG8jJhm7r6QmnRdo2onSWbDwYoPyeojWBIbfSAVBjuNKA
	==
X-Gm-Gg: ASbGncuowmL96sQ6e3VvK3sg3/QWaoHWqgRsbrHD+V+6EFaBvSVNyukcEh//VpCwA36
	wSgXfvtH5yB3o4g0Xa3922L2xQTSAPvVbajafxMcMs06AsYdNuc+hP7PvIkNfHlLULc2L0gXKQp
	a9qj0OHmKGCgendQTW46WhTQdCRJh9I1L8jqh3Vo98YjEAV9rpMS9rCsNW67i4i0glkxRDDA5JL
	TR1Fr+Usy4FVeC51UO9P4S+WdBdSfVaD1ws/O3WqNBjY5X+jo4+I+WJXP4pZVLcMXtza4Du3MnN
	ptWCqfGEdf6ejgvDzQnqUnuW3x/pL2uBZ8LdeuqVOdg8hQpFLEOyXDEwZ4wPo8zc9KG8MnQ=
X-Received: by 2002:a5d:5849:0:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-425577e4a34mr3854408f8f.8.1759404640422;
        Thu, 02 Oct 2025 04:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg/p/3A3WClXyVi0cI2vseaqGhsWcOe/0Q7yc6NHO0UegG/kY8kVpI8noqmlGXEPJcWATvzQ==
X-Received: by 2002:a5d:5849:0:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-425577e4a34mr3854386f8f.8.1759404639960;
        Thu, 02 Oct 2025 04:30:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm3262416f8f.9.2025.10.02.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:30:39 -0700 (PDT)
Message-ID: <58243003fdba1c06d90576fcfec5096012318a27.camel@redhat.com>
Subject: Re: [PATCH v2 03/20] rv: Unify DA event handling functions across
 monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 02 Oct 2025 13:30:38 +0200
In-Reply-To: <87a5297jij.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-4-gmonaco@redhat.com> <87a5297jij.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: RB8F8H70CCMIXnBgRwgcLk7u7qWiavhn--ghTj1oRRs_1759404642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-02 at 11:14 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +/*
> > + * da_get_task - return the task associated to the monitor
> > + */
> > +static inline struct task_struct *da_get_task(struct da_monitor *da_mo=
n)
> > +{
> > +=09return container_of(da_mon, struct task_struct,
> > rv[task_mon_slot].da_mon);
> > +}
>=20
> This function is not used? Maybe later in the series, let me keep looking=
..

Right, this doesn't belong here, I should add it later..

>=20
> > =C2=A0static inline bool da_handle_start_event(enum events event)
> > =C2=A0{
> > -=09struct da_monitor *da_mon;
> > -
> > =C2=A0=09if (!da_monitor_enabled())
> > =C2=A0=09=09return 0;
>=20
> Can't this part be shared between different monitor types?
>=20
> Same for the other handle functions.

Mmh good point, I left it separate because the per-object monitors (later i=
n the
series) do a bit more before calling the __da_handle_* functions (like some
potential allocation).

But it's probably not a big deal to let them do that in any case, consideri=
ng
da_monitor_enabled() is false only during teardown or with monitoring off, =
and
in neither case a superfluous allocation should cause problems.

Thanks,
Gabriele

