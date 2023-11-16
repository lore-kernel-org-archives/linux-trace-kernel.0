Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjOM6T73"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C81B5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:03:55 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-677a0ac3797so4841366d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700147035; x=1700751835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEPBtVIehZENietqQgMRaLfueUPVKPaQSiz0lKmUCO4=;
        b=tjOM6T73bOgVHYQnAA8nPqN2GtcyJDN9hU/+eWFapfh9qsj6akbzxvTmB7mF5Xsmka
         hg3XoaWF5IkBAfSxhNko5AFheUYEtsWs4KMJOdbGTZCCleCHpXIeJwERsLSZR9umf9b0
         3AbtkJkBBZIAzfmAoO44j3SccK+pQzZDNf+e4RSpQ7Yh/ugPtLimqQjubpXdYByVtp89
         YtQOYiWnQhFPnFX+I0qcl1gzLpLqBWy4NcxihC+r5FJljUtckS4XxsEEx1TCc5qFlXA7
         KUHnqFXdEN3ELNVt2PzlBEDPoNRZir5EmW9FsKY2eR/1STbflbYrcDJBQYExSyJddJe8
         O39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147035; x=1700751835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEPBtVIehZENietqQgMRaLfueUPVKPaQSiz0lKmUCO4=;
        b=LFgOrBshT/oV2wfKyJ09XB1vqleevIoLEvDQjviQ0t0g6IFaVe+zkeSoLivTh89pNV
         riXoY5mB91+0heETEAtxElE9uRXLoXkGlzzQWUC8lldBtIeDhFdS48kZTX7qIjFHjkJD
         0ta8bZ09yPqpmCjrNNJcdygpEfAIJCGx0s1OWBhHoOD0WnVgb/87/rqm1lHzskdonsvY
         xv22rLsj7VLJP77HFhpLfCApnYymDWiWwO5YIbDsydelwf1YQI+B5sQbVnyoT4FlGUr2
         eNzpNMG5gCihmVsTfU0JVWAt2aBSWPW12qUJuswxHGgrudnIl8Nn+Dg0/MycmvZ4DaxD
         nwxw==
X-Gm-Message-State: AOJu0Yzpnz0EQ59kRYAcgTOxFJhjPpyok2zra7l+hvcAHhyLv+JkUyGF
	OP85bOXSFAeFYm2vKVQgP4HVg2BZ4yVE7JmZlZkmZg==
X-Google-Smtp-Source: AGHT+IGm2krVDnKXXhSMoJn1uvqnmJEHLLH/sx6QaCvlfNlZK+ZHTBQsOV3/QFPtlz0RyiLxE6410dtEDy0WjvMczws=
X-Received: by 2002:ad4:4b6f:0:b0:66d:55d9:bc7b with SMTP id
 m15-20020ad44b6f000000b0066d55d9bc7bmr8646936qvx.31.1700147034569; Thu, 16
 Nov 2023 07:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-27-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-27-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 16:03:13 +0100
Message-ID: <CAG_fn=XSKh=AmU3mEC7dNmEFk5LaLt+y+TfsVcD0Dn5NsbTBSw@mail.gmail.com>
Subject: Re: [PATCH 26/32] s390/mm: Define KMSAN metadata for vmalloc and modules
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

On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> The pages for the KMSAN metadata associated with most kernel mappings
> are taken from memblock by the common code. However, vmalloc and module
> metadata needs to be defined by the architectures.
>
> Be a little bit more careful than x86: allocate exactly MODULES_LEN
> for the module shadow and origins, and then take 2/3 of vmalloc for
> the vmalloc shadow and origins. This ensures that users passing small
> vmalloc=3D values on the command line do not cause module metadata
> collisions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/boot/startup.c        |  8 ++++++++
>  arch/s390/include/asm/pgtable.h | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
> index 8104e0e3d188..297c1062372a 100644
> --- a/arch/s390/boot/startup.c
> +++ b/arch/s390/boot/startup.c
> @@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void=
)
>         MODULES_END =3D round_down(__abs_lowcore, _SEGMENT_SIZE);
>         MODULES_VADDR =3D MODULES_END - MODULES_LEN;
>         VMALLOC_END =3D MODULES_VADDR;
> +#ifdef CONFIG_KMSAN
> +       VMALLOC_END -=3D MODULES_LEN * 2;
> +#endif
>
>         /* allow vmalloc area to occupy up to about 1/2 of the rest virtu=
al space left */
>         vmalloc_size =3D min(vmalloc_size, round_down(VMALLOC_END / 2, _R=
EGION3_SIZE));
> +#ifdef CONFIG_KMSAN
> +       /* take 2/3 of vmalloc area for KMSAN shadow and origins */
> +       vmalloc_size =3D round_down(vmalloc_size / 3, PAGE_SIZE);
Is it okay that vmalloc_size is only aligned on PAGE_SIZE?
E.g. above the alignment is _REGION3_SIZE.
