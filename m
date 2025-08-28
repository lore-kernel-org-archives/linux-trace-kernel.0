Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A917A2E3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378674; cv=none; b=gt1/yTfCcCC4C6xgPLeUoGBEEezxiU2w3UaKx24Oo9LuoXZ0FmbHkM/eh642sHv/YbOESRMWmCMdJTrWXAe2wz2OSh00k4T1P1DUKRjKckm+hS8QVmL+tvq/cOBEYwp9K8IL7HwJ6NYESY7o1mskhOQ+SOtJf8iki3PMpknok+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378674; c=relaxed/simple;
	bh=Nkerxe6gJ3DQigs2jaxc9hwThlQ4zJnMbKKxpPNcyTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejICov509wESo6d8cx+pzdfe7anL7lPKyh2VjoAJumz4H5Q6ZthW9DEJqerR+bjmC854jmFGQO3iqr0v2JK+eo1Dx7BMGOvsRwbxMuPOs7FFeBGn4Y1UksOeGNDMgt33koAXpNaBR4IrS34UxHyJP54jRt/uOCHed84NzUrF9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fB9VX5I6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB9VX5I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756378671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pCIGk5sD1mWjtUG+f/52au75peaZaZCgcIFZ7J5Zk8=;
	b=fB9VX5I64SPgJRFZrMfl1Gw4PtPEiutbK4gdp4HVQmtvALD2J2rkTQbJaLPPHGsfF8Lm9i
	JusUpWyshVMM9YlTg0kNJgE9edInAcg0zTkZooPdnvVaXq6Zbo123dDSLldwG8gNhv453a
	76nMR2fZh34VTvyhhvyPfFOq26JoJE8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-trkTd6dzPN6XHi5keuv92Q-1; Thu, 28 Aug 2025 06:57:50 -0400
X-MC-Unique: trkTd6dzPN6XHi5keuv92Q-1
X-Mimecast-MFC-AGG-ID: trkTd6dzPN6XHi5keuv92Q_1756378669
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe6216085aso62664366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378669; x=1756983469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pCIGk5sD1mWjtUG+f/52au75peaZaZCgcIFZ7J5Zk8=;
        b=tgg+gM7VRQ9CjZSx18mZNddegzHCm5l8cYhZluOPQ0ctHi9gxrrL5ZGZhZ6xWGLlTG
         KkaHcmLpLV4kslBP1iA4ZN+sebaYTQbhN3JOYLkqymbtL773tjJ1MXun2C3PJIIVEupr
         lGTU5Biy0nhySbjV9NOwTgo867+cdbx/qjriLcqW03UVvnFMgk4XRnTtqTzoKHvv1r+T
         IBF8Iz0FrR7Y84c1m2sOJ7DLeMCisM1GYGfOrdjGTmTueIA7LwhwtSjaQwaqyl2bRILy
         OrV6m3EWMpItOF2aF3AoUZvz2R/FcwVyCwt1R5lSKPeIsHsS9i3j7yCPoH38zHVzt3tn
         P7xw==
X-Forwarded-Encrypted: i=1; AJvYcCXpmWqjFjpggomw/JG5Qc8VpZlX6MvWBwuQuSBylSuRbgyV/ma7/q4pxRJU5ASOh021174FVit/ibsQY7mNBZfr2Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdGGGCf6gZk8aomI/DrI1RU6vUZc0+1v+/90Ls2L0h1ftIGp0
	ELHEj5px9vFGtphGNcGzDzmzJ4vMJno9Qom7xuvgGYxKEdMMZfEqC1ohJiCLTro8G+s8P5b9vBk
	4sD/nUi0r2bWUxJgREmWEGIonubAC0G8fzs3LPhabHTeLmMOjGAVMxXEVRRff06b3Ulgj9j+45g
	ZLD1/2Xsg2yHrfIiAT5WzPjpO18VzpHkC1PsWH0bV3W5dSBuJw
X-Gm-Gg: ASbGncvHnb26yniYns1uAux5XuJXOAdqTY552AbLp7f0s7ExRSQsZCt4/M1dghhY8Pi
	Fv7VCes0UWF8ULWj40dApQkh7E8J+5ZvGSv21F2F7b1jXD9JvJtOn9eKQiX8XyrMvHp3TPz7DG7
	w1Ews+RGxbp4HIw58vxHM=
X-Received: by 2002:a17:907:3e08:b0:af9:a5f8:2f34 with SMTP id a640c23a62f3a-afe2963b046mr2364903766b.53.1756378669167;
        Thu, 28 Aug 2025 03:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQdzFz67tW9kxV3I3iKr8xacCJF5XY3Wj2fzfCyuSx4/M4iv1/Aa5akngbqVzph4qYfBu9o4LMCQQUeNq9RBk=
X-Received: by 2002:a17:907:3e08:b0:af9:a5f8:2f34 with SMTP id
 a640c23a62f3a-afe2963b046mr2364901766b.53.1756378668734; Thu, 28 Aug 2025
 03:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-8-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-8-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Aug 2025 12:57:37 +0200
X-Gm-Features: Ac12FXzmJHhaMa_UYWufSltUhNf-vYzmAmSDrz4tySn2rCiyS7XdbQ5V7fuPCPk
Message-ID: <CAP4=nvTFy6dZ1ab3ny_Yze2ttWjXXxiRKyUDcBzSc8qKcOHZVw@mail.gmail.com>
Subject: Re: [PATCH 7/7] tools/rtla: Add remaining support for osnoise actions
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yre77zKUcKtsk2U1P0giPhBQJB9dUeqxD5Szuzyqnp4_1756378669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
> diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Docume=
ntation/tools/rtla/common_osnoise_options.rst
> index d73de2d58f5f..ba8e6674c220 100644
> --- a/Documentation/tools/rtla/common_osnoise_options.rst
> +++ b/Documentation/tools/rtla/common_osnoise_options.rst
> @@ -1,3 +1,11 @@
> +.. |threshold|  replace:: **-a/--auto**, **-s/--stop**, or **-S/--stop-t=
otal**
> +.. |thresharg|  replace:: -s
> +.. |tracer|     replace:: osnoise
> +
> +.. |actionsperf| replace::
> +        For time-sensitive actions, it is recommended to run **rtla** wi=
th
> +        RT priority.
> +

Unfortunately, real-time priority won't really help you in practice
for overflow-to-action latency, since the detection whether tracing
was stopped is only done once per second, when pulling the data. The
message should be instead just (something like):

"Due to implementational limitations,actions might be delayed up to
one second after tracing is stopped."

until either a trace event is implemented for stop tracing threshold
overflow (proposed in [1]), or rtla-osnoise is moved to BPF sample
collection, too.

[1] https://lore.kernel.org/linux-trace-kernel/CAP4=3DnvQWCWAOefHAqA82-VDb-=
00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com/

> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -8,7 +8,8 @@ set_timeout 2m
>  check "verify help page" \
>         "osnoise --help" 0 "osnoise version"
>  check "verify the --priority/-P param" \
> -       "osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
> +       "osnoise top -P F:1 -c 0 -r 900000 -d 10s -q -S 1 --on-threshold =
shell,command=3D\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" =
\
> +       2 "Priorities are set correctly"
>  check "verify the --stop/-s param" \
>         "osnoise top -s 30 -T 1" 2 "rtla hit stop tracing"
>  check "verify the  --trace param" \
> @@ -22,4 +23,28 @@ check "verify the --entries/-E param" \
>  check_with_osnoise_options "apply default period" \
>         "osnoise hist -s 1" 2 period_us=3D600000000
>

This is useful to have also for rtla-osnoise, thank you!

Tomas

