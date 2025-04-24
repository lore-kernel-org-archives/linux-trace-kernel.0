Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9D146A72
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Apr 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502966; cv=none; b=o7j11upwYQWqBt+tLSeRlQyIfCjb33vyItyd2IIYP+cL0WGkXcbixTcJ83/v9aM0GkBw3b3x3VDcic+XNKKI11PbXs7ReoO4WobaxP56ltCaGZzOy3wfJNfMduW32kLUh8KOPk93V78whSxp/aXQ/Efo8XsVgmp2un6LYRVUdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502966; c=relaxed/simple;
	bh=cTgpeF7IjB4DHQdDMY8/5jo70TmDi6eMpdUuG8Cw7+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJH6pF+tNGKPFST+iZ0DpPDHQ3iA17m2VHyJmDd7kUq3FuLiA6MZ1yZd8WIslY/SwSGCeqs6waMVwch824lbEyMtEcw5E2Dvi+YxhCGi0EoP92Trlg1MOt6LcJj7hyKsvBdXEzQkZvRvPwVcV+rgNZ8n2cR6YVhAFUoXHigstYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQztxAQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQztxAQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745502963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AYEUCC5q0yyU5Rah8MD36KICV7zJjIoMfBlRozZjVYs=;
	b=iQztxAQV7xaKJavfi14uel7O+lgxS284VV1q6SpCclDuav8Ja85W7YPnNAjiZra1Z0pcn/
	50sd1hM2B9qyD3DoSx1TqVtP9EG78oxiY3zgKK9MRoiaIv0sBnmVtvVSCWDeZXCcx/j3M5
	T31gm1diRZ4/2IMkCA1xY/5jOTAAFHI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-TwD3jr9FN2KYkMelMPACnw-1; Thu, 24 Apr 2025 09:56:01 -0400
X-MC-Unique: TwD3jr9FN2KYkMelMPACnw-1
X-Mimecast-MFC-AGG-ID: TwD3jr9FN2KYkMelMPACnw_1745502960
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so4761075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Apr 2025 06:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502960; x=1746107760;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1RyaFKtxAMrB5HauvPOnP185eorkVDz+74Vg8LMXDQ=;
        b=L9ld8QJIkkr/PdbWtJhb8FbaYOaip9XawhMuTEmyGoi2Dln8f/QxqsECrcVt7rk0Lr
         GPpnKteLooMS/WRZPMaYdSEhXRPnbLL0V73mMjtgxmIrFI27TErNEhL83gqc3Da7qM1z
         Yf+9iCSSy3MAKFyRR4X8hzqdSGhdVgirgI/wvAHyu5j08eOCdwc7D4Tg8/681g26eGLz
         ghL8ntu7MVjcTsLH9Zk6VMgFRHGcdCSlj/ai2m/s5Ucyp+hkYvlNOIKVPzNV8PJGzcev
         gHQzX+uFjvEYLHI3zyBcwstXddQaOcKGPE+j0XLTEcBrrGCB52XWYmBDM2BYN2nCteXH
         W2ag==
X-Forwarded-Encrypted: i=1; AJvYcCVZxlXgTT+cSl3mFd29+brNHPyNRr6YpusKwITVch0OMpVbqRel9F7zj1/FcOxHnJEw9lyetf/DEC5COyVkWVtReaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sxsjSQN0jvjFmnLdJbg0NqzfPYZxDjG3KBBLdmjS1BkCWH8J
	LqwSWOwhBFE7gxWnzic//Yw0X5FYrK7V67RdExKbrigiaQPKyZKUJ3HAQ+8PQGnm7ITDTA6AmXU
	b2gN8WL3vvIvx+ZVqYo3BbhUTnq1M6zk/CB5wXuNmgAGR0ufgBz7i5rS7vPWBVwRZAlGalQ==
X-Gm-Gg: ASbGncso12uMp8nixeXG36clBJ1/DfHCqD3hTmNRzpTuHft2QcDKacjuRdaC+BicVki
	UyQT8jKddkt6TlSRA8UaEnHIdHCdAETXrFsycbEPEGUWbdvgMU0cV38WDb+oLjWx2BEFhu9DM+2
	zgF2lC73/pcGU5XHgnNa4BHpbDRPysGRpvX3eKl8m4IRBoRcgZkAxlNlbpN87p4zc858r+vmYxJ
	ffvFNqUXnuMRS3UpH6x85FwsBXP+bEnhj3/t+NgyqRAxQYUuVgt/vwQ4VFSN9mobrOwPvIARbv3
	vRdwhZJISJLQd1Qu3MXkrScfd06YDTRGpWD6pg==
X-Received: by 2002:a05:600c:a363:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-4409bd0e377mr24787805e9.11.1745502960179;
        Thu, 24 Apr 2025 06:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaulAtCMwz/QY4Wsmd7+YPlHQCjODqYQKkCyZqkzc8UCUby+uEZhSuylFsVw/BS4GiRlE9lQ==
X-Received: by 2002:a05:600c:a363:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-4409bd0e377mr24787585e9.11.1745502959824;
        Thu, 24 Apr 2025 06:55:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a2eabsm22120895e9.12.2025.04.24.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:55:59 -0700 (PDT)
Message-ID: <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Thu, 24 Apr 2025 15:55:34 +0200
In-Reply-To: <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
	 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: IvBitFcVlnXqF4ilMxYxY3idzHevl3VO3GC239DSWI0_1745502960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-04-23 at 08:50 +0200, Nam Cao wrote:
> Add a monitor for checking that real-time tasks do not go to sleep in
> a
> manner that may cause undesirable latency.
>=20
> Also change
> =09RV depends on TRACING
> to
> =09RV select TRACING
> to avoid the following recursive dependency:
>=20
> =C2=A0error: recursive dependency detected!
> =09symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
> =09symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAGS
> =09symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
> =09symbol RV_MON_SLEEP depends on RV
> =09symbol RV depends on TRACING
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>=20

I've been playing with these monitors, code-wise they look good.
I tested a bit and they seem to work without many surprises by doing
something as simple as:

perf stat -e rv:error_sleep stress-ng --cpu-sched 1 -t 10s
  -- shows several errors --

perf stat -e rv:error_sleep stress-ng --prio-inv 1 --prio-inv-policy rr
  -- shows only 1 error (normal while starting the program?) --

Not quite sound, but does it look a reasonable test to you?

I quickly tried the same with the other monitor comparing the number of
errors with the page_faults generated by perf, but that didn't make too
much sense. Perhaps I'm doing something wrong here though (the number
reported by perf for page faults feels a bit too high).

perf stat -e page-faults -e rv:error_pagefault stress-ng --cyclic 1

Anyway, the monitor looks good to me

  Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

but it'd be nice if you have tips to share how to quickly test it (e.g.
without writing a custom workload).

Thanks,
Gabriele

