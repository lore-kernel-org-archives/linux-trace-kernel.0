Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC84963B8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106184; cv=pass; b=AUHbFwTV/B8a1B27OaSxjOsmku+Kxk5Y6dfAwZA66+KyJvIB+Fp3wTGl2X+YQWKXFGBiFYdGrfT/RKf3pqkkbhAVIYZ+iEqXp+UIf5s5zqDqDW4vVOpv03DLNN8m3oyY8+8+drHm7Khr9rbfaPDgEgj1Hd15j/fTQIaMVC3/EzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106184; c=relaxed/simple;
	bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYcQfO4Mow/D400228Zr/8OXeq2gqrG1WlSSUGeKSvbPzrYWKZbdHTN6iCb4bPAM7w7/SDzgm1/pwPFTuQ/9DhL510PcTGRRJt432OcgXAuzjQFkkk9+lhee3QGdxdlUm74ziMc1Rw90IfTqJdRf2luJU0MkUHfvmrYgtoBI2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBl8kK7v; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBl8kK7v"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c858961a8efso2624691a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 08:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106183; cv=none;
        d=google.com; s=arc-20240605;
        b=BTMaXItzaWZJyCTU/vEnFMTR8fCnCLyYO24FuK2Fw4Lz9UskNl1s600w47EWWhue+A
         pyigcS9syGMqtffRDL5dzLWVJVqtC7Mj56qa5MZQ7UnTN3/jdin/aXgtYG37RQev7vX/
         Wse3w8xBqX4Fqm85LBTx4AYK12m7yMs2O0WnZugcr/4xedE9SICT4hPok0yWohWx7cwV
         DnLJH8UGKbuFmBKwLblGZ22zd5GZkfC/rrSNprH5vOpaQIHLMzwGct3fnvj/4H5TNIY5
         5Q6/Vh2K5ORetJPJqumRC5nZltKv1H4uZvsYxZ1at63jCOX4XmULXFO6hsxPp7jPniRr
         TQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        fh=rfg3ulGa4rD0v9O2mM3+iWcuOfR1sJlBw9b5bbe+vk4=;
        b=FRediq6Uvs/YtrX1ctExVZlwiU28zbCjE4VdxFclPaQqzKP8JdbY9gzeToxpceTEiJ
         6Zf9b2QntovXdIyXcwj9mXgzjPRx1q/2LuCb1hOQVz/zZSLitM/id7hzo7poR5xW2uj7
         8iO57W96m5jRWn19xrafyUDdcnOAZ7u4+TQwpncIY8iJY/grfqzZsxAFZzLNAMuVMN8c
         w853aPt+J9ZmDfkzV4i6c5i1Olu3uwK+b05Cwg7vDmh/hEYR4ANLZiH6daQH2gKLnPun
         Pcdc1D0aBWc2le99e2kSH+E+Nqp8zhIVI9EYG+FlNh2uWejkAnOfDwMJZOzQdjcAZWoe
         u3Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106183; x=1781710983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        b=NBl8kK7vs7g1kEQ5+12/naidREVJAlqcPqMyWGf8YIpulQ3ZypWhDmcX/fZzmwt6qe
         pFHsjBSLCEaosl6xVuhj8tH6NN3N+VIOSdgo5GHB9DHjXvg7brs76F1/bw3RTv9UBwSL
         dbv2n4jVrgVZSPPP9MSWsOpyRRXEplPhQGLWG5r/EIvYuJdYLx1vdcYw/Xcws/eQgf4m
         2TGxi7JIhl0tXoO1oqNdG/+beVZpPMSas4zuYfAUZeV1i9FCVjwUUczlqqoHK63EKmUa
         nUgyAL5m7Fbsqvk7fs8PDda+TAsZ9S0LUhTHdXrNTQRVhNC89W5LDZz2aifDiM25ie/O
         6TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106183; x=1781710983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        b=ccHlM0HT9oLBmR89DedvFfvVLt9F9s5YL4fQb/pauohbNdkcViNNFRsh4oWTJicnqf
         gz0y4mIzDTb8CFXrzzG2AjRgXeZMlVVtcmbX2fWD4Afx+guNlElTG1N6qerEjW32NrLh
         nbNHNqWMfiZMkY/+zUgBzqOhk3dE3VI+HtzYILF2vra2/T1nh1r/NRdBghnnjQgkp7Gs
         12+bf1x4IiTP1iWX3XIpYtRfhNtGUu5pRQrh9zIaj9ZF5GGd0mFaXzhDoxQnSfeWpqRq
         Uda9AZn2aY857h6MzaHL7OUwAZH6O7rrsrs09heF4f7obXvrEZIV9YESGCKqgoFYi5ie
         lz1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/j3ieCXzLHsKHCfGREzzFmwCgwQBpc/+6Z9aTHP2NadFv6opt8gpd0wpYHDkJ0CqTQ5Fqba/bm1nFmbJrbW4noO48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEds3lxTDRIoNopss9COW5E4kNQ42UNWPchNbe4zNX0CrKzpZD
	xKGcnSoG5ydNPViBFBsSmSe4iF9t1jrMGSv1MvgGm1RzwKFU4aMekGABGjE26PbHPlNOjWeoKnf
	ifN/kRDNZMkxUWlV5GdS6MjJVCIrg1MA=
X-Gm-Gg: Acq92OH0l3qBl5iHAJWpZJL1dg9RIuDpOgEoXP7NncW0DwbXhfYJwVDCy+eVK8O0nSz
	MM8nIIf4MLKXDJJdLT+F9qJyGZ+tthevWHi1LAe2DQImxD9kEwyMmNigcf28K6rfvgcPENAHcuS
	lbHFUe4xq1ics+8rtOCZlq0gbPlW3EanPlGqCi751zRudfIZYSSYSJHrfxLrfS89HQYcMK2EPlT
	LoJ7Vr0zWZxc1pNOfCWWEYqba5MRc+5g55pg04EqwWzdN/mxOpJiMCsIqeJQbDS2MCa3da6QKxn
	SmGkgxTE1BewvRUs3w0dOmI/jbC36Q2jiqVr7KPMJKy/YJCjIMqI/GUn3awhoMEZxd6rvR/EWNz
	5QrnaC/hZpMo3b2FaiJlJsGZxa8feHzcEGpY=
X-Received: by 2002:a05:6a20:6a27:b0:3aa:f9cb:d43e with SMTP id
 adf61e73a8af0-3b4ccdbe063mr30315804637.18.1781106182666; Wed, 10 Jun 2026
 08:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603110554.29590-1-jolsa@kernel.org> <20260603110554.29590-4-jolsa@kernel.org>
 <20260609102922.3c489f76@fedora> <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com> <20260610113536.77172ad1@robin>
In-Reply-To: <20260610113536.77172ad1@robin>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jun 2026 08:42:51 -0700
X-Gm-Features: AVVi8CeN6QnCWHARnizI32fh6UpRcmeczia8YRAursoaXCH_D31y9WtnUreXmzM
Message-ID: <CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry function
To: Steven Rostedt <rostedt@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:35=E2=80=AFAM Steven Rostedt <rostedt@kernel.org>=
 wrote:
>
> On Tue, 09 Jun 2026 16:43:19 +0200
> "Kumar Kartikeya Dwivedi" <memxor@gmail.com> wrote:
>
> > Hi Steven,
> > Version 8 of this set was already applied to bpf-next.
> >
> > https://lore.kernel.org/bpf/178085644764.273544.8250000589480262551.git=
-patchwork-notify@kernel.org
>
> It should have waited for my review of the first three patches though.
> I like to run them through my tests before giving the OK. As they are
> generic changes to my code.
>
> They are trivial changes, but regardless, someone should have asked.

If my memory doesn't fail me you said it's fine during v1,v2 iterations.
The last v3 - v8 you were silent, so we assumed you're still fine.

While at it, please review Mykyta's set:
https://patchwork.kernel.org/user/todo/netdevbpf/?series=3D1096695

It's also been pending for almost a month now.
