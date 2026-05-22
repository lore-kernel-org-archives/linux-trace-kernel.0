Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6C376BDE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475868; cv=pass; b=fR9x4LN7U+BYmmOo8ZxpGbiImYE2t4w0Qw2lsdA/YzVB6ZteYYroAKDArwFBBH6wnSVKfyOsjj2EyFkiOmKrzo94vUano9psibLtYLWCZldFP6dkTCgGiP+WwPm1CPBhbzFE8Mkv78ywOk+G7g+nC8sGvrn6XqBkSSd7B9FUjsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475868; c=relaxed/simple;
	bh=NZShw1MASHtchmMpXFIJ7C+AmrOVAclE9Fcdii5TRXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NirL3X24ofdiw4cZCgoezSVLkGtFHHnAY5iEU/CCT2EiNSD4SDfRdj42yRyPt+VPcPWj3BY07yzf4SFQrcx2QNKuETcIr10I2hMorWaNJjLjhQrvvnJ4fjmPpYfVUuWiIWqBZhWNA/EXEnS7RcYC7uhcATNqVMgDf2wPpEnfYuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT17stIB; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT17stIB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c828daf83e2so3608472a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475867; cv=none;
        d=google.com; s=arc-20240605;
        b=SD9lJf38JEv7b86QQNanXx5TmnRORIwC7ZihCvZasOgzr68vPKtI3x5jrbg/hZVqr+
         2R4d/Zr78n2VmztkMzRGayOZLq8Qcs8jdhpMKNxDHbz8+o5sFIf8wbh6Swc9wIVCjCWz
         ObWHrAm3KrZuVMwukk8RV56zSNlrwfJVbPCverr0bB50BWbvBHF1go80D6dWNfjt7xQz
         jPQ1uCCS2hDAiMlRJf8AdkvwbmW1BrjbZ21ov6Tw7TQni0Iu7BapIalhCNvLjrJDTjHF
         bKwL61Xnt/6UdvBsAVTl30ukXzvFHtzetbl4PPXEaP67PGKKxio/08WitpLCBGiNdYj2
         HD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        fh=sWXZu8FzqHUXnWcDCIIKOFdaPVbOxO52xzR3Wv7J2vs=;
        b=Pms5z16JXdo+MfLFzYCr9AG1Ario3GC3Xh2WwZJ3hrgmN/sif6ifJQS/tSS1QUFXFA
         afoRb9IjuaeVBYww2vbEuPcAi82cQ8GoG4YPWABRHlT+5hlXTey3rTy4Fx2TaphKnoG9
         5BFrsjRkA0b48ml10qDCAveEAvPkLTrstMCwHKl2GZ7x3hTYseSs42C6R6DUyqYBp3Uy
         nynzS7m3bUfrs/F3B/1d0Fn0EnIEo/h6lz83GqV9kAqL7j8WML7ShYKgsV20LGhfo6TI
         X/v4udClx60egbegqhpDgTc8m78H1zZ9YY1MrukH54DXeydoSyaAIrv8rRDXqELRoo0Q
         9vgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475867; x=1780080667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        b=MT17stIBW/M+NGBUakDOQBy5BaD/WPnCvKJh7mWEEeGEm8NdKRxUG0BScrX0m34/aG
         KTyepsxg3iYwvw3SdzxWDUpFQ7a+VtKemRm6Yb+2BFIAwrOd95YIkL7lem6u+ocyZ7oM
         EnRBtxIpVCxdIIzpfHD2IonWvl6sr5BKcpkO527RvmovZDDkVthv0CPRR/ZGQAu8QS2m
         PkaZ2M5OuXq2ckZHACVAPB7eVgpwUHN+lmSDhsAn5eQONgKaEyen8SwU0bx8xOnKtliY
         WwKQpzrZhWl4NPkNuETRar72NSk95pTJoqhvk9KORKZ8mOJs4pZdxuleq9cZtLFHLD1F
         ZKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475867; x=1780080667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SicWR6oDoXTpOwEFSC6EX0IEQzBj/yfrSemAWLQ78jo=;
        b=IQx0Wo7P1gvGme1OdjZV1b8u+3kC3qi453T9Ubo81BL7m8ddBdz1cfvAS2QCiMqU3h
         ddIdSpIM8Bkp8x3ljOfTVYo/Ea+RHaY1ZSvfYIsLWRD6kcdLytux8KbFpvfzUa97byxX
         RJI6h5rLxJdQL+bs/t+1/zjrbMPDZSSfqvBIKnvtZFLxaXP/hKw5K8FkOo3/CYifexZ4
         pMOCmg6OatujSBxNVB9wEjv832/rD6t/ahLnOdYbtANuHAZLywar6DRF9DWsIJWbbhRy
         83HPI0XYIvdHKZkvLaZ6ApWtQfpYjbOyZLWuAfO0F1679NL1S+be/9ANu63wfUwAPvR+
         VuPg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZTauqILmsd2PVeoX8eJ7bd5WAP+IapxQ9Ur2T4lb3PiBd0GBeJeZsvR70K6NJPxhOJIg5tzQaxt9yMOTjd5R0jlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7KH9igNuqnl/tsMaHQmkc4f/iw5b5aOpue7UcZSDRyAYt3/2
	0ktfje2d0b0Rhq2/p0b5VdugYdozzO/03N61Q8yG6jKQkaj3qz5oMftb6AqyB9zJStcqPtC0Zwk
	icdONrWr0mkww9/wxPgovfuKcdm7kmcg=
X-Gm-Gg: Acq92OGrD7YPXIxiHrOCVRht0j4ZV+BQWNpnb7uifleizQlvJ+sHEI6ZgCszPSYGKyy
	HJcImUFwnPRLIoflAYklSDW5Yh0pNgK3uR5ljzHvHOdUcjV1XelsLJ+yUw0gcvPwoeIZdlAdZGc
	07WqlN/hGJMI1cUTioXszZWZKKmD18ag3RWA282xmVWtehb4QDfQuXFTcLKLutOQOb/n2H6Vq6N
	Cm6cPs/0NuGrG4DCLHf20dh3pmVi+j6pVXiUq9IQmIL2KHY0Jtm1AaBqJjRt8CL12UOSUR/2G+h
	OmkeJdxvmjMbjDsNuGyEzQM=
X-Received: by 2002:a05:6a20:244c:b0:3a2:fbf9:d819 with SMTP id
 adf61e73a8af0-3b328f3be03mr4974574637.52.1779475866609; Fri, 22 May 2026
 11:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-2-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:49 -0700
X-Gm-Features: AVHnY4LByqrb2bL0kfR9YGd7hy4rE6eOc5M0VcEvHUbYT6t1lwB0v5isODPzxgg
Message-ID: <CAEf4Bzb9YmTh4_r+GxHtWNw_brr-sV2=KCKp+4yP+o7ihrjaxw@mail.gmail.com>
Subject: Re: [PATCHv3 01/12] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In the unregister path we use __in_uprobe_trampoline check with
> current->mm for the VMA lookup, which is wrong, because we are
> in the tracer context, not the traced process.
>
> Add mm_struct pointer argument to __in_uprobe_trampoline and
> changing related callers to pass proper mm_struct pointer.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

lgtm, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
