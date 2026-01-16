Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C6339871
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575701; cv=none; b=F5vjZ3R/7uD+SrgnCY0y8q3xa08kr/qlarYajbx+nN09nqc2x3L/xtqNrpOF8d9GtXJFaDyY59Pl+2Yx9GvgF+aXLAVYr4jYf+ePGoeUILli/CWkMi+ZH4ZluWoLFpk1mclhoglQM/yXl3yeMk9tFVJfKDbcBa54vTxVwt537zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575701; c=relaxed/simple;
	bh=DgG6V6+gnO57Zu/Qsm8q4E/uJdoEAASINApgNq8vo00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=allMF7Xqp2vVWFtbHV7ARrKXQeib79y1OnRa7KTyzXSciollMqB9XkAqUdyAYvZUmQ3M2kmFvYES2Lrej7jFLoE1nf8RlVSY0c72UOeViwSGUzgMQKpt6bPEaazOVvW5ISqgpNgxRaobrJVQsphV7VXcA46ZDOVgKr51nCtpktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e06mldx3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e06mldx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768575698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DgG6V6+gnO57Zu/Qsm8q4E/uJdoEAASINApgNq8vo00=;
	b=e06mldx3dBgXlipGMg5JO7xWMbTk1bxZ90fDLcPXBXGHAFX6E3N+Uxahmo9xEGJL43gBE0
	oQngf2hiuDOPo9Alv5OBz0DnJ4vVLK80DMXddDdNGxA6dB9uVGE/5ZFDttfL+uGvFFrxTr
	sxJ7k5X5WAIv+5Kdf2Whg9sIOB2z9Q0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-BpTosawANNudo7RPMDjncA-1; Fri, 16 Jan 2026 10:01:36 -0500
X-MC-Unique: BpTosawANNudo7RPMDjncA-1
X-Mimecast-MFC-AGG-ID: BpTosawANNudo7RPMDjncA_1768575695
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcf10287so1824714f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768575695; x=1769180495;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKg+lg08Z6N5Xk6F7Tf5pQeMj1OVmK93OUBlVqb40gM=;
        b=BXcCH14XqT1TNwlsYKvPgtK7lbV4+ML6Kogpgjvh0QhHqxAsGxFiKuAyESK6m+We5s
         g5t70tTDteK7EXfqCMDwMaoaxNrdlMih3cIMVGIo/PF1I2alZYKEYKZmYNUEiadOhWWh
         fbSjc8B0CWbelq/sHdzEN+HFd6upUcHnfHQshwoYWbJ32S0vtP8r4eijPjbZvdOQA+Uu
         SZuFqQ+IyGBYrVWuATIaOqCBHsFcIZJY+U0rHhuz52oY2uaI8EQceS2bTfDuxFAyFHKo
         W6J45xD3HpQeW1bklXK7ABajCiGQafJzH5dNDc7HpNMDbVX60Rb0K6A4V+8XVtQ7NAFD
         NJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQmJXz0a3XoNk8Wz8msrADj/7u1WZ94oMvCTnWrTAcpEQSrGt18pc38e+5OzkIdfqX3ez5JXJRzOjpnFlA+G/XHo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGr9hx48rxXJjspxVUv5r7ASCijIFPNDRK9MSXVIh6nhClwyT6
	vmNlSsZIT0ReD1X4ytJ/PHxQ29f4WtFIzXFOCbrjckF/mJF52+2qbIOEWid58hGHZ1cIZC6kzOW
	/SKTJdBCkwufEZYpGfA79JnI4Qc8Xv0hrteLmM4ahLfwJF/zXDxdH7J7HU/icDQjwhKg5B2l5Yw
	==
X-Gm-Gg: AY/fxX7JRr34TMWMZSQQtAJF+lnXAGuMNLadIy2ZMl4xRKIwuzFcwJ5KO6+ZqR7Doqr
	UM/PW/Oo3j65LI+OwwgrOwcsSPutYrHRjWRd62+b3V/f677weMobtSGiG0hJGhTEW17KM/BcU8+
	A0bgrqmmnCM106jQ3VojWdVtnyra98ml4HW5JzFd7x7QsqjrmAg6UaM1Lfiu3EChuqM/DsynEoc
	STbLg5lTzsLDmXuKBAyQQN2cg0tN1z9hL0+uCegISjyBMLK76E0BYd0OF5ZuVhdXmsMWVJG1bl9
	D/BwXuSXUuw3FX7hb70GAXhc0tUP595jxhGnWYVXgXppQcAcR1M7H8xXCICUqoQ+S2+qK27/Xw0
	4vUyyaJjOv90XuFzf1Jkuu731bP9IUtRbrEiBPixCwQVhxYiDhZtM7Wd8USNWKSyiVrDniQY26o
	nwDgcLPlAC
X-Received: by 2002:a05:6000:2387:b0:430:fbad:687a with SMTP id ffacd0b85a97d-4356997f7bfmr4389019f8f.13.1768575694252;
        Fri, 16 Jan 2026 07:01:34 -0800 (PST)
X-Received: by 2002:a05:6000:2387:b0:430:fbad:687a with SMTP id ffacd0b85a97d-4356997f7bfmr4388934f8f.13.1768575693570;
        Fri, 16 Jan 2026 07:01:33 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm5596932f8f.15.2026.01.16.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:01:33 -0800 (PST)
Message-ID: <5e6c71ca24103a54c4909ae57e58544aec4a56be.camel@redhat.com>
Subject: Re: [PATCH v4 10/15] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Clark Williams <williams@redhat.com>,
  John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>,  Nam Cao <namcao@linutronix.de>, Juri Lelli
 <jlelli@redhat.com>, Masami Hiramatsu	 <mhiramat@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra	 <peterz@infradead.org>,
 linux-trace-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 16:01:30 +0100
In-Reply-To: <17f243a1-8977-4d52-aa26-d4556d62e12f@amd.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
	 <20260116123911.130300-11-gmonaco@redhat.com>
	 <17f243a1-8977-4d52-aa26-d4556d62e12f@amd.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OuPrZEgznr6LvHHxA3khuXWzBrOQLYGAVRV4F5wLaIU_1768575695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-16 at 20:20 +0530, K Prateek Nayak wrote:
> Hello Gabriele, Nam,
>=20
> On 1/16/2026 6:09 PM, Gabriele Monaco wrote:
> > @@ -2087,6 +2087,8 @@ unsigned long get_wchan(struct task_struct *p)
> > =C2=A0
> > =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags=
)
> > =C2=A0{
>=20
> For delayed task, I think you'll need:
>=20
> =09if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
>=20
> > +=09=09trace_sched_enqueue_tp(p, rq->cpu);
> > +
> > =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> > =C2=A0=09=09update_rq_clock(rq);
>=20
> Since delayed tasks haven't hit __block_task(), they are essentially
> still enqueued. Peter should be able to confirm. Other than that,
> the placements of the tracepoints look good now. Feel free to include:
>=20
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Mmh, I was sure I missed something after the comments on Nam's patch, thank=
s for
the heads up and review!

Going to try your suggestion.

Thanks,
Gabriele

