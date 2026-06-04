Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3F478859
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576931; cv=none; b=swsQx3OrOtwnOfNOkKVTgCIcZZW39Y084gOmNNO2rO8qjToK8u5ncq8gFqyi2OEE+WdYkVQyBYTjozACb1jv+XJX1ThBQLLzCFiSGqCkjrlrbaHf0d+7xU9r4AGVoHWZEm60f38MMdVPovo2AkGzHrXmR+Cbk4GHjsYScUXOQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576931; c=relaxed/simple;
	bh=sTR9uLEleqjmdEiEcEC2Ct6t4hEoHcslHn9TViuCpxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVbLpflsbutZUCJg/ueJwXQnOKHNv8XJ4Iz/H43ecjopV9yfW+w43G/fpjNPUPV7VnjTSlF4qd95R8F3hjgNFN0QDZHRfwP3tgSiyB/rNRbG3LIS76rlU9pDuLJ4AjZr8POlVlWu1jTLTDWi2HZ6VjgUphC1A6K7aNn7VReaXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZj0jiqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZj0jiqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780576926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTR9uLEleqjmdEiEcEC2Ct6t4hEoHcslHn9TViuCpxg=;
	b=FZj0jiqze2SXjCGstvlL8uzAxVc3M4gGKW+skOVzUAVpcqbAFZHhcb6QkzA2Ru/1j5k/YU
	605apTZSFrDEtqDOmhrFNC3gmY3ZsghaQqXK8C5bUpaDZZq64veWB4gl79Sr8+1a1sMv2k
	X3hfHKShcXqC6KpSpbwTowGGNBZjub4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-lw1CscR3Oiy1aEAUsWKVOg-1; Thu, 04 Jun 2026 08:42:05 -0400
X-MC-Unique: lw1CscR3Oiy1aEAUsWKVOg-1
X-Mimecast-MFC-AGG-ID: lw1CscR3Oiy1aEAUsWKVOg_1780576924
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso416770f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 05:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576924; x=1781181724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTR9uLEleqjmdEiEcEC2Ct6t4hEoHcslHn9TViuCpxg=;
        b=bQUc0hcUnjjFft09BP5mly0bU9dSMbm/ggWSQqGn9nQGMeVGYherpucVMkggTeH7j5
         2bL9NsQgCCPpFUpy+iahs7Z5Y7UNPVqCcwgywbwQ/drffKP8urBu7cymIl+B8AjEJ7KH
         5Svsb4GwGDys8UCm3NswByGGe5ghTtAlDLwsiJAVk9viFsSPRKSdacLREr8CHjBZOp5+
         Ag46qE6a4CRPENJMwMH4ev7jwIVYxzwcLEwtPBBLYzVoEbh9dlEyLE9+HRPRu8ZhKa+q
         es7RJWSzarUH1LICL/+TwOF1/0OxAtFmzVs0dwfoqdeEHfUNvhla2fTrGxadv5bM5Zj+
         K9vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fCAYdqPKNOXfnwrBSi4cT0nXe/PJCc7VeFyn+A31yN4u1AKVImH7lupXldZYHkcBzisgURvTdyKUzlD2ZSUYANh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk0sZqxoZUC6zSkEBH/B20dK+n0GVHtzzaTJ2dTXPlS5ArcXt
	3Y5e34eVP8LefJAuiNziWbPLF1CAR4ZU1hbVNGLE+W/NXdMxLg5PyT4EzntHM2psu7UX0yT0Ap3
	ZfKr3UgoRlMADYqxkLhUhV9ouFozH1BK+REBn30fHiccpO+tcYlDtSLeFnM9DTtM+m58igp/7YQ
	==
X-Gm-Gg: Acq92OH4AZf8gtsADjQ9SNieKUUv6PyXtc5p3JjvIzXZnlOyXSXliKrJ9ETpohHU3s/
	aN4xx9UNSvfiFlNJQ1uorxkUANtUGzISO4ujpUGWneH3qjMIgMTJGsE1rqdEJC0GzEpjrCY7S+x
	ZQ/5asn28uXjNPchwThRWdTEKpxIEzPGkh0pRQWIUP5wa3lRD058rd7QFGnkadLuCgRD68Xb/N2
	rdLokImu3faFzyeniiYstPK7emopwdvvNnJsWnFPtjZmQHe44x2REcLU4aT5sRRXYySEzjzLOrS
	v6dSdQTa99bxgtT+nRkyMYnBDwJC9ooC88EZUuz6pIlVWGME3mXfVq8YmUB2R0ASuZLVzfs2/IX
	acAViF5exOV2z45RiRFxJaB6mu59EnpwEog/Y
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490b5ed1318mr134678245e9.21.1780576924401;
        Thu, 04 Jun 2026 05:42:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490b5ed1318mr134677645e9.21.1780576923912;
        Thu, 04 Jun 2026 05:42:03 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm15784950f8f.2.2026.06.04.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:42:03 -0700 (PDT)
Message-ID: <791528a4f69460ba1e9589361860bafeb1517237.camel@redhat.com>
Subject: Re: [GIT PULL] rv fixes for v7.1
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 unknownbbqrx <dev@unknownbbqr.xyz>, Wen Yang <wen.yang@linux.dev>
Date: Thu, 04 Jun 2026 14:42:02 +0200
In-Reply-To: <CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
References: <20260603125056.75559-1-gmonaco@redhat.com>
	 <20260603191627.5cb4ef6c@fedora>
	 <CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: luVTvdoiw5lYH3m5Hxy393P_5qzDdK-XUyLZ_iaOzto_1780576924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-04 at 13:32 +0200, Tomas Glozar wrote:
> Hi Steven,
>=20
> =C4=8Dt 4. 6. 2026 v 1:19 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org>
> napsal:
> > Hi Gabriele,
> >=20
> > What is this? All commits need to be authored by and signed off by
> > from
> > a real person with their official name.
> >=20
> > =C2=A0https://docs.kernel.org/process/submitting-patches.html#sign-your=
-
> > work-the-developer-s-certificate-of-origin
> >=20
> > -- Steve
> >=20
>=20
> Is this really still the case? Note that the document says:
>=20
> "using a known identity (sorry, no anonymous contributions.)"

Thanks Tomas for chipping in!

Just adding some information, the username unknownbbqr is in fact a
valid username for a Github account.

The user already sent a patch and updated it with a real name [1].

All this to say that, in my opinion unknownbbqrx <dev@unknownbbqr.xyz>
is NOT an anonymous contribution, just a nickname that differs from the
legal name of this person (which we wouldn't validate anyway), so I
would say it complies with the rules.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20260426150928.870914-1-srinivas.pandruvada@li=
nux.intel.com/

>=20
> It really used to say "real name", but it was changed by Linus in
> 2023
> [1]. Note especially this section by Linus:
>=20
> " It was 2006, and nobody reacted to the wording, the whole Facebook
> 'real
> =C2=A0=C2=A0 name' controversy was a decade in the future, and nobody eve=
n
> thought
> =C2=A0=C2=A0 about it.=C2=A0 And despite the language, we've always accep=
ted
> nicknames and
> =C2=A0=C2=A0 that language was never meant to be any kind of exclusionary
> wording."
>=20
> The wording sounds quite clear to me. And I'm certain that there were
> contributions under pseudonymous identity that have been accepted
> since then, most famously by Asahi Lina, a vtuber persona [2]. I
> don't
> really see a difference between that and "unknownbbqrx", other than
> the latter doesn't sound like a real name.
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2e2f6b0ef8551bf3bd8255729d27e3ad9451e562
>=20
> Tomas

