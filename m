Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174029B8C3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Jul 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530060; cv=none; b=mv596v5/crTv6EX/i/4hSku2vcmgAbxO7zjzK8oBPOwJXjDwF71/h6IypCzVox0mD5mfa5fWSy6NWWGx5a3CMQgukh3D6/oFRNVeqBIhaCtky7dxM0HP5fWH3jHs5LEU8TtA+OjXl3iU4GPJZjiGoMbFY9a6Ns3N5biErv0if0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530060; c=relaxed/simple;
	bh=XEutOZDpX6mO+OjsZpZ8b1EIpGfFQ9vBDyzxOYvDMnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6mR9mUmeIecEQEKBibMBmcq7IYEkNRjSD1H4weJ5CQB41ZpEz0de8AO6VZ8VZXqiuUmzErBPCt0jMBCCxZvH5jNCbRnjRFQxcWKrzoP47zRnje6Ao0BQFr0izuDlQRBeamgeYwwSBiS3YpICdBMRKd0oyTetQm1cew13Ad3fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ec3u4u2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec3u4u2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751530057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GamMp+TyJFc30zumQdIUpdnv7sTzaVAQHgSIzM4gVf8=;
	b=Ec3u4u2YiVu+jFdipMAyZWgsXFpJzhVTqP0AH4VNWkptcBufPN2G6sospIpbzAHyzgOIR9
	97DbYUrFS6YPcC3eVRjypsfgz8Y1GeNi6IIa/xCtM7FKOlQWSpXJiOSCvQIQdGurhpIuka
	ivzIKBHrZJBu1g67BqwS3nzGiD/nP08=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Cpz81mPmNM-ZKiZimmLmfg-1; Thu, 03 Jul 2025 04:07:34 -0400
X-MC-Unique: Cpz81mPmNM-ZKiZimmLmfg-1
X-Mimecast-MFC-AGG-ID: Cpz81mPmNM-ZKiZimmLmfg_1751530053
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so3811420f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 01:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530053; x=1752134853;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GamMp+TyJFc30zumQdIUpdnv7sTzaVAQHgSIzM4gVf8=;
        b=PTkYaMV9db84pIx4o/Kq/eCxZ/0sYvTjdYCSKkUDqLieA7hXlERV6iqyzy/JjU5RWX
         XTbcThuioxenvgALL7p4ilaUKWwqX8pxkWJ9l7DUEn3I2/tFHZNysIaX7ooqoIDo6kCf
         xse7a5orjUs9dFVEXEf1Q0tqH/Ayi51A4yivCOB5DDQANntPhlDjUX3M2qbNIlMIXODc
         Dazava0Mxo1CymCS31nF8rgLw2FVQC0N41NFHuse93tJc6c4r2l6DQ6MXTHmWH/ovfBu
         wl3rJ9qwIFpmKnjlYGuj0twDhjBDhsEkPuztERj5JkE3MAW1jMMZkcNXFFR2/ut45R66
         7vHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3+PaAqX3jyZrZ0OdYiInhQa5PO1WRp+sj5c2HxQ5/Gipbg8iFOUp1xqFLufs+MmDidY29AkDMoxP/PSedaRFzqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/NhdTSnZtNApD5IQpwairmMllZwcHMdoZbrM23uYkIxJs6Tf
	kdwlGzX2GtH+uiYTZv+uf62CETTkDosdMTtr12OA1/w3i0YTtoN1YGEFVuhUZyjOT26JvUptZPA
	dZV9SlV+Y71YoeY/nw+Iyvst0bigFdOJcY5bfDSFgcqpX/K/2cygt6qFcFMm3/tAUsCt+Q3PxLg
	==
X-Gm-Gg: ASbGnctY5pcpZDbHTFQg2PoeyLwfn+6Xtm7V1pyGzBYiHj8MEoej5pNPkjJNg9pDn/6
	r45MthwGC8a6alim5uKpZIhI7kpfg9vXfonxU7mB6zOvNzck2X/RUdIFMPd9Vp+aTqKDpGxCtD3
	uVHT0hTYnh5V8o54fuShP7xWqQeg8RCUc2P6GqVxzAExzAwLYZXu8P6atnj1YW/fgOJJaeI7+aN
	0d1XSuclb4RlXK2PJfrV029ZmoScZyDiT6a7Cho8jxd8MTP3VUX5CTmzG/omNT0i+WWzmfQ2fZ7
	/uC+4dYE08t6tKT2SQegGakHTJs9elW/X76Z53Msz29QMT3p
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3b2005840cdmr2948555f8f.47.1751530052840;
        Thu, 03 Jul 2025 01:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG05IT0UewuXSmKOoWgx9Nq04Gs+TXwgHPmEfRpAXHBlO7HuRZUAMsKy4Nw2TO9gr1qifTV4g==
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3b2005840cdmr2948523f8f.47.1751530052307;
        Thu, 03 Jul 2025 01:07:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f842sm17623149f8f.86.2025.07.03.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:07:31 -0700 (PDT)
Message-ID: <564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 03 Jul 2025 10:05:59 +0200
In-Reply-To: <84o6uatn6i.fsf@jogness.linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	 <20250626113520.315db641@gandalf.local.home>
	 <20250626160459.soHxOROG@linutronix.de>
	 <20250626123445.5b01849d@gandalf.local.home>
	 <84o6uatn6i.fsf@jogness.linutronix.de>
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
X-Mimecast-MFC-PROC-ID: R-nP9TxZnU0ayVbFUG8pL1G1bUA7gqZTPAwH30bqn0E_1751530053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-06-26 at 19:47 +0206, John Ogness wrote:
> Hi Steven,
>=20
> On 2025-06-26, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Your scenario can still happen despite the memory barrier:
> >=20
> > Yes, but the point isn't really to prevent the race. It's more
> > about making
> > the race window smaller.
> >=20
> > When we disable it, if something is currently using it then it may
> > or may
> > not get in. That's fine as this isn't critical.
> >=20
> > But from my understanding, without the barriers, some architectures
> > may
> > never see the update. That is, the write from one CPU may not get
> > to memory
> > for a long time and new incoming readers will still see the old
> > data. I'm
> > more concerned with new readers than ones that are currently racing
> > with
> > the updates.
>=20
> Memory barriers do not affect visibility. They only affect ordering.
> And
> ordering implies that there are at least 2 pieces of data involved. A
> memory barrier has no meaning when you are only talking about 1 piece
> of
> data (in this case @buffer_disabled).
>=20
> For example, update_traceon_count() has an smp_rmb()/smp_wmb() pair
> to
> make sure @count updates are ordered to be after @buffer_disabled
> updates.
>=20
> read(count)
> smp_rmb()
> read(buffer_disabled)
>=20
> write(buffer_disabled)
> smp_wmb()
> write(count)
>=20
> But what exactly are the memory barriers removed in this patch
> ordering?
>=20

Hi all,

these statements made me curious: I always thought of memory barriers as a =
way
to order reads and writes to the same address across different CPUs (in oth=
er
words, for visibility).

For instance I'd do something like:

CPU 1             CPU2

write(x)
smp_mb()
                  <implicit paired barrier>
                  READ_ONCE(x)

Now, I get there isn't much we can do if reader and writer are racing, but,=
 as
Steve said, I'm expecting the presence of barriers to make the racing windo=
w
smaller.

Am I misinterpreting the whole thing here? Are those barriers just ordering
reads with reads and writes with writes (hence useful only with multiple
variables)?

Thanks,
Gabriele

