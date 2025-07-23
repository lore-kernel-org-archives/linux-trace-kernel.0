Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE078248F52
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259434; cv=none; b=AlMAz3EbfyL1NhINKjGdUEscJdb6BGAsrqaaprok6gHS3e+VsSGlJ3Xt++G/5dSOF7IWdcauEbQcW6zKo7apgNFYtR4seCnZQBkLOUF5oH/qHqWGPq9N6x4+Df2tqEHeXxTLvHNA4Gl0I04iSlkO7vA3DwmK2KTryoTj41wS3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259434; c=relaxed/simple;
	bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbhinG4qGzn98KSPsK4ta1d+Cg8PHyw6QZR2GV+X5f8jI8fZJjrLxiOW+mgwyLsBUz6v2CAixfsjEJlH8f67ELX9aB4x0aLf8nEmvpjx0dRH125v2TkvB0zHTammvtkgZPV5m3UVE11KsoLyyvbcwAePWlugujzTt/JL8Mg1HoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpQlHi1u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpQlHi1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753259431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
	b=cpQlHi1urLBM3EAMycQL890XEm9PqxqVVovOcuwu4ZJlpAuOveYApsITvxZm6fWLm11vB6
	NXDaKLe8rsmPHB4JEgjFA8atGxKKDxq24T2bGczbC+LNQhKQK/z3a8CDxpKNq6j7WGH5zl
	168mYPy+nyZEWV+KJVn38YyEzX0RjxA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-o40723vTO1aRXzf_DHwXxg-1; Wed, 23 Jul 2025 04:30:30 -0400
X-MC-Unique: o40723vTO1aRXzf_DHwXxg-1
X-Mimecast-MFC-AGG-ID: o40723vTO1aRXzf_DHwXxg_1753259429
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad56a52edc5so658589766b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259429; x=1753864229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
        b=o+fPKpECg+h3pr41Pr3WiLMg3rZPEEJ6IHEFT7AqsYySOAUNBa9C9BK7cViRfZXzFn
         XOF0elpcedtlP01b9yscLHQcImcps7oD1IUPcWqVPnOOKcM35VAoqkjBaXdErYvJ1bMO
         oqXas7Ww7fUt+BxYuINE0p3nsGmJjRRwK90FOlmuU3Hq+A87JlFMwyp2uYRSwTxb4I6V
         4E89qeGsR2A5XWIf5QNfE6J4zvY/HZzKVylo0uno7ol6OWJ6/xSsEOQo/g6rsodzwJiA
         670LeFqtKeDaNzdZr5TH1/XEAUMQm44Nv4p1jzfWYdFV3pYigDqBC2EFg7nfwykivrjM
         rIZw==
X-Gm-Message-State: AOJu0YxW8Vp+LLqIDqbE92vjjJuZ+4yeiyiAwZDKRsAeV3ww/Wg20AAP
	aPpzvuevr6uKWBbhSMD9UTSxxu9uxZ3piH/RDBDIcceCg+EzQNFRlewTLaxcw0hHzaPvGIrKv3/
	ABMF8Mp59Dx20Vk467YXBeqAeSWR3i9E5JxddHz9vrsyWttks1iIBUDpw3OnkYQVnwaOrb2f/Nc
	dchhECJH8+vFern8zLVNwm28Y53Ua1/mAP7WgXcwiOi8RA1ODP
X-Gm-Gg: ASbGncvgqmErw6F5mMeHFHFYfTH4ebPrWoA6Qv1Bohp99FSMoUK3NUDamDsouyvUUPY
	nUUUZ2rgBk94RX4mLmoV667rFfNv4qyU3DdeUMn9jVxXJzGHQC8HZP7+Me+KdKtri2BHqJFPg//
	JUz2T5L+iYN5s0PyibSVAAXTx/tZ3JWoKTtD6QXFv4rDnjQYuYD6U=
X-Received: by 2002:a17:906:ef06:b0:ae9:928d:f285 with SMTP id a640c23a62f3a-af2f9271a76mr224162866b.55.1753259429026;
        Wed, 23 Jul 2025 01:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUCquKYM95lpkzero+gW1DdskdXIxo41fmMVrdQBzGb5qc4sMw0+zowOnuFoncN8TnYaRK99BiJIikjg//U7c=
X-Received: by 2002:a17:906:ef06:b0:ae9:928d:f285 with SMTP id
 a640c23a62f3a-af2f9271a76mr224158666b.55.1753259428491; Wed, 23 Jul 2025
 01:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626123405.1496931-1-tglozar@redhat.com> <20250626123405.1496931-10-tglozar@redhat.com>
 <20250721183606.0489b1cd@gandalf.local.home> <CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
 <20250722112926.17ea1c65@batman.local.home>
In-Reply-To: <20250722112926.17ea1c65@batman.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 23 Jul 2025 10:30:15 +0200
X-Gm-Features: Ac12FXw8iPQlEJ-1WcTi2Z6NqstzZt9bHeBzd7CgP_VNoJSCQXpxfgXMkZKZ1ss
Message-ID: <CAP4=nvTSycYMGmbJ7nd1Bkp9Rrjn1ojH7VvRo1GCKO5FKm8GZQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oiHkWKcdNCrnUggWIvSLUBbjuz-D5PlY8lQ1L2INAek_1753259429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 7. 2025 v 17:30 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Tue, 22 Jul 2025 09:03:24 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > Of course, this is just an implementational limitation of the timerlat
> > tracer. If timerlat had an event (like osnoise's "sample_threshold")
> > triggered on threshold overflow and if it is possible to wait on it
> > even without BPF, rtla could wait on that for both BPF and non-BPF
> > mode instead of what it is currently doing.
>
> Right. Is this something you may want?
>

I don't think it is that important. Non-BPF mode is mostly as a
fallback for users of rtla on older kernels which don't have the
osnoise:timerlat_sample trace event. Those are (I assume) mostly users
of LTS distributions who run newer rtla from a container. Adding a new
event wouldn't help in their case.

The only users who would benefit from that are those who don't have
BPF or libbpf. If there is interest from using low-latency actions on
threshold in such settings, I'm not against implementing a threshold
overflow tracepoint and supporting it in rtla for triggering actions
on threshold.

Tomas

