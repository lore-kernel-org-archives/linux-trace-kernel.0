Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501917554D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871311; cv=none; b=uscxU4bdU8P4fTmDjs4YIHFhVLqAp871UgJn9u7onzGVEBezFZZJefz3oK5QuZskRvELL+hbJt2ATQjwAUhPTt4WAh2PsUn7a6TS/bYiUcvuzWmwx10leELgHmH4GRC1ehesZyCV2j2pPJ4VDZcfynLQiz7IYLTZ3Qm801TAoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871311; c=relaxed/simple;
	bh=ZHRuGJFlUYdLamnB6sF47nsjZQIytquVYyRv7K2ZWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXiOJaa0+EPzLXIqr2OXv/V3YWrJStDKQYNt3darBxIz1ahS0AtDhUBnjvazbj6Z0PPQX4gz+sRBp//+3KasB3mN+Rd8plUaAlWFRFH1SK6dDOG2iBsnwhy+mpGjXAS9q5gIwK2a9vaJ9Scz9FSXnil9ur1vWr48BQL3HCMS0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q1TTYUR; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q1TTYUR"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-63127fc434aso4840417b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871309; x=1719476109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=0q1TTYURnIp+/XFb/EoH4dDbQF63DjNb0U+1GNE+ogoI/17YREMvATQGVlZ+Y6fAfV
         AUyJLwDnn3FP7lwBsoNp10YgVAwp2QdsHCllE7PW+Y5wiCoHKW9McjfSfQmbAGkeFJym
         bKwrSSW54DfizLu/IGad6MaLecomhonc0iXvbQ6NaAmX/1LGC4LlnLAzzP/6QR6xkQZT
         7yUta9lsPaaNfJt2bbaMYrrgLINexvn9ihcRooPYTyFSmrEnZ2DgSD7Ayr7jPfwl1PaD
         hW6+/vbc6A/NQ5p3IHkWvGy7W6rwj8y3qTN4L3rZMG/H49O8GUbelgrAroLH7vhEQgKS
         crhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871309; x=1719476109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=UvQnfrZsPBh4n3/+JZwrawm6DoFQ5FKjLgx2XrR9SORwVrdcsJTH4F+TcbVZ0uwEW9
         GhZPvEkW0cL+9JdxVihJVSRL4VTUQbwRHMBbnFSQ/ZslHGNOMpdYyoBeXpIFm28E3jup
         Y+Blh6G6agkFSTRHIVkBWU1lfXNFSKGOZU5Nq2zsAvkaupw4TestlIGlXqlFt1UiDl5T
         knFNBUF6SEeGaH9fjkO7AOWmlr5n2qID5vLRlXDv69pkDmsL5++DApJcnlZPveyIXFp6
         +DQHjymPSCRBJdXTAMEH66jLrKMXvVY2Z+JMGHc2GhTg7jNqV3J1ymc6lTCGw8afO/kF
         lHKg==
X-Forwarded-Encrypted: i=1; AJvYcCUdt7lWmkmtDCazFUjlcH4KPNO38Vy8Won4VmhmpRS3YbY7phBx9F6oNhfxrAF8xxHbkbdkOnOAiPPHP7NiRdpDHPWMy1OdX/l2OiOzroOsay7y
X-Gm-Message-State: AOJu0YxPU0spBbTC+OjghIRZGsKUgKx3LM8u5v8K44vVYw8NGJoVnJuE
	F8CJJqxAVenDC+sOSIGxobFuYuBfZDnP3d7GyA9/Bnmqgb38l7349cRdeEEpkDLP6/kShmHvHZu
	h/ZCgPFaF6GakFR2n3xfHwCnVnB/LXKM9u+Zn
X-Google-Smtp-Source: AGHT+IEov8tA6WgC+NocZnlJNfskZn/sCcpgNQNbOkch4CKnuKF2F+01qvPEG14FlebgcmBeM68GwMaerknT5zuvZsM=
X-Received: by 2002:a0d:f185:0:b0:61b:3345:a349 with SMTP id
 00721157ae682-63a8d44ac47mr43240177b3.3.1718871308642; Thu, 20 Jun 2024
 01:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-13-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-13-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:14:27 +0200
Message-ID: <CAG_fn=W6L0Yr_GLHEok=LmL0-whk2r+-E7fVHj8pA8GCtgze=Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] kmsan: Introduce memset_no_sanitize_memory()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Add a wrapper for memset() that prevents unpoisoning. This is useful
> for filling memory allocator redzones.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/kmsan.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 23de1b3d6aee..5f50885f2023 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -255,6 +255,14 @@ void kmsan_enable_current(void);
>   */
>  void kmsan_disable_current(void);
>
> +/*
> + * memset_no_sanitize_memory(): memset() without KMSAN instrumentation.
> + */
Please make this a doc comment, like in the rest of the file.
(Please also fix kmsan_enable_current/kmsan_disable_current in the
respective patch)
