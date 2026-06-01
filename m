Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E03438AA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298115; cv=none; b=ljVy3q/9fIp548DzA5Iz5EQ2OFwutDPQRjNqZYA1d5sCX7xX204yULP/7ntR/gOhAZksSrObojiawgZj8UMVDgddQHFY5gLg0IurN6oQMqNUA+3/tovFIkmYQ22VSykyiGb8mT3dt4AnG+fcQQrWnwGZIiOlFiwpGMftwMa6nQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298115; c=relaxed/simple;
	bh=gmQQKOraI2EwUQMDYLYdJ6yuA8oGW4RaHYhLKR2xQLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwW5o8YtIgsGqS+tLeYJlQjObPylV5S6xK1jqgD75gj57gGpJSuHEfq4cFmP/rQ6eh2Hie5HXwQDsHbPdV2ZhZwvTJOIRnkfH2nhT7+OL9Sv1Eot0mj2wxmP+ZM193inXG8xvZAhgNqkQfc4eDtEMaEoUW1okWvMaB/YEUIoRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIadnW7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIadnW7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780298113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmQQKOraI2EwUQMDYLYdJ6yuA8oGW4RaHYhLKR2xQLA=;
	b=PIadnW7QpvGrL1UB2HNwgOz059i4XBYHW2nV6KB6jAAPVzOG9Ld1jfl7QOrLapXmDv+mIE
	zZDMSr9H2v2tHaPCJYmXSX94Nr0s3weelAM+D5di+j0NbWINAzYuThT9JYSn1ivAf8Oatq
	UKB47nUGnZ5kxXMioIwGvBhiPpv4/NA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-L2QQze8pOa6vsenL3xhwqA-1; Mon, 01 Jun 2026 03:15:10 -0400
X-MC-Unique: L2QQze8pOa6vsenL3xhwqA-1
X-Mimecast-MFC-AGG-ID: L2QQze8pOa6vsenL3xhwqA_1780298109
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46011aa5000so291957f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 00:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780298109; x=1780902909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fvBsMVKeDZrNyh5hX3nwapbF4YMBNws5zjlgVw0ARU=;
        b=TE3j91FE6UF2Ec0hnoW833F1NxpydJzybx7pyQkNfN4QAwrRQZI3xfiRLWDvPqrp+K
         QIZOeblhvePkRwUYdjBMRepZZffR89mCeKq2MRCPuknFQh/FjpLV/iuepWs1U5BFFC0X
         8lE89Od9YgWHXb1kF+zhyTLrYiHZ135K2jSfVjSG5Vxor11dRLkh+LD/kMqepznWxukK
         5WViy9Ugg6mStM6I0f82AKnEfUu2cCyyral+bET56tmfJFtW9U8rAEHTldobddpV+2rk
         QKk2H5pqE0Gd5ehAU+orw4H2obFCSD0YLtbEwAygp4fFeRZSHxc7ItxWF32jvK+lgAcb
         TSuA==
X-Forwarded-Encrypted: i=1; AFNElJ9cARKNFaFk+JSIEj5tSSNyt32tE/Z2c68Rwek8T/F6520Wqyv1VHV433MiN+nG3OTofp6puKsxjV2s5gmaTSn3ZPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCty7qnbtdd7ucVS31ARdvmGad6nfZH879d8ZEH2JpOwnYFKft
	ErjkO5Ago/rcHntvjA4RFKR2C+CSdor23V0E+/zP5bNG34JATiNenEbFKrUFPK9ssiCK7T1MUAH
	Yy/fOVhYXygy1A7b/bdF/7avSY2LzpEx5m+/AqB/g65m5AkFAufR9gahxB2VZhi+BCLyht5PG1A
	==
X-Gm-Gg: Acq92OEw/U8VkmPppUbIbwE3jfQ73fyLEN2ozPJlO8RonuMMPM3ayIPw/CkuK+iAW8A
	ZGgEqnn7ZiQ1m0BRyoxLuOCdO4OhmGlwKmK4fVpAR/DuG1kBOj8KwIqCmS5FYjSHSeOnyugTaDE
	iaqjd3QduY44/RP2gauq+1wNoYbqvIuS18rqAr0lNwOhyQ25Od9aTrX1AhShM2vOZT1TlbDner9
	yeii4RRYB7erl5wL1t6MtJMyoznMFWHLaNS0hM4hjyUqIROKP1pWlfPRhhCQHqF6FrC2awUSW36
	uSP4RqRVLb0HOrao4AGHZYzLuAjzMYJ6tjuplLeVDUs8CEfK7zScyt3BDAo5/foB57z2T4wX09+
	G1nIlmmhhwaNbLT/LPtv21WVIOlRQDk5PBC1+
X-Received: by 2002:a05:6000:2812:b0:45e:73b3:4515 with SMTP id ffacd0b85a97d-45ef6b8c2e1mr13618010f8f.35.1780298109095;
        Mon, 01 Jun 2026 00:15:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2812:b0:45e:73b3:4515 with SMTP id ffacd0b85a97d-45ef6b8c2e1mr13617975f8f.35.1780298108710;
        Mon, 01 Jun 2026 00:15:08 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm28983761f8f.32.2026.06.01.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:15:08 -0700 (PDT)
Message-ID: <76628c68336037b0d652456cf2033d3b51399a09.camel@redhat.com>
Subject: Re: [PATCH v3 05/13] rv: Fix monitor start ordering and memory
 ordering for monitoring flag
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 09:15:06 +0200
In-Reply-To: <87ik82ycl3.fsf@yellow.woof>
References: <20260530141652.58084-1-gmonaco@redhat.com>
	 <20260530141652.58084-6-gmonaco@redhat.com> <87ik82ycl3.fsf@yellow.woof>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dUv5D1FZ4mMsE2Hiu2m-F2XEt8N0lfQ3wlUzmyn_Vjo_1780298109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 08:55 +0200, Nam Cao wrote:
> > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > index a7e103654..60dc39f26 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -82,7 +82,7 @@ static void react(enum states curr_state, enum
> > events event)
> > =C2=A0static inline void da_monitor_reset(struct da_monitor *da_mon)
> > =C2=A0{
> > =C2=A0=09da_monitor_reset_hook(da_mon);
> > -=09da_mon->monitoring =3D 0;
> > +=09WRITE_ONCE(da_mon->monitoring, 0);
> > =C2=A0=09da_mon->curr_state =3D model_get_initial_state();
> > =C2=A0}
>=20
> Looking at this again, do you need to change it to
>=20
> static inline void da_monitor_reset(struct da_monitor *da_mon)
> {
> =09WRITE_ONCE(da_mon->monitoring, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb();
> =09da_monitor_reset_hook(da_mon);
> =09da_mon->curr_state =3D model_get_initial_state();
> }
>=20

This order won't work.
Monitor reset relies on monitoring to be true to stop the timer. The
same function is called also on monitor start and there the timer may
not have been initialised yet, we use monitoring to discriminate the
two.

> To prevent another task from seeing monitoring=3D1 while the timer is
> already cancelled?

I'm not sure what could go wrong in this scenario. Perhaps another
event that could start the monitor would miss the chance because it
doesn't see a reaction occurred (monitor looks like still running)?

Or a concurring event would run on top of a reaction, potentially
moving the state machine further or causing another reaction.

Those aren't really disasters and I think could happen also without
enforcing an order with the timer, nothing checks the timer's status.
Following events don't even need to know whether the timer was armed at
all, in the worst case we may be stopping twice.

Am I missing something here?

Thanks,
Gabriele

