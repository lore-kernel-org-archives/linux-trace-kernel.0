Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E31885BE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Feb 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781518; cv=none; b=EfHgUfmMAL9BkwC7+V+WQy+4/afXT13die1t3xj/E09H9QD65vx9VbkxbfG2HML86B78g8pVXsQu/fL/wDOva1n4ycgkJ1NVDig5Xj3jRIKjb9GnR6JxjAaOks6/UqyNYjfRYessQ96XLEHHk/ZwA02FPJIY5/m89o/gOKUKLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781518; c=relaxed/simple;
	bh=w/JK2a5CMvt50/ztN3kp5qqW6WjHBNOsrATdA/E09OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEu9OuGyEWMm9D4ACWa0NUDGVOVcBl03tty5eZ2oK+uRvDs6SMb7lym/1oQiCtwDz2mbuUdfmyhYwlZ5eJ2Ag5miUNQUJfwBQQR/Tm5/Qs8H6bGBjEgLJXLEI1I8/bUv+p24ZTSaY6zoWEFskhfNrKfpq3Raac8GrscVpZ3uQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhf3UZ28; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhf3UZ28"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dcd33d9d9dso1044a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Feb 2025 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738781515; x=1739386315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19v3BofUqD63vuDcsPUGDTH8QbxB2ijJg+MULEk8I8c=;
        b=dhf3UZ28Rj0naQEKIjGquOHbF4AZiDir+I6ymXKkq7bbuz7RtXeILYaKRlH8RjYivE
         d446Dmuznc0LR5LGI5b1WSRNxcwbHFqCJ/Al4/1ZDSeX/bLFXuzeBhmfrYiUd8nuyYmE
         wgzmDf9iJSH3MYL4tcdk8+ienPeVl+9umSDFAUO/3nxUPpUm7fiWu6ZZ87XJYxOP/WWT
         eDWDK6Z7cFwXUSzmQKyl8+WW2yne/iHe4HRKvcqgF/OF0PWTPqr07Q524jt4XLwcBHtb
         fI38HlgRzPd97YqMnDgNyKgrESoh7AOkSiq/JVpweBPg8CHv2Zf4KjLsdh+ddJ6UFUPH
         gxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781515; x=1739386315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19v3BofUqD63vuDcsPUGDTH8QbxB2ijJg+MULEk8I8c=;
        b=XYx2OPlx+GR0o6dGCpWrqJ6oOvpPR9pnqNEEY5MQej9LQwG1aOP0YRPVnOaXFqgwYy
         GlsoUBeZHvN5USuijnZuW2cDgC/RZjoWhJoJP/bm3vtVL6BKdQL0lsE4alVyJIQh54bZ
         iJs0UimOCxD0S81jFp3EdmwWaV50NfuJbpJHIXP2nkGM0oh6LODVJiQjxzlgDqqp1S6p
         1LJso+EiT2APi9190t4QgvtA6iAXXeHMFmgrurl3pOxVtifOY0Mz9Be1Ws/lnoKVjJoZ
         co84aQvvoqimtLWLj2Fm3Q0V3JGES10gAVic+EpDFnVk7n7/n6orgGBHzYvegi8q4iBz
         pITw==
X-Forwarded-Encrypted: i=1; AJvYcCU6N7VRJwGSxci6q9vCsYXaPzv3R2C94xQKtjspq1e/z+/BphKWSbN7r1a+hfQzBwRZltUNvUcESVGriujFDFSuVwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHj+7edpJDKG2ChdBUf42CcWK0TFUVLbQCO/xligW2cjlZ0ZB1
	M1IKiiIOBACXylVBQMVs+hwdp/Y/vBGD+g6+I9yuSZr/lmnca8oLgq6sZn90t2AgMyk5GhjcbMX
	Vuts/oVLEhB9Dn9x/F9aWc9XSYhJLZVV+GaZx
X-Gm-Gg: ASbGnct16geFXLK4CPSj0/V7QL5qiogds1o9TlWRMkYed5cEx/fYFeHGi0wb/GSrq5Y
	weSHzsdEOWSU4iTIh9o1A6bVy9rBVLGIMOLLyIO4jiRBMHsdLKNd/h1IfkCqxz/yhPZnR+g==
X-Google-Smtp-Source: AGHT+IGdFRxuVZNHbCQrpEx/USZkGtjvxS42wJTFWBOHQk/LEI3AJWYwhK/6SELhDokMAeQUPabPJFSwFrBrFl28vLU=
X-Received: by 2002:aa7:d38f:0:b0:5dc:d9b1:ebdf with SMTP id
 4fb4d7f45d1cf-5dced6b1033mr7629a12.2.1738781514515; Wed, 05 Feb 2025 10:51:54
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205180116.88644-1-haiyuewa@163.com>
In-Reply-To: <20250205180116.88644-1-haiyuewa@163.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 5 Feb 2025 10:51:17 -0800
X-Gm-Features: AWEUYZk6X2Wgv4lR-1hURALTgbltZRUha-EXRIt0htDWFLYOKzBHkHqWn1Jfbs8
Message-ID: <CABCJKucW0HU_TVwe6sdn8B-Cu7Jn-M61i1VoBjJYqQkoxQtTxg@mail.gmail.com>
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS is enabled
To: Haiyue Wang <haiyuewa@163.com>
Cc: x86@kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 5, 2025 at 10:02=E2=80=AFAM Haiyue Wang <haiyuewa@163.com> wrot=
e:
>
> When switching from CONFIG_GENKSYMS to CONFIG_GENDWARFKSYMS enabled, the
> build is failed:
>
>   AS      arch/x86/entry/entry.o
> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>                  from <stdin>:3:
> ./arch/x86/include/asm/ftrace.h: In function =E2=80=98arch_ftrace_get_sym=
addr=E2=80=99:
> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of fun=
ction =E2=80=98get_kernel_nofault=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
>    46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip -=
 ENDBR_INSN_SIZE)))
>       |                     ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>
> File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
> adding the missed declaration header file can also fix the error:
>
>  getasmexports =3D                                                       =
 \
>     { echo "\#include <linux/kernel.h>" ;                               \
>       echo "\#include <linux/string.h>" ;                               \
> +     echo "\#include <linux/uaccess.h>";                               \
>       echo "\#include <asm/asm-prototypes.h>" ;                         \
>       $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
>
> Fixes: 2bc56fdae1ba ("ftrace: Add ftrace_get_symaddr to convert fentry_ip=
 to symaddr")
>
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>  arch/x86/include/asm/ftrace.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.=
h
> index f9cb4d07df58..063ce70837bb 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -34,6 +34,10 @@ static inline unsigned long ftrace_call_adjust(unsigne=
d long addr)
>         return addr;
>  }
>
> +#ifdef CONFIG_X86_KERNEL_IBT
> +#include <linux/uaccess.h>
> +#endif
> +
>  static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry=
_ip)
>  {
>  #ifdef CONFIG_X86_KERNEL_IBT

Thanks for the patch! This looks correct to me, and I confirmed that
it fixes the build issue. Feel free to add:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
