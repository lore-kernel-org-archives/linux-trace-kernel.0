Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7191A38EB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427175; cv=none; b=pMt54tv1xuxkdDPS0t/XGF5CiMhDDa+W7cNbxoSFsTxXYbpNqtxvFBPc7VgxqTxWGV+QCw8Wu6Ih6s+adv8/wObC95xOrdEkVqJZ8wG2sP1vAMlyte+aKlNOfuYu+pssvNwve+Gf2p+/TvE4wBTGBbj5vii6h3lLEUC6acw3CLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427175; c=relaxed/simple;
	bh=vxl3u3WXfRj6lyIUGOSPlktvZvIM1aUTg0zHeU3OxdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCNDME/LOywVnHE3E9gcTl0yFgKHuxR9R/meaaUp495nR2CVlwpMPpI02l4jMTj1na/oiuPqlXeJcx/55jcv2yTTJDBd9EBihWZluT/mRPbd1+XZYKLg++0GcVN7B4BqxG/kN1mGWmcme5OjnAnHLhlulm7xSMuCe8XLGDIMgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjovP7bG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjovP7bG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710427172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46Gk98TBlJosFPvzkzPm67bCiV+KyQM8YPOxOMd7pII=;
	b=HjovP7bGs/iZy4q2yyvtvJbg0HSaz+wRCRGCD6oMrO31a+JdXpu1GSFBD0hMmWGOgZ1bC3
	3ffsR8+YDHtL2pOgojuJWRmRnoWd/K0zoDuCDIapnLGUfnqBDuYcf/Tz0EH5xl0PGD09nx
	/9A++Ldam0mi764AL8zXlLXsgSvuVEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-mUKCHP1cPbCR5cACGpZm3Q-1; Thu, 14 Mar 2024 10:39:31 -0400
X-MC-Unique: mUKCHP1cPbCR5cACGpZm3Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e4303fceaso701715e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427170; x=1711031970;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uu+6Lcsc167aknt17gHSlt6RJtJnzw0KlGtcQvx6o9I=;
        b=YpObEvJNLq5V0AeO0bFai174pnrHDDeFWYFvY+GZAkIT2jSOGalFmCYAbd7HI4IP3k
         RtmvzSwASgxWg2O9b6GigQ0Sr4mLYL/PJZ+EOD/Rwrh64OsNUDQt0aTmVp2sM1X/Iaje
         KS00YVRe9PchNu59NIUKt9ckJ3wY+H4fngjvl72B1uO2Vbj5jruDGnczCfFQnu/dpttT
         fESo9/v1L3fGCV86Ro3jnVjTrBnKzPRknwU7EheCja8fAejO0drE34dghgXZhZHE8SHX
         uIqoPInv0rMSbYYySe2yDRDDw/9lJ6hSCOy0YfKqGkLryXjVH7mLXbYP3tLdu9uv1P8f
         f1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUImzHgftocEHKXjJj9S8L7y/+ALPi6khSoifnms+q9/Tkf1fJEPtZhs0HQW8H+oHQOPs+v2cXOzHKRnBAjLwaK8qKaEA6h0ZmtHD2GnP8bJ6OP
X-Gm-Message-State: AOJu0YzA1jeYr2E9sqURDmWP99NDRLBUjUdvWjnhx3yiswOFSaWxkcRN
	2FDz+VJcK8V6RT2e2jmJkp3/6cXTcQ2PBLJLd3xZW1BUt99s3sNCZu9verFbwnJ15NBDFZN6IPN
	cH0w8Ed01nAlLna3WyFnxVfxCnjzafh47Ls7ss+cmnoaPm2HZPRch3sANvRjE6z7Espjhig==
X-Received: by 2002:a05:600c:45c8:b0:413:ebfb:aef with SMTP id s8-20020a05600c45c800b00413ebfb0aefmr1628744wmo.4.1710427170376;
        Thu, 14 Mar 2024 07:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmvdjJr4wkiWWW/fJFayTEBhIFmvVEFkGnaixiKzLYCX5/kChL5fqaIzwFodLALgl9OvTfUg==
X-Received: by 2002:a05:600c:45c8:b0:413:ebfb:aef with SMTP id s8-20020a05600c45c800b00413ebfb0aefmr1628722wmo.4.1710427170005;
        Thu, 14 Mar 2024 07:39:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-217.dyn.eolo.it. [146.241.230.217])
        by smtp.gmail.com with ESMTPSA id bh26-20020a05600c3d1a00b00413ee67f741sm3647861wmb.13.2024.03.14.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:39:29 -0700 (PDT)
Message-ID: <8607787b42e80503e0259f41e0bcc2d3ff770355.camel@redhat.com>
Subject: Re: [PATCH] net: hns3: tracing: fix hclgevf trace event strings
From: Paolo Abeni <pabeni@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>,  Jijie Shao <shaojijie@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Yufeng Mo <moyufeng@huawei.com>, Huazhong Tan
 <tanhuazhong@huawei.com>
Date: Thu, 14 Mar 2024 15:39:28 +0100
In-Reply-To: <20240313093454.3909afe7@gandalf.local.home>
References: <20240313093454.3909afe7@gandalf.local.home>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-03-13 at 09:34 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> [
>    Note, I need to take this patch through my tree, so I'm looking for ac=
ks.

Note that this device driver is changing quite rapidly, so I expect
some conflicts here later. I guess Liuns will have to handle them ;)

>    This causes the build to fail when I add the __assign_str() check, whi=
ch
>    I was about to push to Linus, but it breaks allmodconfig due to this e=
rror.
> ]
>=20
> The __string() and __assign_str() helper macros of the TRACE_EVENT() macr=
o
> are going through some optimizations where only the source string of
> __string() will be used and the __assign_str() source will be ignored and
> later removed.
>=20
> To make sure that there's no issues, a new check is added between the
> __string() src argument and the __assign_str() src argument that does a
> strcmp() to make sure they are the same string.
>=20
> The hclgevf trace events have:
>=20
>   __assign_str(devname, &hdev->nic.kinfo.netdev->name);
>=20
> Which triggers the warning:
>=20
> hclgevf_trace.h:34:39: error: passing argument 1 of =E2=80=98strcmp=E2=80=
=99 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>    34 |                 __assign_str(devname, &hdev->nic.kinfo.netdev->na=
me);
>  [..]
> arch/x86/include/asm/string_64.h:75:24: note: expected =E2=80=98const cha=
r *=E2=80=99 but argument is of type =E2=80=98char (*)[16]=E2=80=99
>    75 | int strcmp(const char *cs, const char *ct);
>       |            ~~~~~~~~~~~~^~
>=20
>=20
> Because __assign_str() now has:
>=20
> =09WARN_ON_ONCE(__builtin_constant_p(src) ?=09=09\
> =09=09     strcmp((src), __data_offsets.dst##_ptr_) :=09\
> =09=09     (src) !=3D __data_offsets.dst##_ptr_);=09\
>=20
> The problem is the '&' on hdev->nic.kinfo.netdev->name. That's because
> that name is:
>=20
> =09char=09=09=09name[IFNAMSIZ]
>=20
> Where passing an address '&' of a char array is not compatible with strcm=
p().
>=20
> The '&' is not necessary, remove it.
>=20
> Fixes: d8355240cf8fb ("net: hns3: add trace event support for PF/VF mailb=
ox")

checkpactch in strict mode complains the hash is not 12 char long.

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

FWIW

Acked-by: Paolo Abeni <pabeni@redhat.com>

