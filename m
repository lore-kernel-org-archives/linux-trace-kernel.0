Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D51A6824
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781299; cv=none; b=iYJtwevAffKnko0bTclnOrvfSaMfo+iqH4pzc4V/PXEl87slkV6CxNjuMOKWjuloCzpsvtWEOSS5BeDxM1FTDVnUzzxPX8omG1Ps+W4qnNQPb/HSpM4AmzFYtBtRP/8UNoo9fTsE1/d6rjYneiXzsIFGhwQfiE6qqLwQtIVpcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781299; c=relaxed/simple;
	bh=AedUMlSyw6XFjPVA5iN7FhX2vHC7C6TuLPwkgnCkKs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asDpe8nPOFJLC2BfbBgBJrqksG/22JTXIE0sjA4sRpNB1+aNj8DwBDmBly1+53Ui6D1p0CpwTC8CNdCtQ4UHgdxz9bQsOjGvyAmw4A0bShIc6rRWsYYPK++exBJKesMZHQL7IrAZPdMx4pZ6+qupkPHmoZeGt0vcwGQYvqIq2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pmr1qC6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmr1qC6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
	b=Pmr1qC6N7mIfsg03Tu09eNMtlZGDH7KpO8w3GkI6yOkQbobIZeUin1dFVrjJ6zoIZLejgg
	VH1OWmPXiGQnytT0EocA3eSL8qmUkwgrNVXpJwzQ1fM6WT4aN8jRBnjWSH+imam7eX0vZU
	i6wILU1VCCXS70mk4M04mWD88Rduspc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-b9q6iuENNnybkMQqzVoKfA-1; Tue, 21 Apr 2026 10:21:34 -0400
X-MC-Unique: b9q6iuENNnybkMQqzVoKfA-1
X-Mimecast-MFC-AGG-ID: b9q6iuENNnybkMQqzVoKfA_1776781293
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f71437218so2732645b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 07:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781293; x=1777386093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
        b=XGAanHyT2YrXHGi9BU4TrQ4eWHHgEoGuL42XwnHgHCgFPuqMUWDRIwVcRRkYURcSJL
         mHpPvZo3GDZmhP4M2mp086ozSNFnIBt8F7dKd05iXQScQg3Sdo2By/kleVs4mLFDXBB1
         MEDiPVBLyENdfCNmF4ZVmpflWneE0CfnM7OAhVSbaQcG5ydezNiGR/vapkq+ZW+/E6e+
         UQv1/dt9pi10tbN6jbN/1+fZ+XK3vGnW0OIX1R8wypd1IAK0Uw8anvNVTLJyiFrjhH5K
         6W7PKMPok4QZ65+TKMEjXUzz37adlwTAE1NA58RrVwyNZw599hNLc9m+iX7MzmLfKtzu
         7g1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SqUZLWIDe0eMySeQ2EuihyHGfnBuIZS26S2elgYR1OaF/D1YRyDYutErqkza82L6ne6F9TKuDlvGIkEYTRjJ9rNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0PGly5milDynRB2CuiFZq/ZIy0QY1ZpV+RhxYPSt+L95kRkI
	qc+grpGeT5e4TbMqEnQET2F3LaHST4hCb0LtK8xCBDd6DfudYjPr76rTZNpbEVVBmpv5H8zXlI9
	ge4E3g6y1HUnWExL3GcL5BXUBnCnMKndQDpNDov6fFc2kC6fkA7PQYLhJezlvDm9kULcgXs+DRd
	kHNUeVKo8ygZYzRHJQdKR36riTnkYUz03p9m7Zcb+15ldyTwn9
X-Gm-Gg: AeBDieu/GUAtF9w5LHRSyLskDN1EURArA/vxs6Dc7MVIwk+IrIQdIUrIvRA0P9bHO1C
	uklLqhOFkGJLGVueJSvKgvciTuCZpienqTCPn+dFcJuB9UkSR9G92t3L21cifEl8UMEFV61oRlW
	py9mE1n6OqpszysjcbEZmEd0NeLiWQQdn1UQFnUWKtHRnZWm8LNTtueHkUnR+g+CiuU+Zt1u9E4
	R9wDdtDhkYZSGYdZb0r8dft7PZ+Rvu1OFEVWDYNPdoZyFxGm1uyEkF3Y5iNFzi8t79E2tkdbDsT
	rQNtobgxzHfTv1I=
X-Received: by 2002:a05:6a00:2d8d:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-82f8c99aa1cmr18917673b3a.40.1776781293117;
        Tue, 21 Apr 2026 07:21:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8d:b0:82f:38:a5b2 with SMTP id
 d2e1a72fcca58-82f8c99aa1cmr18917635b3a.40.1776781292628; Tue, 21 Apr 2026
 07:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421100455.324333-1-pbonzini@redhat.com> <20260421100209.7535e26f@gandalf.local.home>
 <86ik9k1jqs.wl-maz@kernel.org>
In-Reply-To: <86ik9k1jqs.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 15:21:19 +0100
X-Gm-Features: AQROBzCHqdW9w1Itv9qFdyXz20N2UJ_Tm4C-PGQnlDGcI3ssuL2JTM-6QB9jJJ0
Message-ID: <CABgObfam470W_Cq-jFHXc7H=xkr4CRMOGrbuLd-HtkepvwA3AQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: trace: do not generate undefsyms_base.c
To: Marc Zyngier <maz@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: REePT--OgUpPP0uCcEzX77W2S7iIRmXqLEwMONX_9TE_1776781293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:18=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
> On Tue, 21 Apr 2026 15:02:09 +0100, Steven Rostedt <rostedt@goodmis.org> =
wrote:
> > Marc beat you to it by a few minutes ;-)
> >
> >   https://lore.kernel.org/all/20260421095446.2951646-1-maz@kernel.org/
> >
> > Although he didn't Cc linux-trace-kernel@vger.kernel.org :-p
> >
> > But anyway, it ended up in my internal Patchwork. I'll take his as they=
 are
> > both pretty much the same patch.
>
> On the other hand, Paolo's patch has the SPDX tag on the new file,
> which I forgot to add. Your call, anyway.

Yeah if you want to get the best of both worlds, take the commit
message from Marc's and the code from mine; he has more complete
trailers whereas I have slightly cleaner formatting and more comments.
But otherwise it's not a big deal.

Paolo

