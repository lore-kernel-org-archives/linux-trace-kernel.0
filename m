Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792743781;
	b=jOjciSnj5CEuOj4uqPhQ4WQdVYOw1+c9ifAsC021DHxX1OnJoZPcc29xCC+0oxvUyz+x
	 0i7W+IFYuo4fCJTRwG5uLRnEJiioiQ6RieQCaNDwoeFvGDU41/H/e5bNx9Y8c2r1/K5Av
	 WYpXUC/NqYkX3dPbBLxpZIl81v8NDVnl63ebYAcnA4oEu618FxgVFVXtHIvqp2OB2peHG
	 AGBj4k1yGuk5mMrl6F6rDYgLi5wmJMoMjQYDixCGjbIxBSAJlC89a/9X1iCG1M1r3Qr+9
	 mAuXKAo4YadGWGNx11kLdigtfZKyF4u+lUQFzH01wEtBod/aFYqfUHEJG1MHrKuzmPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CnID61DBqXYExMRhfWZPF2Tk54RL2V7LncDliM0Ny80=;
	b=lCiDZ+ah9S5+f1muHdy4Nx0eYydBoWj6/6CIiKNGq3IYBcQ3Qm/z4sqMtJW6ZurBv2Ds
	 m2HSwHpordyp+1U2fkgfGS5+EwZNZtd45/6dsvprJeMHZ1otR/mHhGXcVip8V5JiMmQY6
	 WRCDyEN641Nn4dtt4kJJd0bkNRoIpQ1gIAsKt2NzWKnc3AFOJsHKgPhslyulszpKe5XQk
	 VzrBsPdEm8qhunCuBOMK94nyP91ND7ULiGFusTiz3uGgKUmxgPaVIqMyUn/pQwiXbT11f
	 R3zDW2MvwsEvmE6lrZMM/cWT1F+wQiUAIcoYyNBgO5zokGPZRmSNnUfeXzOe0rGdxiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pBThlLg9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40C606A31D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 08:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA40C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pBThlLg9
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso375307e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 01:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792743779; cv=none;
        d=google.com; s=arc-20260327;
        b=raeJ3Kficig1piZqck/VbkJOB9CT6496aWTwWgAvrWrxC0ZhBg+2X7qmHCTEPzvBsQ
         MumCGSpRzxQF1eTJowIoAZ6dwik0DvKEHj5eyGTaKtO3DvtB2JiweiEZCG85z2Zf1pWA
         cVp3WQ6StCIE57a+m5/d/lkikQTKfLSFTmoVAvhgQuKC85fVV6Oji8BW+iRF13CX5O7Q
         fZwU6SDk2uIlZYNC1bLbgeWLvNwGZMc1ZVHLbPac3QQD8hWBD8OgdEUwHAUa102t3UBK
         HPz866oL/JxZxs5NpYM2e8yqWcjNhmqgL0dyyfXJ/inNwa37HA7b+3GzRwKXHE9CtMRZ
         NZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnID61DBqXYExMRhfWZPF2Tk54RL2V7LncDliM0Ny80=;
        fh=GZxRq4n3lxz5Hk1SMDeuFchtJMYHPg8IPYKLEbWyJO8=;
        b=UX3u1khW0Q+C2eWKwHyhge/3VdmYPN4zXyVd31CX50crVA05M8/CnI+qMcPkCgpo1K
         Sh+YWOAtBrg4xrY7anmk0cFW1KuytyMFO1BJCo747zBMfUb0IF6hN32c8CZiT8q5rnXV
         tLD+XUOTYvG3Rw3XD1NnMYmF3FISKJKO8MB2+LC23PgTvk44kxuyx9G4AZ8F9P7Kr4Vu
         kIXpkDjDMdzgwikVJjEc8iBl/TIZPgLfkNpS5nJVFU0gge4zwSvHS/iWNXJfn+Rn6HDH
         fdVkmf5PyJ9KpAbVd5tXEIrq3lT5KByRBmhdPmU1LNnYJa3nLUiXs8TJSATdhr0ImsId
         2P7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792743779; x=1793348579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CnID61DBqXYExMRhfWZPF2Tk54RL2V7LncDliM0Ny80=;
        b=pBThlLg9Wjoc1dNzzQ2MNkvpXXZwwfgqFXg8OaxUDOg9A4KNOFTNmM89O1J9PtW+UH
         6nemQHby/5344u4cN6Dt/dqw0Ht5fE2+OXmur7xj9vfgmp2j0GxFwUWrnSC8aMFk2/jX
         ulprL88lYSE9g5mEt5OuqFl18Hx2T1bzdXzr1/BjnsCml7oc8bNdyNhK6Fl12tWYUQJw
         zBRjmi1vuc+yMJItrFAV9R8V6plwWAW9faLqHxCCGf5PRe4bW/+A3w61FSuOD5yBht9M
         IHrtIDs3dgw4BOUpoLKwD5kB7hcUnmlpjRsJw4SwcY0u0zjxZRZy2J09v6luAPKWFYUj
         XPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743779; x=1793348579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnID61DBqXYExMRhfWZPF2Tk54RL2V7LncDliM0Ny80=;
        b=rFpze//FklBtD/s51pNnQ2I2fxgmeB5YWuMqtv3UzLoONHFYPjJhIWnRzetJihkw31
         1YP5kOqJ90yXuxIeQL+o1sE6NZLUtqSZZP5X1AFsb1ZGu5wMIO0ROD/30+lFoR7Nm94a
         MeskJPDbnKNVF4esdLIjmOjf1+N2I9O4lXeGmZ66wzaIG7VlBvdVcpw56Ph1iZELKbyo
         TOgOgAaqeewlvtYgWtrFbq3g70lyK6fwqolS1HiWsExVx6ovOvqo2XTCvs/1B8QLzLUv
         LDNFkT4xSC/hQpKavIuuUBvrocZo5JrmKXZsaYMK5NwEA2ZqLH4tP95sxuSO4ndZUxYC
         exUg==
X-Forwarded-Encrypted: i=1; AKwUvByRFB0ZXpbgDua0J9mtaY56Z3sjUH2E1mJzAVL2u/QthggaunOWBX04WKkeWvcvD+PjrzHR1ViJ6oJZMAOE7IzujAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOOFLM1LwrH5EH9A84ieg/0Tlc7Go/8S5U/xf8f1WgnHFkSjE2
	kFq/STQF7x/rjB0e/AqaDTMQGxtThpbY7YzDvJw/blhGRKILYbwiZHxmY/8bMKyEoo4NUR3ps3Q
	5zBBNHI+Q0f5VKi/zD/VmTGzjV0O88OqbbGwI8sE=
X-Gm-Gg: AYBFou0lLV6cZdFWlWUNrxPvcb+kpZC3BnyozPvGoDSdvmIMXi9FelLg7nWEqgtglG0
	RzUzCHxV28JsQAPVplXbw03Sm4DxtUidNYtlY4IDM5lhHLUOzlzIi9kI0OicbaTNyHI2kObEYP/
	I1r98zQ5p06r+zetMMKoRsdsrPv3TUXPCwB45AuqyzCtlDsDDF9QlxDHdIECn4wZe0z4nvgo9vZ
	/hdPpnmTa5UK1SucYPx8zaZt49qFzmQr6ty1CBlrJUfxJv1g6ueLRb5B/CkMx5fjmjqTDShJbrB
	553XjTpqwXtV1vmlsIZMLC35SSSDyzAEP7ClbXE99O+dxm7He2DUszu4tW50JbLu1dgGtQSxLPH
	2vjfMew83PgRisTk22Ml9Gruh05MpT5MJ39EkZAdWlRySORbJt72ux9pt6ZtCKVoJ72a90O8h3B
	eZ1mgihMnVS69tAYyMpwL+pQmKNYZS//DXQAxvFpcITpQPOeGtHLLijyXWzGVL1oJLP53nBl9NM
	tLUQjauulJHIxThc8KnbkWSdQOmj3KPfYUzTbQ=
X-Received: by 2002:a05:6122:3b85:b0:5e9:731b:84f3 with SMTP id
 71dfb90a1353d-5ec14a6c5damr433520e0c.12.1792743779585; Fri, 23 Oct 2026
 01:22:59 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021181626.2004489-1-edumucelli@gmail.com> <undine-1792630374135671788-0c3e675ffc202af4@undined.local>
In-Reply-To: <undine-1792630374135671788-0c3e675ffc202af4@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Fri, 23 Oct 2026 10:22:23 +0200
X-Gm-Features: AclHuK9WpOx2XOoSeKunyY_VJs8XYXEI0-YSZhd77j30Ylj2IWLLKn7cIiX0T78
Message-ID: <CAK0NWSMH0Xn1HrP-sbHgAveF4pR8D2LaSuvTZBX+g9Pzf_UnNw@mail.gmail.com>
Subject: Re: [PATCH] tools/bootconfig: Fix enabling all events in bconf2ftrace.sh
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Masami!

On Thu, Oct 22, 2026 at 2:52=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 21 Oct 2026 20:16:26 +0200, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > A bootconfig containing ftrace.event.enable makes bconf2ftrace.sh try t=
o
> > write to events/enable/enable. The per-event loop treats the global
> > enable key as an event named "enable" in a group with the same name.
> >
> > Since events/enable is a file, this write fails. With --apply, the scri=
pt
> > exits before it reaches the code that enables all events. The same thin=
g
> > happens with ftrace.instance.NAME.event.enable.
>
> Good catch!
>
> >
> > Skip the global enable key in the per-event loop and let the existing
> > global handler write to events/enable.
>
> This looks good to me. Let me pick it too.
>
> Thanks!
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>


--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
