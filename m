Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F72343B6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410119; cv=none; b=unNpbuUJzIx6EsEerwO4A2L4sZN79jHz0Mx6ZFy7z0/NIJukQsViFTKfjK2bqWcs3CTzK0r1+SRZ/BQtraWFPnviQFDwmum8LSwfs5e+VLh4CDxrgJocZx2kp6cRmiy3V/c6R19RAkTTyg7xCKbNVfjksjMbyR4iRNDRroqs93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410119; c=relaxed/simple;
	bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3chX3XwtdltE4YNpvculpbCqTDqQESZJeSvRJFnAigmA6Dyd0BpURukEeewxcAm8eBvCcCpUvWaEZBfxgdZSEjb69yuWt+yjSSK6bnMa9vnh0xggQG5Xdg2tKveyD20ytzhCoM86B7dj7oxNT5B7ydJUyS5Tx1t0W94zKnPkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpuayaEr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpuayaEr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so44166155e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760410116; x=1761014916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=fpuayaErAZ5ooC2s/IQzA0WYiTjjxFHI6F0Of++54xAdODFhT2PqP4t6CcMIONOIdB
         hlZKD+n8m+i8hvONsQr8epghJtzwCxgrc51rSm6DrtN4zQ60ofhEc0RAiZrUXf/UJHQ7
         R0iNgiM4ApL3WVKmUqth+Mx6ZbLsVkUO9ymHTC/FVt/7OYmjt9n5g/LAi+iqVmMoC1VX
         rJgvNUkjCKrNvT3ch6xVfswqsBL4dLKIRsfuW9rCg0104y6lqdIajckBNy4pWw63jy5y
         DAJgoXbYNPJHvRls1CN42TFnPltBzXwonLP6FP78nINbcHzNnijgH/SunX6O9cGUE+Md
         4WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410116; x=1761014916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=kZIz97esDhvUaS4PPwCz61s22h5cT/Ai61T7WaI9acMCwnTmtje8rWTKI3/VjjsTDD
         NHJt9HXBgfCH3YVBpd29/8By71heMhZlWhxBg+HmowwzuDiKzdXyh2WjatvwJR9XAzzJ
         T534F1RjTAwI1Ws/3mXKOjzruPTnzcF94JAjrQLd3Hh8pcBzmtyXKkCccE86XvFspwMj
         pkyfOKBZJT3mrZQ7Lz2SY7y/FJNdQfbRkG4GTwvfxX6I+VKOFT3OAuK95G++KgLl/Jlj
         Gbu2jZneg6XaPQgmc8W+rtJjr0gfS9cMMIL7iterDLoCbnxYnqaGEFXhASylsIBlNQ7I
         50Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqoGClEIMCzzkXcxKNDJQp0iO6X0ACbKRjSO1Y2e0I8VJHDuW+ElstT1vdQSKRFw4yIqL8vSB7QbVnz9vdMMtCpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31uV4VUCc/DrmAyITSa0mmJlW8MCyFDyXhUBKt6kdTpQ/P1CF
	/mwsZiRm137dMPQ8gz1fzvzdh6d0uUhDB7HIMU9Qr+b4oSj7iSB/N5aCWOxWo3N1kYJoUlGvNvw
	6FQjCUkQhj3MnvyG8rj8HOqV4isKuWXg=
X-Gm-Gg: ASbGncsbjcUBbDzAXNxdWOSIqpq8ww4DiZpc9N/I/Cj/lS+4G1CnH67zB367KTR/ma3
	DOgeXTYpZKNjPwt+Hxs34s0QtjkgQEnrXXgsenCJAuJRvnXU5L+pVdkvWN28QU6tfS5Y/LMME00
	RHKboeTJX0iWc9E8sRu8ppfK39l/lyFD55Hru/aoWVtaMSDpC0w0HWYFg6p6jFvo9oqSgc0LMc7
	6AnU3lMmST52tWAgksADtlQ07lVDTOiYTz3bd/EYYmhwbwQhsL8MtWKdzU=
X-Google-Smtp-Source: AGHT+IFotiWPFO2AllCGKA6tO/T+IXcCmNirCX3Lliq0AZ2OfXI3bRZk7OrVIcI9TcUtGhU5hzc2a/WiVxBXjnfZarU=
X-Received: by 2002:a05:600c:699b:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46fa9af35c6mr161148645e9.24.1760410115695; Mon, 13 Oct 2025
 19:48:35 -0700 (PDT)
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
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com> <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
In-Reply-To: <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 19:48:24 -0700
X-Gm-Features: AS18NWBn4zAMAeVMaeMdIBpO0QuBxoqXylpn07vpJYMirTGjgZsbn7Yyj6E3etc
Message-ID: <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Just a few observations (if we decide to do the sorting of BTF by=
 name
> > > > > in the kernel):
> > > >
> > > > iirc we discussed it in the past and decided to do sorting in pahol=
e
> > > > and let the kernel verify whether it's sorted or not.
> > > > Then no extra memory is needed.
> > > > Or was that idea discarded for some reason?
> > >
> > > Don't really remember at this point, tbh. Pre-sorting should work
> > > (though I'd argue that then we should only sort by name to make this
> > > sorting universally useful, doing linear search over kinds is fast,
> > > IMO). Pre-sorting won't work for program BTFs, don't know how
> > > important that is. This indexing on demand approach would be
> > > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> > >
> > > Overall, paying 300KB for sorted index for vmlinux BTF for cases wher=
e
> > > we repeatedly need this seems ok to me, tbh.
> >
> > If pahole sorting works I don't see why consuming even 300k is ok.
> > kallsyms are sorted during the build too.
>
> Thanks. We did discuss pre-sorting in pahole in the threads:
>
> https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy-h=
SuHoaT5A@mail.gmail.com/
> https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=3De=
8avRWpMQ@mail.gmail.com/
>
> However, since that approach depends on newer pahole features and
> btf_find_by_name_kind is already being called quite frequently, I suggest
> we first implement sorting within the kernel, and subsequently add pre-so=
rting
> support in pahole.

and then what? Remove it from the kernel when pahole is newer?
I'd rather not do this churn in the first place.

Since you revived that thread from 2024 and did not
follow up with pahole changes since then, I don't believe that
you will do them if we land kernel changes first.
