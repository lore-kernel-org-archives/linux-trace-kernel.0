Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518489;
	b=vPhZd93GLh4eQeqMUu/szDy7cbPH9IJW3aMyYNIsf0oReYVnWrKrZM1p1KXedaOnpvpE
	 OqnVGZnEsOZta4hccz2v95DSSDqWxNpH2apvKp+Hz1lM1/E2hEDO6p4iGhz9tXwxWyBPc
	 GanjNwFmesC25JXNaUbVwIqur2byvxlm7f/ojwqWCmLUTx1HU0YBaK0JwSYUdqbs94tnp
	 c+juW0P2sVkR+oOXxJLfg9eDu/ivFW3ALHYKj7raCZiI0uarodaLL/rQplgcQlgXBQLrJ
	 zb16nFWytwpDUwOh2S2qSes2I49i+mPvBzhL9ohy3jurdXN79VZqUR9d/Wq8snaK2fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CSG8ulEk4ASRkphCd8GtzCLacYX5T3eijsggHwB+VQw=;
	b=PTFlnpZPhgM4dbA1q/BAA83W4OeX9jzlJl+p3je+UkqlYjiNsGizcTFDnCXGHU49oK+5
	 5vkVfR9Qzmj8YMGxXjaNDO1/lD3l3zg5SsmfMa9k96qOq6NyrvGixE6qapuEKgL1Gwl76
	 qF5ujy4u2qk/iz9hTjUIPnIrhb/wU4D+q2q1R0fXyX7KblGdbOni6XpAoN3gpYpOrFGRe
	 +kDvnCEx0BaOb2ifTXE7R8i8zpRHM1Xi1+rNiSNfwZeRPu14Hss1FGxYE32Jy1dhXHL+K
	 NOsKe+K9R1T854rFgZVStJB0Y1zJd/wDDfQGWoqckq8P3nbQdfFIe8OeVDyc2vw+nJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gh8+vZKK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C40606A321
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 11:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C40606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gh8+vZKK
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so5466041c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 03:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795518488; cv=none;
        d=google.com; s=arc-20260327;
        b=mebxkwpb//nCwsv9xl8EZRAWbQP/ra6OWzxd1GS6vDnx2DTcTSxZY9aZbF1rimYu7f
         b8O3/Civen8XFW3Z+lfub7Npdkl9b5ChwvsFzDoyVZEXbv4rcX0pkmHtf1Ck/BMay27p
         iInzT/JNUmMh3ebi6HdbP2ipSs4AqtoymmgZFCmw4bwDNrpmeN0rxWP0ZdtXfwaOIepO
         iZIJt4LOvIMgfHQGF4IWFGhdt5lY31YTgNki1vxF8okRJWXhULszliOlqmduqkRage/U
         Y+7CB+3KjKj8U/0/Ou7lFDMFw2/WGsZHxWyx2LDA8FmY7zveDk19jWy9mABkppFlH6d8
         qLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CSG8ulEk4ASRkphCd8GtzCLacYX5T3eijsggHwB+VQw=;
        fh=C2dWxT9UrHQnwef95Ew9gCtrPDz+3aJ9ImLx2sMXKSQ=;
        b=FAV0aGMBs1wgE4Z9c5Js3dP2CdWU9LovoXPY6Jqo5zJONc5YX92dLEHzyIeC3fs/N8
         X+qvS3gr4gqmKiCpFs0jP+GZq56g+XnyxDTXoV8UvhmuProf2G2x5kqSZwNvLF/wvHOX
         sVbQmZtI5mjyBltyTjCQ0kDrfIfI7ofK/SQyB0y0FZjujpzdgLEaN5ZUGNyCimvjygLY
         EmaHWsKxK/iOJ8RAohWAdan4t0iPFLJltnyAmBf3Eg0LXW5yLw8zW94KTJdJ1RG/RSrJ
         GCysZtiRRzs79H8zg901KgtinSlN9d+ko0rESf/4jm/pJObtWv1z3V8M/a47x/9vEIfJ
         PdHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795518488; x=1796123288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSG8ulEk4ASRkphCd8GtzCLacYX5T3eijsggHwB+VQw=;
        b=Gh8+vZKK209fK9gkJYckunVrXdTd5nYLvA1Lpo9qvL2NFIfM/JAQyXYQIxxhBEoUfz
         sCXcBNx86VAxPYkC2lgFy5i1+6ol7da0DaW9cIMfQeBILMJWAUOnH4mDdgGGGzUtruB2
         8Z1g7U3SEJC/AAnHfiiR1Z5sOhfp5iUgX4Ij/AEfbsNONHQip2OtdU/VmCfp/9R82bRz
         JQ278CC6aaGVVlPD5csL4ngHb8MUUfXEC3v9jwFxop0QhXyR9V+BRAtjc9l6em1qB4aa
         7jF5ElSyq9fPTx6acputZUbgay/zMuiFaZolWCQpbtIBZfnBvVRhHUPmV29fyGZUIedA
         A3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518488; x=1796123288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSG8ulEk4ASRkphCd8GtzCLacYX5T3eijsggHwB+VQw=;
        b=Y4C06xp5Egch4kCN09fxwCbnzLMBSEMNBFl7eQAG/JunGQGEuwIGxjF2g+do2qOwrf
         HqMNDtKXulAvTdUQpa7qQIM5gVu8+HdEw3yYDsMj0JERNFsF74iG2y3ehvYMlRBAYh88
         nOYCqfEhdHv+F3aK3T7lENrUcvEs3PD6UzyT0/U95H8YyZtYFg4qQMLT/gYuJLdXEqVo
         a7GhHSL9aqfIrmOY1bQxtmBgXRcACuEXAHsw1UGeLiA+IXfvr9AqIehnDiUMgvA6Vp03
         PS9fTqHvEUY8au3h+G0mS+PnksqsKPePg6gLd2qeuw2PmUWsx7BOetIcxTqxWGtGsQzf
         7A9g==
X-Forwarded-Encrypted: i=1; AL+hErE8TZRoCNcGemN6T2bEqbHOjv3ZQGjzl7gANL1yJzEvZquAFFR7ReGaDySq6GZDdfuC73/CApPjgt+/354z1cbnhbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q+Hhzi+gQumHFkHGX90Bl17CP8ZASbgxIt6s2Qd38c70d9xoI
	b2ppXQ1Hh2MFHEYbXt2qaDgbV290M1gTW0l4v3pkxtxgXnX0Z1GFrfu6gnp8WGn68ugeWt0ymp9
	PxN7Z1lPD8sx6mhhIVmuHj7EJQt7oYwiS1lf5IxQ=
X-Gm-Gg: AZFdTZcpWD2jIbh93FQmdLb+RRB8qyQkAj5q0xWmJRNSINf87e2d6TGNquDLixKBWbi
	V4z4cOkZYYL91Q0qprI7kTZY98Kjx6h+0XIEvyxYKmnuKsGoEYRrGx+Cek87UDLTEeqBKDQpkEa
	yVAn1PReMAPKqFkQkS0GgCmpj4uqs+02j5QLCzboG0PLczNQhADdtWJI9ttPLefYzQW5lOlOL/9
	Q5ODGv5VNWQYwwmQKOimpyGOguVjslWWenihKzf4slkZV35rizcz/ikxaPuTak5DaHeG0k5PDTw
	kY9EgWYM4/sb+Oas8ouruL5Jhul5oX0JByVPAAYsyLOYiBkypGcJ0p1LZhBp283sMhYApHxPyoA
	3PEN1qIxJxhcjOg+d4e96kiUTy3GJIY+KgbqHN6s=
X-Received: by 2002:a05:7022:c8d:b0:1b3:b3de:9228 with SMTP id
 a92af1059eb24-1b5568a4f37mr13449809c88.8.1795518487615; Tue, 24 Nov 2026
 03:08:07 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020104710.2366146-1-dolinux.peng@gmail.com>
In-Reply-To: <20261020104710.2366146-1-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 24 Nov 2026 19:07:55 +0800
X-Gm-Features: Aa3M54rJSbFkT150mcAAsBUPDfD2FajCh9qRRPl3qz22VxpNwn4ZoQyq4YKUwi0
Message-ID: <CAErzpmtcDUu6dtQAvV4fJTuDyr6YqtyrLi6XBjWHLjxS55RTYQ@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Format error pointers as signed errno values
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a quick ping on this patch.

Thanks,
Donglin

On Tue, Oct 20, 2026 at 6:47=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> The BTF-aware funcgraph-retval formatter currently treats all pointer
> returns as hexadecimal values. Error pointers returned with ERR_PTR()
> therefore appear as high unsigned addresses in smart mode, obscuring the
> underlying errno.
>
> Recognize error-pointer values for pointer return types in
> btf_trim_retval() and select signed decimal formatting.
>
> Before:
>   trim_retval_ptr_error(); /* ret=3D0xffffffffffffffea */
>
> After:
>   trim_retval_ptr_error(); /* ret=3D-22 */
>
> Users who need to inspect the raw encoded value can enable
> funcgraph-retval-hex, which produces:
>
>   trim_retval_ptr_error(); /* ret=3D0xffffffffffffffea */
>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/trace_btf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index bcf65fec7bb1..1201105aa48b 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/btf.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/kallsyms.h>
> @@ -197,6 +198,12 @@ void btf_trim_retval(unsigned long func, unsigned lo=
ng *retval, bool *print_retv
>                 if (signed_type && !hex)
>                         *retval =3D sign_extend64(*retval, msb);
>                 break;
> +       case BTF_KIND_PTR:
> +               if (!hex && IS_ERR_VALUE(*retval))
> +                       *fmt =3D RETVAL_FMT_DEC;
> +               else
> +                       *fmt =3D RETVAL_FMT_HEX;
> +               break;
>         default:
>                 *fmt =3D RETVAL_FMT_HEX;
>                 break;
> --
> 2.34.1
>
