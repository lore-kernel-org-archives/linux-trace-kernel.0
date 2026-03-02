Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C43FD152
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462026; cv=none; b=lTbBqxMaIYrKL2+H1oYUvcpVe6EkleWT9o5d2VOd8pndFEXWOzU4mBpAJ16Y0qPahPN0lKiGCLIDTWnxZApdFVEk8zGVHBoTxIoAqpR7b6SdYoXYeD5gFDb2tttuFu8MIq69OwZK35p7sM02MBQVN+NyG8MdxR26PJU1YOA00HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462026; c=relaxed/simple;
	bh=uwQmw4zAN79NwhQtiVPfDrwYfeImPdYyqA7w/pehgRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuCn23q9SJpaEKXS6J+LAVegQAzcNXkbJBzosAQUgyL4by2ML5ib0z6BkMLlJxzNAOvuvot5TxsPMYxuqpqrURF+N9ImSsCB75+R1Awg7I3k/0NzTOAMmTu4a4lByrmyB/d5st5fhKD98c2vm1InNNQ5EQS4iDVI2kUon0ImPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXTfADYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXTfADYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772462024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
	b=eXTfADYpULeLDOubwyBUVXhvavU6uNfOK3Xy+3eJKhDJo4nivv+TM9qiWFQbmz8GK1Mcl7
	qc87x9tQoxWY8RrgWi14nxA36PvabMFAadyJ4nTONlbd8vAyZL7Bc/GAXFttopZy93jO2t
	0rfAVSsn47fweIahqarVMr8Bfa10zJ4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-_qUv9EVSPriwO7C2Aw_tvA-1; Mon, 02 Mar 2026 09:33:39 -0500
X-MC-Unique: _qUv9EVSPriwO7C2Aw_tvA-1
X-Mimecast-MFC-AGG-ID: _qUv9EVSPriwO7C2Aw_tvA_1772462019
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8fbe7a6f41so411454866b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 06:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772462018; x=1773066818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
        b=BB+sPCeYcyLKAdLpaUbmYwCK5EYaPKf07UEqwhM1RTQhE3s2Tl69sObqGsvjDxuzNT
         P2IacCcj/3NNLmuPguCSrkKrWjU98ubYd8vVxlijSPNMBlqlH47aFLBmRsOFQucHPmsT
         +t77SBqminG8EdjmOv0veXcm+WTobVxOVX4D2scR7YAcIPapXl7U9XYXfz5/zYXIyXK2
         miCgcXnfSeQN7QiLdbBB2cZ7lnTHRqQPOGIJdUCRpU5xFnguRCBk9cMHrC+aRMUqaSPY
         V9M8UR7U7U/lNYfoxLkNPEp1s/iUnSWKa6C+EYdcyRA13vOS6Wuv9gAzPz12fyc9Wz4F
         7t1A==
X-Forwarded-Encrypted: i=1; AJvYcCXXKk2pN8FyXFaX2dPOQfDrfoAmYU73tRLDu08No0aQZbTSLSru6mTQQbMrCseql8mOuRs3SrZMyB5lpB2zRsw0uZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPWOWgFRyZEXCFkfu5+YgT/yiXtZ9dKVll2vui3KuEBEEncVZ
	1jmzIyTw1SBBq6Eft7isNMZu5RqO9P41dGampla5xWs2Iy/h9kTyg7nruIv0bOLamkVNECm9/f6
	xcXYU9nmyPJvPJytitCr9FpKxt5jjSCtmWteX3abbpWPi+KzHXi8wg0qc1I58t35cTzFal1++J2
	VSNh97gW8V57ZEylE8KSqxmRHV+e3VWDKbfcYZXm0q38m1U1SU
X-Gm-Gg: ATEYQzyF3IxnH4uLdZXqbZEs71lzBwDlQ0canxQNSwt6cmq/JWyXANAr0epDZHENVzF
	7gCesOk3EWQ7QuTgx58f2iBHcbEZX0XCvXbKnw3F6lPGsU4jhxrXuSj0Vr4/e7quOrGETWM67VN
	w+aZUJxZty7/pcid6xYvctX7C6oSVfUqqdK4Ki64KFGygu85A0qzArbL0ZOJB1AQx1FvgJd0Vnk
	m5/DsncTWPApwn9avF2hQmER9zltcTrDCDK
X-Received: by 2002:a17:907:6d03:b0:b8f:d13:dec8 with SMTP id a640c23a62f3a-b93763b6e8amr729134666b.22.1772462018596;
        Mon, 02 Mar 2026 06:33:38 -0800 (PST)
X-Received: by 2002:a17:907:6d03:b0:b8f:d13:dec8 with SMTP id
 a640c23a62f3a-b93763b6e8amr729132666b.22.1772462018092; Mon, 02 Mar 2026
 06:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-8-wander@redhat.com>
In-Reply-To: <20260115163650.118910-8-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Mar 2026 15:33:27 +0100
X-Gm-Features: AaiRm514QxdLOrOwfkkiBNdRkFgDYfMrhEEk-id40dZva7oHe48oQU0sFLt1uLs
Message-ID: <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] rtla: Add strscpy() and replace strncpy() calls
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Haiyong Sun <sunhaiyong@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YyZ1naMB4JyqqVrryL9aOG_Zhmgs99nv8PrxIi5ZZuc_1772462019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> Introduce a userspace strscpy() implementation that matches the Linux
> kernel's strscpy() semantics. The function is built on top of glibc's
> strlcpy() and provides guaranteed NUL-termination along with proper
> truncation detection through its return value.
>
> The previous strncpy() calls had potential issues: strncpy() does not
> guarantee NUL-termination when the source string length equals or
> exceeds the destination buffer size. This required defensive patterns
> like pre-zeroing buffers or manually setting the last byte to NUL.
> The new strscpy() function always NUL-terminates the destination buffer
> unless the size is zero, and returns -E2BIG on truncation, making error
> handling cleaner and more consistent with kernel code.
>
> Note that unlike the kernel's strscpy(), this implementation uses
> strlcpy() internally, which reads the entire source string to determine
> its length. The kernel avoids this to prevent potential DoS attacks from
> extremely long untrusted strings. This is harmless for a userspace CLI
> tool like rtla where input sources are bounded and trusted.
>

strlcpy() was only added in glibc 2.38 [1]. It is thus not available
on systems with older glibc, like RHEL 9. Using it for strscpy()
implementation causes RTLA to fail to build on those systems.

[1] https://www.gnu.org/software/gnulib/manual/html_node/strlcpy.html

> Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
> buffer sizes instead of magic constants to ensure the sizes stay in
> sync with the actual buffer declarations. Also remove a now-redundant
> memset() call that was previously needed to work around strncpy()
> behavior.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
>  tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
>  tools/tracing/rtla/src/utils.h       |  1 +
>  3 files changed, 36 insertions(+), 5 deletions(-)
>

Tomas

