Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3022367B5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231862; cv=pass; b=JvkmqFJBT8hoH1bMoV+MGHssJTCB4o57fH7ro9jHideFB17iu0JHJ2Y9I/G6cAw+yz72jksN1110ndC4wcSIwpqkKWxYVWr0hXJwEGlf+65P2WKEj5azdvmkabb68Vhhq7/+SJpVCFGLxunvjo3UcT3wd78w32q3+sex4PiZzCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231862; c=relaxed/simple;
	bh=Dc0nYxw/rN5N5J7dVW80Z++yUTLJFp4B0UMOXuMTVHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsZPNziFDdqxbLsnjHT8nqHDsesm/CJEwPL+qojHZNBFPplJszjpo7o6QFMjCEwSw6M2X3QwT8FjCWwpIsQkPjOcCxbm+rWg1xnPWkgJJjyXhKbQzgFjA0cm/X82FuIVgvMftvQTUnSASGafiboBW6o2lVmtyvIztd+sChVctgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqF8g+8T; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqF8g+8T"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so17070a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 11:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231862; cv=none;
        d=google.com; s=arc-20240605;
        b=CsSY4FNrBtsJwthQImkM09aWL8gwt0FYgb87SV72y9oO7jfoJ7b7M1r4mRvR0QQSdg
         I1VVHB3ljdnQ5ZWB3QseDHuMqO4+PCvrI2oE9Pz1cg2XJfPfP7mIPuFRaHFvZB7YpAyW
         xh2PXn9w1J5nLo9El2ySK1m39RK8xQslA87hl+2dDOtrRWuqOp4e9mvu08xLJO/ITW9C
         p/E2bFSitwaPrDfLLl1Qx2sdHb+NmVFPEnakAoZQ/bC+JDHSkd4wu5R9VAOKh0IjAk++
         v0VSGo8Dw41r+m6IxB3YQEaf347SypPv6Gr5T/nSuiscYSnErSjzy6T2zK8uzl9rGEtR
         OiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        fh=cPAkIcgmi9ZARsKNFxfR+aDSOWb0paa+rPGvyvDU5aE=;
        b=JbWUTpGYK9Q3vjIINPl7tOBTd/XOS0xlUeEjVHK3p7VDK5X+z0p8nJNJHjtr60qX79
         h/FITWVt4Uctxr/nvej99ntEh3ahY7qE7lmO5kfzGyOgUH3BtRCDQlbP7ffqDGw20g0Q
         Of54rOTJQg3y1LFsk9UKftIn0ojltrVi1Qbu7UyDJLZJAI1EN0A3QF2B/eoy5b/MnrVf
         NFkTJzZL6mprNhx6rDyMP1brVrVB4aaBBsq5G01i4hVJJtq2aLi/FRnw2OfPQQ+oVk7q
         f02sCZrtq9o6A6xSvy3RyrgUeEt/la2R3Z6nzmqdaY4dUwXN89jrq87cvMxxL6gx5GZy
         ETnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231862; x=1770836662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        b=ZqF8g+8T/zUsvF7DFuqBB8YrzWweYrP+KtBhv3adMvxWxJM2tlBMrBtv9FMY4pjIlR
         3KpfoX0WWKyEN2eD8bidQ+jAxPcb8cYsc9n8r2m/Q8S19TDmv9PYCCPi1cvamCO8RzKv
         7UfkTrK+YpEZ1qTjcT4gTVbDQdVaO5m/d78aUm+N6d/EiRzWXBMqnlxAmf88SMcLBa6j
         aFIrcub9f3kXXY0YpWraJyFVce/vyeavOUOP2cvysap6lUYjHoquUAlHR6VBjqo7hZSp
         7CQJw8YEby4k6WwdFrMsalHiZTw0M46pHxU3Qpn3pOY9U94BKC7ZJ9VvTouP5irIBnJK
         21lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231862; x=1770836662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        b=PlBPa+lFKshQBMtblDUpOOlnZJQ0/Tsexj7ANjGBk5z3TXTzQmxsQ8OrblY7C2k0br
         hHB9G7vXjKlCfeoQbiaizHUoaDX9S2WABJQEL0rKNw4qQJjyXc+vxdtdnX/EPHg0h7aS
         GsyFCHZ0Um1kzKJDWe3Xuh4SwfkKUIGPVl96mCZajc012A1s0OFTTB5isSvj4Y6FbFO0
         cSp5m7ttKhgYuOH7twTxzcxtq+pyOPpKQp6ra1SxcUs0mr2GgSRzJFNGvBep6oyfAhJ5
         3FhVWhHlhThc5PcQFq3+nRHqpkCY3F1Az2UDsv5GCRIaDGeOR7jdH6o5I4/swhaWNHh5
         eWIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKNlbJncEtgvz+JCXmiCFYG5NxA0sQcmlkxO5P7b//OH9IoZMvgG5BNDMa54FcCwJLbFn7/O74p0IzX7rE2g0LyHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Te3E7vvadzLf4jfTocaTcGOFJHZPy6D+k+l6SohZDYYSgm4n
	aUhWt55ZNnIQlxq3abN4X4O1W32MqAZl3nzb83l6Z0zALWraL/HLxLNnvkYLjk8PjlGDfmzYRrz
	s8aH0/Qgf759HYDPeABIMOltKbAjR9MU=
X-Gm-Gg: AZuq6aLHFS0RsK8lxQ7WJny8elg3xpNJxkU66a/c8PZAJV/KZqmHn9MlJbBrNVqBS4I
	beN05vWtG0h68YbuXgbajWkfkd3S1vXMqLXzOdHaNPcQ3ll8fYAV+5TE1BlxmKOauEUJfw2m273
	c4Lkn92ZYSc7d5FZsAtLUseD66EU8YLvTvGEKtwOAEQ/GUCRvCpFFPk1zDJ5NtnZgdrTJGcHZTO
	lJUgGDibqodywYBgpCPIXNT7zzfHxGiR7/AcawYrVAGMBQKMNucL4mcJSq0oohQG/BuPPMNtmah
	purZNKj82XY=
X-Received: by 2002:a17:90b:1a89:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-354871951d6mr3910487a91.18.1770231861526; Wed, 04 Feb 2026
 11:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-9-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:04:09 -0800
X-Gm-Features: AZwV_QjTmRdFGEvb_WAqWPfjTYqkItrykLxxHEkIbtsV4rnebavgSBjlfpmxBwY
Message-ID: <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding btf__find_by_glob_kind function that returns array of
> BTF ids that match given kind and allow/deny patterns.
>
> int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
>                            const char *allow_pattern,
>                            const char *deny_pattern,
>                            __u32 **__ids);
>
> The __ids array is allocated and needs to be manually freed.
>
> The pattern check is done by glob_match function.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h |  3 +++
>  2 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..64502b3ef38a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf=
, const char *type_name,
>         return btf_find_by_name_kind(btf, 1, type_name, kind);
>  }
>
> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +                          const char *allow_pattern, const char *deny_pa=
ttern,
> +                          __u32 **__ids)
> +{
> +       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       int cnt =3D 0, alloc =3D 0;
> +       __u32 *ids =3D NULL;
> +
> +       for (i =3D 1; i < nr_types; i++) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               const char *name;
> +               __u32 *p;
> +
> +               if (btf_kind(t) !=3D kind)
> +                       continue;
> +               name =3D btf__name_by_offset(btf, t->name_off);
> +               if (!name)
> +                       continue;
> +
> +               if (deny_pattern && glob_match(name, deny_pattern))
> +                       continue;
> +               if (allow_pattern && !glob_match(name, allow_pattern))
> +                       continue;
> +
> +               if (cnt =3D=3D alloc) {
> +                       alloc =3D max(16, alloc * 3 / 2);
> +                       p =3D libbpf_reallocarray(ids, alloc, sizeof(__u3=
2));
> +                       if (!p) {
> +                               free(ids);
> +                               return -ENOMEM;
> +                       }
> +                       ids =3D p;
> +               }
> +               ids[cnt] =3D i;
> +               cnt++;
> +       }
> +
> +       *__ids =3D ids;
> +       return cnt;
> +}
> +
>  static bool btf_is_modifiable(const struct btf *btf)
>  {
>         return (void *)btf->hdr !=3D btf->raw_data;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b30008c267c0..d7b47bb0ba99 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const=
 struct btf_type *t)
>         return (struct btf_decl_tag *)(t + 1);
>  }
>
> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +                          const char *allow_pattern, const char *deny_pa=
ttern,
> +                          __u32 **__ids);


as AI pointed out, this should be an internal helper, no? Let's also
not use double underscore pattern here,
"collect_btf_ids_by_glob_kind()" perhaps?

Also, you don't seem to be using deny_pattern, where you planning to?

Also, are there functions that we'll have BTF for, but they won't be
attachable? What if I do SEC("fentry.multi/*")? Will it attach or fail
to attach some functions (and thus fail the overall attachment)?

>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> --
> 2.52.0
>
