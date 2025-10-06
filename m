Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205C78F36
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763971; cv=none; b=JKgMFmg+yd01vT1a79p8rx+DZvkseRfXw96gwZov7hGXghVdfvgi2mjdPq2ptcdLk/3KpzNlmSzMQvwoaoFfpYtuZWf8HIofUBuqjHB9/lZaTsAUGc0VSwC6HWOSo3h3581UkGP8rhbgitP8SXW9E0HIpsf5AETpvSwY04T0T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763971; c=relaxed/simple;
	bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMZIEeLXNLaIApMqXENIbRsurykZpWWBJmosgk3H06IWhNx1cePmS+LuH+pQUozSkhAWP2hJOrOuDnkVWaKSAtc8GPPgdNPy3LzTFMhdae2A1j7pHE9G0KzjrGHVESTB+2OFmlC9xX/TTHYkzztkm3xZvyi74Slqbqmsq6aDUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhbWbKGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhbWbKGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759763968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
	b=ZhbWbKGkpb5pShtVJd0ENEIMgIuKP8eicYnDLbTjLRySxxrkwJB9V/Sr9e/bT/b5QWrP4f
	w8Dhii8Vy3GmdbWZzAeHiXTr0fc1tGon1HKqnIgaa2/Bw9Wb5rdg9GrLh4ahIn7j5w/qO8
	1x4/iPe+KQTNRsQ+Hjv5HaIumvakP84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-fWSHusOcOrqtVatNQaB1Jg-1; Mon, 06 Oct 2025 11:19:27 -0400
X-MC-Unique: fWSHusOcOrqtVatNQaB1Jg-1
X-Mimecast-MFC-AGG-ID: fWSHusOcOrqtVatNQaB1Jg_1759763967
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so3545533f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759763966; x=1760368766;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSfsbYVXfa4yZWYa7PwAUZH5Ynxmc9HSGg8nJqJMmk4=;
        b=UAu2uI3E4K1V2vFWuZYVK/xm5OGAq0+fRcIp2Vp8B+ZBLZvo56nEhlgmETXhGLh4mi
         /O1YHN2R6WlK7r8CO7b4J3ArQ7UxMZPPfk5yXhiNth36jjHu1IgggfeOp2UW9p7r2d/4
         HeK56J39sIZccR9cFGuGTs4B8Ksgaegap8Lwm+TX4Y21s101MSDO97AqpD4i1ANx4eRF
         PbKXVuQnmFzBWcPp8I6EBgJsLXs1Y0D9rOSbOF5wbu95Je9PvfjgtxdlZXgICcwnWN6E
         uRb/aKQF7gbFCPIdN2JNR87jRgdkN85+Mzn7G7oK6S9AHY7Q8rXTtJLmCnMWSXdOURbV
         eg0g==
X-Forwarded-Encrypted: i=1; AJvYcCW7jlbkK8s8bwBdVqcdB8rPL/FcitCNxb97omOakAu58nm+qgcFrFgxMIkpRI1FwPv3GFCAEeUvsXUCNciVJQhq9d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCsM/6Rd5j24sHR9W7y6HmFCyiL6CtFXIh/BL8T7Jal+YzwMZ
	U1xfD3mbe0BL6slgPej6JVA44AgEhGfOeUnbVRaz84cM91J3TtHX0JEBTSsf5Cj3wniV/J/ZCiH
	1muu9WHiuc6RtvXGvNPcZcfUrb1EG9nZHi9IqBQuibrtR3+6OqtVUtwpUAqfu2z1aOt4CwNrADx
	vwV3wtXuWI
X-Gm-Gg: ASbGncujxSxUsO/dSEVAsAuNCdYG2nx7f5LNh3s7HB1lhsQjXOFdZk+Aw4ywAPNoC14
	EKrzzob8xCdkCIU5FCNHj3iTlkSKrrkqG3FUU6HeczEXU7DKKivrVOh890EF8WtOiFntLQ98xBp
	1RHZcoMn7fSGMRVrLJ5/HYyqZoodyz06XDU/CByh7iUFiBMqhidOIZmWTUhq6THci26gsyi9BSF
	95IHw2eT3+4CXIQavcsX7ZRk9TTREJAXIRO7BxLlY1giAsDDv2o9T5Wtak/I0EB12y/uC/jSW83
	Z+NUaUN9w+KZTLzqWSgyIcnV4RMYgmQTmr61yTNmciboldEgfhOkX+7WBiVx6ISWerzBQpk=
X-Received: by 2002:a05:6000:3103:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4255d2ca77emr10468444f8f.21.1759763966648;
        Mon, 06 Oct 2025 08:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjOGZhBb1Hj6boNC5jaq+DsBlqku3D3S8G53bScw07rODCyR44HfCHuJGOAX5DYcdXXAMU1w==
X-Received: by 2002:a05:6000:3103:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4255d2ca77emr10468415f8f.21.1759763966126;
        Mon, 06 Oct 2025 08:19:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e58asm160675225e9.7.2025.10.06.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:19:25 -0700 (PDT)
Message-ID: <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Date: Mon, 06 Oct 2025 17:19:24 +0200
In-Reply-To: <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
	 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
	 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_35ovW57fZICkDjxX-A27Nj-6zHm9513jo2W5K-LQg_1759763967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-06 at 12:10 +0200, Thomas Wei=C3=9Fschuh wrote:
> Hi Gabriele,
>=20
> > Well, many use cases might be better off with tracepoints, but reactors=
 do
> > things tracepoints cannot really do.
> > Printk is much faster (and perhaps more reliable) than the trace buffer=
 for
> > printing, panic can be used to gather a kernel dump.
> > One may just attach to tracepoints via libtracefs/BPF and do most of th=
e
> > things you'd want to do with a new reactor, but I see reactors much eas=
ier
> > to use from scripts, for instance.
> >=20
> > LTLs don't benefit as much as they don't print any additional informati=
on
> > via reactors, but DA/HA give hints on what's wrong.
> >=20
> > I wouldn't get rid of reactors until they become a huge maintenance bur=
den,
> > but probably we could think about it twice before extending or making t=
hem
> > more complex.
>=20
> The existing reactors could be implemented on top of the tracepoints.
> This should make the RV core a bit simpler.
>=20
> Note: The current interface between the RV core and the reactors is
> inflexible.
> Passing only opaque varargs requires all reactors to format the string fr=
om
> within the tracepoint handler, as they can not know how long the objects
> referenced by the varargs are valid. Passing the actual objects would all=
ow
> for example the signal reactor to format its message as part of the task_=
work
> handler instead of the signal handler and avoid the allocation of a fixed=
 size
> message buffer.

Yeah that's right current reactors don't really make sense for things that =
are
not printing. But as mentioned before, fitting this for all the different
monitors types (per-cpu/per-task or something more exotic) and model types =
(DA
or LTL) has its challenges.

I personally never really used the panic reactor to get a crash dump, but I=
'd
probably miss the printk one, since it's much faster than waiting for the
tracepoint stuff (at least when matching with other things on the ringbuffe=
r).

As I get it, extending the reactors integration to support more things migh=
t not
be too useful, but I'm not too convinced on removing reactors for good.
I'm gonna give a little more thought on this one.

> > For instance, what's the exact use case of the signal reactor? Isn't it
> > simpler
> > to do everything in BPF? Is the signal needed at all or something else =
(e.g.
> > perf) would do the job?
>=20
> The signal reactor is convenient to write automated tests. It can be used=
 to
> validate the monitors by triggering known-bad systemcalls from a test
> executable and expect it to be killed with the reactor signal, see below =
for
> an example.
> On the other hand it can be used to validate that the kernel itself does =
not
> regress with respect to RV-validated properties. For example the test pro=
gram
> can enable the rtapp monitor and run an example RT application using all =
kinds
> of known-good IPC mechanisms without it being killed.
>=20

Yeah, what I meant is: having a signal isn't your goal. Easily understand i=
f
there was a reaction is.
You could even restructure your test using tracepoints without any signal.

So if I get it correctly, you are both "voting" for removing reactors in fa=
vour
of tracepoint-only error reporting.
Am I getting this right?

Thanks,
Gabriele

