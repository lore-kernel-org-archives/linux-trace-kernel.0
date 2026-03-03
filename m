Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E935DA70
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541988; cv=none; b=ly4X4K5geng3fOk3L2jEKChS47SN4+AT6A0AnOeXXfuDYKs2y48et2lPKGW8uLx3NF9XgvevCkXhkV3+7XjmVdLgUamJPhzFqgkQ1wOrzHZagREW7rqz2fTN7F0CTrC4s+AGGrwBLmShD1l9uG8fowFTTDnMVkiZq/r7R1u7Ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541988; c=relaxed/simple;
	bh=JAD0GsAXzpcGD9pr5IR/zQJEInVPlw0Smf5HeV04xG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdeo8m+g6G1tysFnwAGlKCigH/5ICYtq/7e29eqCT0bapeOs/zesUBa4SMKe1BSrBIfTQuSmTmfTFTKyXaFEOmTkzZPmiuqvXzlQ570oPLpRroRwWh3Y3MyTvXRW5KCHwT+yNbQIa20aMzuW9ZIOywQUeZlaJjUqVFIlbkVJhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv++NL91; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv++NL91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
	b=gv++NL91MjpFsK27c2mgbgwrURXTjxzMUwHA78HLEBhIFzm7NQUcIwGz2U2KKvRBaE1/Dx
	yv6c0uY2m+AfGJ1B+WmG+hs/P4Bj/VQQI9BUi0i25gcIHr4d41LTt7II5Ddy72WnjcAW7d
	5IoNu/ER3IEkLjTeSy+EPr330WQoGY8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-m558i3rNP6eaXcYrOxGC-Q-1; Tue, 03 Mar 2026 07:46:23 -0500
X-MC-Unique: m558i3rNP6eaXcYrOxGC-Q-1
X-Mimecast-MFC-AGG-ID: m558i3rNP6eaXcYrOxGC-Q_1772541982
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8f9599feb8so428488766b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 04:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541982; x=1773146782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
        b=qssMFMTJeP15Zfg1cXEcau9YeMDQz0ujhXh7H5egltlRhLnxCp++/fkpsvyu5GuJkH
         sb7P579WgQNJtBuvaAtyt6DlkyIcvNcvmkJlWMYuhYGWU6a2Pd44Bt5yYj60lYhMDa7t
         hIHxZdajgROqXFfXesny2aG9x5sFWL2vciLw1qRV755mIP62PkQaI4Rlspj2mJTJ86lg
         pvoVY/x2ZnAc7OZBhiFElKN9J3fzLOHC8iU4MEAUUGFjTHi0Te8nluZJmfLxoBBfEl7L
         6IL93364qys8j4ibon8p37Y1Gd3UI4IHPU5LBMZL/9s+84EIitdKvhjMLqdybwIfJa3L
         LGAA==
X-Forwarded-Encrypted: i=1; AJvYcCVMNtNMJUrTyDGHViyZ0rYlDTp9b+S7Wl8uY3dnQupz3Kww7d+za3omUfxnatCmaEORQZMDiYvxVq2fZIA64ngzOmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzN8jN1FBluUtnQ/2OKwGAkM4dL+gbddpnRDqpWWtUIyAwOM9t
	gDR8hmfuuTQP808WQZprP6BtcATB8dnpOa92V4VtjkURrct0NBfD/umpq/NGjOmjie0UZ9wDp/i
	TZGujZ6MKX1VksC/DjdlyH2b80B19bRuS2m+IXkf2OQKVSH+yaC+1BEcpxnalOZuOpFHjOkgSXG
	OM3EIz+lg/tjoleiv4YPQDUkikCXMDwqjtCX0q0aiHjBPX1Gi0
X-Gm-Gg: ATEYQzzpt5pn45/hyo8m7kGvxucpm1l6c7S9cvnl/dfZ0vjskdIZfOwKxJb5MOKVzvX
	cJjBc1kfulzlJ1B8Mm4YRldgUp0Ad0xWFUlHdxgl7WxyrgRuvcDA6xByx3CS/g+zIxya608oeWf
	Ni1sJ+mSd7V267HT/W0mn48zcunDG3PR3S4Y2knixGSPxZ3ZCR8ZwmMjx9SOAp1JxWpYMD0oy2Z
	cKmvQ==
X-Received: by 2002:a17:906:ca57:b0:b86:e937:d097 with SMTP id a640c23a62f3a-b9376514675mr729184966b.38.1772541982391;
        Tue, 03 Mar 2026 04:46:22 -0800 (PST)
X-Received: by 2002:a17:906:ca57:b0:b86:e937:d097 with SMTP id
 a640c23a62f3a-b9376514675mr729182066b.38.1772541981952; Tue, 03 Mar 2026
 04:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-6-wander@redhat.com>
In-Reply-To: <20260115163650.118910-6-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 13:46:10 +0100
X-Gm-Features: AaiRm52GZVPjzh-rd5h81XelxgZ2dXcPJjs53KKG-UzICR-7mah2HbQfJdFe3ZQ
Message-ID: <CAP4=nvTqJhM+0KuDAOooOtgUEad4t-7oOM7pDKxiMzEz=Pb5Pw@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] rtla: Replace magic number with MAX_PATH
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aGlho-k11oO5jI0oxIGotAaSeOltE0ZeVfHEyOopBls_1772541982
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -52,7 +52,7 @@ char *osnoise_get_cpus(struct osnoise_context *context)
>  int osnoise_set_cpus(struct osnoise_context *context, char *cpus)
>  {
>         char *orig_cpus =3D osnoise_get_cpus(context);
> -       char buffer[1024];
> +       char buffer[MAX_PATH];

Shouldn't this rather be strlen(cpus), a new constant, something like
CPU_STRING_MAX, or a value dynamically computed from nr_cpus? The
buffer is used to store "cpus" concatenated with "\n" to be written to
the osnoise/cpus file, it has nothing to do with MAX_PATH.

The contents of osnoise/cpus can be arbitrarily long [1], if you
specify more than 1040 CPUs - which is theoretically possible, as
CONFIG_NR_CPUs on e.g. Fedora 43 is 8192, although rather unlikely -
it will be truncated.

[1] 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")

Tomas

