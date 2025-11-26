Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448A2E7F32
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149638; cv=none; b=cngtZ3eWrEXKKLJ/zLdDcgFp6NBF+X6bL+Z/hyEsevRhtB21OKNYdlOLNTV2QAD05bkP1DkIyVww+bAUmEzmFW1q4kadDDZnJOk+qx+GYtfCVpCBkZe65vgQTqj2fWDFBNFqnZGaCho8wP2INL5R0PMJCLkw+U6EKoFP8BKLgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149638; c=relaxed/simple;
	bh=5FbMnTyrfV+qG+0zwyjlJlsCtBDvG9W+T9Nk2hljNPk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boC6Yii/hK4by7La287HZDT8GBOGdBLGSFKiM3ofDybZEjLUy4Ktr0KaOOxRPujVCrPHRlW4LX5TP6EN7l71i176j7FQSlQxtvX2kJasRXLp62sStKD8udixeEqo9omLP7wOzE7p2vZSf4pds8mCxL2lTvq+UYHOodleo2coid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmRJBQGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmRJBQGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764149636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5FbMnTyrfV+qG+0zwyjlJlsCtBDvG9W+T9Nk2hljNPk=;
	b=XmRJBQGpFWg6xA2DuwF3g31LGwOQMMfL0FZ1vne9JsGxLkAX0Av8CIvLTFilas+37HVtCT
	Oi1ha2YS4jt5hR7mxt6wmkNsEjzo4TWdgiw9QFi4sfCBa6bGN3P+wjfP/68cCwSCI4NI+K
	IeT7AKKjMsu5md6S3My5K5fZP1jMX0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-4tQhCQFCPreqa3LSQhZcHQ-1; Wed, 26 Nov 2025 04:33:54 -0500
X-MC-Unique: 4tQhCQFCPreqa3LSQhZcHQ-1
X-Mimecast-MFC-AGG-ID: 4tQhCQFCPreqa3LSQhZcHQ_1764149634
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cabba65dso28981975e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 01:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149633; x=1764754433;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCmLktXxJEqVth4IzXw4WRzHYYGXxF/eFRIihcIhd7s=;
        b=cxda8YlU0S8FOc8tQjikI4i2G86t0kKl7Beq7r4UkVctqh8v/NRlvkzXRdrUTtw0I4
         QLZNJSgHzClv9+1Uyhc0dtSEa1xh7j9vFEftDOW+CjeNjX9rrNpfxMOdmDjbc8qNqzAy
         B9ETLVMOL39EQAkdTmokoWwTdsxrh8nZqCGD42tIUcpH7v97IwShZbR9KdD6XGf5XzNn
         nszN9WmkSSQXZ+KhHCn8IueQXnjsxDkyljTrYUkslrVlPUCHB/7hY1FDh0GVc4RDCBSO
         QvPO/XMSu5cOxUfHwW3N7MUqLbVQQLDqyS7QPbuf68pcZwr4BjspAzydfGR49eZ4DmRs
         iDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbbaxHh/CV7DtF/xWoCGPKFH8KxnZs3UCwPbfeohl61VXEm+ct4hdkXKWoTaqkVX+YnbnT7k1p5M989UYmFsoiFcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJyTWB/2lxbNaAfUv+v/3va8c2EhY9cf2E4Fe5xZy5QGOpstT
	4/7AaGJG6vzvamiHdsUPkND5TqvBcaG31U9a0uTaN2FuWMNyzJMiCrm8qraOW6/1WDMNNaqEB4V
	QtD8VwtbthlS+AcxzthW7VJZWxOawUNi5DujCEETb5RNaL4PEn3MFC6V/3187kNyhtEJse37S7A
	==
X-Gm-Gg: ASbGncs+8qCawaoMpN75D0CYTJ27payxca9ZoDRLMk4qcdq9NLEhuoomJbqS6pDIqJQ
	0ZJiOhPMI70lT1uK0iXScxHEoH++21bO5ll11JU3mzA3df+JixcxI5bwFvZ9xY150pUjuWM2iT+
	65X26PwwqKAOjrWSJ36rTOWR1J5COpVYZH6vEY3Hq0w5cqpA5dio2dn2wrAJGkovjoVZvnEDqYl
	/HfuRaeAX7KsIsQg8BOhRvvnXXUc6ZutoiuKPR97NZeLvfZrLOEs0nDQbD5/TjBrZxO3lU25x0k
	pd+Y5k5AO996vuuNbU5RL0x/tTNY8YtjQSfHs1lVJDssdrWmzK5RfSEBDvDjwvv9ZFcNc1ydKFJ
	kBh4vn9Kkjcmal4mBfSB+OeNy/jUWhSTgWiI=
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477c0170782mr181020735e9.8.1764149633662;
        Wed, 26 Nov 2025 01:33:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTQkcjS1iYZ6d5htepGxVQeLZD2ukrzB85WZqTi1/b6nJWhdURU1dfjzkAAQHs9U7l9KaAjA==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477c0170782mr181020435e9.8.1764149633215;
        Wed, 26 Nov 2025 01:33:53 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adf5387sm32028765e9.12.2025.11.26.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:52 -0800 (PST)
Message-ID: <2803da35e4de12ef2ca966a69052bf228f1cd10f.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 10:33:51 +0100
In-Reply-To: <878qft5gxk.fsf@yellow.woof>
References: <cover.1763370183.git.namcao@linutronix.de>
	 <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	 <20251125145736.48c3ed9d@gandalf.local.home>
	 <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	 <878qft5gxk.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4A1GPxjKVo8fFbTKNzlLlAhIMxZ2pV55hRV2yrEQ30A_1764149634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-26 at 09:36 +0100, Nam Cao wrote:
> On Tue, 2025-11-25 at 14:57 -0500, Steven Rostedt wrote:
> > On Mon, 17 Nov 2025 09:06:02 +0000
> > Nam Cao <namcao@linutronix.de> wrote:
> >=20
> > > @@ -644,13 +640,11 @@ static ssize_t enabled_monitors_write(struct fi=
le
> > > *filp, const char __user *user
> > > =C2=A0=09=09else
> > > =C2=A0=09=09=09retval =3D rv_disable_monitor(mon);
> > > =C2=A0
> > > -=09=09if (!retval)
> > > -=09=09=09retval =3D count;
> > > -
> > > -=09=09break;
> > > +=09=09if (retval)
> > > +=09=09=09return retval;
> > > +=09=09return count;
> >=20
> > No biggy, but I wonder if this would look better as:
> >=20
> > =09=09return retval ? : count;
>=20
> Unless you really prefer it this way, I would rather not. The first time
> I saw this syntax, it confused the hell out of me. Took me some time
> scratching my head until I figured out that it is a GNU extension.
>=20
> I prefer to stay with the C standard unless there is major benefit not
> to.

To be fair, I find it a bit obscure as well, although it's frequently used
within the kernel.

Let's not change it then.

Thanks,
Gabriele

