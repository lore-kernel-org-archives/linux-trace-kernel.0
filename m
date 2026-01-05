Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334B3126B3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651898; cv=none; b=fU+bCU9NQLFMJSpsEKM7Iyxq/hDfQHV25Fm6/m3ZhnZ/6Vq3qPJ01ONDdGY7GggMggmABx1+HYNJigELCvv1zyg7MOA67k/JlxXBj03IiqHvr6inY0SVRHtIJTlr/uTtWUltyTjYe4dAUt5qmu4TNH6bfyHBZdCzuHg9YypcodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651898; c=relaxed/simple;
	bh=4GujXFcPY78Soe5fJ5zpAxshw/1UlVOk9zQiTnAySak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6fmwDihYc/Yf7juEvzkoEwd3HmKTPEqkGlavqteDy8XbUJpuvdRtuAm+/UgZgxTHsoG0VyJFkByOkwd9YxB6NafiR9s5gmPOoBoCZQl53U5/WF5QZKawC3ZiuBv3cgtrusDBoyaqrCshUU1587rwkL9lR7oqV/oYrvqz5g3yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib2XQTLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib2XQTLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767651896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIu36dvOmGSWGl/xVA3p8ygE7dV+HFTFGY8xQr3jAbk=;
	b=ib2XQTLo3tZ1zBNZ2NiKD6CbwVzF0Cz/6y00R5u+vio4FpqPH8oZrqn0nTT+DkRwKitOee
	Vdiq6k562cJkN/1ZhYabXIo/qk4te3PrWiNYN/FCg0HHwxHOmbee7u/9qkZ9ZEDeX6+2b7
	L+FNkp4faRDqshkZ3BAKrNNVfu8fDa8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-prwueBnzPtyjwNHSHYocXg-1; Mon, 05 Jan 2026 17:24:53 -0500
X-MC-Unique: prwueBnzPtyjwNHSHYocXg-1
X-Mimecast-MFC-AGG-ID: prwueBnzPtyjwNHSHYocXg_1767651892
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1d60f037bso8098251cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Jan 2026 14:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767651892; x=1768256692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIu36dvOmGSWGl/xVA3p8ygE7dV+HFTFGY8xQr3jAbk=;
        b=Q/3n1DjT3JdTN2yCF+TCjYT5F5LrqGWtBacGSGnhLAooHW4bMA+Kuj44m2NlN4Aym5
         h7Lu26GqqiS3gkadGkB7bEeuIq3+2RVG04DpcnAGU7EHZYpIYtqc6LTfuG7hyKv5d5HH
         PTfjW0m8lBZOe0cJ1Rd7A5l1V13tofEetlxUQ4ZRymZVUkQru5ynBsfEwBX8sx9xus8D
         dWANM7bZwyAtaBP5FitRMItVKrnojl+xcxpT3SpNsVMZCw918xh0opm8WNccSOEVWJ8R
         KfhN0iJb+7REBm+zkbDm5Klyt2inIU72/Se1XSaNnL7tJ40k2sT1ME/fnrRpAABej97v
         eztQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7O5Jg0Y4vvX82DGi0Ilc8H6D6lzBfaqg3DZhNWpDTpfuBX/ICJSNJLZgR+IOLepWdbYASQUZaHmqEFl/H7yM0fu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIEfQXYEgGp/eQCTHASqJQl5dENN8vyUNttgSgk09dP2sb1jz
	eEmbrRm3rF6FoJZXlRYPPaaNl5dmlBm3/CGAgJprLQvZAJ65r1AVARpbM5gA+MFIUMAzx4i01i7
	xVXCARcIdvWa/LnC8dBR/8lw3DZ6oIQ80wHCbmFm6r2KRNynq5hJYlzCLl6P07O2Y71ypUVOW/Q
	==
X-Gm-Gg: AY/fxX6M7S7Flwomt8VNq7HGHHx6Wx4h/Ewp8r3n/rdSSjxIHJxUrFFfJKizzmDF9UO
	OL9arcAwjnjfSOLv3BxFX3hQrz6Z/iHnjSzq6tfQ6qzKF9sB4ky+1WW3w2uZmFQ4IVtjCpyDotY
	6xBkBDZATItO29Pz98wG3ZGv8ALlPILxLa5x60pBTNy/ADNGY0fmjCb6Xup8QEMLA65XbQPU/C0
	Fbh//4BpPh55CNqlWR/hyFn9JvZ/QxDgRwcQUK8aWLJMsqjrkHe6Gdtwr3qvGDnOKKGu1n4bb99
	oWh3ETKRl2XJnZ4nZqiHltwYxSJ5xnjhZokQgDgFzLUokCgv7ArOgRbwaJqNet+6bC35uEp8MtY
	/yCpxUGuVePePuvvSl0qmD/kgpSyiBS3x4tGzTy67AQ==
X-Received: by 2002:a05:622a:3c8:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4ffa76d8404mr15124051cf.35.1767651892399;
        Mon, 05 Jan 2026 14:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExNh0xTTv6L2+E9HZQoqXbrAGQ+sIzOchE6ENYBi29Y5oaqVBf9GDoOpp1unnFpjh+Y6BDeA==
X-Received: by 2002:a05:622a:3c8:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4ffa76d8404mr15123831cf.35.1767651892036;
        Mon, 05 Jan 2026 14:24:52 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726041fsm2305706d6.45.2026.01.05.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:24:51 -0800 (PST)
Message-ID: <7f953b7e2a9d30e0f22c30c5c4e10828018bc40c.camel@redhat.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all
 tools
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa	
 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
	 <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 05 Jan 2026 16:24:50 -0600
In-Reply-To: <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
References: <20251205151924.2250142-1-costa.shul@redhat.com>
	 <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
	 <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yzSLXKdJSnDbZ9Ueh1MpjmUnfiaxllUK-mmK7_2qtWk_1767651892
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-12-17 at 10:06 +0100, Tomas Glozar wrote:
> =C3=BAt 16. 12. 2025 v 15:41 odes=C3=ADlatel Tomas Glozar <tglozar@redhat=
.com> napsal:
> > Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
> > osnoise/timerlat and hist/top") that was merged into 6.18, common.h
> > includes timerlat_u.h. Your change thus causes a double include of
> > timerlat_u.h, leading to a build error:
> >=20
> > In file included from src/timerlat_u.c:20:
> > src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u=
_params=E2=80=99
> >    6 | struct timerlat_u_params {
> >      |        ^~~~~~~~~~~~~~~~~
> > In file included from src/common.h:5,
> >                 from src/timerlat_u.c:19:
> > src/timerlat_u.h:6:8: note: originally defined here
> >    6 | struct timerlat_u_params {
> >      |        ^~~~~~~~~~~~~~~~~
> >=20
> > Please rebase your patchset and fix this so that timerlat_u.h is only
> > included once.
> >=20
>=20
> Correction: the base of the patchset has nothing to do with this. It
> is the C standard, from C23 (default in GCC 15), redefinition of
> structs is allowed [1], so this error doesn't exist. In earlier
> standards, this is not allowed.
>=20
> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2863.pdf

Regardless of how permissive the language might be getting in this case,
we should have #pragma once on all of the headers to avoid this sort of
problem.

-Crystal

