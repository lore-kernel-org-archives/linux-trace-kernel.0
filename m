Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F98318EC5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231931; cv=pass; b=PJwQe9R8Al18BheuNHZ+sPVLJ73hMPlTwNW8gAOV0cKX+H1wb8w/ngtqsCrVQMj4Ily+imbQHPBjr9Xrvni1ulEkZPMQFG33VSV3WigNHcVlB3/2cZXCEXc4CPlAOQp1HXbVcrJgq8EHkexL+pqxoOSeABJJyAeWLJkBL31kprk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231931; c=relaxed/simple;
	bh=1dbeWO5LFpJKj4kIqqUWAsIYt2PSGy1Uuoa/aP1gUo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEYsDM9PvXxDNzqTFfQIlF4em766tIJruJMAUC8Qmi/dE5hwP5epkS2t60+2giHolU2QNhYoeRpmxxt81A1d65kwXAAwdnE/Dw8pxec+sUBNmhUcF9cMJEO1/yhlGwf999uPLmqo6Svapfo/vTME20MwL4Bb7SgHY/ykP7o32b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqiocb2n; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqiocb2n"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so1674675ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 11:05:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231931; cv=none;
        d=google.com; s=arc-20240605;
        b=OrKzyVeACQJ2z614PMkUeFzFqVHXOA6sVINaHbTw1S1kYnX1foy6ecWFAYry2LfRX4
         ppnlKSBrQhlKIr1LgP9piRxnPOQWA382yuaUo7pn2lLV3XpiFSLTuadQgSBLMYQB6qGT
         HJf7CHKbvnvXg/J5uT8fwx0892sVd2CMKCHP8pQl47qQm2bk3x5Z/27hq3PHSX86t+M8
         EiNvfrnQUhRBq4M4uGHR5kjZj7sTi11hAmVRlMhttnG4qfbTpNqlbRXY3zPLlNKIuZrN
         YJq8omDeFmLkiceDf9giZGnpKR7gwlasXo+c/X2GPRRcqedpIm+M2oua3ASxPuMrs/U9
         jWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnDPeb6tsH3iytcoTISmiYrFT6n+/+39ezoN43xAOVo=;
        fh=Cq9rCREQft/+VlsJZcXKFyAa/g+PpN7xSSSA0UdeuOQ=;
        b=UNm1tazFyhAyH9zYvY0TM3wPCUYqa7sYNqR8Z6Ea/iZkPldD96iuffiNY4tcwkTtFD
         NFAjNTgSqekHqCTeDeds78LgW1PN+ux/91UtkZn4ramLl/gpyitZE+53BRSb6en8kK1V
         vnSZ+oAkBxLtHs3FOR2oJj4iBns19qyyu842zB/AwAAxE9e+DhdjFaRVvrzqZv6tRs4S
         RZAZO2x4ZAP/d2gGK8wm25RKfBtqQP52WR+RoGTrNNAzPDjcWxL8OHFiKh+8xGKLwgyD
         NEHHqVQ7or8wYEuRLD5yYyvUOSz4FXyLW9QWQ96Dr4NLEfR515mujNje9Rf1SZh+5jw1
         8wtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231931; x=1770836731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnDPeb6tsH3iytcoTISmiYrFT6n+/+39ezoN43xAOVo=;
        b=Jqiocb2nn+TLcM/yZpAVN69+2EIjSS3BKGkXdyyMiMlk1y9Gsl3lv2MeDasKYZweZf
         HSLQmX2oXzdj8jaz0ukXshgloYaNYMrDs9LxnMfPUXvjDqJi31FpVvfYBbez5ngd74ly
         KfldW4+yYDUa4Yrq/0FSk4XPNdClLqEak6IU7X/BsQ6iobtv9Pq5erECS2sspN4QJ3iG
         rz9cqAaojNcf377kJ1ja3t3YLR3eEh4mlCpoDgvpTxeasH3SyvEQmQb+5DfzsF6ffSgd
         F1PLcCd6U8coDpSZehRJXZ5NIQmJZuMYs80023LsxgjV2AHWfscGXVMz8xT0i1GXpxve
         ifag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231931; x=1770836731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnDPeb6tsH3iytcoTISmiYrFT6n+/+39ezoN43xAOVo=;
        b=L16vnzkEGHHWkR6BKv8wmfMy0BPRWSCAbojs9QtOxVpt969uXUxuk4uqYSzQTwMD0U
         LMu++FghGNAPOkoTE0KM/TTkgZt6MFXQeDr1QuNpdSmnF7D0KwRDdQIcEy9lCMNdOUQM
         Cty7L5Vkh6OcQ5OG+1uDnE9rGR3FQt9c+PJg1V5q2ZMvuvINafOMKUVA24I8JBUK+CA4
         0e27YZxrgkJtEu8pwMTlJ4dmcn6bcTy5z4M2CJgYAqz/+pWV06n3xP5/COhnjsDzxzpb
         TeEGSUCbQEoa6vdqRpkjYBWWNRFoX8r+6o78IpH7Qb/FYUWWdhjp6qVTEGduy0ni1MUw
         UQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSHgbSHiaKZ5Mm1Xea3a70OQv4mCltoYA4rJfzOmnfErWu80Cxq2xrmlwBfnrzVk84B4o+TKjuc2Jx/P4k+kwubwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQaqGB9R2LFT18Ahq+dJ1HJqiJ3LU8A1Ku9M7KoUccASvOZPL
	UOT2Fhx3YK4Wu7Iz1PZG85NKS9zT/0W55K4oHrdUksmL/o0s15IBaBofRzx088aUUQOzmWKC+Mv
	TxF7YyLWCcWsNdqFW9y+lTPbWTag0Dgg=
X-Gm-Gg: AZuq6aL07gZmxAm6qiVMAeh6hTx3QUYPFOr8oqjQuBPlZpUhIs9UMbIxIZfm4guiKYk
	jmPCvi6Oe45fSjOQ981BpKxs4BG+aSv1GURkYUw20Hk+/TzpXFtxFIpfqnGkBsj3UAsk7uy/ZXX
	KxeM9NOAO1m5i7L4yTc9Vdok8f85t9X8xjcb1L6KxUNcv4/Djxj468fRYo4wZzcPGIooNqBrKkX
	uWcDWVtQOdVfZQNP290lB3N2nQfrYfO+C/VTRQH4ph+qIg0CHElBVxdUMloCReZav6FNm5TkV6r
	NpIww2uR5dAbquERxhNXfQ==
X-Received: by 2002:a17:902:f687:b0:290:c516:8c53 with SMTP id
 d9443c01a7336-2a933fb321fmr42812115ad.40.1770231930994; Wed, 04 Feb 2026
 11:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-10-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:05:16 -0800
X-Gm-Features: AZwV_QhJfv6VjdcJV9wp8iYM2M1Z3o3-7voLrA-H_mf2W1haFnii2IsLekgcejg
Message-ID: <CAEf4BzYhP8CdS_Xpw1iEvGNxYGnf3Zq5zkb-HEZKvx5cxEJBqw@mail.gmail.com>
Subject: Re: [RFC bpf-next 09/12] libbpf: Add support to create tracing multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:40=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new interface function to attach programs with tracing
> multi link:
>
>   bpf_program__attach_tracing_multi(const struct bpf_program *prog,
>                                     const char *pattern,
>                                     const struct bpf_tracing_multi_opts *=
opts);
>
> The program is attach to functions specified by pattern or by
> btf IDs specified in bpf_tracing_multi_opts object.
>
> Adding support for new sections to attach programs with above
> functions:
>
>    fentry.multi/pattern
>    fexit.multi/pattern
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c      |  7 ++++
>  tools/lib/bpf/bpf.h      |  4 ++
>  tools/lib/bpf/libbpf.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 14 +++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 113 insertions(+)

[...]

>  static const char * const map_type_name[] =3D {
> @@ -9814,6 +9817,7 @@ static int attach_kprobe_session(const struct bpf_p=
rogram *prog, long cookie, st
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
> +static int attach_tracing_multi(const struct bpf_program *prog, long coo=
kie, struct bpf_link **link);
>
>  static const struct bpf_sec_def section_defs[] =3D {
>         SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> @@ -9862,6 +9866,8 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATT=
ACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fsession+",            TRACING, BPF_TRACE_FSESSION, SEC_=
ATTACH_BTF, attach_trace),
>         SEC_DEF("fsession.s+",          TRACING, BPF_TRACE_FSESSION, SEC_=
ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MULTI, =
0, attach_tracing_multi),
> +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MULTI, 0=
, attach_tracing_multi),
>         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_tr=
ace),
>         SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF,=
 attach_lsm),
>         SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF =
| SEC_SLEEPABLE, attach_lsm),
> @@ -12237,6 +12243,87 @@ static int attach_uprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return ret;
>  }
>
> +struct bpf_link *
> +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const =
char *pattern,
> +                                 const struct bpf_tracing_multi_opts *op=
ts)
> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +       __u32 *btf_ids, cnt, *free_ids =3D NULL;
> +       int prog_fd, link_fd, err;
> +       struct bpf_link *link;
> +
> +       btf_ids =3D OPTS_GET(opts, btf_ids, false);
> +       cnt =3D OPTS_GET(opts, cnt, false);
> +
> +       if (!pattern && !btf_ids && !cnt)

let's check that either both btf_ids and cnt are specified or none

then we can check that either pattern or btf_ids are specified

still two checks, but will capture all the bad cases

> +               return libbpf_err_ptr(-EINVAL);
> +       if (pattern && (btf_ids || cnt))
> +               return libbpf_err_ptr(-EINVAL);
> +

[...]

>  struct bpf_uprobe_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d18fbcea7578..a3ffb21270e9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -358,6 +358,7 @@ LIBBPF_1.0.0 {
>                 bpf_program__attach_ksyscall;
>                 bpf_program__autoattach;
>                 bpf_program__set_autoattach;
> +               bpf_program__attach_tracing_multi;

stuck in the past? ;) we are in 1.7 cycle


>                 btf__add_enum64;
>                 btf__add_enum64_value;
>                 libbpf_bpf_attach_type_str;
> --
> 2.52.0
>
