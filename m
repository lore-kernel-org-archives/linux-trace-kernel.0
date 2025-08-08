Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73691D514E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634070; cv=none; b=rTjze6Sg3koqpVoueYZThW811qeyy5j0ogUA4FIom/CSGbia0q1Iun1zl8tj9/5tqhGtTeB0kjO40CvRpL+u8VcELliQI4EqaR8RFLaL8PfvTFmGEib91Rs3RnzNmt1TC54aStuDpBuA1JxDF5uUMZH8Gxk2izIgN6cd56c4FYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634070; c=relaxed/simple;
	bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRNdl0TR14hCiY/b7yB/jvXwdp7eHY75PcelCUXKOSO/nEFTvzHgFkKQA0PLxPxvRlBNQtutHd/O/rC6mGj6arWlOACvupj6Gjx9pUNS7uv/WEB99IVwgUy1CT0bJbk6nkuSsIPSkidS/NIBUcabYyceN72DRjyCsWFyVjWEJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq3Gh4pr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq3Gh4pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754634067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
	b=Vq3Gh4proZxmKaeFnrB/6VStIadGNPiOeRMnXS/Z+qpwZQt4qSgPpjk05An/thmkc3/Qdr
	TKNlgOFjLn4kkpLQ2MEn1IdGLoOtL2dWupO7FAWOMHtI+FldAiisk5cGAxNg5KClQfPHBF
	L/KhQihZ0Z1QEIANlBmBWJSPM6TdWHQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-fMMyM3XSN5-NRi6VYyGAcw-1; Fri, 08 Aug 2025 02:21:06 -0400
X-MC-Unique: fMMyM3XSN5-NRi6VYyGAcw-1
X-Mimecast-MFC-AGG-ID: fMMyM3XSN5-NRi6VYyGAcw_1754634066
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b065932d0bso50474841cf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754634066; x=1755238866;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
        b=LboMipGY0+EIsT3rQqQzh7Gnfz+/TuWqTQehBWTqnON1leN9rJoDXfefGZYVLYYyJn
         JofdDu2v2nM6dYioD96QBSU+S8Xz2C0gUlGOQVLp3TwgxlkMFTK4i4bontwKEWxyTPSo
         NHvl1TuQ011Gjnqg06O3uL4m8UMrf/eUkc8zXl7IxUlYGwWCejz0sFWhcZfJZwZgg2g3
         mFnU1JGz/aBJyIWG0dV46oKfJRpH2FtfXBzc0xjz8NC7sywsxR0WmiIzCkTBljXH3BGi
         /UQ/+bld+H4Yh+eZERNkuFJfUtjv7RTxEnbHeaGmB65m5Y7zPEOYJSIY96xOKeoL0ktG
         RFFA==
X-Forwarded-Encrypted: i=1; AJvYcCVtabq3H8CyOMGzgjOOgnpDk3TBn8qVSgUDfpiiFQqu07I5JMN50e+GNebBWK9TFbVJkv0E8aGcxeC+4PnQVL+k+LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgyrrjDYz5EMsfLEcR7AIYsOczgAdn4ugiVpVrjASF84gwTT+
	8pHw0URiu5aT4mKKcQv2ZTM6DFbwocymr1hpKDdoYzk8NaXbBWMe2RZFBWAJTs4jtnsIcXQrrNM
	sDaX8vbCjW8i1cpnk1hWar4Twb62YPgghyPch16lNt2wfHOE2r/RKRausUH3GyXPvyBtaVTMwxA
	==
X-Gm-Gg: ASbGncu6BjvR6PdazDtb6xOxSjo1IFSCbLg6M7A6K0cBGaEhGUGm0E7/z1P05fTZ8UJ
	ZSYzZYmbNqmtdt4VMFxDv6XHVZ6zMJA7OlcOaAsxpIbR3YB4iQziIJh687HxTwDKd/BasFOJFgA
	uSfXQdm1ESPDwPPRLO2rnodsxAfY2LOj4VmCzksOCCHXluD/Rox8mHk2mP9ip/lCwTBK7mCXqxp
	8zSJWx5vEA+6PnQ024eIklOiEpLkijRJJmYuV4ErJafrHB2M9Pu+bGp3AS3YFdXIROR5ve/vXxy
	buN8/AxHnDxGdKBirjp6bIIZE6Tf1gAX+gGR4ycdkk5TawIocQ7jFx9PaS3ChOjnIA==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr29222591cf.31.1754634065763;
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn23V/fOnbpdI0/TPKTgI2uF4FeN2SOw7oOfkOZP16j9bR+mqT2PCGlqrhSZ8tf/3teGaa9Q==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr29222381cf.31.1754634065413;
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b076710ff1sm53950591cf.52.2025.08.07.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
Message-ID: <0d29da11a78f8c4b67f3a590bc015ba1ff4bfcf4.camel@redhat.com>
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 08:21:02 +0200
In-Reply-To: <87o6sqpfbj.fsf@yellow.woof>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
	 <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
	 <87o6sqpfbj.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NIzqa2lQgkhnqlPbuqY-Um23nV_oQA5SE3zM8N4JoXQ_1754634066
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-08 at 07:12 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > I get you're trying to be more type-agnostic, but I believe this
> > /online/ is a bit imprecise, unless you register a hotplug handler
> > and just initialise the online CPUs (much of an overkill I'd say).
> > What about something like "this is false if the monitor exists
> > already before the monitor is enabled"
>=20
> Sorry, after re-reading this one day later, I am still not sure why
> you says "online" is imprecise. Due to hotplug, CPUs can become
> online and offline.
>=20
> The current implementation ignore hotplug and initialize all possible
> CPUs as if they are all oneline. But if hotplug becomes important in
> the future, I may add a CPU hotplug handler.

Alright, I was probably a bit unclear with that, I don't mean the
implementation needs changes, only the wording.

> This is false if the monitor target is already online before the
> monitor is enabled.

becomes

> This is false if the CPU is already online before the monitor is
> enabled.

which is not always true, when starting the monitor, you initialise all
possible CPUs, also offline ones, which are still initialised with
@target_creation as false.

Mind I don't say you should change the value passed to ltl_target_init
nor change your logic, I only mean /online/ isn't the right word here.

Does this make more sense?

Thanks,
Gabriele

