Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyb2sOjs"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956BB8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:34:20 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-677a12f1362so3280476d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700130860; x=1700735660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCzmGpWmQul4wYiJvXX4QGBTD7ZNE9De5NBHM0dQ8JI=;
        b=gyb2sOjsJh64yKJY92DI+11XTUrz8vDPBIhiPDzickHe91aBE/zIxmv8ULiXtESFXr
         WFhtxbCeO7szK3OscKGPMOE9YvjJw6vuepxbOHI4lN4tURE40V5i9ffpwArWa58F1Tu5
         e7yBhlSJ5pRUMSwpYccwKW0n07sCcpqMueIE2DlQcuARCjNv5MVqASNXadm+5TDUYs7i
         95QyRu7wjL4yWCXHJRJ2n8oOqQ5PpiTnRKj2TFb+E2EYoa7guUHZAS3eaM9q81UH32PD
         sOhndC+NtXoXchkWdE5Wn5CYl2mdsnoa7T16vcleNbzN4Wf7m5koykXDGaLm45kaQ4RE
         3Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130860; x=1700735660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCzmGpWmQul4wYiJvXX4QGBTD7ZNE9De5NBHM0dQ8JI=;
        b=su4gcm8rsvq5mCS4SiCvO1v2wPg5VsU/UVjOwavYh7oDt4Gebn039MiFLmrt4u7ELX
         gGLZ7tte/9dxaFSCqU/kRgWiOGmWN/kg5EJRE4z9iK7kCvQHxo0bxAdM6DxgVAVWuP/O
         R5uDGZsbT9KHx4kietxMRXSuqj46sXB0ycygZMPLQ2GnOqNYuJMlE61LKYHtSyizD/aZ
         bZ0mPSbdzJH+v0KYcQu/Nd6b/zBL2Fba+wyJkW6X0mGDzJWE6DKww1Db851sIl/swyXD
         XA2KP06jvGICdloi10EiFQn5YkRn/eirZx4uwh9InQ8VQrC8HZWMAfPFOkz9UbFvALGb
         QYUg==
X-Gm-Message-State: AOJu0Yyh1bYPMutlS4s1Ha8dlEUBBtxJrfHQ0iZz3Kc1hRwnVl2WM5l1
	uJPNNSgsf9BqBDyFAxlsrUT3Ohqg3zYXW0dv2pljsw==
X-Google-Smtp-Source: AGHT+IG4aY9GHR76tVKMTAGmd0CseNMuUXkNiPOGtMWZyskYlNgHZ6XGDtn1AzcetJJpwAPmQpPFevQ/edxH5B4nbxw=
X-Received: by 2002:a05:6214:12d3:b0:66d:1d3f:17d7 with SMTP id
 s19-20020a05621412d300b0066d1d3f17d7mr7472430qvv.8.1700130859918; Thu, 16 Nov
 2023 02:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-20-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-20-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 11:33:43 +0100
Message-ID: <CAG_fn=VMKwcsBL4KuRYG-dojpZg0WFqJgZc67ks5Rg-HEnd2bQ@mail.gmail.com>
Subject: Re: [PATCH 19/32] kmsan: Accept ranges starting with 0 on s390
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Pekka Enberg <penberg@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On s390 the virtual address 0 is valid (current CPU's lowcore is mapped
> there), therefore KMSAN should not complain about it.
>
> Disable the respective check on s390. There doesn't seem to be a
> Kconfig option to describe this situation, so explicitly check for
> s390.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see the nit below)

> ---
>  mm/kmsan/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
> index ffedf4dbc49d..14f4a432fddd 100644
> --- a/mm/kmsan/init.c
> +++ b/mm/kmsan/init.c
> @@ -33,7 +33,9 @@ static void __init kmsan_record_future_shadow_range(voi=
d *start, void *end)
>         bool merged =3D false;
>
>         KMSAN_WARN_ON(future_index =3D=3D NUM_FUTURE_RANGES);
> -       KMSAN_WARN_ON((nstart >=3D nend) || !nstart || !nend);
> +       KMSAN_WARN_ON((nstart >=3D nend) ||
> +                     (!IS_ENABLED(CONFIG_S390) && !nstart) ||
Please add a comment explaining this bit.

> +                     !nend);
>         nstart =3D ALIGN_DOWN(nstart, PAGE_SIZE);
>         nend =3D ALIGN(nend, PAGE_SIZE);
>
> --
> 2.41.0
>
