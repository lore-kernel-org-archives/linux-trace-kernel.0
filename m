Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F19350829
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301674; cv=none; b=ghbgjt8suxrMbHTgoDWcFmf6fhdPv1o4wqdWasA15/TJZI9Y80BM+VP49rp0xuZ0gLv9FW3X5+1ZGY1aoDq46oZJjwCgeJeTG+hGxTLvBVE5gbhAsQyhMoiAN6cXOkjimoIaYQVm7+m1b4Edz+ftglGDBC0eYql+euD/PdKytRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301674; c=relaxed/simple;
	bh=RX86EKaxodx05Jo4CYVnvh22zphvQ7WnXi505H5/Y48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EthJju9wqmGIDaFtXad2aiRHl7Q/5Iz+rQXTGnalTl359FeL8mAXeisCgng8jeXi7/0w9o96+yoG8DYXwE6nphxx/IlqUF+l904FpWU10zk0p7PggFTsKjQvJwodEUye5PYWkuGXKIsE9Q2kQxFm3dNaXhdlO8/+bLDPDGtgf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIR6YI/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIR6YI/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756301671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwmGCC5Gh56UXmzILLi26IzK/FvlTvLHRmWQRhUwlUY=;
	b=IIR6YI/caPcL6BvxWEjcrAElKxpLclX+a+jxu49+h6yO/h6pyb8gEsiwetxUhDwj0ebkQI
	WF+FpCRHzKfwFiHFf1Xp+GcG+IfQcTg8kQ3iKH2y/AL54+BskyC9zQsIIVlduq/iqrVguo
	iQDHkXrvxSe1/UmUt2xCIlXWxp4ytW4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-aj8Z1lUwOymk8q50PDEs-A-1; Wed, 27 Aug 2025 09:34:28 -0400
X-MC-Unique: aj8Z1lUwOymk8q50PDEs-A-1
X-Mimecast-MFC-AGG-ID: aj8Z1lUwOymk8q50PDEs-A_1756301668
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-61c927d2bfeso1930317a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301668; x=1756906468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwmGCC5Gh56UXmzILLi26IzK/FvlTvLHRmWQRhUwlUY=;
        b=W/SOCST4tvj9moSEnPXdTfISO/Lo+g2Drklf4GV9rHZkkUjdEKQXV1BZJZPzqNioCu
         oDLkRcPEdAffL+9QoFzqmobT9vhC4nAP9lYiqdzvdzldfRg1aIuaqy8FROhv/MpLEfQ7
         xEnc8ZQPrHstDZpSvBCH32ug9Qk3zzgzvBBWKD7q+Sxd3yNVOFVlYTPfG5nbkexsHVg3
         1df2pfQxOBkRwzhCfzl72huX7QZ7fONe4ZBvixOJ1ZrodgyQMY3NazoKo2t7LtGn2HXh
         5tPdfUIchasuEkC7qUqjZswbPyaVLb4RNifVJCIXJgSu9CCDLOlPzAxy4fN3YfZDoz+D
         eWqg==
X-Forwarded-Encrypted: i=1; AJvYcCVbUsp3b33MKfiRI3rNWSoMCtRnGuXItLm4Sw6qligHOfNUAhsFYXD9I2aA77DkQawEKzFV8dQQqscMxmcd9tWw7uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvu4PtvnolPurfwE+ndTEQbuKam+HDPL4jrM+st6P7LNXNf5q
	BJerUN/HlN4cCRzPIiTjv0/eb6dRZ6GOfHrHvRUM4LDqf3gTvfsS6v+3hsdwsOudhjACZrNzTu9
	bd1/rsl63pvqf7FbFxq+7uM2gHGFFtuYJE1eUDaQc8+JpSHhy0z0XXR5nm+AYX5lS+bdIpmIXKj
	mwLwhvAcSUa/Ij4ayKKqf/afaCT9uc6zuo6Y4lzNBssYXPdf5E
X-Gm-Gg: ASbGncsQrb5CRLuaZTBm/h6AQ8F2jTqSloh/wYqq+zopZu6aeB6dDir8C+RcbOBOjrb
	aVoRHWk/QBrTDNUVgolxp6GkhLnjr1DW0yobg7ppUWs3tmraDdYtXgarL1H588HjEgKc6QFZTCg
	qRXulpIY8Qz9LVBZINOBEqtm0tgnfRb52O5kozStcf3rwIgRkI128=
X-Received: by 2002:a17:906:9c82:b0:af9:2e26:4636 with SMTP id a640c23a62f3a-afe296e74b7mr1660755966b.32.1756301667548;
        Wed, 27 Aug 2025 06:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbd1IMQf1t1xzflLzrok6ewkTK/MKKhyxlLarjQKXKkJAuMnn5EDWz7weKeRafRsrDteP40yhFFHnLXD9+UTc=
X-Received: by 2002:a17:906:9c82:b0:af9:2e26:4636 with SMTP id
 a640c23a62f3a-afe296e74b7mr1660752566b.32.1756301667134; Wed, 27 Aug 2025
 06:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-5-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-5-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Aug 2025 15:34:15 +0200
X-Gm-Features: Ac12FXw_KbmPWP3y14qhjXeMDM7cD_iXFkJSbnYUVHyvprjHFTcH0Pcfftj6KfA
Message-ID: <CAP4=nvQPDEy_GZWTUhQcMYW32-3DvyeyjzDjNLcEEG1AwZnczg@mail.gmail.com>
Subject: Re: [PATCH 4/7] tools/rtla: Consolidate code between osnoise/timerlat
 and hist/top
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vsEBcUby3dfYSEs-WJQz5l8gjj3fsfrvDHT3pw79yVg_1756301668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> Some bits like aa_only and the user stuff are in common even though they
> are only used by timerlat.  In the case of user stuff I plan to submit
> patches for supporting that on osnoise, and it doesn't seem worthwhile to
> jump through hoops to move some of that code out of code that is otherwis=
e
> able to be shared.  For aa_only, making it non-common would have preclude=
d
> sharing some code, and the code that the flag inhibits isn't tool-specifi=
c
> (unlike no_aa).  Plus, there's other common code referring to tool->aa.
> ---

aa_only is implemented only for top, because the behavior would be the
same for hist: just do auto-analysis, no histogram, no top. Of course,
it doesn't hurt that it is included as a common parameter.

> +       stopped =3D osnoise_trace_is_off(tool, tool->record) && !stop_tra=
cing;
> +       if (stopped) {
> +               printf("rtla hit stop tracing\n");
> +               return_value =3D FAILED;
> +       }
> +

Is the output change necessary? The original "osnoise hit stop
tracing"/"timerlat hit stop tracing" refers to the osnoise and
timerlat tracers, which stop tracing on threshold (unless mode is
TRACING_MODE_BPF
). We already have ops->tracer for the tracer name, that can be used here.

>  /*
>   * timerlat_top_bpf_main_loop - main loop to process events (BPF variant=
)
>   */
>  static int
> -timerlat_top_bpf_main_loop(struct osnoise_tool *top,
> -                          struct osnoise_tool *record,
> -                          struct osnoise_tool *aa,
> -                          struct timerlat_params *params,
> -                          struct timerlat_u_params *params_u)
> +__timerlat_top_bpf_main_loop(struct osnoise_tool *tool)

The naming here should be consistent with the comment and with
timerlat-hist, that is, without the __ prefix, there is no other
timerlat_top_bpf_main_loop that would create a conflict in this
version of the patch.

Tomas

