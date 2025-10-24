Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE22773E3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324159; cv=none; b=I4+KcAcdjNmhqlll9SzLu8moV0RADcJn9wfHCLGjj8SM2TRtaJuucN2fuaCeHjFW2J9IQj8hcrcksN0gCm2JTvIUjVeJ8lFxcTcYYu5amrQ4MndFKc2+S1bKUz9REEBodnJ3OLiuAoB/SHHRdA1M9N+J2dYSJiLPsFzaZmp8GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324159; c=relaxed/simple;
	bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpvJsq46j1uaaEVqcvxJnnmVftHtVoz0rbcK6n2bcXNDvObsjOEqjsBpkFBLwv21d3c5ltTBHsBoN7WH7ch+qvt25iHZki9dYGmi3zaUQq2IJAgLzH12b9AgNQUp0tZszKMUC73xTipdvOFDAiuVMIoJJyKEwrPhkyV0BwwEbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTJ9IHeO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTJ9IHeO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso25708755e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324156; x=1761928956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
        b=FTJ9IHeOdrrjFXhEgu/jP19ViNTj0qu4lU3N7INJt65B4WivWHh8m6B15oJX03GQse
         ZVGUJNuXHgmD8+VvRHM9p+WcUvcFRb3HNXJNXzf6MJjF5K1nFsETUpzl3sWBPMGCK70s
         kVEO1uGMT5nGQlTWnaOMKDmamsZeSV6juvBBCTdP7cKeP8ufRvs61/ymJxae+MAZK/dV
         BkGjrSad8pGjYOgrkYl2vND8bMnjSnfXKvnnqeR7ysQceHGJUcHEQdtZrE8qdhDpU20k
         G+PWm9HNwH0AEUW2LI93UTaE+5SfTNGgxSFL7HIc4Db9jKjrfVpEdW55cvKz+VHmV6vu
         dppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324156; x=1761928956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
        b=VP8oC1NX0H/5KJeMbFWswcBYht0wuveyJ8E2EXxNqRVVFvwA8Wy2oo6cdvSmWWJAdq
         qhFIfTLSc7yySYhw6DwC6v30skhxuoMpP/19eMi762rSHhB/70q3sO5tZ3lAA+IhfoC5
         11b6RgA1B5xMU2GWgOPMY+7553HY5IqQy7paDDKARvCQm3HGL2DunT2jAJV4fDq163ym
         ixrUaMSn6snoKipNXrIdTcTbZfy59DErrZmNNMrUAd+h8f+w6GibmM/YguqPlqRYj42V
         0GLHVk5HnNx3LK/3td/dF45N/nPvOoYAW0nbdNfMXJR9N0RZXRNlULOvbjr80Qy/InZA
         NKig==
X-Forwarded-Encrypted: i=1; AJvYcCWDY2K7XTQl3eJDG3PZtfY+hrqP0u7iLzo60CsMJ+VUVXgIhiSPRTMt2o7U/t7tV3541dftBuU69WL9A1qFe19f7Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgvmoRUVJKRAjlGIF4ZgBu/UgpcnmwJwZ321sVC0xVjHQgchp
	pzhjhdkd5/uBBnFeT8KozLsObXea9b756P+HAHfir3GYPCH6dL9Dfpx9HefPNx+iYix56kAW1dJ
	L8xVQH3oDZrws9MaH6ooShqNphb/XKhw=
X-Gm-Gg: ASbGnctXaKG6npBCvEgcNKEc73+Pk4BeTPaJD1kBKeeVXMO0Q3I2zAXpeTPLpWtfeXm
	6tzlDvXd64g55HMUuIJPXm6qGn2Wxdj6wHe9v6wDnGn0h8jzoc7COk3fAv6kKxt08+gAHE7FKcr
	Yta/8bRzMObNkzgbE3wCDwUzI9xINh2kAUSfuFn3yXoNEF5eeHmPOd2R1mQA5+gEY3AVv+w1Xwr
	ZUXHVyu4cm7DpQMhhKn0KW5TDCBpmjO6C+XmRyebPRXEYfcBtDkLtUj+TpqEayocLgUUgOaSxNo
	J1aYMokRKPHqOZrXHg==
X-Google-Smtp-Source: AGHT+IH5nqX51vYu1IexzHdkNZ0afoJ1pJcMt9JtXykhaYOJDMZrIHUFWcskwHmjhcu8uYAf0gEL402Nx2zXqhGVX2Q=
X-Received: by 2002:a05:6000:26d2:b0:429:8a81:3f4d with SMTP id
 ffacd0b85a97d-4299075ca93mr2745229f8f.63.1761324156212; Fri, 24 Oct 2025
 09:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024071257.3956031-1-song@kernel.org>
In-Reply-To: <20251024071257.3956031-1-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:42:24 -0700
X-Gm-Features: AWmQ_bmjZ0ZCnr-m8vmqb1yEUfyIazFF0Pj2kGjJ8zWuivBt4mpAdBnhmJLj6R4
Message-ID: <CAADnVQ+fJZAHKBz6aVRBLjMyxbF2wZusEfD+AihN+9RWvrBwtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix ftrace for livepatch + BPF fexit programs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, live-patching@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> livepatch and BPF trampoline are two special users of ftrace. livepatch
> uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
> functions. When livepatch and BPF trampoline with fexit programs attach t=
o
> the same kernel function, BPF trampoline needs to call into the patched
> version of the kernel function.

This sounds serious. Pls target bpf tree in respin after addressing
the comments.

pw-bot: cr
