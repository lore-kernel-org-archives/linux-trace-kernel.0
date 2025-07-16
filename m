Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085954F81
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660033; cv=none; b=KEpHDktCnVO/KVIDVRKfiKSwL1wvEXwS5los/5HbqmtHxJ30eCJBMTXBozfubRgoR5N/PS07PtE4mKZobJFX8pQ42HXgoalbT5zzOeDNSr9JYgHUfVbs4YekTEx0NPTXpNLxrjcA+/0KuUaoI/2Yx4gY9csQBogOzLM+U8+GVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660033; c=relaxed/simple;
	bh=e3fJFYqyOFd9NTgarb3VRVq1VAytVj2KoWG/LGxOmCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip28/2WPVUXVO0tYrsLj1NtctncOMkrGuPwk9K1mNexkdFyCk4J8s1v5aOt//uzEOycpf8nMH6iPUW6ddesqlLayo4w/LlpLnvIVIdO5x3cmy6ppFpSozFU0JBpe/Nx/Td0fy8MYmhthn3AFe6NjHj4fN7PBBiy+NW1zsEv5pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkvDh5pt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkvDh5pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752660030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e3fJFYqyOFd9NTgarb3VRVq1VAytVj2KoWG/LGxOmCk=;
	b=AkvDh5pteaBlkeenvoaQdwZKyy/6nlh9+POV2jr+367dFYsK3DiAqqiOZzRIP1RWtCuDVv
	glu7c98v1dVui8AdNC73cEOA8RA9T9JYneJlV4JcCmRWUG+ERzQzdBj4QteUTxanUIQVpc
	dpeP/VHCWiR2iOrjvx6jsLVrIlFusa8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-JHAKqpV5PhWhX6vhm1azFg-1; Wed, 16 Jul 2025 06:00:29 -0400
X-MC-Unique: JHAKqpV5PhWhX6vhm1azFg-1
X-Mimecast-MFC-AGG-ID: JHAKqpV5PhWhX6vhm1azFg_1752660028
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4961245e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660028; x=1753264828;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0eHc6+5H9SgZz4Xcjm6r2qNKf2VLwrklymOhya5fbw=;
        b=b5vfWljaOKf3vdKCnKnxC/Ql8bAffACHPAdFJ6YlBWV8pc4pyP+0M0SaVckQpUWgev
         27wZ30iKKlaBtU+JPGi/SjeoUychcsqNI7nuEHde9eUJLkjGnbKJV79fGx2AkMYQ/jVp
         aO5XMdBVWPcS7vIakePoj3DkLup6ODoBEj486G8qhRqVBYPSgrLWt18o+iYmr6M7hzBB
         GZAWUah93AMj1qEB99y+u9GtnNf4C23tyavIDaYeRAU5r5CE2m+8JPAUieQy0oavwM92
         uaIc/IT0l3N1wKtUY0GCYMhOkjvP8+mMIPLdH11FjQMpSWa8tQlmT6l/NioJorWb2Ra0
         PB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhfPIkJ43jNqt2WSIN/k8ps9CebOAXl/MHuDyJqHuLsTpRlBLHJ5QR+lgumQ0keNnnRi1EKRe0p/4ZunvVAR3Qji8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASRa9B6zOYg8u//L1kfA9Uud+79no+uCAQ4xBrBzLv/4O4Fl3
	AYVQvoS1oK9rKaq1e8W9UaO01vtXn8ZH8dTOGjrIDbUF4LAY61+CiPEqwceAgyB1DbBCTEetSiX
	ZAF+ZWNzLJw2Cz2Bue7TxVWE4BUh8/ldb9NEE2Cu79xc1W/FV6Jurb+9vtOTqJZ1a7UBFoJqbZw
	==
X-Gm-Gg: ASbGnctP0r59GnnLAi3xcWm+C3IvIWe2tGh5fndtMWU9/msku1fnRlLLjs+AgVXD2M9
	61xZZHHx8pWYDl2sy3dkQeuZ460xOoM3sjTsm84psdr+SbmAxp4O3+vcbvx1xa0WGQupIg3rLF1
	6IrMnHbPcA7wkJkggy+b02Zw+lEvNWNJrpo98XPv1wBXyNX344cyU3rUt+m5wpORd8V5ugy6g0H
	G3wJpFuMe5bD/P47pXyZY6xj9EmQUX+WHxtUqb1C/3TcwvEVAHBzMgergiNzlg2vZsopzkMnA0x
	wrCk/dMUGorVbEs7F6OEpPqQqEt9k2DzOVJFNKEem1UHZ7kEbzxxmG/OJlYmoqRWfA==
X-Received: by 2002:a05:600c:2ad3:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45625e12572mr49088455e9.1.1752660026628;
        Wed, 16 Jul 2025 03:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIZgKfShCpN0AhUR7T0WU+hhCNt02vphv8/fP10yQjGMUW3uuMd1ZkzEMXXpDi1pz7gSrpXg==
X-Received: by 2002:a05:600c:2ad3:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45625e12572mr49088185e9.1.1752660026195;
        Wed, 16 Jul 2025 03:00:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm17399303f8f.36.2025.07.16.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:00:25 -0700 (PDT)
Message-ID: <ecc8217af9ad8142abb73d6ef2fe9bdac9df6c95.camel@redhat.com>
Subject: Re: [PATCH v3 17/17] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 12:00:24 +0200
In-Reply-To: <20250716093825.rWXnBtv5@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-18-gmonaco@redhat.com>
	 <20250716093825.rWXnBtv5@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: pJ0WdbfGPIbnP7Txf7NJlfuquLwsXvuPm2gpV4kTHHk_1752660028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 11:38 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:34AM +0200, Gabriele Monaco wrote:
> > diff --git a/kernel/trace/rv/monitors/nrp/Kconfig
> > b/kernel/trace/rv/monitors/nrp/Kconfig
> > index f37ff70e8d204..a175c430d351f 100644
> > --- a/kernel/trace/rv/monitors/nrp/Kconfig
> > +++ b/kernel/trace/rv/monitors/nrp/Kconfig
> > @@ -3,7 +3,7 @@
> > =C2=A0config RV_MON_NRP
> > =C2=A0=09depends on RV
> > =C2=A0=09depends on RV_MON_SCHED
> > -=09default y if !ARCH_ARM64
> > +=09default y if !ARM64
>=20
> I think this is not supposed to be in this patch? It has nothing to
> do with
> the opid monitor.

Damn, fixed up the wrong patch, will move it to the other one..

>=20
> > =C2=A0=09select DA_MON_EVENTS_ID
> > =C2=A0=09bool "nrp monitor"
> > =C2=A0=09help
> > diff --git a/kernel/trace/rv/monitors/opid/Kconfig
> > b/kernel/trace/rv/monitors/opid/Kconfig
> > new file mode 100644
> > index 0000000000000..23b43d2704153
> > --- /dev/null
> > +++ b/kernel/trace/rv/monitors/opid/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +config RV_MON_OPID
> > +=09depends on RV
> > +=09depends on TRACE_IRQFLAGS
> > +=09depends on TRACE_PREEMPT_TOGGLE
> > +=09depends on RV_MON_SCHED
> > +=09default y if PREEMPT_RT
> > +=09select DA_MON_EVENTS_IMPLICIT
>=20
> Shouldn't we add "depends on PREEMPT_RT"? I tried this monitor on
> non-RT x86 kernel, and got some errors. That could confuse people.

Mmh, my rationale was that it reports errors on non PREEMPT_RT, but it
does build. If someone wants to try it out there, they are free to do
it. We are just not supporting it officially.
The monitor might start working in the future also on non RT kernels,
or at least if someone wants to try whether it's the case, they can do
it easily.

Same idea for the ARM64 thing above.

But I should definitely mention this explicitly in the Kconfig entry
not to confuse people..

>=20
> And the monitor reports some errors on riscv64 with PREEMPT_RT=3Dy:
>=20
> root@riscv:~/rv-tests# uname -a
> Linux riscv 6.16.0-rc6-00054-g7590637d9ca2 #87 SMP PREEMPT_RT Wed Jul
> 16 11:26:00 CEST 2025 riscv64 GNU/Linux
> root@riscv:~/rv-tests# stress-ng --cpu-sched -1
> stress-ng: info:=C2=A0 [452] defaulting to a 1 day run per stressor
> stress-ng: info:=C2=A0 [452] dispatching hogs: 4 cpu-sched
> [=C2=A0 614.390462] rv: monitor opid does not allow event irq_entry on
> state in_irq
>=20

Mmh riscv.. I haven't tested it there, guess I need to start keeping a
VM somewhere.

Thanks,
Gabriele

