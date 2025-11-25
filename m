Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E432860B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089607; cv=none; b=FkhwI4G5XpYd3sDM71fzkHkO6MlEaNQmRwxFWbrMEGGxJ3WeXKPaBUQfXuMqCpSLhBiVXSDBIlYvXIJTbV2ikojU4xR7WIU0d9vHdmHc+I9z7KO/TD2idBYgPAmIlAYSEIj6RxMsoNpOpGWisp6seCKJuQNC5A5HmS1BUPLBMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089607; c=relaxed/simple;
	bh=6e5KuEEpAl7/FnmosDxY2LU/5yEoEEeNxSYrHTEquBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2npd8QK1e59SxWbQkyfvfrHQV4sL8hERcFshH4mnB6QoY2txCB044XTmAa93UbPzQBqr3b8PYLxVe1yU3dg+WHI5NJuCqmxKw5QM/y1BlVe9uH+qWn+k1N/xEtzCfey9njLPQtTU4uQIxs9Dc6mcBuKMI6jQh/6+Um4rcqAP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvGLSMCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvGLSMCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9n5eHfbpL/gFGGuU9QmtP/kf1A5Fu1IN/W5ZKliVISU=;
	b=QvGLSMCOK69fZpPK3r1TK8pF5g5o1fywLlMGDltXd0DahdpMHSq+/DktEh/RnKUuM8EfyZ
	fxkkQPiWqF4t1q1d+G38z6BF/acAzCv/Is6ERNFuK00YCfZHFQEypArEPIVjE+e6ntPNiW
	W3LmdI/+8kC6KluD+m23oAApEc8uhI8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-eTeNc3GtP4qyH7yzORLUBg-1; Tue, 25 Nov 2025 11:53:22 -0500
X-MC-Unique: eTeNc3GtP4qyH7yzORLUBg-1
X-Mimecast-MFC-AGG-ID: eTeNc3GtP4qyH7yzORLUBg_1764089602
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-948610ae935so443211739f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 08:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089602; x=1764694402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNMLZqRfPhJPXYEU6Gk044z1ivuGtojcivk4hF8JaXg=;
        b=BvQ/bx/YLt+4nMBi9WJuRoIvwDYoG4qTjsSUJ9FGCIBCBOLM87A5d7823BUOcbyhGi
         sx0Ve86VrZ2LH7920TQiZhvFjm9siN2VsgKG3rO8Uv7qThHBfX5HjE/dmW51UW/cexkn
         qZJYISIhwAXHt+mDMY3+DuhGqYh5cGyeJmJD40P/a7TFAEJsqUW+D/2/fp4HgqoRww8D
         6TCxYUZvXk6V5JpQ5/Z3Cn4L2S5BcR6WSBzCubHp/d/6kiZ7A87VLfUy0EGVT9mv63w/
         5jw1ClSe5Cci1misunEQpLMDs2a6DqcMsgYSJP/QLl/ymP1+7Q5ZHXMsTz0g7F8b+//G
         1tjw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Gc0tYfESXESrCJpzPFwpvZfmIGJFiRk7tXBzdbLJaRB5FZWT6lM6y0K1mfrKPQmNzZXBguS7c6Erl5ArHcRxrqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmsm6duvTpYHZMyofGvz8C2PIXgu4kuy5/aiqOUNHMCBnYcy5v
	vFCmALxU/aYwT3Fd8qy6V4Q8nlFh5vGP5knu8pR5LU+SZ3/+Ul1w0Y2PZwnvtoao1bcx6hzNr96
	Q6TeQGCtvZ6Xrf9jBAzVlBmquJ2EdbCNB/cZbcFUASjM+SMmswmkWfei6+AUABSiPjzm0OMc1LA
	==
X-Gm-Gg: ASbGncsXfhubALPTKfIE2yo8Y3qc0akmCItq6LuRhSCUbE1xfj8qJEF6m3foGgqA1LR
	a8cZKdK/iXlESpqzDgLK6bQjLSGciAWyg3+lV+8lz68VCY8qPp7NJToZ6UQVQPAFInvkQx/yAgi
	S89pbeEqnTrM1UBi2uTZuDZ+j4g7EGypuhN4t50BiMOxMPvNrdAtCazzmlV7bIuyEsOjshInjPg
	RRpdKo6QbxkYiwn08zxTKePEbzxpPyswMxUmIgMmWJJ4elIZS/k+tJuFSZcITFXuZPk7KaZpjwj
	Imhn/OUuHumC06R+f/4v+eeW3Kx8p1VEfBgLzFQgWOpeJpC1IquhszPsG1X4xwmKXGGvzujs+qX
	4D+4s7EUelWKG3ccH9xg18iRY9lA=
X-Received: by 2002:a05:6638:2111:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b967a1abd1mr9586220173.10.1764089602174;
        Tue, 25 Nov 2025 08:53:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMP6cNmI2UgkIUu3TMBPDamSsDlTl2vwDYR9qa5lzTw9UsBLGDjISEJiS9NZjDSVu2t04ckw==
X-Received: by 2002:a05:6638:2111:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b967a1abd1mr9586204173.10.1764089601761;
        Tue, 25 Nov 2025 08:53:21 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b212basm7001250173.36.2025.11.25.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:53:21 -0800 (PST)
Message-ID: <301c25518ff81dc967187497a0577f8ee2fb2e29.camel@redhat.com>
Subject: Re: [rtla 05/13] rtla: Simplify argument parsing
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
 <jkacur@redhat.com>, Costa Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "open list:Real-time Linux Analysis (RTLA) tools"
	 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 25 Nov 2025 10:53:18 -0600
In-Reply-To: <oamfaffwyj6y3mtmhjxlk5u552xvdc4xd6is4dg2mxyh55ebe5@y6fsy73ig5ez>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-6-wander@redhat.com>
	 <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
	 <oamfaffwyj6y3mtmhjxlk5u552xvdc4xd6is4dg2mxyh55ebe5@y6fsy73ig5ez>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bckR7gPpgTeP7z_wGaEJILfe_lq-DBqVEmZ_ESGfzYk_1764089602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-11-25 at 10:45 -0300, Wander Lairson Costa wrote:
> On Mon, Nov 24, 2025 at 06:46:33PM -0600, Crystal Wood wrote:
> > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
> > > diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/=
utils.h
> > > index 160491f5de91c..f7ff548f7fba7 100644
> > > --- a/tools/tracing/rtla/src/utils.h
> > > +++ b/tools/tracing/rtla/src/utils.h
> > > @@ -13,8 +13,18 @@
> > >  #define MAX_NICE=09=0920
> > >  #define MIN_NICE=09=09-19
> > > =20
> > > -#define container_of(ptr, type, member)({=09=09=09\
> > > -=09const typeof(((type *)0)->member) *__mptr =3D (ptr);=09\
> > [snip]
> > > +#define container_of(ptr, type, member)({=09=09=09=09\
> > > +=09const typeof(((type *)0)->member) *__mptr =3D (ptr);=09=09\
> > >  =09(type *)((char *)__mptr - offsetof(type, member)) ; })
> >=20
> > It's easier to review patches when they don't make unrelated aesthetic
> > changes...
> >=20
>=20
> It is just git messing up the diff. No actual change.

The change was to the position of the backslashes.  Not a big deal, just
something that's helpful to avoid to get a cleaner diff.

-Crystal

