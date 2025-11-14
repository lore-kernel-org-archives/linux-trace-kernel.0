Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FC33FE28
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144547; cv=none; b=U0ihoe5HBmEQqEcOMGzFjwOu1G1TVkPs3leK9bZwDcpIfYS81ptv3vvhNWggAnleJtUWlykxULTUpqiO5ZT6QyK02+sRk1Is0r/wNJYTPwpicbaWcCNQmKX8rRN/r4bE/Sxme/8ciG6xsufOKWz9YsK9czgxO/EZ8I39QK3GN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144547; c=relaxed/simple;
	bh=imYTRsAu32nO2XrcQhwaL6kVBM++D7Oc6Tv7+2nAnvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0ZUUGazGdGyonJFhOJJo2p+BI4aIRieYEbrghsrS33m3IMMuPjyiDGd+/qhrm/SyFhMH3GFC3XbkNzgD8PxQH4kRcdVczyJO6GG1554OjxL7Ps0aVtEMo7S4m8fMpc49Ls1miJiVTUg1OprQ6EdEHuSob1DSdBhLwRiVLbGhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNwVH3tU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNwVH3tU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1774824f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144544; x=1763749344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7zaNp4QyAISIfq+OL9vs0K83HTQEuuem1wMgjVe+n0=;
        b=FNwVH3tUyQZuBJa3KYAl6ke2veAHPF0jdbbHdP7Ov+IcogDA4uUVMnLqN33prXBKZ1
         0olT3Ywwmkqct94T527k87DWo/mXXo6GJxC3d70+5QsOkWzxSucTmcVQ0pFCd0r8okyI
         AUz9jynTZFkFFcjavxtkjlifAKVwO3C3knr626ltNhJ6A/GK48fkFpdn4d2oKJ3sSzVP
         iixWwCJ9lkaTy1K+duUjznLWhfsQc+lEU+//nGS6sWvq8HIll/ZVvHJUR+vza7lnhiVQ
         64xGFpWPOEYV3ikYqwZmL4Yv7+I1P9T72/ChdCtAIrzLfIDBEw0+t8LUaEhqGIb06SDT
         2NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144544; x=1763749344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7zaNp4QyAISIfq+OL9vs0K83HTQEuuem1wMgjVe+n0=;
        b=Qobp+6bMo+VYMfLeiW/du+RnKpozP731kHYigcyag/VUpFgB8aeFg25fT5J/hTOGt4
         SPEcAkLEMhagz4k3AGbvtjslWvEK2pZYV2+nMTkBF95RaaO3a4i7jG80WpjZuWdjF8rN
         dlVQZzTRn4PHGKpo3hSXtu3LhqWOKSLKWnxwbhT6UeIgUW6Yj6w7x5oLFN4ztvDadsGX
         QnNtzTK530pasEXdBePxaXgBrjS6ZqVxU4dd8VrqR/9/Jz30edwC2aY7LQYR0XiNmffw
         2LmLjnhZSU1mLsZ6JVAYRVFbh2Lsyfjbc/iM0uBDxPY9mw8Cvia876t2MQED9AsYMRGk
         /caQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzbqx1ziQVSeL6F6nF0JAn9EXpHpFvOP6ZEel8gX7R9zJP9ZOS0zRQBRfDVKdyc/A1G1PvOV+YVWa/DZPOs+nakiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTI7qOqqD+xS++yjLzlCuxsYsIar6qgJFbbInuvIKlRT80iR71
	wSoH99fxkLrRbLh4xTNc8uz4MM/zqrBmKe41OipcJZd2mSgqBhJXPkWsOOUk01VZezq0/u91sYz
	rW/R6ur3D8J2eAGgptqzIy4QPEojVBvU=
X-Gm-Gg: ASbGncsUbjIuV4ZA4bLLoc7ZSbK9SONxLsebQQVz6KtzERIqFlFHOhYig666d11oZst
	tPwN3cOrYPve8JTH7wVxog/yhDh4CFxekodrxbUB37qf7Bw1eVBYqLprFgr+w6tQJC0lutauMKF
	I4tF245iZmpVjSjGNgGdVta2ASQCcxPrF9PaODsTMM4OIkwogSPkoxuwwvXr+IZKeMSA8wce4Cu
	bS7i9wLroTVCfiEhiHmMUkVwOTDXaiGn0itYYEH3lMFrjKekkoukTIunegAp1rpdBzWHN9jWRZW
	aVL4aa1A0jSEMPwtqbUlh55ZYV1i
X-Google-Smtp-Source: AGHT+IG0Kw2xcdPae4Ge3vqVJme3ODdIflBSBD1/EEBWrzi1ZyNc3vHqvBzBJwqZfm0LgITTQYw/AgEviQ37QECn7sA=
X-Received: by 2002:a05:6000:26c9:b0:42b:2a41:f3d with SMTP id
 ffacd0b85a97d-42b593495camr4010766f8f.19.1763144544159; Fri, 14 Nov 2025
 10:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:22:13 -0800
X-Gm-Features: AWmQ_blhd5UV2QYJwXHHQL6Uwzr5xRWdWmTign3jpn0dkYPClv86ghdInOvoX4Y
Message-ID: <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/7] bpf,x86: adjust the "jmp" mode for bpf trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
> that the trampoline is not called, but "jmp".
>
> Introduce the function bpf_trampoline_need_jmp() to check if the
> trampoline is in "jmp" mode.
>
> Do some adjustment on the "jmp" mode for the x86_64. The main adjustment
> that we make is for the stack parameter passing case, as the stack
> alignment logic changes in the "jmp" mode without the "rip". What's more,
> the location of the parameters on the stack also changes.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
>  include/linux/bpf.h         | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2d300ab37cdd..21ce2b8457ec 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2830,7 +2830,7 @@ static int get_nr_used_regs(const struct btf_func_m=
odel *m)
>  }
>
>  static void save_args(const struct btf_func_model *m, u8 **prog,
> -                     int stack_size, bool for_call_origin)
> +                     int stack_size, bool for_call_origin, bool jmp)

I have an allergy to bool args.

Please pass flags and do
boll jmp_based_tramp =3D bpf_trampoline_uses_jmp(flags);

I think bpf_trampoline_uses_jmp() is more descriptive than
bpf_trampoline_need_jmp().

The actual math lgtm.
