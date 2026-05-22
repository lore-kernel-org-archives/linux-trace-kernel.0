Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CC377000
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475992; cv=pass; b=AsapQBWKKxdermTjZCmxLT/sJ8CeT7xoedJlP962pClVRP/8qFSnCfbruPiIDcWEjqvU4hDmKn1E06gZWJKV5Yow6usc+EeAD9E1kxcmEieERU04He/yh9x4g5LseueCiSTOisS+/cQiYDUd1a3EpdJYK4mHlwLLxlAojQimvrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475992; c=relaxed/simple;
	bh=P0n1fZ8hC3OD4nF71hAInfcl9hkB3ZTgTE4eNK/w7AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGdH7z6GY04/ToI+0POn3dLzqUP1tNe8iAEH8HDAO0Vuf3pST+P+lftPp5tzNxfW1jlEvgETSS2hwfjaxWfxoDKD+prPwUCJSO9mIb6AanhfSOe5rcAkp0ACkuRIuPxDTMsP7ZJtL7i92fxoaPrLze7hV/Pkv8ls4qQlcmCWotg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2HSiunP; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2HSiunP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso3842161b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475990; cv=none;
        d=google.com; s=arc-20240605;
        b=IlbaRzdM1rqdQtlTAdSqRRBiOoK2992wJXP3jNgRsD1DIM2W02OVhYiZYfxFKUi+P4
         mT+JMDc4WzQ7U2FZEyWACFUAiOrjclij5jDOtgxTlx+h602HOOEJLxn1JWjZ8e7/6GZ3
         DuDxkkSggchjAc7UfvAhPGm1E9oyyhn2k1ZQrDFE6rcGhTGpvhqaoKJVtr60KcU6O3pG
         nhAMvKCrcZq/aFYsRNaorD//Lr1ScRKPl2y/osPWiShJvXfzFeNUST1+ZnlAR3WlPqU7
         s/kCurw2lsPnUVq65/9Fz7M+vqAIlI6MaTn2F3/hIz/0XHeO4uzay9KFV1iTvVFVgYCD
         pBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        fh=TcsWRZ0dwPfdlwnuTr/tuqHyl1G0idFnjQMMndk8zNw=;
        b=abQNjWPlrKnhOFdDpwozDQ+GijzDnWyrU4wEk9ejgG+4sJDGasS5YjVH8dleoJnpOv
         +IXQuXbiuiKKX93z2aowiVMadJ0Tz39iv3s6+rPT+CFj+E1m+xb8DyIXCRDsEmawAWYb
         54E6HlCJJcZxK3QL0hslBPnwxVAfgJM5prIf59IdmHK0zBj2XM45Imnm0/At8SwpZzno
         AW/YwTxHCL8TRtjCptyMBPn/XBALZUZvFf5LBl7PDB8Gyy7IH2BLQ1godEOvZtB/NgSw
         qPhRr6EuzxjKZr5x3ApCzC4W4xMhhvKS3x8niViPi9emeycHQiwtsvc2+A0Bci+rOwYl
         JEDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475990; x=1780080790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        b=N2HSiunP1UgigdVHDUo1uMgkErcVyMNwSXBwMXluKojx4hpKKQ2C3u3tmgkL3vMvfM
         KoePQtmw0Z6XWdRAayGoz0YehS13YM4+lPdDMUV5fkbRCXFWcpIgOp73hx2O8pQjeIW1
         8yzDTC+HhQ/rx6kSosAwYphvVVb5tbLvGimA2iiGoQIK5itIzuCbvFN0d9A6SVQF9hJG
         7vlHmvKiGR2dcLtKTe+7DW+WXupliUQX+RAGcjBx4MKY6oM1Q6Yu8bG/PMe4M8fOlReP
         WpUKQ+QrdScbyujVxwCue/nYtzfK7LyoDTQtiJ9s5F50KT8UNgFhZqViZ9bcqFgMjNkt
         D5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475990; x=1780080790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        b=mL9fjq4/O99vpZUitMRrgjtHNdwU3QqTcLBJYIJzvEN3qXlvWwnXwkKvgZYAZXBLRF
         eYKxrrER6sam+yYINvq5CwisZT99bJX4rZpQ+dnvqUy2HVcEQGTTwImGiFymOwkbYxBh
         XCIUwt3y5jgDQwKHaGQv83CV55n2eDDWI4SZOuMMD4Cj2lSXZXo5wgG3D1/JH/8F48qf
         ChnrQCogwD8WPpfQW0dHCn9k3es6zdBOW6lncyKvzDgla2gFIs/fxQv1lTMJYOPK+ErT
         NUWQIRRJVyLLgCv6ETFKo65V9QGRdSa6/lFUM5OA2pT0DkQFt2bagxrdpTeASYTW0lAj
         yTZA==
X-Forwarded-Encrypted: i=1; AFNElJ9mdxVWQ8Y2+F0a4Gbw7U/k86yc2XIuxsBpv4t88yXFhMyHE/a8gJeQMJgtafCXxa+56iDS0dCo8qXGQqPBygK2SEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOetryxEu4JIyfZdAw8GBQzpUDMmM0E3JpMaAg5lqNOfFiC2d
	kW8aFbAQkf1o5gqNr7CrNNpaSKgXznV8Vgl+ZkGWZfJG94NAIBeOntRKcfCOa1yM4Sk+RllTk6U
	ulYMoZGVVwOHkdK8pC7E3dw2xpvuV4So=
X-Gm-Gg: Acq92OEXrMl4a8mzPpg4L+AkS0g1Ydnd7YCmL6RllCi2Ej7qv9NhUkw/f5eCOKJHFLw
	Y+iNeyiIDotJAiqflakU1gXMO/ddIQ9qStg7iJKpnmUlNcIvHKGOQj4tBGYTbSOapAemwl+6OeZ
	WpJVP3u5984nCIPJfJi0IIHVh9aKo+V5zt708soWVzRga+2DDCizerMfJlpr7mV0jScJMUw9WrY
	I5dYD+erehMpCtme84yR36JuE2FAbvFTtMO2VZGMVGFWFJ3FMX7/3+rHXCQF4hC8Abt/T3l50yI
	yiUYfL7oOKwC0/+8eK2hR5Sf1cnrq4RIhg==
X-Received: by 2002:a05:6a00:a96:b0:82f:6cb3:645a with SMTP id
 d2e1a72fcca58-8414b5956bemr7133353b3a.31.1779475990150; Fri, 22 May 2026
 11:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-6-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:52:56 -0700
X-Gm-Features: AVHnY4J0I1T3BExdZJu4Z_1SbsaTPMCUJYXQuJWJAXmxIXaY5DnKc11XjERAYdY
Message-ID: <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:45=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> fixing has_nop_combo to reflect that.
>
> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions=
 combo for usdt probe")
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52..484a4354e82b 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_obje=
ct *obj)
>
>         /*
>          * Detect kernel support for uprobe() syscall, it's presence mean=
s we can
> -        * take advantage of faster nop5 uprobe handling.
> +        * take advantage of faster nop10 uprobe handling.
>          * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to sp=
eed up uprobe")

Would be nice to add commit that switches nop5 to nop10 (but until it
lands hash is not stable, so, hmmm, maybe we'll land this patch
separately? send it a bit later to bpf-next?)


but otherwise lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>          */
>         man->has_uprobe_syscall =3D kernel_supports(obj, FEAT_UPROBE_SYSC=
ALL);
> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -       unsigned char nop_combo[6] =3D {
> -               0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +       unsigned char nop_combo[11] =3D {
> +               0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
>         };
> -       unsigned char buf[6];
> +       unsigned char buf[11];
>
> -       if (pread(fd, buf, 6, off) !=3D 6)
> +       if (pread(fd, buf, 11, off) !=3D 11)
>                 return false;
> -       return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +       return memcmp(buf, nop_combo, 11) =3D=3D 0;
>  }
>  #else
>  static bool has_nop_combo(int fd, long off)
> @@ -814,8 +814,8 @@ static int collect_usdt_targets(struct usdt_manager *=
man, struct elf_fd *elf_fd,
>                 memset(target, 0, sizeof(*target));
>
>                 /*
> -                * We have uprobe syscall and usdt with nop,nop5 instruct=
ions combo,
> -                * so we can place the uprobe directly on nop5 (+1) and g=
et this probe
> +                * We have uprobe syscall and usdt with nop,nop10 instruc=
tions combo,
> +                * so we can place the uprobe directly on nop10 (+1) and =
get this probe
>                  * optimized.
>                  */
>                 if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, =
usdt_rel_ip)) {
> --
> 2.53.0
>
