Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FE0s2wm3"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6421AB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:52:47 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-677a4d9ba82so3282526d6.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700131967; x=1700736767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqJIzLc+e20w+CyJG0SPGKCmTSYxEHr4GKar1orgi4U=;
        b=FE0s2wm3PmLua//p/e6XeGXDBaBgpoIisWXgbbZ5mPjkMSBQC7CEyO+6TNpUNv7s1/
         rHuwLKDsX5oiijkhLGSZwdvMRdE+ecRQ1Rbt+AIsm06WeYbvLEUjMjXlrUp3UBupjrRm
         ydjRq4eXz9MyZBeqaPl8jw62q2i5MT8GahCq92hS8yq/K5DPgSmeAVYs/lj08i11FamG
         W8h3gMqbrBziHmzPGINlxZzJ6qUkKre7OiCdRNdYHhnGYGO/NCs6NxBCXTOIW/2OFhvk
         vWxT9MJxOgMG8ZSPINm5VSSMiigVpIc//xg8L2ZiNt/O6SsYnHuyJp+lV3sf1ubvM2og
         k+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131967; x=1700736767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqJIzLc+e20w+CyJG0SPGKCmTSYxEHr4GKar1orgi4U=;
        b=R37otDJ4Q9emnHFYewYX9z2B3gcW3w/nGDU9ts/Dt5NDEqADr2wGIVGf7IpJHIFYk6
         ZZLGJLL9KGYDwXPSWwB/o+NmmGFjmXWeSdezi5cfg81EVjGn+Q+7trt0ajnQaNuInPRc
         owmBIg0NwsWW5DV54E7AqcB98Qt85nFauagiPANpgUQPl8nd8DzcDa4xpfSuQh1pupvb
         cKhxgV6/gKzkrASzx2r7kWmiKVAgF9f9ArZqM+L+S3uBmazVK6VlzOOjp70xWX3IgrT8
         7jYZ9pY3i91Jx09rnZpCreMJrAdWl5xwx8ga0YwmL7XGO49TdVvEuhYfgF7p40jHFsqF
         AhpA==
X-Gm-Message-State: AOJu0YwOAlPhRSf45xdRXUW1+5jzOAjtzARkoQpxZ4dR+BokV50c6EGd
	vSNLI1i+8qpyP/CL86AeFnoefkD+pn8iPu5X6vnzlg==
X-Google-Smtp-Source: AGHT+IFL6OuFCAHtWGk+M6NysNl0dEVVN94VlaoyeFHRURNLqxhoGD85IALw3+5v3xQOWTXOZjFb/jzqyV+sTc8GtMo=
X-Received: by 2002:ad4:5990:0:b0:675:58de:b59a with SMTP id
 ek16-20020ad45990000000b0067558deb59amr7530365qvb.65.1700131966900; Thu, 16
 Nov 2023 02:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-8-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-8-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 11:52:10 +0100
Message-ID: <CAG_fn=WcuQxB6ZRKwi221EM-QsEfJ7udyQg9W_z0jv9nFCB89A@mail.gmail.com>
Subject: Re: [PATCH 07/32] kmsan: Remove a useless assignment from kmsan_vmap_pages_range_noflush()
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
> The value assigned to prot is immediately overwritten on the next line
> with PAGE_KERNEL. The right hand side of the assignment has no
> side-effects.
>
> Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operati=
ons")
> Suggested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kmsan/shadow.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index b9d05aff313e..2d57408c78ae 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -243,7 +243,6 @@ int kmsan_vmap_pages_range_noflush(unsigned long star=
t, unsigned long end,
>                 s_pages[i] =3D shadow_page_for(pages[i]);
>                 o_pages[i] =3D origin_page_for(pages[i]);
>         }
> -       prot =3D __pgprot(pgprot_val(prot) | _PAGE_NX);
>         prot =3D PAGE_KERNEL;

This bug dates back to 5.1-rc2, when KMSAN didn't exist upstream.
The commit introducing vmap support already had it:
https://github.com/google/kmsan/commit/3ff9d7c640d378485286e1a99d85984ae690=
1f23
I don't remember what exactly required the more relaxed PAGE_KERNEL
mask though :)
