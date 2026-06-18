Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304713DB645
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770440; cv=none; b=ZNYHewLSGqG2oiALK9NuJ2gG/fousDSsf20RCsR3sBaL/MZOeH6+SrKuxmkFp9+5MZyFyUIHBh5tIvJzH7ySue2E+vvq4f9DBf8H7uyIrPXxrIrrtWs1O39AxDXBiMk9e9UGXrXqK/twIuibnRihBFWPrBuhJzky6IJu1O4uCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770440; c=relaxed/simple;
	bh=V4atjPoRLxPj/P/o9GCbq2G6p0+PCrf2LHSnCgfA5UY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFptx+pppLw7Q7/GcbyeEMXFnjJFtQV2ULlY1lgnHF5yi7/JI3hDOPgoqA9YV0UsAwq1cAsxUOCIl0qFTF4bgqUrbKLL7OSV/+zV8/EfAkCh4LvuJ0FN9dmfvSseW80VfnC05jlTBDQIJqOzLky0yj8mx5aRb1tDSH7i9mG7I/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9+FobWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9+FobWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781770436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMNQ/q7fbi4PfAmfawMCfx/QWCOmT+5njtbain3KxO8=;
	b=Q9+FobWff3GBn11rL5ynatUVX/XL1DOeiJTUpxEIRZfe5+2I4OABiQpH5sYyWE0xdL49/A
	aOiE2H+hW6JvVTLiv2POEPB3CNuyT1KGfGw/Lz1ppED6qXtOueDNEHzNIR6GiG9mceBp75
	mwbfaSzUPGSycwAjOla0YtZORgc+pd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-myKMldnqPtSikBU_pZvWFA-1; Thu, 18 Jun 2026 04:13:55 -0400
X-MC-Unique: myKMldnqPtSikBU_pZvWFA-1
X-Mimecast-MFC-AGG-ID: myKMldnqPtSikBU_pZvWFA_1781770434
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4625e71d3ccso1117139f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 01:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770434; x=1782375234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMNQ/q7fbi4PfAmfawMCfx/QWCOmT+5njtbain3KxO8=;
        b=q/aBsU3ButsOqGuTBwID/m0x3+9cycMh821ZQsY5aSaUNSOpP0qd943dD5PU6+I+g2
         gX0Wjj+moALD8jb+2hh7Vbe3WdGElFPZ5r5Q1M9DLMb0+jjQFgzP2lU/Q4ITYo6XSZZZ
         OlmZpTjnl3d+pOY4KuNOVUHX9iMXoMAIr5xDe35w2vOMJlbJ3SwovGjmUHk8sShbOaDu
         rtQweXqN+zQnsir2ABAqJEIW/WRggDkT5lBGCStUI0fTuNLiGkvelZXAu2Qg5v6h35qo
         379yNG4o7qVRoC5xoAgSXBUfap/epr2N4vYRuCoU1zmQJ3SL0+l7TKcXE0tj2ZcLSQS0
         nFPA==
X-Forwarded-Encrypted: i=1; AFNElJ8FVBTRZKrryxJjjGDdhX+huKsP/E+b3RNfq2VgFbq6JkRGONaN9BydS+v3NwGGOnDvqjobvGGf9ic430PFAxfKTOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5ZYqgyI7vrxPEFabeGWG20LO7W3HOzSgGang1cmqpbPKEyfB
	g7xzxhyLsaWWmqVu5GYe4FQhvXCazqkttzfHbQygVnb10NRHn5jn8TDVjzO+vlEDwq7Rybxn4h1
	4Xo5GhijE76S1NcKdfm7h9aPVS/R7edgWiMLDy4aWWj/2SfGbPBx4btyrwJvc0VsmdW05O7GGnQ
	==
X-Gm-Gg: AfdE7cnnq8fY7RTxpZ6o36Hmx8yWQAMtkybA5w3ZV2po4ou8wEyzxHnkI89F3UOkOlP
	m7ZyFNhu2xGNomcUXG5R57+wb56/0e6lQb3vtHRVSPQBQtm9Af6uyhoI+LZf4IdaWJ8nPvAk5UV
	8QEhccjGkxzc4tsLNqWnSfWemK7eM9TGp+15v5WWx1fozGeMUctJw0wDKV9/2brrwvSXJUYwB+e
	KNVWz6DygVxVDh34k1pJYcO6kiDqIa2dBCGLKfPbrBKmgGLFRsizxc9vYOnQHbgJF1PnoIRFxkO
	CF+fwkmgziptCMLKpZs1a/IN/gEH2U7hnisMD1HkVPNptF46UX44Cou9vkuuOq1uUsY3kH2EREB
	PZWyw/pLnbNW/qnQ=
X-Received: by 2002:a05:6000:2989:20b0:462:6fdc:8194 with SMTP id ffacd0b85a97d-4639881b88fmr3232286f8f.25.1781770433952;
        Thu, 18 Jun 2026 01:13:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2989:20b0:462:6fdc:8194 with SMTP id ffacd0b85a97d-4639881b88fmr3232260f8f.25.1781770433508;
        Thu, 18 Jun 2026 01:13:53 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm60856772f8f.3.2026.06.18.01.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:13:52 -0700 (PDT)
Message-ID: <9035cc5b83dda3a8ec06e8488fba62ceb7431123.camel@redhat.com>
Subject: Re: [PATCH v3 09/13] verification/rvgen: Delete __parse_constraint()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 10:13:50 +0200
In-Reply-To: <87tsr1mqrj.fsf@yellow.woof>
References: <cover.1780908661.git.namcao@linutronix.de>
	 <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
	 <e3f63618b48dba9299c88bfffeae14b71717fa77.camel@redhat.com>
	 <87tsr1mqrj.fsf@yellow.woof>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OuOrEQWpTzlMAg2MtiAVyF8qUyyJtjOyC_gfarkOx0M_1781770434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-17 at 11:59 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > This function used to validate things we are no longer validating,
> > now it's
> > alright to create a model where a clock is never reset, which
> > doesn't fully
> > make sense. Should we add that check somewhere else?
>=20
> Theory does not require clock reset, right?

Yeah, I don't see it explicitly mandated in the theory, but the
description (from the sources) states:

  The value of a clock thus denotes the amount of time that has been =20
elapsed since its last reset

But it also says (emphasis added by me):

  Clocks /can/ be reset to zero after which they start increasing ...

Nowhere it says clocks /must/ be reset, their value simply won't make
sense (according to the definition).

Now in our implementation we may have some automatic reset when the
monitor starts (I'm planning that to avoid invalid states), which could
make explicit resets superfluous in some cases.

Let's leave that to the user for now and skip this check.

Thanks,
Gabriele

>  This is not some sort of
> hidden issue that trips up unsuspecting people. It is obvious from
> the
> model that the clock is never reset. So I think it's fine to allow
> people to do that, maybe there will be an actual useful model without
> clock reset, you never know.
>=20
> The self.env_types check is enforced by the grammar. We do lose the
> self.env_types check, but that is likely redundant anyway because we
> have this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for transition in self.transit=
ions:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if tra=
nsition.reset:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 envs.append(transition.reset.env)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.env_stored.add(transition.reset.env)
>=20
> so it is clear that all envs that are reset do have a storage.
>=20
> That said, I am fine with keeping these sanity checks, if you are
> paranoid.
>=20
> Nam

