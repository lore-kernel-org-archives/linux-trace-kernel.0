Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896C3093BF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420171; cv=none; b=Lwc7V3sKz8uKZNoOTQojMg1GFUAvqef9prf/mxbJEacPIsU0XJZkwRnLpZCtB8HmgRVpdVU7Bu9RzV68Akr8OKXVEKafBss6CQ1lwr/Fb3hd8WJzyc3rdTBJYeysVJx3ZeooauM2JdAK/b0lbWnjtuVOB8lucd8b3INoLAkK988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420171; c=relaxed/simple;
	bh=YOJg043NjtgIa7Vv2vbLQnw1pcnmrebVgIWH7HMe8As=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXWR/S+0JWpNlI1GPovIRLQetlmNr05dmdmXgslOXk9DfI2AsZBsuLDPhsPBd/zhmDw9KMs0BTomFzS5LXcZnJZ4mGHE+2bgUf7GPFhTIgHIvTaXkxUVduZJwXsvObWRAzrbCoWmCjsioe4vM3KfHTqja6/wZ87jB1zx+GaiLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gytgdo4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gytgdo4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768420168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vky6hSZDPT1dPXG8ZdsJ6xXMx0R9gF+jMjhFy5SupRE=;
	b=Gytgdo4UwdRkvkkYmZaCM+33ZSfM4j3whujzlUrjUttvDKi/8ahM+XEx/4vazEOlK9it9O
	sRH86o4TQ/cakaO5xbS+4csaOz/8RdtLyXhzX1BSc2uUacQjVv5lR75H49jPP7VnrPe1xy
	HsxVeM/fqJJyY9dQY/eFiE7jpZhDUPU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674--w46DHoWOYCnpJ6lMCMTzQ-1; Wed, 14 Jan 2026 14:49:24 -0500
X-MC-Unique: -w46DHoWOYCnpJ6lMCMTzQ-1
X-Mimecast-MFC-AGG-ID: -w46DHoWOYCnpJ6lMCMTzQ_1768420164
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56344627228so175447e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 11:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420164; x=1769024964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u++Xz0cnjGkJEP63pY4RzjASIAxlnVi2WZSHFYYKOxA=;
        b=IKvZUndOK38yUv5JUQZljO898NxB51UbmTsh03SR/Xkkabr+AguVkmntYEsR05fo/f
         uwzZjamYLTofGjLOydxUoZYM+PuSt9E9bYtRECI8OvN/HCoozD4hdINwFU8tJRSqmpLz
         bBdNAUOxInnoPsMD7tizm8+E2YslYddAb22nwbCvWofmixl8J1qWsSm1PdlYBGQpGaeD
         ONbK2D3L/teRJYh5DD629/WrXjHu6SsyDHU2DHXcEImBhCTXhgAt91BuSd26D2q2Fse6
         unjCy04KjYX9Sn1oa+CaxKV04EqYzMt86bZGjhYZ00b4FCHodT6zEl8audUBO+U9/9Nh
         Dr9g==
X-Forwarded-Encrypted: i=1; AJvYcCVAOPLZfnY3Re8AQD9rBat2zrqICqudp3gCylTZcVMUgw//jzm0ukAYpBDGFtbQ95BIFnPV+jvfpTJpdLBiG9G/QaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJc0vrip8OPWPCRnNqYwUw99YHOdLDscP3ZHWw86qcuh5MinO
	eaRkmEFkD9D8ns0pUSweTL9uDDCY9CbgfoPGO3M6B/2sXV18GK4pZg9YS8z5l777WDeBtixD0vI
	0sSTG6AcuaJlLvkDDGSWiFZgKwmTsR6jvc56St0KILsStxT5mWeyCetH/mKoP0btGrMWG1I9FvA
	==
X-Gm-Gg: AY/fxX4fBmT9QCz7dQlUfzFWNeWsJ7nnHkLrpnCSOsfPivxX8fViQuy3XYx5uEpmvNP
	/uBlaJ8sKsa/eZ4bdQ3Q0lENMjS3eXzHazR73CjGRdQSSySn8/9ADl5LkNAJam6x2ija6pu3DKj
	GteWxjA09pA0liewcnBWF6ryygntPIwAJTLTNvqv/c5nApbkinBPfSjPyX1s4XaNV8WiRvxthQT
	rxV+kz4wZcynx081DKc5Bf8T7OrNwdo++E9bSfGpUqUZOZo06YjB0539KgPemAOPFGE18tzrv/z
	scVXz7h/XWWGWZQ2+VAd2nPQQm85eI3JPelBz5SPl8kvGpSiFN/bk+haxgyOeMpkGraCXPRbEd0
	M3ItPS3SZbFggenwsqaX7EmedS2SWeKGTr54cEfOjwA==
X-Received: by 2002:a05:6122:c8d:b0:563:6012:53b4 with SMTP id 71dfb90a1353d-563a0a4882dmr1479703e0c.16.1768420163803;
        Wed, 14 Jan 2026 11:49:23 -0800 (PST)
X-Received: by 2002:a05:6122:c8d:b0:563:6012:53b4 with SMTP id 71dfb90a1353d-563a0a4882dmr1479698e0c.16.1768420163404;
        Wed, 14 Jan 2026 11:49:23 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a20a183sm23841288e0c.9.2026.01.14.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:49:23 -0800 (PST)
Message-ID: <bbb834f13cb1480b2517497481a1b3e0137d089a.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Fix OSN_WORKLOAD-related crash
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur
	 <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, LKML
	 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 14 Jan 2026 13:49:17 -0600
In-Reply-To: <20260114123547.583859-1-tglozar@redhat.com>
References: <20260114123547.583859-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hfNxFxkgZ2YXNiVEx-UoWkwtd9QI2K5txpRSupv9WmE_1768420164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-14 at 13:35 +0100, Tomas Glozar wrote:
> A kernel panic was observed in the timerlat tracer with the following
> reproducer:
>=20
>    #!/bin/bash
>    while true; do
>       rtla timerlat hist -u -d 5s & PID=3D$!
>       sleep 2
>       echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
>       rtla timerlat hist -k -d 1s
>    done
>=20
> The kernel first displays several WARN traces with the following pattern:
>=20
>    WARNING: CPU: 1 PID: 1822 at kernel/trace/trace_osnoise.c:1959 stop_kt=
hread+0xb7/0xc0

The line number doesn't match up for me; is this the first or second
WARN_ON in that function?

> and finally a null pointer reference BUG:
>=20
>    BUG: kernel NULL pointer dereference, address: 0000000000000030
>    ...
>    CPU: 1 UID: 0 PID: 2155 Comm: timerlatu/1
>    ...
>    Call Trace:
>      ...
>      ? timerlat_fd_read+0xf2/0x370
>      ? timerlat_fd_read+0xee/0x370
>      vfs_read+0xe8/0x370
>      ksys_read+0x6d/0xf0
>      do_syscall_64+0x7d/0x160
>      ...
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e

What's the actual fault location?  And those ? lines in the call trace
are "considered to be additional clues" rather than actual unwound
frames; what was in the ... above them?

>  static int osnoise_options_open(struct inode *inode, struct file *file)
>  {
>  =09return seq_open(file, &osnoise_options_seq_ops);
> @@ -2229,6 +2254,10 @@ static ssize_t osnoise_options_write(struct file *=
filp, const char __user *ubuf,
>  =09if (option < 0)
>  =09=09return -EINVAL;
> =20
> +=09retval =3D osnoise_validate_option(option, enable);
> +=09if (retval !=3D 0)
> +=09=09return retval;
> +
>  =09/*
>  =09 * trace_types_lock is taken to avoid concurrency on start/stop.
>  =09 */

Shouldn't this be done under interface_lock to avoid concurrent
timerlat_fd_open()?  FWIW, your test script doesn't appear to cover the
case of option setting racing with timerlat starting (due to the 2
second delay).

Of course, this is complicated by stop_per_cpu_kthreads() happening
before interface_lock is acquired.  Do we know why that happens outside
the lock?  That might even be the actual cause of this bug.

Though even in the non-race case, we might still want to return -EBUSY
rather than just killing the thread (which might still have races since
we don't wait for the user thread to die).

-Crystal

