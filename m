Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245C3CA4BF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793129; cv=none; b=htjjZSZs/agSizRUxq277vPGvzkdux4YhVtBjv8sWR/Cj7djGnIS2CF1jwRD0C09+Swy/bwN9Y/YPKJASKYHo1C/i1XfAJxT4ps+LGvn0iaGyrgA9r+gbiTOTnm3h1EvR1A9EbzvPvFJi3wwE+vKG0s8ot7xB1hLDsvoVOSH9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793129; c=relaxed/simple;
	bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0c/kQZTqQfO8ia6NIP1e8xSUH8N962UyJot3SUBF+0FJugB9mp/tlxhU311iSff2LknnypcOHMlSDom7eHOgcbxhshW06y2ubNwXfl4zReSWchjUbO1WWlXRuVOqAoMM26KSIVrtdV1+QvdDF51gpXtY/1SNrMFqqFQOa54l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e7AiuZU7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e7AiuZU7"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bdb3fd39045so770074766b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779793126; x=1780397926; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
        b=e7AiuZU74PJMrpshXpb5vD20MuQdnuCKoiE1cMZtHL17YgkOW8jEBWrkPy1YL/uyOR
         DQDkOtpRpnEUxgtlz5P77MoyblFORlF71Jzkc0MEGyxXzLZngOrjhuwtof2G+m0I4QJS
         MYsJHWeQ9Nud5/y1kOuQcFY4dpqFVfa818+oXrWOfkO53Rp4s8FFEOcFi85VVosw27mo
         esG6m/nNqp0PBZCoB55ezeULu4SzGT3klom8VjeIz1ckaPjPCMN8WTe/yADyV8k6kmMr
         La13G9+XP95KYMG0vGl7t0aAOnV9vT4YhuvklbOIA4qGc33HZ5fZYrSFL2u7uKVY9Sgp
         I9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793126; x=1780397926;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
        b=Woa2OlweT0WO2grMyj3HPDc/eJlXiVFM+iNGJ3hIut7WL1hMs1OmFFkLh9uEQhkDmR
         BOut22lJEtsFtgHaYcDPk7K2t3cp/0kLGsTH2BNDXSq9WTcy38m86uerbh8nDbe9xpRQ
         DZWapogR7BFOHwTYC4ylj5iSWcFEZW9b9f28Bs2EScbfLSv3HuiMa/IQ3ZN60Gls5S5k
         JOu0IOAsHlk+Nnc1v5amna+5zddd/tpWeQwn8HS+x8vVscruFTF4DR8cPEapdTFrQJPT
         qAreQVFhKswAgCz9p2HwCDx+JAvlrV3FjgmeS0vqW7S4g5xn5Wqkpex/mt3c/L5+Aheq
         jPhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8engIYhTAMC/ViFHuaf809WjZFIwAZ04n6z4x3FE2kuMFRt4vqXC1YEOS4griaPX2wRNecnL7f5NekcZbK50I/Djw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSra7p3qJ7I3J+FCfNdkTZxBd80DyhxOHnY51cXinee/FEGrLW
	HKN/J1jZqmMiXcibYG0O3BbkdtRZLN6lIAHx3bllWY+lHm0+HVtkGg032OKZ5hXtC8k=
X-Gm-Gg: Acq92OG+Cj482fJPP0AUdwGr1D+hn81Xok6Xm77l6KHAkAn9YX6pi6rOokrPRKIwuMt
	mLnD5Zy1erBaerV7DgUphRpepd2GKOiYmqjPphepen7/oYCTSZjcXJuNGhSPpbyg3PFvwRnPCZb
	ROmkT9+b6vOsJoNBRieA0Hu5Qr6qExWsvE8j1Ue0R9pTj3+K5aZN/7BMAv/WzWsrKMvbNGEsckq
	N1JFoWEM8VsKHEcgcONuO2BoJXwyTne45ydAXFURrp8yp4046ixWmgdKwGY9SxNRzzYlpwaJZ5R
	vc3Mn4GHEETQGkB3xwlncC2xX+X0GYV+1f7BHyK+aaB+zsaWWnLExGPwcWiWJxcpVuHx5QX2ZJ6
	DlM7xMChWS2AmXE808q/ZPPIt9JYS+ZWcjGk4HjNMahd63R67SCMFVm5phAA464praLztZQQWDP
	NRp+n2URrWJvbtq1qHAUnEZZhTTg==
X-Received: by 2002:a17:907:b5a7:b0:bd4:c66e:988a with SMTP id a640c23a62f3a-bdd21a5c072mr767209866b.0.1779793126064;
        Tue, 26 May 2026 03:58:46 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1e984sm4867993a12.14.2026.05.26.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:58:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
In-Reply-To: <20260521124411.31133-8-jolsa@kernel.org> (Jiri Olsa's message of
	"Thu, 21 May 2026 14:44:06 +0200")
References: <20260521124411.31133-1-jolsa@kernel.org>
	<20260521124411.31133-8-jolsa@kernel.org>
Date: Tue, 26 May 2026 12:58:44 +0200
Message-ID: <877boq77yz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 21, 2026 at 02:44 PM +02, Jiri Olsa wrote:
> Syncing latest usdt.h change [1].
>
> Now that we have nop10 optimization support in kernel, let's emit
> nop,nop10 for usdt probe. We leave it up to the library to use
> desirable nop instruction.
>
> [1] TBD
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
