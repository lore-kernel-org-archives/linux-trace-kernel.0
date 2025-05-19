Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62B26AA8A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644114; cv=none; b=MlPquiNG05NxLefKRykPBncCtygriWDN0HqWi1ghPdcL9t5xAkIiHSlyhG8J57qXjbCMTM4VUeYXWnGBrF7SqBwiIahoqxQFS9EKL+fs4i3beenikM71DbnX2DauC/CO6KV2IBqpwLSp07RXmprJvGOauO5a466D+Mct8pl9jPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644114; c=relaxed/simple;
	bh=iHHPuNUYPouIDp9w6UdrSX4oHKfC/CYMOkqUmWEy3SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rU6nz2XOr6GE8xjfhLDgT35XzA2i8IlsSOsy7VmzDh66emS3Pwd37gorhMf2L8cif5B4MOAf6kwflAbpAM/mUoUuJ/YGfS8eg8yWKBq1yhR/WcK3vdcZ9uzOTIg9uCOI6mUGHPiof+le/rduIdkh2kh0kMK2q5sfIYpZIqVB3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6V+ioQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6V+ioQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747644111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHHPuNUYPouIDp9w6UdrSX4oHKfC/CYMOkqUmWEy3SE=;
	b=h6V+ioQGfFwvFBPga94fkaPl3UEKu71vFWATPmuclxK0rgqtUz1UcTSxKiEYfgqyIvyZG4
	AkODLPnUS8jRLQMtbomu/1xIGG3RZSBEyvCMA7Bq7uHA4ARnmJbuIBNrs4fdjf5Ny46Ghf
	V56o6a4lGV+jDEvrFB9vSSDDjm/CLzM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-CopkFVIsP8SCZDJijaCByQ-1; Mon, 19 May 2025 04:41:50 -0400
X-MC-Unique: CopkFVIsP8SCZDJijaCByQ-1
X-Mimecast-MFC-AGG-ID: CopkFVIsP8SCZDJijaCByQ_1747644109
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-445135eb689so6400325e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747644109; x=1748248909;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/93kRZ04MljWKTXpgSsuqhHDlJ+9nDlXduLY3K5LE4=;
        b=SVsgKTlalB9JOghnNwh6ye6SFntKJ6VmqefxusJj3eTMYOD6iuYKvnRsOkC9nfjiQR
         Cnjge6a3sqOzMGR9VRyWGB+SxS2LiSC+l146agiFnZwdC7xroT13O9qgBNRMdZRShsEM
         DZwZhSrF6SrfHYvqWPQ92B4LGcTa9gT7jRjqUiTbw++7nsUeIGq5CB6RReXm3caXqtMy
         QSAHBWR7k0EsbdsxaqN8zm0E2JVFjyE9JrIwwnPDqSgd4bnQTS+qsAS2x6GbbO908jPH
         w9m1YTy0ZcLshHWs6RGoeX5vkqDHAIG6qXS39gzfsnqR1IznIPRIcEVEklS9UQOpghbV
         FZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhql9h6QegcpDj8ljPAEkITdZS58Kfy6IpISZQSt9EjM4glnsbWW2bGBWFF9vWCE75cN14XXa7y0kkPJRiLlkJHE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCdD+2uy2RTQqISUo+p6oDIXdOKGDHUaCiMA7XawdS3yav+On
	pOV4hlHBPznBsPtyD5XNrVpFDGENFr5TwvfWsMnlic6KUTxkeJp4D+DtfcUGtq6VtCG3h59Al10
	aOGI3LuXB4Z//GlUrR3dhX7lac2remj7dcxOGd6VPxCKSZhUOeYk9zIQdWc00BjS6GycMIJDmmg
	==
X-Gm-Gg: ASbGncv/5bjV3G9c5DUd23oxfWImcRUUrXmy+TfErsbDnsFMMK5gp618p/Ko72zD5VQ
	fiZmSeISvrWFxV1dMbJD++4U8ObjG+EOda1w3WcQHrahqO+Ob0qaOZH4ziJzP3FKPc7yFsqErSO
	b6QUcY4zmaIocq2x9aRtf4Y8WPHYorAi6ujmOz2ElFudIxbUCJsMZxIGA6DwLZj6dqHy4nEmj9B
	yXHIWNIM8hRRHXHQfPfPSbxgggTTFwsIZ/GLc1alynR0j81rA4c3tsAumbEuklsAKnLFu9qMOY1
	n1Rm4YflxguBsvk0gy8y9nsC2028eRAT0yHq/w==
X-Received: by 2002:a5d:5f4a:0:b0:3a3:6c61:9d52 with SMTP id ffacd0b85a97d-3a36c619e19mr3264662f8f.18.1747644109324;
        Mon, 19 May 2025 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH28JFnGXE2eWgrYdBC+axL242T6gdtGDhErZoZ6MaHmnwYhN6EO7AXsV9hXveJ9/cPyNzopg==
X-Received: by 2002:a5d:5f4a:0:b0:3a3:6c61:9d52 with SMTP id ffacd0b85a97d-3a36c619e19mr3264637f8f.18.1747644108994;
        Mon, 19 May 2025 01:41:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a366e08747sm8498929f8f.95.2025.05.19.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:41:48 -0700 (PDT)
Message-ID: <5385360f8f01a213ec3918dbc341f48339d7b8e5.camel@redhat.com>
Subject: Re: [RFC PATCH v2 06/12] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu	 <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Tomas Glozar	 <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>
Date: Mon, 19 May 2025 10:41:47 +0200
In-Reply-To: <20250519082908.Nak_YDaO@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-7-gmonaco@redhat.com>
	 <20250519082908.Nak_YDaO@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0m1Q_nLMBOXP89Yoj-bkJWRnExL3tSXUrElSfYsZ204_1747644109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-05-19 at 10:29 +0200, Nam Cao wrote:
> On Wed, May 14, 2025 at 10:43:08AM +0200, Gabriele Monaco wrote:
> > =C2=A0DECLARE_TRACE_CONDITION(sched_set_state_tp,
> > -=09TP_PROTO(struct task_struct *tsk, int state),
> > -=09TP_ARGS(tsk, state),
> > +=09TP_PROTO(struct task_struct *tsk, int state, bool
> > from_signal),
> > +=09TP_ARGS(tsk, state, from_signal),
> > =C2=A0=09TP_CONDITION(!!(tsk->__state) !=3D !!state));
>=20
> Doesn't this break the build? Because the monitors still use the old
> signatures?
>=20
> I understand you adapt the monitor to this new signature in a follow-
> up
> patch. But every commits in the series should be buildable, otherwise
> you
> break "git bisect".
>=20

Yeah good point, do you suggest at least fixing signatures in monitors
inside this commit?
I can keep the other commits to actually fix/adapt monitors but at
least allow building from here.

Thanks,
Gabriele

