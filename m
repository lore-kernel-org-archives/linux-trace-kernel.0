Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D73298988
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363414; cv=none; b=lVp22GIonF8YA83lvhjOLSqQGnX+H4DSI0XFa0u2isBEftSP6D1bJeLKomQLJQ5HvWEV1nd1m1iQ2eOp2OyLiTQpUjCZEwYdAjjCZ8xTACsBvdYr9Akkjyw0zOeJEtDxhFU/Mb9omGdbuJc2cJUVk1Bvnx5dJpfORLzFUu01rig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363414; c=relaxed/simple;
	bh=NTeluDA+UExIeyzPxDkNUEsmtLJGhWL23hC/QxiF8ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEl9xkWN9iYABhNXJiP0Ojkr1gaysqAz+YB2nEsGrMeJsvgrkkRjf38oF/ZUOqDhQeTMpUIIcDG50SMSWTXgsK7P6ItsJT4vuYaT8Ixkb3pnBh5Vy2D+rWEkM4bnO5oZRA9nENFuC7WJpIN31JoWfqhZh8IFMEz4v9kz7dC+U9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOONytFA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOONytFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744363410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NTeluDA+UExIeyzPxDkNUEsmtLJGhWL23hC/QxiF8ac=;
	b=JOONytFAUhew5t+TrnFeD4pk/j/AokjgIlyAS+7xZqeSveKSLdJYBSdmLO1oaObYoswmPn
	TqgBKaV+hJ3glacu0SEt7kUcoZKmswtcIoIfsQWJRB34O0etd+OeF4GmKRjsBzRPl33sXw
	cXZ1C4fC9gkypNkrG2M3gggDPAN4dgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-Q_K6siFiOL607MzwBNrr3g-1; Fri, 11 Apr 2025 05:23:29 -0400
X-MC-Unique: Q_K6siFiOL607MzwBNrr3g-1
X-Mimecast-MFC-AGG-ID: Q_K6siFiOL607MzwBNrr3g_1744363408
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fc9861cso638098f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 02:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744363408; x=1744968208;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teC0q40Smb9/sHs5ms88/N+VZamOe+tf/CzSvYEeiXA=;
        b=VlLKI2eOy/ZgTJvYiKFQaxw0l6pO8O56eH4F2Hnw4roz8a8O21qTXyCivgzgUMWSfB
         pPMFXl+39GShqRYPsZ8R9H6i1anr+JsKEqZlgs7oOydXPVUn0OVf76cczvVZPHtIwSUu
         +Dis8M9mQQKqAX+OKp84oYM4u7oCu18D18rE+oBv0btZo4xefv21UOkfb60ud47HkOoN
         j4d97j5Qxrbhkq5gCFTx0MpiVSfYqzVgtFu//wltfpCppe4NaCfUtW0gQbel/0pLxoPd
         rVopqEPhGOT/2ABBuvXs1fNZgBVzwHfLnGiEh0IP4LsjHTddM/9J++7NnIPB4lHELjT0
         8fLw==
X-Forwarded-Encrypted: i=1; AJvYcCVaZN3u6KFtYZxebUXH4gWQtTLJeJg0YSm9CTiCehgcMlRcCwvP5M7P6YV/Lpw6vmSKBHf78sI2MM56oWlOgdEOClY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV79eIVuFv+TMfbea8w8ytbLZIWAN+sfywUg8BCfAGKTPJncpE
	bCN8xK7i74Jhj8pKIcHmyPZJd/CyOiUDo4bjkvHyY5Ckfaujr4Dh5fZHbseeBBYK//gcy8kUa06
	quWWN4liVIOlr/qQx8BvOy4wizirRx4fA2cnyQVHSrLpHxnimG68tEcnTcjdHbebUARb3KhWekm
	qD0kC0
X-Gm-Gg: ASbGnctNAyfxdTS3lXQ1HYbjXqwzsxJRhF1afqnKCZ2+VNBrk8rcwXBePl3oztwTblN
	IvUpiOQl5aLXuSHZ+sMKKeriTmHtEzeaTV5NrFpfghfB8wrhAPg1FSGj+bzN7IsIE4dc1kXXgu4
	onuP+marRDQ9rnVOToi7+bIyzkDtl4zPEqMtIm1KRwZkSi4WQxGvjcU9OiGJAPtv0xwTL3LsyYp
	mt4pGNQ4PS9KuWlVvsYqCWd0zgXvfKmNFyUYmSrwy5s3popwNmE4Aw47TT9oA3KRcMWGqz2QMee
	o5Sa1up8cnLR4fCGit9GrYtCtlWNlHw/8azXBQ==
X-Received: by 2002:a5d:64c2:0:b0:39c:1257:dbaa with SMTP id ffacd0b85a97d-39eaaed2bf4mr1448087f8f.58.1744363408059;
        Fri, 11 Apr 2025 02:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFneGmB5fJfuY1chs3kxwXYmp6QcLLE3ridOAtRmVdVv1WXcFqESDfHiQrxjkVyOXYb9zOWLw==
X-Received: by 2002:a5d:64c2:0:b0:39c:1257:dbaa with SMTP id ffacd0b85a97d-39eaaed2bf4mr1448068f8f.58.1744363407737;
        Fri, 11 Apr 2025 02:23:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cceesm1422858f8f.73.2025.04.11.02.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 02:23:27 -0700 (PDT)
Message-ID: <4b4c9ac8411e6398b7d4487541d978f908785d27.camel@redhat.com>
Subject: Re: [PATCH v2 04/22] verification/dot2k: Make it possible to invoke
 dot2k without installation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: john.ogness@linutronix.de, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 11:23:25 +0200
In-Reply-To: <caa6a7668f958c68fc7b8a40256e3edf3f11ae99.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <caa6a7668f958c68fc7b8a40256e3edf3f11ae99.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o4Swq2xdSlTBwDXUoi07JJ74h8w7b30IZsaN3xo-M2E_1744363408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> Without installation, dot2k doesn't work:
>=20
> namcao@yellow:~/linux/tools/verification$ python3 ./dot2/dot2k
> Traceback (most recent call last):
> =C2=A0 File "/home/namcao/linux/tools/verification/./dot2/dot2k", line 12=
,
> in <module>
> =C2=A0=C2=A0=C2=A0 from dot2.dot2k import dot2k
> ModuleNotFoundError: No module named 'dot2'
>=20
> Installing dot2k to the system is not always desirable. Sometimes it
> is not
> even possible (e.g. no root permission).
>=20
> Restructure the files to make it work without installing.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Mmh, the workflow

pushd tools/verification
...
popd

has always been working in my case, but probably that's because I have
PYTHONPATH=3D"." , not sure how much of a good practice that is.

Anyway, since you're already moving things around in 9/22
("verification/dot2k: Prepare the frontend for LTL inclusion"), does it
make sense to keep the commits separated? Or you could directly move to
rvgen here and just add the ltl related changes in the later commit.

Also, after your changes on my system, I can run the script from the
kernel directory too, which is much better than having to cd to
tools/verification .
If that's something portable, I'd change the default definition of
monitor_templates_dir and allow the user to run the script only from
the kernel root.

What do you think?

Thanks,
Gabriele

> ---
> =C2=A0tools/verification/dot2/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
> =C2=A0tools/verification/dot2/{ =3D> dot2}/automata.py | 0
> =C2=A0tools/verification/dot2/{ =3D> dot2}/dot2c.py=C2=A0=C2=A0=C2=A0 | 0
> =C2=A0tools/verification/dot2/{ =3D> dot2}/dot2k.py=C2=A0=C2=A0=C2=A0 | 0
> =C2=A04 files changed, 3 insertions(+), 3 deletions(-)
> =C2=A0rename tools/verification/dot2/{ =3D> dot2}/automata.py (100%)
> =C2=A0rename tools/verification/dot2/{ =3D> dot2}/dot2c.py (100%)
> =C2=A0rename tools/verification/dot2/{ =3D> dot2}/dot2k.py (100%)
>=20
> diff --git a/tools/verification/dot2/Makefile
> b/tools/verification/dot2/Makefile
> index 021beb07a521..7a2ec30014b0 100644
> --- a/tools/verification/dot2/Makefile
> +++ b/tools/verification/dot2/Makefile
> @@ -16,10 +16,10 @@ clean:
> =C2=A0
> =C2=A0.PHONY: install
> =C2=A0install:
> -=09$(INSTALL) automata.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/automata.py
> -=09$(INSTALL) dot2c.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/dot2c.py
> +=09$(INSTALL) dot2/automata.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/automata.py
> +=09$(INSTALL) dot2/dot2c.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/dot2c.py
> =C2=A0=09$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
> -=09$(INSTALL) dot2k.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/dot2k.py
> +=09$(INSTALL) dot2/dot2k.py -D -m 644
> $(DESTDIR)$(PYLIB)/dot2/dot2k.py
> =C2=A0=09$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
> =C2=A0
> =C2=A0=09mkdir -p ${miscdir}/
> diff --git a/tools/verification/dot2/automata.py
> b/tools/verification/dot2/dot2/automata.py
> similarity index 100%
> rename from tools/verification/dot2/automata.py
> rename to tools/verification/dot2/dot2/automata.py
> diff --git a/tools/verification/dot2/dot2c.py
> b/tools/verification/dot2/dot2/dot2c.py
> similarity index 100%
> rename from tools/verification/dot2/dot2c.py
> rename to tools/verification/dot2/dot2/dot2c.py
> diff --git a/tools/verification/dot2/dot2k.py
> b/tools/verification/dot2/dot2/dot2k.py
> similarity index 100%
> rename from tools/verification/dot2/dot2k.py
> rename to tools/verification/dot2/dot2/dot2k.py

