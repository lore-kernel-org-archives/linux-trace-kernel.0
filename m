Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNLXCl1J"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591B182
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:27 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d093265dfso4654776d6.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700146586; x=1700751386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzM0stGZCClmmzmredmePw1BMrI7dq9aY1ehb48KIQU=;
        b=FNLXCl1JfVrSP3wlr5c1EzCFRf4WU+SKRk5ziIleaUK4O05dpZtUZsJLwVwAI/76ZH
         JHZGLZRdv6Dbz2lSp9sb3b/cA/o8QkcyXWKsz2kQ2e+6LVd+vobUDAcOd5t0XcuXqIHl
         Fp1koZU/BZrbsvki7hCSZ7avhZooOTGOl0Nhnm2Xyc5E7K7LiuXZZJ/MyHcv6MNVqN4M
         Vg/Zsxqm7ou5hRnI8YOos7QUrCpBV/ICrSrICeFbj/+HhCDeNmT7RCqv5+4x7R7MgMUu
         P+lm3ysD0XGQiXYwq73x+6UR1DFOzQ52uDNhwPNmuXaMi1wY8AmrixwxvRwW7Kur73cP
         9kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146586; x=1700751386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzM0stGZCClmmzmredmePw1BMrI7dq9aY1ehb48KIQU=;
        b=Pyt72rv9PDkFtXFwfNU8A1U6+LMI2w4PssHOpPSQmB0q4R3NBpPlBqcl52LkJ0FmHf
         2qge1eI1I0y2r4zq90naPbQFejE1wJUYK7UCSYr2hxeDSZ3pRqX8A7avtlDYHmU94NFT
         Pp/qh+Bxi+9y+LF+9vWN94CRm5PbVaKBOsXzAFIU/jN7us/g7G8g4ZqE267ORsB2oRje
         ntt52tgxhlTjX+yFqsGCJ/1TTOHCtIApFjTZtsXT+OxxpuR4ZhkF7+Ci3QlInLyqBAkd
         3ISJ9iqmRn3FXJKn8gPJAFS+mF8vFKArt5s5+geE6rOC4zfaCWSZtE9IVU/TUIBlgkX3
         AGTg==
X-Gm-Message-State: AOJu0Yy+ToNoRtn2fuwUQJvPh9yi/2hANvbvpLeojwqiC4n85/fPcW1T
	+OPdUcS6X0UdD0ILqX8OIWzoSEMx3yg+I6L0qauTKg==
X-Google-Smtp-Source: AGHT+IESlLCp03SBdqseDxgs7HGGaCnWUi82EdGIBUyYoFDdg/kV3Wtu7IaPSKUrNV12K+J0pCN37EM86rUdQP7PWi8=
X-Received: by 2002:a0c:bf02:0:b0:675:5925:7e08 with SMTP id
 m2-20020a0cbf02000000b0067559257e08mr8062067qvi.32.1700146586474; Thu, 16 Nov
 2023 06:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-14-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-14-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 15:55:45 +0100
Message-ID: <CAG_fn=WOfRvDw3r3zcZXWr8aa6MiEuKSa1etQrGVSJP+ic7=mg@mail.gmail.com>
Subject: Re: [PATCH 13/32] kmsan: Support SLAB_POISON
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
> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/kmsan/hooks.c | 2 +-
>  mm/slub.c        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 7b5814412e9f..7a30274b893c 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -76,7 +76,7 @@ void kmsan_slab_free(struct kmem_cache *s, void *object=
)
>                 return;
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od */
> -       if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
> +       if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
>                 return;
>         /*
>          * If there's a constructor, freed memory must remain in the same=
 state
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..8d9aa4d7cb7e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1024,7 +1024,8 @@ static __printf(3, 4) void slab_err(struct kmem_cac=
he *s, struct slab *slab,
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>
> -static void init_object(struct kmem_cache *s, void *object, u8 val)
> +__no_sanitize_memory static void

__no_sanitize_memory should be used with great care, because it drops
all instrumentation from the function, and any shadow writes will be
lost.
Won't it be better to add kmsan_poison() to init_object() if you want
it to stay uninitialized?
