Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3F3B14D0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057803; cv=pass; b=BRZQ1WENBxtf/KJ7fsSjUykBeDcRTmPnGOv9WhIIOiKFMawXdBpUf3Wspn2YFF1saN0R2x/W3wq0JMQpiYa2sViHhg8tBfirY7ixiwLtdYQW8IdtxnWXWSJZdwrFwxQ+GaOGs0c5Ahle8dSlr6jD6YjK1kCqxwkN5pDCuO4aUSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057803; c=relaxed/simple;
	bh=BBkQ9owM4UN7HjyC+I5EPj2XFIiMDuhZupokt1yGInY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGt6SDv6noiqLtNwr4pPl53Gni0lkY54lIvHUAuZfgj2bxMRdZd2/3mwbjZF59LsIjvKe0JdAQoF9BRXa4loaOm5VK/446PT+UZ3J+BVqFByUU+jqCwK0PCU7GudstfxPmpwlTpfCvHRNTxg1JqExVpO7UzPp//7FGGSGLf4vcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtkBb2AI; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtkBb2AI"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66f8053e7afso5135747d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 09:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789057800; cv=none;
        d=google.com; s=arc-20260327;
        b=g6YXq38+91kANj0SbVRa2t6hzMxuDFAGJMpdTgLtd7CBzhWw/13BcUnDwUG2Fg1ilM
         iwd9PyQEEaiomatAnPuDD0HdeFCgiZS/pgMb76w7TPn3fUpD4LhNA+O5h/08hbf+bGbh
         LpVb9bI3Td25UlA8ae19PSX/drUGRgvIuhWHWUpUrmlFYaqTT54ZbqIfU6/4nJ8BQMij
         NKuzrOzKbuGD7xzNBz5bi1Rql1AYh6Gtxw3h3eER1rBLOlhoB5Rpwj43Yc96CgC6t1nt
         mTlgRm72kI67JwqsezriwIYXRrMKN5mgeqUx6xtRXvMcw3sM4aYW1d/GvUBe+j5n6Y9Z
         HgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJU9YUENvOE810OZrMLcmDFYvKrM4tnNdpUx1KzH7KM=;
        fh=yzVx+08HJ1CgQxur6utL8uuEOp8oG4EEYcdJvEB5v1s=;
        b=cR04piHsLFKWnwYGOLjFnK8C6k9xr0g0GEj5N5+rqqGT2A9hCJhiTtYzx33cwy1lPn
         JrQF4lXcApRuis0/KyxuQC3uVHtszYuf5hzHWRgBOe4KUWxyp/baqGXGeXcw11QdIuYz
         winvKHrwW5N8YQiNfhQziXXTN4yLBjwl/WI5SIUe46wptjAhp6b1RzmiJeqeNOL4Oh6b
         MttgMY+wnwYDeAyBpvYBfhS5J64tjd6LTSzzURoEr/F9hF2Lc8jQYk5j1Y+ZXw42SF81
         pjDQA/26FA8T5Y95m7a5pq2W0rw7ro43/206PMYwFJEMUsCwwNOXlsfYBVFA1DwODK2k
         bvYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057800; x=1789662600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJU9YUENvOE810OZrMLcmDFYvKrM4tnNdpUx1KzH7KM=;
        b=GtkBb2AIBkw39FGqfMwCueN2WwFrK4Lnk09weUWNjztolDm7X/WmYdUQYLN6YWuAD1
         YekMwAOpNmvAePTkymcwzNlFTVs56vpEuXoHA5DlzKwLDor0yrrDMTlCqNTtAaS4ZGpJ
         qtd6uLUizVVodfDfjMtU1H6hBazuu8Lq6Xy4EzFb+YfSsbqId6drXyhEdz0JPSBypPGv
         CLqKsRmO5HzAUvUVEJh80CVwwDzJce4OV+sXkBVgSMX2NcmpaNM5i39HIF5wlNZpXodP
         LUKn8m5NqT/D/1SHRzZq01bhZMjq94+KjSseqq1ydAlBOjmzpqI5aLIAVMGoGGysWVZp
         E91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057800; x=1789662600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJU9YUENvOE810OZrMLcmDFYvKrM4tnNdpUx1KzH7KM=;
        b=bpE/EOimM5nwR5X2ceNDJcssWOFooRRS4BnP5MQU4NBRihmqanHQBqWvpY2cGv1EDN
         4e4tIMnpYZftFZd9hF3Vl4YGQtig/pjCF1U1uMnZAmqJH2Slh3XqamirHA1KG/xmqNGp
         Vo9uHV/BK4QnZav6l15Q/g/IVlsOgptxudofw+Hpp/ysD/uGMPYhABf8FXZqWLUc7//C
         OS31/m2VxkPGm9GTD54RDocJO5HZYadP20KU8Xm+yMtjQ3ECtVs6p/TxbhUfSM+KkAFI
         UYi76pQOP7zbo0dPfr+VrtNRUvvNvNu8eVG9u3VNpeg/MMiAeQpEG3NnUUuDiw9b64cC
         wVnQ==
X-Forwarded-Encrypted: i=1; AKwUvBybKwlpxW+KUvXbB5wC6nPYOZCLw2cPs9MxB8sDgtsxrGDr3Vf+SFq7ZI6i0vnGOv6Xtmqyq6//pabmkrJJNY84z+A=@vger.kernel.org
X-Gm-Message-State: AFuF++nHc96tNj+qffGoKuvib9XdQuvYBEsUt3BVEHTyh5NVsoTitO3U
	bt7dfXyZQz6ftjlmR/JM6TzvS5veXmCa3LpJ/76hpX20Cgad6VCqipBKhTP5/hIxpl/cOzqgf1i
	Dfddn92lzeTwDR9wV+TopN0ek+Rc7hrg=
X-Gm-Gg: AYBFou0kaa857pRSlotrqEmiY1bveKieEW3VM5u6mQfVsA1YVeJmFAQ4OxRx6j9XMT7
	2JDFzaVfDkYxShF6/smOzHVdAGhaefUorgSyO0hYtvTn3ezDyVRCzikoXwsHQJM1ARWklmVedN5
	VVnJY1W+cgQeOAFrmRqWdG5UVl3rXqiRRXAbCbpBy7+bPalY4LD6XwBZQ6L12GleXK8qJtgv99o
	9uRIh9PijGLZdqNepsZYwGlQvHF7DslXhJjfZoKQ6dfYiQ/WV8gSZpw/HoKBs2i8dXZaZC4Q4le
	a4WvqAbFspkV/AphuXslpWC87zActtjgoWJO6gXg+i0LAbu0fncI
X-Received: by 2002:a05:690e:43d0:b0:66d:151a:8390 with SMTP id
 956f58d0204a3-6712455db3fmr16262d50.3.1789057800113; Thu, 10 Sep 2026
 09:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178905331374.213925.295025394754459843.stgit@devnote2> <178905333479.213925.1358412668943562406.stgit@devnote2>
In-Reply-To: <178905333479.213925.1358412668943562406.stgit@devnote2>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 11 Sep 2026 01:29:48 +0900
X-Gm-Features: AcwNN1VREyB4q5zwLtIZujnDUISlLPvEW2AcNPTgjqcyHIPMzOih7zYo-54zTTM
Message-ID: <CABFDxMHKQpa_WGk-RhEqQtzZoNfvZMj3J8JSYQn4-=RG+R1q6A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] bootconfig: Fix integer overflow in initrd size check
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Douglas Anderson <dianders@chromium.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:15=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
> with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
> arithmetic:
>
>     data =3D ((void *)hdr) - size;
>
> to wrap around on 32-bit systems (or when pointer subtraction overflows).
> Because data wraps around, the subsequent bounds check:
>
>     if ((unsigned long)data < initrd_start)
>
> evaluates to false, bypassing the check. The kernel then calls
> xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
> hitting unmapped pages and triggering a fatal kernel page fault during
> early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
> unbounded 32-bit size can similarly bypass the initrd_start check.
>
> Fix this by:
> 1. Ensuring the initrd is at least large enough to contain the bootconfig
>    footer and verifying hdr is within the initrd bounds.
> 2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
>    the available space between initrd_start and hdr before performing
>    pointer subtraction.
>
> Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from init=
rd while boot")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kern=
el.org/
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>   - Accurate the error message for size > XBC_DATA_MAX in
>     get_boot_config_from_initrd().
>   - Remove redundant (and wrong) size >=3D XBC_DATA_MAX check from
>     setup_boot_config().
> ---
>  init/main.c |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index 2613d3f9b3ce..16749bb7a219 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -277,7 +277,8 @@ static void * __init get_boot_config_from_initrd(size=
_t *_size)
>         u8 *hdr;
>         int i;
>
> -       if (!initrd_end)
> +       if (!initrd_end || initrd_end < initrd_start ||
> +           initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
>                 return NULL;

(nit) how about moving BOOTCONFIG_FOOTER_SIZE from tools and using it inste=
ad?

>         data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> @@ -294,16 +295,26 @@ static void * __init get_boot_config_from_initrd(si=
ze_t *_size)
>
>  found:
>         hdr =3D (u8 *)(data - 8);
> +       if ((unsigned long)hdr < initrd_start)
> +               return NULL;
> +
>         size =3D get_unaligned_le32(hdr);
>         csum =3D get_unaligned_le32(hdr + 4);
>
> -       data =3D ((void *)hdr) - size;
> -       if ((unsigned long)data < initrd_start) {
> -               pr_err("bootconfig size %d is greater than initrd size %l=
d\n",
> +       if (size > XBC_DATA_MAX) {
> +               pr_err("bootconfig size %u is greater than max size %d\n"=
,
> +                       size, XBC_DATA_MAX);
> +               return NULL;
> +       }
> +
> +       if (size > ((unsigned long)hdr - initrd_start)) {
> +               pr_err("bootconfig size %u is greater than initrd size %l=
u\n",
>                         size, initrd_end - initrd_start);
>                 return NULL;
>         }
>
> +       data =3D ((void *)hdr) - size;
> +
>         if (xbc_calc_checksum(data, size) !=3D csum) {
>                 pr_err("bootconfig checksum failed\n");
>                 return NULL;
> @@ -394,12 +405,6 @@ static void __init setup_boot_config(void)
>                 return;
>         }
>
> -       if (size >=3D XBC_DATA_MAX) {
> -               pr_err("bootconfig size %ld greater than max size %d\n",
> -                       (long)size, XBC_DATA_MAX);
> -               return;
> -       }
> -

Nice cleanup!

>         ret =3D xbc_init(data, size, &msg, &pos);
>         if (ret < 0) {
>                 if (pos < 0)
>

Thanks for doing this work!

Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Best regards,
Sang-Heon Jeon
