Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81383612E3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018179; cv=pass; b=N8jVonZSAt/YIyekpnE4+QxyX2/cQ7BxH8fsXgGglMi7BjipYQcn3HNKtl+4HOe5REWBsM45tZhB51yLDdsiDMMwV2V8kGHm34nkJPEQYjWIuZvufBArmh1D4AzavpxyVt6MH7V+dtmewum1JaJ2T1gj1lw2Ouz474ylbzaYM4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018179; c=relaxed/simple;
	bh=0zUNFdROD+s3FbG06ZcIlC9kAGg6qu2e9eBHnz8R8rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3+u8ufWvx2KGU+EBIjD7TBswFDwFckFz6yaQQN6uGvyCL+tpMXTXWFVdJzbn0Se6rZbZ/Tr7Z2feHdNmmbJYqa/l5Tmq/60kcxoWqzMDFz2DKS7FGgALcs4SR0WId6irzReBahX6SH2qik7ZCGN9dnasBPuqlnPHXnlvMyqxeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoOeFmap; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoOeFmap"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ecso1197765d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 22:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789018177; cv=none;
        d=google.com; s=arc-20260327;
        b=R7PsYw+u703l2nj9V01wTYQoc6sKr4f4c8jkBlLb6oxuLYYKhX9V1yP9Cs+edOFKxn
         bwx++/WyP+8PeDrOLymnEVUEu94W2SCvlJX/fBPOg9qGU6578WnuMFUUDCH7Uv47IBbG
         AnzLbdPO+6AZSu4Tw01aFDp5dTkGYClCZr3zD8jJ6wVrJ6el8gfJdG1JatBNBUDNOMjC
         bXL1zJjZrNV3qusJ4RLULOarZjh8ev0YzvH2GtFymOu7QIucK6zIO17vM07I1UMhtu6H
         JF8GtoWjaR1UkdOE3QqjI2rbjbM/182cB3MaJXk4O60LdIX/gdO5rNrDPlHZclX6/uf+
         ZVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sVJ7wwjXP5FP1fIe5LzmMMJV495iJRt8J3I4dXdfrhU=;
        fh=wxofMD5fxA/meE+B2fbESZ4ErZg6L0dch/UOUI+Bb2M=;
        b=C/TIRkYzkVHECBziYVQrnXYuxNMWX6L1mEXXsckGVtD3KGz/18gSe3qLusAEJlY6+E
         p1DzziTK375SK/1Xt59Gi48mZSt0y5HCpUkOBnqkkn/W/Hg5Tr+RFZlRrSSk9FRnj9Dl
         mSdEpYn1JPjypUNiazRZgW3sRNvVHnwQfgQfHklZ6svqy8TeE9EVosuPpjm/SZ4y3tWt
         ikiRxdJ7HGlU+FoEAkG3jQD6CM+tBG22ir75fQ+7ZfKjBUu1oyQBjKa2GuaKbblJ4S7T
         Ozq59EHTN94OaAMKIxVXZOR0OR/R2LB5XXbaewt0I9hoLuoBfZ+2Eyp2WwwEll80hcXE
         gaxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789018177; x=1789622977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sVJ7wwjXP5FP1fIe5LzmMMJV495iJRt8J3I4dXdfrhU=;
        b=HoOeFmapBS8z05Ctmo1zSNcUsUKCq6lSh58dpI/4A3IlyrpjIigS3XfStcd4DJHeJ1
         LLowdSJFrndshMWsDsL7uyLrmL0re0aF7XVHaYELf2PQRLCPoXqzXVBmIGDUl8F+wTnc
         9GA5EYtQkVGThng8j91yfG3+Vey4E7wTnh7kIsRJcVBeiU/Rjxhq6JeMIwbbQA7Gz/Ga
         5VqHvhDOMippO6jxgDmGSvGVYvkVmk/tV3+X+9DsOjZhJ8SoTnUxNXRgKtQheRLL+nUq
         vWKCik37JWv+nGrCLith4zRvPKxdAGPxxDwiI/OzM95ZEIRdQrQ3/MALcJlkpHHRandP
         ecyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789018177; x=1789622977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVJ7wwjXP5FP1fIe5LzmMMJV495iJRt8J3I4dXdfrhU=;
        b=ZvGRpvdDuGgw0xkwz1Raw+2VBWX6hnVGPpNGr23NGx+AX18a/ajtquvZFyk4JYX5kg
         3AlV455XeHNyACEv/S0oga93qvdoSbKSQAHwLjKt0dtzW8FbojPZy5VppIqV7fdZpbsS
         pc6r6UQvIOWVE8+cpnKaY2eoR6wa/ek/ZhGYOZLWLkzRSBmmX0sJ/dHuxvPBvnod19QF
         KNHmMDezKwlbcAscUncCnQ61RsvJmAGMUdp9iJUSuciAkPOM+lNQnSQhrT/YWdnIVQlu
         LDeQa/XpVVB9hdKXboeND46wqleLcLjOTYyQPEcATZ/PJ1PmzKrRuM3llSAKYYzp5K9a
         oayQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZnAS3MZXMFnU5Z1ipK5mW4R25KPScuEBfSGMI5hbKDyQxFL+nAL395LKPe9mPm5dJzUfoJrsI8wgiK1pLI9pIQxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l0OjDvPLeP0ZEv1EvdZcSzhuwOJMIVy/w8rb8XNqeAzwBNd7lq
	zDkCpl7ThApbajZ4H8e29yyVdtvIip0Ljz6Lk192ipfk2Url5wL0cTkxLoAslBzQJE3yRWpLurh
	aS0iupOJteyaKjQu23vU2ktkgtccke3/EeWdS
X-Gm-Gg: AYBFou2MOhgaPS3r3iRYaNx0gqjll3f8Z3PKOvJMMOwiVoPvsPfvM3XeXxnPI5c/ePU
	F8WZ/+Ezf7JB15Bh4UG/B2hZdkEYaUlr+j4eR+0DNQqlhvw0L7IVIUP+dp2C9RRZbQ2VOdHBDxC
	izhiTGw0xtZ5+YaPxz0EYOXFQbS1mb9V7ax6EtsaBSar8Mt1D1LRu587TbApNJJcJXt6S/hk1NL
	d8YfXaBFksPgpGongN0UtGu1YqAlCY6d6rp3Tn9ut3oDDAeM4EneJRNMT1jtGUX6LQUSRhqUTd8
	yX9vrfz3+y/zcKq0VOZv2O3DN69zw4IgQZKt6Xu+u8aSkYkgNrns
X-Received: by 2002:a05:690e:4083:b0:66f:c1bc:87f2 with SMTP id
 956f58d0204a3-67110052265mr2611416d50.75.1789018176882; Wed, 09 Sep 2026
 22:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178896921555.177508.434402948295885560.stgit@devnote2> <178896922501.177508.6894964926791268965.stgit@devnote2>
In-Reply-To: <178896922501.177508.6894964926791268965.stgit@devnote2>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 10 Sep 2026 14:29:25 +0900
X-Gm-Features: AcwNN1WfqoCBjOCD1GDG9fJFcRPteqqjXxaNmf3GsdVy7IL_frWFMz9q1scHfmQ
Message-ID: <CABFDxMG-T6t47JehL1AtwqGOV1L1iUj_LUW73=UYQ_V2_dBbrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootconfig: Reject unexpected data after null character
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:53=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> If a bootconfig buffer contains an intermediate null character in the
> middle of the configuration, xbc_parse_tree() stops at the null character
> because string delimiter searches (e.g. strpbrk()) stop at '\0', and
> cleanly breaks out of the loop without error. As a result, any
> configuration data following the intermediate null character is silently
> ignored, allowing unparsed or potentially malicious data to be hidden
> after an early termination.
>
> Fix this in xbc_parse_tree() by checking that no non-null data remains
> between the parser termination point and the end of the input buffer.
> Trailing null characters (such as alignment padding in initrd) continue
> to be accepted as valid.
>
> Also update apply_xbc() in tools/bootconfig/main.c to calculate the
> buffer size based on the loaded file size rather than strlen(), so that
> files with intermediate null characters are not truncated before
> validation.
>
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  lib/bootconfig.c                    |    7 +++++++
>  tools/bootconfig/main.c             |    4 +++-
>  tools/bootconfig/test-bootconfig.sh |   12 ++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index aba11caf6903..0ec2874db9c7 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -1116,6 +1116,13 @@ static int __init xbc_parse_tree(void)
>                 }
>         } while (!ret);
>
> +       if (!ret) {
> +               while (p < xbc_data + xbc_data_size - 1 && *p =3D=3D '\0'=
)
> +                       p++;
> +               if (p < xbc_data + xbc_data_size - 1)
> +                       ret =3D xbc_parse_error("Unexpected data after nu=
ll character", p);
> +       }
> +
>         return ret;
>  }
>
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7dc9fff9b637..6035404733c3 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -422,7 +422,9 @@ static int apply_xbc(const char *path, const char *xb=
c_path)
>                 pr_err("Failed to load %s : %d\n", xbc_path, ret);
>                 return ret;
>         }
> -       size =3D strlen(buf) + 1;
> +       size =3D ret;
> +       if (size =3D=3D 0 || buf[size - 1] !=3D '\0')
> +               size++;
>         csum =3D xbc_calc_checksum(buf, size);
>
>         /* Backup the bootconfig data */
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-=
bootconfig.sh
> index fc69f815ce4a..530ce7e28d63 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -180,6 +180,18 @@ EOF
>  $BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
>  xpass grep -q "1:1" $OUTFILE
>
> +echo "Intermediate null character test"
> +printf "key =3D value\n\0extra =3D data\n" > $TEMPCONF
> +xfail $BOOTCONF -a $TEMPCONF $INITRD
> +$BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
> +xpass grep -q "Unexpected" $OUTFILE
> +
> +echo "Trailing null character test"
> +printf "key =3D value\n\0" > $TEMPCONF
> +xpass $BOOTCONF -a $TEMPCONF $INITRD
> +$BOOTCONF $INITRD > $OUTFILE
> +xpass grep -q "value" $OUTFILE
> +
>  echo "=3D=3D=3D expected failure cases =3D=3D=3D"
>  for i in samples/bad-* ; do
>    xfail $BOOTCONF -a $i $INITRD
>

Thanks for doing this.

Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
