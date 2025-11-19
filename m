Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4E221FB8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514015; cv=none; b=dBWTeOv09pJk/cYxFANa9QIQ3fP8fxJc3t6AM6W9F8gh8c4+IrITN51Z8jeBvrNsOzHj7YfY4HVjboykrnpXM27KLp5lpfmf2UkfIFxHrf7VvX+y3am9mjLUvjITztEBFxpOJlauwWteDu5qJSJ5rbe5RQlH6rVxZJkemeYkYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514015; c=relaxed/simple;
	bh=nyNocpByUR3b/CwyKnvf0BiUzAfBGDnj8J4bNztx4m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/IXyTOFZNvU49nKrezj32G80180RWG13DO0dGHBUUvHJ6KcKpbBFeyfICwuF8wdlBks05ydoTzh8pD7UoPlP4pUYEF6ILxV4B/BYpnuXSBN8J5H2zMEsD6TqyLZwmyZDyN1YnER1abJgI3IBv7/10St1PD1ux0AQUAEs6DWEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNsTt+WP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNsTt+WP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4918568f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 17:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763514010; x=1764118810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OY9WTVmOOVuWqdg+fgfXG+0iTabreO+6WO5UBcn+ro=;
        b=VNsTt+WPJSmsJ8igXSptOuMTT5AdDrUj/zuy8eDwHePl9AC+ySXA6CMsEO6ojm1pGZ
         bTBdUWZfVYQjsshrWgAq0WEElvxoMShY3vKJGRpQ5PJyaIyV5Hw5degNSRe+HnUo2HX+
         gio4bpDKdTtKzit/cvMwP4zTTP/2Y+4sHZ0cTm1eiihQEj+flgiKh9Con0HSbhUMBzHf
         pGPYKHlfAPTyMZ6VCk2e6exu3b7Ct6BB/oLYWl2mRFD9wq62TxffEiez7Ud+m0hqf1MW
         zV1wJrsz3sAWkjrN7eVJouNSTDA8KsucNOXP1XNxQH/pm3LHnrSQWswHXI4OX+C8x7Xa
         5JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763514010; x=1764118810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OY9WTVmOOVuWqdg+fgfXG+0iTabreO+6WO5UBcn+ro=;
        b=dyDdyV7oH/WTaXYnqJxWufXrBGT7pN+OgAfBt2djow6yGnxlO/1iw2CV3Q4BYrm2F4
         SV5jqy3Bh3vT5xl3Kbsl9yWAt3uHCoppkLUtjf3+nrGoejGQrat7Aox1QdC4rrSbS15F
         o6/MTTIWMBNLbVTBah+nOWRsQZQbrAkEwuEHhK9Jr1t5pWUgPQrN0yHChU7tPXSOKjjV
         4hf4gokhw82ZjlRp3awnCHRj84NKYp3jO+gy2W5Q97qMPPtk8rxrori2Tazo+NQ3tlt2
         i6S8VxKlgLq73QcdQHj6lPa1drMTv/9bYdW9u8thGEXDcCV3uMXOROxyKQmmgOWaDulK
         8nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaEnglHdHGbFd1gsR2q0acce8vPSDV2XQjiT16vu+ak+wc0ByOtZ+tsLVlCsOu8x1K9RTLW6mjCOWZgULY8EF7YGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KaZkcDRSYDRSPgR6y1Q5kYfZmYIiuw8Gd6rmRFRJCT9rBluq
	mAK56fPXJ0MhaB6u5wKXJh511a+KHskXY9IKho1unR/wEdHyPWIhHnsB5viTuPveAN2X4fqCdzL
	tt9na62cJThexNzrmHSVDwGn/hnO4tsU=
X-Gm-Gg: ASbGncuQQedvmmuT0CUf/3crRDtj72zBtYElmHmmR8UnxB6HC33JbMAv7qhtGLRBQCR
	akftDNnKKHzRN4wHd9AqGN2GLqpQv8yFMXrGyqWjZFDFJUCGB5smf5Emjm3luPke99yyV5IPYn7
	GjG3mWTbagbDEGzP6A+E6MPwVFO2lvNLwY+j+nrni7Z+V7jTOIZab0is++XVuqbfUpO7u7eeeAW
	5VyuOi+tCboQZV9bgWLt1rq+vXWtHBAXWGAq7tK8RH09QQW1rPY5tTEsq1bBrgjd5sTyCL1BROJ
	EQXwIP8ddUOiZ7TTToMnoA==
X-Google-Smtp-Source: AGHT+IFDVz7Fb9uGkQyQmluWKdUqIHteBKVCQHsm18F6wXu+OqNK1GPC1YzV6EetTn7g7tGQwNtMuHx6U9oLQSe4zxI=
X-Received: by 2002:a5d:5f47:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42b593847f2mr17058858f8f.47.1763514009964; Tue, 18 Nov 2025
 17:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn> <20251118123639.688444-7-dongml2@chinatelecom.cn>
In-Reply-To: <20251118123639.688444-7-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Nov 2025 16:59:59 -0800
X-Gm-Features: AWmQ_bnxKXPWNefwBIhAKxp_fFSOIAOFUGn2xQfiHye2gUu4LTw_OUbNxrvnfJ0
Message-ID: <CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
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

On Tue, Nov 18, 2025 at 4:37=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
> is needed.
>
> For the bpf poke case, we will check the origin poke type with the
> "origin_flags", and current poke type with "tr->flags". The function
> bpf_trampoline_update_fentry() is introduced to do the job.
>
> The "jmp" mode will only be enabled with CONFIG_DYNAMIC_FTRACE_WITH_JMP
> enabled and BPF_TRAMP_F_SHARE_IPMODIFY is not set. With
> BPF_TRAMP_F_SHARE_IPMODIFY, we need to get the origin call ip from the
> stack, so we can't use the "jmp" mode.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - wrap the write to tr->fops->flags with CONFIG_DYNAMIC_FTRACE_WITH_JMP
> - reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
>   bpf_trampoline_update()

All looks good to me.

Steven,
are you happy with patch 1?
Can you pls Ack?
