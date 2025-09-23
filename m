Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194826CE2E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655438; cv=none; b=ocYInRbPplR1cJqU9431nYZiPRNOg3G9trv+WzHamgJQdp//Q27vzasRayXRC89iq+7Ndw7JXfsSrtkU+q6yz5kINhaiRk6ptSv+FvxGls6prT9pMKkIWj9cYDnJ13ClX9je7J6kEFnVCZ4JP/lMw58IFl9sosD6gJkGI4eeNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655438; c=relaxed/simple;
	bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZEO7C355bO52kdexgV9apXrRHfHDF2NpJzcMllKXfu1pTzVtCW2o8M1Js9U9Yz/K85QUcn3si+hZSo3U0l5ON71ghcHFy7sgN8eQIXMdDCs/7C6hebSo52ZB/O3+PchsInZK15slF+TcB2nvt316OpiLrZsbeoNbKQUILK5CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRuk6BEA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRuk6BEA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee12807d97so5212158f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655435; x=1759260235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=WRuk6BEAyG5qd/meHhAM7eAqaL4r5/fTvTQySSK8FWKMWz/phX3T8Bmp5q/Eq0P/Hy
         BY01guXAPPgv8Ar/955Q2cy0dFp0spY0ubCvaE9qllh5ppuue09ewDd7vBAK9mEz9g/m
         uZ+EFqLTh2Xh67Fcfj7u4QKfuDTUrpam5XWflOds4o9hSPM6vOsq2k3qyZjA0fIt0tF9
         7AELidGe1q03KzEBdwXFv4J8PcdVHeYgXNc3Jr05WkF+L5uc8OUUb+MnCqyVgP9329BP
         +2nJQ1cP+bM72QQOzpVnJ1v01Bp6QVcUiK4DvXykNtzaq2554VYieYn2d+d2rVPBis2S
         6MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655435; x=1759260235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=T4L1UPD/gFe9TTu1VIV3foyRsEPTcr5YHS02rhwioVFsNoCAOQntFrIBHFBryh4FVx
         0ZWU2PI+PV2DV1gMH/2twJOPp7iU4zCkV16O+LiWoWIr+1cVOWk3LUEOVvnH3NVRtmu0
         VwXObkgaYeHa39mhO+9eEZ0amoc7CHSetE0lexRLdI6uyT9ILAk6l0hGp3BX+K2SKTmQ
         2o7oRhjd1rXsOAC56Jl9tGlWLpD0ULT1ddVPZEdzj+KWem1FXHRhsl1mlqG7/beud1qx
         oryxK9OmD3dOdF7mntbLJwPfV8LSkwixKFqCQ0sE9gv7NshiwS3amn7t4XjH2T9JARdk
         AUnA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQNng8drR3qaKmd+Y8joQZ1WNn5Sle8rCscWKHdQ8XbEkeUjQB5lTbAHew5Ub8F7wP7TIuFlHJNc3XVyUt5v9U4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvTPHMWv7PBSAxXUCc3zlaRp7yEHXNVLqZ3Pq1IJI9RUJViI2
	2cGm4UFujuwaurrt+6zo+wu+NczRXXu+ioSxFBrz5src3VGT6mytvOjaAzHjcPpzJY69vW+Alk7
	dzZqfmd8FLM3buP4rvLKFQ5qS/01y08E=
X-Gm-Gg: ASbGnctn9/r/ZZm5zQze3EJnGF8+Ev1MqgoHCinDbfOPtZnulFfyBLuuVkNQg/3pSKJ
	e0a960gZIv56JEg+RP59+TXXaPnqqDrFMlwSphny18MQY2llGCd981dP3UTaqsf1vgmIeldS+2x
	OVgTCCi3QMZ/GxIZ5suk5I/Zl1LIh+AxwwHuht60INacEPsjZsTlC+O+mPUTeG7XcA7cOBGcrjJ
	KLjSQg=
X-Google-Smtp-Source: AGHT+IEROyvN89zXwrTLvHEBfh+lTjpX1gLN5zjZ4UthmYExEG2GOLLm8ftHboFI82Own50+u3ZOPpnUc08RGvIFLxs=
X-Received: by 2002:a05:6000:2f84:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-405cb7bb76bmr3258549f8f.43.1758655435354; Tue, 23 Sep 2025
 12:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn>
 <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com> <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
In-Reply-To: <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:23:44 -0700
X-Gm-Features: AS18NWASmv7blurpmrNo9VunWCEk5u9gzididl1CMRVq8cti29RRJ98n7ZkNCbQ
Message-ID: <CAADnVQLZMwNUF0PwoCyLUC6tWVuyx80qJF692VgnGoJVm_M=eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >
> > On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > > Therefore, we can store the "is_return" to the last bit of the "data"=
,
> > > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
> >
> > Does this really save anything? AFAICT, bpf_session_run_ctx is
> > only allocated on the stack. Therefore, we don't save any memory
> > unless there is potential risk of stack overflow.
>
> Hi, Song. My original intention is to save the usage of the
> stack to prevent potential stack overflow,

8 bytes won't matter, but wasting 8 bytes for 1 bit is indeed annoying.

> especially when we
> trace all the kernel functions with kprobe-multi.

What do you mean? kprobe-multi won't recurse,
so tracing all or a few functions is the same concern
from stack overflow pov, no ?

> The most thing for me is that the unaligned field in the struct
> looks very awkward, and it consumes 8-bytes only for a bit.

let's keep it as-is. If stack overflow is indeed an issue we need
a generic way to detect it and prevent it.
We've been thinking whether vmap stack guard pages
can become JIT's extable-like things, so when stack overflow
happens we unwind stack and stop bpf prog instead of panicing.
