Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541953D9529
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406891; cv=none; b=HPL1bkkFS/ZXc2fseLT4736r9rZO+kFU3FNB/heP5HldNxpg5OCApjg/685yea99XJDzkFK9JN7gkwZ3EMES0ZxSyaKN0IGze1LSM5pMhsGnqqtb2ztAu3QDva9V6iIBTWdqm1fiJqKhnTOJfNk5PjGh6Bd+rrNGdAYzwLIV/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406891; c=relaxed/simple;
	bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd0BddnW1zSdxqa5tg80HVJzCt/GMAGsCT06Q3wuy39YGuYv8oD5c4s7ZHkZtzBI8BZz9FTX2Hvo1rftKjhnIR0qzdQ4Qhgu7qBB7T1rR5txjhKNRVkF7HTYWHkXN71h9SlwvdgLsfygRoWNaFbIc2AdhkKzBoyG6WmHz1xsvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=freVI5Ew; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="freVI5Ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792406886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
	b=freVI5Ew8vIitAjHTNlKjpzdW6eSTKzQIe8MYwckEBow/mm/Gd1nbALbMWkP7x9lzCc9Ry
	6GT1ocZ7UzHtHdE+wMUUzEfJW8dsDDWxO4Riz9iNrfYDgcGBtHpPURHOkWw9T9+y5j311P
	rMhURe/IuyD/Bx48MHGbfY9x3TpaNEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-F33XHq6HOwWxpuXLFmqHEw-1; Mon, 19 Oct 2026 10:48:05 +0000
X-MC-Unique: F33XHq6HOwWxpuXLFmqHEw-1
X-Mimecast-MFC-AGG-ID: F33XHq6HOwWxpuXLFmqHEw_1792406884
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so12645485e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 03:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406884; x=1793011684;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
        b=FJKqvOtK2sBmWe/KVvPVUao4WNEDWtKZnCFa2eSXrvGKTWLuJP4zW4uV8ecDsKUTQs
         MBqM6ytCVq3+kvoMaA/DZbPpPV7QavLbIhDaGW1C4WH3rfTImysB9iJCgdaDqda/3Gxs
         FEWSpeU1l6MHVPfXJuOQ7vnJMwIahu/4enN6pW29ix/WkXwt+TjMDLBD0KhMkxrAdM1B
         oWQ+Bsok8zG1WAA8psLd7yAVhmE4jGm62v1h8uDF40uUL8y8rvinG4yFUUv2kuxOMAq7
         2238+62FceP/Se+oFijxSkWPofEbhdQz0DzdsaICQ/4gzkQ/tQTsen1MTm+sufOX7y4S
         rSww==
X-Forwarded-Encrypted: i=1; AKwUvBznQnTNaXtyanp00tjxvU1HvmjazE8YyLwUBYo4AUXNP0eL5O2Czt+euprqY+y2v2ieAYJdfLBYw05c9lsM6GaFXbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/l+0q0uXGhheIJLvNr38MvX8bpozwkUgobFYUc7M8Ofwjxj/o
	J0ov7SUFrUsnkjp473fKRDcUPETQJpJ9Y9Hy5EuXTBxjhRBdD8YPmU6B4NZcYig9URVk2ggBiHy
	EkfXwgiEHtPXJmJ55EJZhNWOcfsYeEnj8Z0bUfwM/FQXI0Wu3qY6vysh3IkRgBDlHW4FRwMME7A
	==
X-Gm-Gg: AYBFou04ycgjqxWFioFAA/ip/V62hvDf/CHaOQ/tyBymjhBMMK4eVZ/XMIbU2Ynr56R
	UrlNtudVDeAGKUfkP97NeTqaU1Zh9fxsiaC8rcDkvuyTSf54NJ7f3Rl3NiIW/piF2y1tj45tFci
	flhMqPNT+y/+MSuGD6CoIkiGtxJaFBFdpqEUz/y3DIrF48gUrplMvBnvK6wGcfA7GzBEVb+YgsQ
	cCgbI6RY51hLB+2BXnL0XQEtx7HxseMhSXAEWUeCsmskmiLIfIJ3taIFSv17x9DEtynYNeAhHfk
	M2ed94dYIYoO8plmKIFZZbKD82w9PD1ESFECrh2WBiO84QRG2Ph7IOeE8vVwXk+1x9ARXWMTL4C
	M2OdIzhG8Jny7CMGz1ArJxE0jjQ==
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr162834405e9.4.1792406884483;
        Mon, 19 Oct 2026 03:48:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr162834105e9.4.1792406884163;
        Mon, 19 Oct 2026 03:48:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8b5fsm397495935e9.9.2026.10.19.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:48:03 -0700 (PDT)
Message-ID: <d13e57e312e24b389cb366ede5b3c535ef8f7071.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 12:48:02 +0200
In-Reply-To: <871p9mqcn2.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
	 <871p9mqcn2.fsf@jogness.linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: akqdZenJ1CMSZQipthdgVugeScASmM1aY6k1Ts-JwdU_1792406884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 11:16 +0206, John Ogness wrote:
> On 2026-10-19, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > > > We are missing stack traces (which I'd optionally add only on error=
s)
> > > > and perhaps other events (e.g. the -e in either tool if you aren't
> > > > only interested in errors/events of the monitor).
> > >=20
> > > I don't see the point of reinventing tools that already do the job
> > > well. I do not mind if developers want to create their own tools that
> > > provide some small subset of existing features. But I am concerned
> > > about removing the in-kernel RV support for ftrace and perf.
> >=20
> > That's valid too. We'd need at least the rv tool to start/stop
> > monitors in addition to ftrace/perf. Kind of what you already do now
> > with sysfs.
>=20
> I do not expect the rv tool to start/stop ftrace/perf. Nor would I
> consider that useful. When I am using ftrace/perf, I am interested in
> additionally related events. The rv tool can not know what what else I
> need and I do not want the rv tool to become a wrapper for ftrace/perf.

Yeah of course, I meant more that you need to call both tools (start the mo=
nitor
/and/ the tracing).

At most I'd have a -e flag in rv (just like rtla has, mirroring trace-cmd
functionality).
But you're right, it's best if the other tools can do that first.

>=20
> I would use the rv tool only to start the monitor. It would be enough if
> the tool would report the bpf_trace:bpf_trace_printk globs that are
> needed for the various possible violations. Then, with the monitor
> started, I would start ftrace/perf for my own investigations (also
> capturing any violation events).
>=20

That's an interesting idea actually.

Thanks,
Gabriele

