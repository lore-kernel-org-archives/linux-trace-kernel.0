Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04B3F8EDA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819175; cv=none; b=BsL3nE9VHvd1SFg+kmvOChT5LO0unwrj+KFYrsRhrkyUmzSk6rp9GQhbwDAtoG2REt9OXMUKFSrHLtyoX4ak0wf13wfw/VPubkUG6Ned7Bh0JKDhtLE2xQonrzta9TjSVa7Uo/BieTVByi86rYuosTPUQGf79BIaaDxAltgnBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819175; c=relaxed/simple;
	bh=ffGSH4IaIJoZHP1gdRgmrd5d8SmwqeySVgXFE4JU8Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNfTuKpjnGjlULAq/KelKh+OQ4eIKu2I7A4pRYB99QyOaxUzXBJ+MOiWXpaXZG4A2iyNyt6t2DS0YyUBtGRIVI0KxvBn6513U58NjQmCefdmJSswgucMpKTVKL4K1fJeCSSBKxZpCrMJ1ParK8I9XFVfrEiLPqHN/jOYHb53AUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O29M5wHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O29M5wHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782819173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBTz2wXtqBvGPZiSe/mxuJQdVwaDfA6xdfyUMxtKKSg=;
	b=O29M5wHqn9FyFjkzTcKHLKMlOeJ2bwgW2GM2vDkWgxdtk/27A1gHTD82Sd67UogNShQaRC
	AADHA7/6uUwnkuhIC7spgThLM94z2cxjZ+IVtt/Wq+69j74nxtof734OT6wlvKqX6RQT7R
	WoA4B38pkj4LiyGT/927bI+NXvky3x0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-eC8UjzByPAKPJSx9Js6ntw-1; Tue, 30 Jun 2026 07:32:51 -0400
X-MC-Unique: eC8UjzByPAKPJSx9Js6ntw-1
X-Mimecast-MFC-AGG-ID: eC8UjzByPAKPJSx9Js6ntw_1782819171
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c122a8e4952so405087566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 04:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782819170; x=1783423970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBTz2wXtqBvGPZiSe/mxuJQdVwaDfA6xdfyUMxtKKSg=;
        b=QtgrlMMoSvjjIYeT6pe8zx6u823mNcbgQJUc8qIRMFbtLnLrj6V1KTDEykwR3+Tbzc
         G7E5aJ/iRy9XcUYKo8Ga35HYP/jOUTgAE+paezWCaObBU7Okss9v9TCa1uCTUrDgMdNx
         LHPV2Auu7BRsP9TiRahJiq9KXDIJrpNXBYoP/kNYX1JptExlTq1Y3s8N+cybJ57nVqgX
         M1IVPDz3kd65hKZBm0fc8d//Vr5JS3TVkJYGWy2Z0z/ccijzs9ui71EEXUKNnaYXFqw4
         nNuvsg3y1b/MNX2CRpEuSLZ0uGvO1+Hq5519kOdgPjD25F1ogUl2iqI2DofYPphQgyA9
         g2UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rott+G9XhI/8nhgF7hrSxiGpMq6wadDUrJaGS4FqtqMggdy9yM3hJPHy5raoxGSkV4cbLmUPow7taBDLNZTIW8DH4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2HHCm9+u/Q9w9LVA45LGj5r7uu7JQHz2Bh0D+wj6D4RuDM1Z
	8tsQ6zB27/PcmB7vzTEMS3XJTmAf9hCoAKIBV5ENvjry4FzMhlpNhkcU9YgywmbtNkd29sqcmN0
	VK9VwhRxkycZMEx34NHgEnvrFz/A7bF+bVWMgY5hh82ZmNO+ZcCDwKJ59yxgd2oThlD0Yl1oZA8
	y3kV9PjoDeG3d4E1DE60AH3ABzCH3bVrBZ9H6vcEIS7hjQHQy3
X-Gm-Gg: AfdE7clotpNe3bp+MBd0kfyzVo/TyMs8D/mUHUifiPRLRqyUT1HW6Q3F5qEaft7JrzO
	Nc2f2uVr46Y7UB1alDf3jFN/4GvFD+8wnOqI9sGoxRni9plSlZtX8ix4mjAwdY1907HmjUtONHa
	pifudAEGJPaIPyks7MuRBWsS3IWxKVWuJaQKAjT5R46kNvwHJ9KhZnBdotdpR6H7M/xRA=
X-Received: by 2002:a17:907:bb49:b0:c12:8b1c:454f with SMTP id a640c23a62f3a-c128b1c4e6fmr130706866b.2.1782819170465;
        Tue, 30 Jun 2026 04:32:50 -0700 (PDT)
X-Received: by 2002:a17:907:bb49:b0:c12:8b1c:454f with SMTP id
 a640c23a62f3a-c128b1c4e6fmr130702566b.2.1782819169899; Tue, 30 Jun 2026
 04:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617131803.2988989-1-vschneid@redhat.com> <20260617131803.2988989-4-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-4-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 30 Jun 2026 13:32:38 +0200
X-Gm-Features: AVVi8CcQU0PbcEqWS5H0rq7ajtEDLjvGh4cBpavnLrLvOxj5BuQDFZ2rmR4JQOI
Message-ID: <CAP4=nvSSw4wSUWMQfWRU=Ez-q0L8-Ugon_nYPvXS2d0kEBQhaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] rtla/osnoise: Trace IPI events when recording
 a trace file
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Adxoeg1lzDNQuQ2SAZTni9A8ChdUBwKvmoSyoPMOvo_1782819171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> IPIs can now be monitored and accounted by osnoise top. When that is
> the case, also record them when saving a trace file.
>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c  |  2 +-
>  tools/tracing/rtla/src/common.h  |  2 +-
>  tools/tracing/rtla/src/osnoise.c | 17 ++++++++++++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
>

Looks good, the numbers match between what is seen in (non-truncated)
trace and what is detected in RTLA:

$ rtla osnoise top -q -d 5s --ipi --on-end
trace,file=3D/tmp/ipi_trace.txt | awk '/^ *[0-9]/{ print "CPU: " $1 ",
IPI count: " $13 }'
CPU: 0, IPI count: 20
CPU: 1, IPI count: 2
CPU: 2, IPI count: 1
CPU: 3, IPI count: 3
CPU: 4, IPI count: 0
CPU: 5, IPI count: 2
CPU: 6, IPI count: 1
CPU: 7, IPI count: 1
CPU: 8, IPI count: 0
CPU: 9, IPI count: 0
CPU: 10, IPI count: 2
CPU: 11, IPI count: 3
CPU: 12, IPI count: 0
CPU: 13, IPI count: 20
$ grep ipi_send_cpumask /tmp/ipi_trace.txt | wc -l
0
$ for cpu in {0..13}; do n=3D$(grep -F "ipi_send_cpu: cpu=3D$cpu "
/tmp/ipi_trace.txt | wc -l); echo "CPU: $cpu, IPI count: $n"; done
CPU: 0, IPI count: 20
CPU: 1, IPI count: 2
CPU: 2, IPI count: 1
CPU: 3, IPI count: 3
CPU: 4, IPI count: 0
CPU: 5, IPI count: 2
CPU: 6, IPI count: 1
CPU: 7, IPI count: 1
CPU: 8, IPI count: 0
CPU: 9, IPI count: 0
CPU: 10, IPI count: 2
CPU: 11, IPI count: 3
CPU: 12, IPI count: 0
CPU: 13, IPI count: 20

(This is in a VM, with apparently no ipi_send_cpumask events, so I
didn't test that.)

Tomas

