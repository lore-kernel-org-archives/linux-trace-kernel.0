Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB373FB05E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451476; cv=pass; b=mSffdZzosvoL4+NFJn+5RFEQUeVc6ngINR5iksAxeIz37HhNLcKse7gYL2ICEbFJWRHRyhlip9dOA6P2gSwetpGO8ZjKl789XGb8Q2LIDluIT7A0zhdyXdjAxwdXDoQgrHza0iP5bFhV4YzjKm/1diIfVEr4xh6yITwrXTxXshc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451476; c=relaxed/simple;
	bh=tEmJpwuP8Bx2EyfWOZFEr5jKjcfFXY3n8OTV2ATLxuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naF82dP2F2EdTTEc5fPDr6lh5Z7y/pPvipzJKEsesyAOOVaem/QmwAWzphGBsZBhGWWeJcqWAMULoE1QGCIfAzTPfeCPzWTSZJPqlRemG/9s3RpygPT/5rP8zSEmGJVylx9jo+LSfmkfyEgAMf4c+8wxpGl8UqbZlVaDANybBfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPxdLatd; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPxdLatd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439fe4985efso4513889f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 08:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451473; cv=none;
        d=google.com; s=arc-20240605;
        b=ddlRUN/J83IIW9u0qdCYKqR6J7EL1WR2+3Ibvp3ZVEeIM+O4ut3rdf3vsrdgHhSlo2
         pWFTOn0Asvr0o6mOxWo4I9N5gcrRD83sjdEN5VzYg/32GVqgh498A02k3LM85UIvSU7W
         +RkQam5QXckXY047IfJtcZiSxuo9OWZ61YDZxLh5Sd9+bAN4+NLrmwOW2vkPjfxFC1ja
         TBN/lGhx6mRH03vKmjqWxhN31l/udLiw4De5ky0yg8dr7Z8pnGffNUEXLJ6fsKDjXHJx
         yPEM5PSz7qylhEkVbyF8PEHFoZ6b5oGdcbB7mUfe+egWtv0wmw22Wftv+UkD0CQHabbT
         0xOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        fh=HibW2W8uVeeGwps5OWY/v8t+aaqVgqreXKcfQ9PO+lM=;
        b=AF7LsdPKaXAxRnlFTkiWt9sz7zO5hgxzNK0XLQmqViVqNu9JNa8TGLNyHBDRM791bI
         mb2t5lbhFlOPYhTDRVx1MCUVk3db/KoQNdXBOcwYFl1Rj14x1pSpsob50RJex9tSDaF2
         ndgu7lGahEDlfDdWuKw+NuH5U8XJvtDUxSzBmEx3pq8vmQ8D02pjVV8UEZ9kAu9Qv+Du
         4kQ5KU9PlH6dFuQTjpIK3f/lnUzBjLneQhVjalgDiug5JADB8ogvTItcc+QskEEHv0X6
         aTO2SBT/J0/1RR5PzN3Y+YWz3V6QwBQzAtitIqAOzl/JvNeVT0SFLYArKaG0iOGnbZo4
         kK+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774451473; x=1775056273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        b=JPxdLatdT8i9BQaos2+4O9ahU7LAvsvFHGJ3Clopjk8ZEPDc6ONak1UyshIMaCXzmn
         p9YPZ85VmzY+bTczA9BPjk7VLzX/lRxv/RQ5MrzauHCU1+YX9a490/7z+4hVhWDXsLT6
         A3wbNC+7sjurwikAcGnsYPpTot0LGdqpEZz1gIudC/S/bqCm8TzY9Wx2E6KVW0pjmuLG
         E70Vy2HowEK9CHqN49x/OpC3zUdcByd9hSFe4z+YND9RY0CxUiCAE2UETN0zCqPkFLC8
         ZBINszU98/CTFQ5K6KeqFK6EQfPtL6RbAk1oeXRKmICck2p+B/JhBMkm8mVhicDCme6F
         ei9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451473; x=1775056273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        b=klBnBKip4QlG2rkIkKbId1Unr8dFhFTRwcbVbQ+jHH73uBBwbTyiQyh9vS0sUhvyLK
         CQycyOgalE7YL6Ubo8+D8AP3FMhLA81DmiGcc5QPSm+Yww9hFKqPP5WaBP8exIQAEOBj
         XGniW9P5LMWVg093NRQNSwe8iKJVS7eVL6G6youMHHVd+sSuvmSOP0BeJbmYld9eOX2n
         M0X76ssG6WcFH4uD1eMEDAnhG6vmA8mf950bvPI4R6OovMh9l9q30OPV5UK04WpJdM3K
         Ypkt2HjUHoUfthjbjaMuvYsJ7bsea9JK2gc50AnqX64BQX9O7i7fmLgCGcl7120m65DN
         gXQg==
X-Forwarded-Encrypted: i=1; AJvYcCUppEMth4l/aOj8QPZgdO7jovdO8Ct0OADC55+0azO9w7L2eiL9bAld7RJI66OADmd8PKZ3DbPPmIWpeJOtt+3Gwds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetibR4Iw9EtT/nMHU4OzdAt4UrEhh6njLjx4siLS+M8RB1EG5
	sVZPlIpR2XWANXLRNYfjPTetVcAErtotLf9qEw8WkVoa2IWngDjgrsVigfv8E9QCwoNFCL/6nw9
	ThAcQhXoBu2gRLmuBvxrHc/lnVo/BPaI=
X-Gm-Gg: ATEYQzwW+URAV8vVK4STBR5TaKvccoUZNN5SVVQoA+tdh08opJWirKPRO1anLyYp719
	1k/ZB3syOvMPXAuiq1kP65+Wr/YiN16bcRPjBIg27A/4NEtSM2CY4VTu0K7jmHDDSu8BBS2Jrnh
	IR8zKufDJ82S8PmVqe22PGPnJIQBxZV5iXN2Q4T+sJcJBPab8qf0ifE55nwZgWu0td+iJTxysKn
	UBdlARRXpi1Ozen7+6z6EMeKAzfRAA8SHRzDOviWJBlXWwSYVH+FmEbBEaoEh3DkLBOvddyDrAE
	sArxmcmru43vT3bSmuTIjsJ39ehWrRHf5LzwUiktLeJcQNxLh8Sd6Iv78tZ6HiBqv2jn6DOEyQ6
	JDztrDWm4sA5g0BdklHlnNGmaCg==
X-Received: by 2002:a05:6000:40e0:b0:439:af81:1b23 with SMTP id
 ffacd0b85a97d-43b889aaf9fmr5597133f8f.21.1774451472938; Wed, 25 Mar 2026
 08:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324081846.2334094-1-jolsa@kernel.org> <20260324081846.2334094-25-jolsa@kernel.org>
 <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
In-Reply-To: <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 08:11:00 -0700
X-Gm-Features: AQROBzAUBDSr70gmyhrufj8u8FMSWnPty6h_7SeMpMvBeesJou7M0cJ3OLUDeOE
Message-ID: <CAADnVQL3gO=kuvDHQNa8VfL_NWUMvBv6=vrXkOd=8Fe9-dcU3A@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 24/25] selftests/bpf: Add tracing multi attach
 benchmark test
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:45=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> > +
> > +     btf =3D btf__load_vmlinux_btf();
> > +     if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +             return;> +
> > +     skel =3D tracing_multi_bench__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
> > +             goto cleanup;
> > +
> > +     if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> > +             goto cleanup;
> > +
> > +     /* Get all ftrace 'safe' symbols.. */
> > +     for (i =3D 0; i < ksyms->filtered_cnt; i++) {
> > +             if (is_unsafe_function(ksyms->filtered_syms[i]))
> > +                     continue;
> > +             tsearch(&ksyms->filtered_syms[i], &root, compare);
> > +     }
> > +
> > +     /* ..and filter them through BTF and btf_type_is_traceable_func. =
*/
> > +     nr =3D btf__type_cnt(btf);
> > +     for (type_id =3D 1; type_id < nr; type_id++) {
> > +             const struct btf_type *type;
> > +             const char *str;
> > +
> > +             type =3D btf__type_by_id(btf, type_id);
> > +             if (!type)
> > +                     break;
> > +
> > +             if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
> > +                     continue;
> > +
> > +             str =3D btf__name_by_offset(btf, type->name_off);
> > +             if (!str)
> > +                     break;
> > +
> > +             if (!tfind(&str, &root, compare))
> > +                     continue;
> > +
> > +             if (!btf_type_is_traceable_func(btf, type))
> > +                     continue;
> > +
> > +             err =3D libbpf_ensure_mem((void **) &ids, &cap, sizeof(*i=
ds), cnt + 1);
> > +             if (err)
> > +                     goto cleanup;
> > +
> > +             ids[cnt++] =3D type_id;
> > +     }
> > +
> > +     opts.ids =3D ids;
> > +     opts.cnt =3D cnt;
> > +
> > +     attach_start_ns =3D get_time_ns();
> > +     link =3D bpf_program__attach_tracing_multi(skel->progs.bench, NUL=
L, &opts);
> > +     attach_end_ns =3D get_time_ns();
> > +
> > +     if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
> > +             goto cleanup;
> > +
> > +     detach_start_ns =3D get_time_ns();
> > +     bpf_link__destroy(link);
> > +     detach_end_ns =3D get_time_ns();
> > +
> > +     attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> > +     detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> > +
> > +     printf("%s: found %lu functions\n", __func__, cnt);
> > +     printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +     printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > +
> > +cleanup:
> > +     tracing_multi_bench__destroy(skel);
> > +     tdestroy(root, tdestroy_free_nop);
> > +     free_kallsyms_local(ksyms);
> > +     free(ids);
>
> Is btf__free(btf) missing here? Since 'btf' was calloc inner
> btf__load_vmlinux_btf().

Good point.
Leon, please trim your replies. No need to quote the whole patch.

btw sashiko caught it too:
https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
and many other bugs beyond what bpf CI could find.

Jiri, please address them all.
