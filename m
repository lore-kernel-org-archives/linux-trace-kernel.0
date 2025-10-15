Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D68273804
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499835; cv=none; b=u9162RBoIjUjGTFCvqOGB/fTNQ69Yda7wXQtahf0uUyM6lJnK+fL8KWqFATXL2Cz+jWM6erMzO+Ni1R4mG7uLjPEjXKXXGyeHykhKbobPzT1jtClM8bkkdJ6a6XH3og8kflG8RSNSKgu7sFOM6FXQAQnHk/sxFPya8I9SXcOHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499835; c=relaxed/simple;
	bh=bs90N2O+OfC6gLko2I5pK5Mj0nzh9Cy2JeQklp9uugI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGFpswmMsfuTgdbNS6nbKhSUTuIOChQEVQGx+uMWXzrxdvqDVTkOtmnSEbFUA6PfcsoKckFAr1qowL/cOfUZpiAiY4hGDuaCFzEnqyaBeLyyUm1ESgmOmnFp1E/NKwfBIBThVDFpnuJgkudbznObuGmHVu2eh46QskmUHzV13EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkl2QKBo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkl2QKBo"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so692959a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760499831; x=1761104631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfc4SAo3RtJQzNNs5jnSQ+Q9K+JBZBw8RgeC7sKo9ZU=;
        b=Rkl2QKBo5LalZE7Imy1VpelU9WuhNB0jHrtxDItWoEcR1d+Odt0b6PHzyPw9Ye5zHS
         nfFBcsySIgcIhYWlB6cwVxjMfVWBf8/fDVV4/5LyiGH/5VHVCWwfwYwDq+OT0I4MY+v5
         4YdEOk9b/U7SsTBssOSTlJCGT/qmrTweZZZwDQ14W5kngy5lTVs2Erd3PBtfnp12C//u
         /naHa/CUwM1pMXrew188cLbDMkHXtMOIyz3FYiUW9fMB7N7xkRNJ2mrJhrjxq6S9p9D/
         En5sLnZK/qFB1ewBWYgn3g3n51loZyXuRjEjcIOI1w4lzpu0x4HNWk9uv4a37SvhnWLo
         avHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499831; x=1761104631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfc4SAo3RtJQzNNs5jnSQ+Q9K+JBZBw8RgeC7sKo9ZU=;
        b=oSe0Y7hwWo2ShFSfKenDprhB2tL7j968aIZTkfrRqWQjsPTiyhgdC0v3hU9zRdfPfX
         EBEsiucx/LJQguVMN6oqA/DSauMkazRwfvMo9JKRG+qedEwSn4Z7naU0LptuSlCjeYIL
         oFR8aMOzk3y5H8dc5+wGRl+QSxXIvekcsY8HIBrosECFyqZOB6BMEBSfmLYi2FoFL9lO
         CIHT6Gwrl4Mkce3MtVCIlzgTm/fGEml/Uw+fV0kyCIJWMSowuui6CZ/4rtBZ4mdfqE+U
         P/I4zYXHPeNhCtnpxWfmonqT6frTbW22beYCMSRwx9wvFl+CYQQNzl2r4Vbe/z4I2FMM
         jSXA==
X-Forwarded-Encrypted: i=1; AJvYcCXWLV0LpamWhZhVQ4dV5i0GQbRgqzT94+5MwTsDFr0ZIM7JMfMIC3n2b63vJTHvNWcjc773OJcoclxiFizIhLYCpA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXl9v8OlXR/MZgGofF1VkdpT/BzrRUVf+r/U+tL19TFbYKdvn
	2OPvM8xXlhaIuiB8NS9YXHBD4/c0NPM2TkMDMKHU+LXGYqeqRy+JWc+QXiu33b5FV7+8evlcjup
	1OqcGjcfneddHUgrKknL9I9d8gO3cB3I=
X-Gm-Gg: ASbGnctl5doRBqBnJ8l+r85Yfkgh2Te418EOP+kWw9q+BeuSZZsqDq7i8UDdGcbfLjK
	5gk/geP4CsptSf88Yz1+O8XqhxXjsY599N3roQnPu1+rNq4RFEiix/D5GwZ+G4dzqk8E57qMqD3
	madZS8ymHmIKwSBSEGZEcmcMuAdOtsYht8rppfwtf3pd83R/3n1VxqSceUK6oKROLAtTL5EqiZk
	AjA428mOGeowLPqpSclhlPCvFE=
X-Google-Smtp-Source: AGHT+IE6TnwD6hq0Re2T7im/kHETcd6MPtGzgcgnLxoxTNSpQ/ViTKt6MEV9EaAHO9G2MXSzT574vzKZUEkEeX96PYA=
X-Received: by 2002:a05:6402:51d0:b0:62f:be4f:23f9 with SMTP id
 4fb4d7f45d1cf-639d5c371abmr25287716a12.20.1760499831009; Tue, 14 Oct 2025
 20:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
 <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com> <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
In-Reply-To: <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 15 Oct 2025 11:43:39 +0800
X-Gm-Features: AS18NWANkwOTjhB-W70pOiuQNrvHLxvDN7jDGm-MLw9rdBqq6PCmK5-U3JHN08w
Message-ID: <CAErzpmvdvDFWyKXiqAxZHQTEArCKCPZ1FFqKx99Nwu6CG1sfqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 9:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > I=E2=80=99d like to suggest a dual-mechanism approach:
> > 1. If BTF is generated by a newer pahole (with pre-sorting support), th=
e
> >     kernel would use the pre-sorted data directly.
> > 2. For BTF from older pahole versions, the kernel would handle sorting
> >     at load time or later.
>
> The problem with 2 is extra memory consumption for narrow
> use case. The "time cat trace" example shows that search
> is in critical path, but I suspect ftrace can do it differently.
> I don't know why it's doing the search so much.

Thanks. The reason is that ftrace supports outputting parameters of traced
functions through funcgraph-args, like this:

 0)                    |  vfs_write(file=3D0xffff888102b17380,
buf=3D0x7ffd1e9faaf7, count=3D0x1, pos=3D0xffffc90006f83ef0) {
 0)                    |    rw_verify_area(read_write=3D1,
file=3D0xffff888102b17380, ppos=3D0xffffc90006f83ef0, count=3D0x1) {
 0)                    |
security_file_permission(file=3D0xffff888102b17380, mask=3D2) {
 0)                    |
selinux_file_permission(file=3D0xffff888102b17380, mask=3D2) {
 0)   0.111 us    |          avc_policy_seqno();
 0)   0.380 us    |        }
 0)   0.585 us    |      }
 0)   0.782 us    |    }

which requires obtaining function parameter names and types from BTF.
However, there is currently no direct mapping from function addresses to
btf_type index information. Therefore, it first obtains the function name f=
rom
the function address, and then searches the BTF file by the function name
to get the corresponding btf_type.

> Everyelse in bpf we don't call it that often.
> So optimizing the search is nice, but not at the expense
> of so much extra memory.
> Hence I don't think 2 is worth doing.

Thanks, I agree.

>
> > Regarding the pahole changes: this is now my highest priority. I=E2=80=
=99ve
> > already incorporated it into my development plan and will begin
> > working on the patches shortly.
>
> let's land pahole changes first.

Understood, thanks
