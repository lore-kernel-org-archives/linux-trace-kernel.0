Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04462E88B7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447479; cv=none; b=QgQdODDSYRQRZKrC5jWvPPgGRIOxvIKHfuHH0bv/HA8VyivY+EpjEnCaUIpaTYCYZ44JF1gnoDt8Kao4p8KyoMS8NJVsTGRIQP4PzgOlK5gTyCtP0ZVrVaV3fKn89kW0NLzaZeqHM44MG41vhYBnb4kVW5wUGfJejcg1roqTvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447479; c=relaxed/simple;
	bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljlR0bZGel08zyvUcwEzY+wX7FQN/uo73KBFW/sH1tf5yyvm66jJcMnyNojyvOXMzp+Af1LRhYtRCeCt93KCzuzL4BbpD+XPBxK8TMsyN8bIsVDVHYWQ7vGGpSxzOYXVbXtZR//goONvUpAUQTSiALqzDymdl7nSdh0ujAihU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnZEUEZD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnZEUEZD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso3597921f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763447476; x=1764052276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
        b=hnZEUEZDWELi5O9t85T9ug/VC1sKKC/jsq0202LWBcbv6USmpVBVuvyXIO5dlXO3u8
         w3ZZ9dZKMn6mhIKcdDNNry4zJIGDC/SuKipx/bUCahJq8Ev7EJkPnMXAcm9CaSP9acSb
         2rGCyXjCY9iSgHR5lx2tmHUCMuEAw7Fglh9xPc2gqLiyuuWhXUulOk/g+5N4XKmXHYu2
         FJnzRnfzXY05tU2YnN2rLV6TvORB+UThMUgc0PLOXy+mfUX7BgUuLLqKT887VlnLdOlb
         5jCfC0NB71YxuBNB5E4v+K4UBcKnr16EOuYvKDFx0xjQJq/MIq/TyM9kh22R33OiYNb3
         Nneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447476; x=1764052276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
        b=eoBZU1uSK1OxrMiNVEg6lIuy/trbP8dOc9F4kUBi4pmAFwXt5+7A79H8VaYLPolgoi
         816OvWrPkBaXeOZmsKoFt6wdVM4lXvk6E10VjUfsBXqROl2gH3/qFaCnoIxtEB8+ZMZe
         fdoll95mkQDnxpySqgpQAHe+YZl7B8QpSZ0FdV4fAR0/YdP44bDQXNLU8drRWAfS2TIh
         Ti30ML66HMrinZRcEaTHo5ORiWBT/rTt+tRBAbO/z2QlGgM8qqAl1GFzdZlHIk5v2SAs
         bRegjsLE+T8BOJeThEl7+Cy1UJinFX89qgywKWmwhZuCarmJVtnc0UdhiCgSwoKN70Mg
         ufRw==
X-Forwarded-Encrypted: i=1; AJvYcCViC7UsivW0cNX4GKHJnHbBxHURdmPTMXvhR5RNxG0N83HBIveAaVt4j6GadTXiv3WjMHheNHsNJ+sGHHI0GW5M6NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLcvclM0hju2nvha9+NHapTOrgGg49QEFWp6s1f8ce8Y52mZ8
	VZ3dfJ9Gml17pnkzVjn/GoL+4CvpudwRoKbJM4T+itQ69T945giWN7p0nEzi9A3xFWtj6kllRl2
	zopIVKmLchLEZPIiNJiIMoW5Qp9kNCvM=
X-Gm-Gg: ASbGncu7XDC+dCBXneyH3WVweQGRv6VNTwEkHNshrWzS+PJm6TpAyRaUMck7kgfdYL/
	m/DDakEMispRl3PRCbRzyDRc2RlO8d2nQuQ02fiXFYtK1AltNPAAi3OwjRP8hDyeXWBksAf1HuF
	j28bDZu9wf6JioRQogCESYn0ZCsSWEwjFgNV2H0AVcpsl7xS5aBnKhrTJVE23uIdZWnPuNQ5YXw
	uouqHW4/+wOsZj6WQQbgriBMQIXrYiyodTl+UqFpB5gg4Yd1m/qGiZbgCOgNGOiY6eQ7M8vO5s+
	nygEngVF
X-Google-Smtp-Source: AGHT+IGiQzEDuoP5/rQBelcFnteNemSmme2hOWV/uNK3bvOOTlSp/xZ35k8FaSnpPlQ/PLq6l7FQrN2IuidjCSTCpf0=
X-Received: by 2002:a05:6000:2585:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-42b593901d2mr14691038f8f.44.1763447475857; Mon, 17 Nov 2025
 22:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Nov 2025 22:31:04 -0800
X-Gm-Features: AWmQ_blTs97dxxsdFXzsq82EUJxwRysJEJrBAyAw6Kd-0LrumGTqH-utJu4AKC4
Message-ID: <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 7:49=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the bpf trampoline is called by the "call" instruction. However,
> it break the RSB and introduce extra overhead in x86_64 arch.

Please include performance numbers in the cover letter when you respin.
