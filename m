Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01830CD82
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237350; cv=none; b=EcFCX8UBqRm478ry6+033MTeOAi8r/DXxD8ekBx3fJ5mIsSRHs5XHl97RJ41frPX8AMntBbkXmavdMDcHFMfP7UgHjyPBXKlILv7J0wq2CZquIZSY3dAvI39OmEVlalKoxk7LvhoEZsLx0AYQQ39KAJdnbMsuVjYaUEqV06Zwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237350; c=relaxed/simple;
	bh=+08vxlyCb1BeKIgCZr3cAvUfHGNfxO3TPx1KC1SdAYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slsuyHbWs0GGqok9zf3RdXvIQ2JAiWNg7M+xYy3n0EadZH8NYCbZXeY9XbfWlmnB4xTgdWiEHW6Pb2mB++/2NeODJO89gr+LbqDnsgjuBlD/OWNreCGiMkFI1KVPTu/6UnXSkZ7rxNrf5JmFHRVD3Y5tCw4LRQtnSnPcfbwEWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRHgAEPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRHgAEPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756237347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qmx5qiRQCPCdKly3sT7WWqdCJ2SPn0JKLsOTN3T4lG0=;
	b=PRHgAEPJG8lYLa1YWhlxPEehUH3E0x1R+xpSykqhfRF/kq3KcHv9qPHpwiCY5Y/n1024IA
	VdlL7LpyY6YRxHEwah31YNqN/9eN1vJ0fLTRkUScLf4K/0D773RssJrc82HblVLjISIDFA
	ckSsiw9b4xJkiYRgNVUgPtJZfbhqXiA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-8uz5UOehMnquJmQLs_PQZQ-1; Tue, 26 Aug 2025 15:42:25 -0400
X-MC-Unique: 8uz5UOehMnquJmQLs_PQZQ-1
X-Mimecast-MFC-AGG-ID: 8uz5UOehMnquJmQLs_PQZQ_1756237345
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8704e34ccso2044902885a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237345; x=1756842145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qmx5qiRQCPCdKly3sT7WWqdCJ2SPn0JKLsOTN3T4lG0=;
        b=Ey1FusAiujsRVc73ebEQdvUyPWyQgI2hsRcdL71wOjRWWzUqAKOrhI1OQjtrGoa78u
         61ysJHYGjb5h6WDZI7U/H/JOoqFsLGBeZqt+YHS2BdkeQ+y42c0nDMzU9CooxMWnADzC
         5kvBSYnTMWcNxx+fa+//SPdAGUnMw15l6AsbOc3OuywWMdlz/ZuzO1ZyTEWeaH1tgM+r
         ZdfSHqM7phXotY+wMuIk0nj2t3GypPNu4pBit9SLnp/AMhL6fATH5l8NVE6pHcpM+LrS
         yftbAFiSjc76hIIS6Y2gEC5nhb9gYRgRPeCJ0H/z93yATRXVmMcldDKvbTKkXQF/jAcx
         WuVw==
X-Forwarded-Encrypted: i=1; AJvYcCULUZEoV5LAvOsrGBZy+8CE6pCjzuBD/l+NywFGsh6wtlBBOL/K2NRDlzTBSP+Nn7BEuS01o3c8uuARYJzvqgvin+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwrrrrPGn6C/0LrEEJ8VSLHLnI3iN8JIS9Mftl+7+qqyZjDt6H
	0GtZqib4Sa3G1mSSM+om3KKNnF7h0+rkmhXZDLBe25dAGpJoCk2GKbqKmGBZd3hwl6GhX1fpmY2
	0BDefhCB2XgGvET7MY09EKmubqeSLOv67KgCyshXTr2EgBS6BERhS2MhPeWTTnxwWAthl9FHAfA
	==
X-Gm-Gg: ASbGncv32TuMDUf4I3Snb25zubc6KZlCZf5iC+VoFKaPdOInTxLoBzrZlXDgAPH0M1K
	T/PswFfbJ1d4l/JljJXW7CN/T4Wz5qU+A9mN/vjTLL7qVCFrRT1C/OI6/tycJ2kK2DbreZngK0+
	qY8ctqJZXvri0fW6kKbQ6aJzt0O+/qQ9lCcwM6vhxQopxhwTdGzDu4kFsWce+SnTP1AT9I53fzY
	d4IoblbPh03g5c1JszYARuK+sWeFE8yLKm4w2CEfud1neIQcr+uWYLG3Mm1GdxFqCTReFVMvCSM
	DKQ+QAAW+KAu8BfhyHuBL4xOOe+oPAAJNSYlpLbTw/yQ7Fr5JX1ConkRuGYqeEXY6Q/l
X-Received: by 2002:a05:620a:2995:b0:7e8:b54:782e with SMTP id af79cd13be357-7ea11020322mr1967977485a.44.1756237344895;
        Tue, 26 Aug 2025 12:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbVUmv4rzi5q7cAu5S8188dth+HQOWJBbe2VEqeNcftZoGZtCQ48GVaR6YMezAEqjCFbfzQ==
X-Received: by 2002:a05:620a:2995:b0:7e8:b54:782e with SMTP id af79cd13be357-7ea11020322mr1967974985a.44.1756237344359;
        Tue, 26 Aug 2025 12:42:24 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebecb19b6fsm747742985a.11.2025.08.26.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:42:24 -0700 (PDT)
Message-ID: <b14451e2823743c5f884c862edbf4954991cf629.camel@redhat.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>
Date: Tue, 26 Aug 2025 14:42:23 -0500
In-Reply-To: <CAP4=nvQtKguNDikon2idnaET=Rpfsuo2DQeoRD4Nn8_FFRUX=A@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
	 <20250821035719.137161-3-crwood@redhat.com>
	 <CAP4=nvQtKguNDikon2idnaET=Rpfsuo2DQeoRD4Nn8_FFRUX=A@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xHIek_M7CzKy6NtO5qyJDmyekx99FT0UojWjACxi8VM_1756237345
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-26 at 15:58 +0200, Tomas Glozar wrote:
> =C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
> >=20
> > The hist members were very similar between timerlat and top, so
> > just use one common hist struct.
> >=20
> > output_divisor, quiet, and pretty printing are pretty generic
> > concepts that can go in the main struct even if not every
> > specific tool (currently) uses them.
> >=20
>=20
> Absolutely. Quiet and pretty printing are currently only used for top,
> but they might make sense for hist, too, in the future. output_divisor
> is actually always set to 1000 for osnoise-hist, once -n/--nano is
> implemented for osnoise, it will also be used by both osnoise-hist and
> osnoise-top, just like with rtla-timerlat.
>=20
> For the commit message, maybe "Move hist/top-specific params into
> common struct" would work better? "Elsewhere" doesn't quite capture
> the idea for me.

OK.

>=20
> > diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/=
src/osnoise_top.c
> > index ad5daa8210aa..7c68feed300e 100644
> > --- a/tools/tracing/rtla/src/osnoise_top.c
> > +++ b/tools/tracing/rtla/src/osnoise_top.c
> > @@ -125,11 +125,12 @@ static void osnoise_top_header(struct osnoise_too=
l *top)
> >  {
> >         struct osnoise_params *params =3D top->params;
> >         struct trace_seq *s =3D top->trace.seq;
>=20
> > +       bool pretty =3D params->common.pretty_output;
>=20
> Is there any specific motivation for doing this and not just using
> params->common.pretty_output directly, like for the other parameters?

Because that wouldn't be pretty :-)

(it just felt like it was repeated enough to be worth it)

-Crystal

