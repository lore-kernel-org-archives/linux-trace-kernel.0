Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44235B121
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955458; cv=none; b=krXc3bjZRa+W6jkFqFTFpWkp+R7RX3QIo5m9psn0XbO2EUnUFl1r26/vbfa+OgMWA9asoSvz1VIqBvcPTeFdEDpk+2kJmfkmCihMEIzCdPmiaD1YawLBbtsus7ZbXet+YHnZsZ7OfstoKhQVTrhafEmZJrej03d/hzNiE/TIo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955458; c=relaxed/simple;
	bh=s0iVd2RsjlWS/9TR2zy9YAOZbmjboSgGnXQyMW8/G3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6JHOaFp9DX+DIHbTnMoxFOaiwlV/xTpHn93T33FQLPEidY0As014+wfrZDGawTcvI0L5YAl5N+LuDAnp0i1TJYqJl7ceTqnCiY6lcUhxKTBqyKat3j9NH+PhEEq1dFczmYedz/EpPPYDfOLfuX/7tTVbIOWXWETjBF/yrvtCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YxkUMM1i; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YxkUMM1i"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4162463a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764955452; x=1765560252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=YxkUMM1iAnIqvBCYCXW2GR8I0tkgi0oeIswtbpN5YciOo697DW+coFTWobGpRviWci
         URbqSEhddBEz/e5fI3R8DIsdISpmrbSC0PoawLROoSIfP1n+A+xGJk9v57xOGsMS91w5
         IwlrrBSFkQuCe2aew3KohiUmbC1wcpx0aSEpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955452; x=1765560252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=wyc/Hcx0Jx03+tIwU58rIjaZ+3dEsFnOxHHA8QS0mgFdJtHEwcblQqZUwR8XpQSxhd
         8dvZciKDXJ5wjBqAyp1gPrRmn3P4LigdiCUWHc6u9TewLpgRcUV4bJnBGDf1+0lP9Axx
         LAslpI+D9Yxbr8xqNnzvwkpvXSIQPbTY+tJVPBCLELJRL/Yi4G5TxU28OqiX3DNYSjRv
         bSZakJyHM8Ka9GlSx5dxmLNXF4Kv/AMTVlHrAvxM73mCzOInxQiaAMRnSpbaVenEgyEp
         zevuIRq++gXWvPsD9eAoEloMiL6GJr1Ql0Qjj9zq3Cza0mpdwyQBteGti4k5b+3g5Ekt
         mfAA==
X-Forwarded-Encrypted: i=1; AJvYcCU9DQIfvRCITTOjC6lolemmYWDMZcuZLA6TWFR/KC4VSRLTtsgH1UQVr5WftGlLakX+etTRg4RzcioCKw2moPVT2hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydM1f77csrm6g1hlXLRV8iuSpSCLoF7ReLmPcEuP4S81vdNHli
	dC3svaD/MS6W0hmj6iqn4Sb+fxSB2eFnZdm5QT6CAMdefcHmvAQpfFoA45eBWThwizpkXcmjp1n
	Az+jjyRI=
X-Gm-Gg: ASbGncv2YtRNwVly6raCwc3ZOAhLk8tQu4+c93X6/AQB+6C8Htcom0lwF39d0WKMNqp
	BJ2gNziFYMrBFRtxFiyhRqoplGlOrwvrLeXCCt1WSwYzuzgDNRMvzmEQnjy7yEl/N2b4QSv3fYp
	a+eBQiBdu+kRChaVPc+HPteFwG7c2Z64+OTBb6E7N1VCGvlwjp7K52k+eWGa3YeRSVvli3EEzb3
	ZxA3apJvphwp+x53pOvwqVxr4IOcuoH1lgJ7MzzMvSXM6Py5p806Vf6uVi5aQWx17oo2gLm9ufv
	CRnfuZodqdRvL/iYgidryg7ixScCn/qswYyn6st1j7ZOSOooU2cbZoSONd0GAYNaJV2Trme0YmF
	P2Kai5QXLNUs0X9SdmyWlT1My7ktBRGapx8Sm2dYfj0G65Hqe5WJt3F/l2erKr7irSavgwNvy9x
	/hSpTnNGOblRuMAZnhxGXqLtpAoRCmZ34yW0jSsSe90Nd1dlbztxorTZt54w33
X-Google-Smtp-Source: AGHT+IHDhFBWps5nXsX6iSFDEy4zOtxX6kXwaluTn2woc2nZ35shItBAhfFhvNm0rtf4rgLXzP8Zcw==
X-Received: by 2002:a17:907:86a3:b0:b73:54b6:f892 with SMTP id a640c23a62f3a-b79dbe5afc3mr1142155166b.4.1764955452452;
        Fri, 05 Dec 2025 09:24:12 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f449ba82sm418010866b.22.2025.12.05.09.24.10
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:24:10 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4162364a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:24:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/M2+YvPXCs8hTge7By277UEGNVO6Elks3WBaPMBnBpE8CPfKrnE+k+pzm/3EHgv4MljmvcRGic9SB5FU1mobE0Cg=@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:640:e943:fbbf with SMTP id
 4fb4d7f45d1cf-6479c496412mr9886451a12.11.1764955450397; Fri, 05 Dec 2025
 09:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171446.2814872-1-jremus@linux.ibm.com> <20251205171446.2814872-4-jremus@linux.ibm.com>
In-Reply-To: <20251205171446.2814872-4-jremus@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 09:23:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
X-Gm-Features: AQt7F2qyEU-sRiqYQ9Tvu5NNk8tmioQu9za2N5evR27IqNXhvz_m-7r0eTXQy38
Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/15] x86/unwind_user: Guard unwind_user_word_size()
 by UNWIND_USER
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

 Random nit...

On Fri, 5 Dec 2025 at 09:15, Jens Remus <jremus@linux.ibm.com> wrote:
>
> +static inline int unwind_user_word_size(struct pt_regs *regs)
> +{
> +       /* We can't unwind VM86 stacks */
> +       if (regs->flags & X86_VM_MASK)
> +               return 0;
> +#ifdef CONFIG_X86_64
> +       if (!user_64bit_mode(regs))
> +               return sizeof(int);
> +#endif
> +       return sizeof(long);
> +}

I realize you just moved this around, but since I see it in the patch,
the #ifdef annoys me.

That user_64bit_mode() should work equally well on 32-bit, and this
can be written as

        return user_64bit_mode(regs) ? 8 : 4;

which avoids the #ifdef, and makes a lot more sense ("sizeof(long)"
together with "user_64bit_mode()"? It's literally testing 32 vs 64
bitness, not "int vs long").

              Linus
