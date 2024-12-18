Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0B3594D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485970; cv=none; b=djQDkPNloB2jhLDZkZ+DlJHTShPKtwKLhUUA9ZXFgfbPNFCUl/6jTdY3scLBBcxBGKqVmUwCH1/h57j2RVPbadtUelkgHJRaPOVRzax15otj7t3dW2xxA9rVnghSk8Jeod+/2RBFQiTr75rcoIR6/7S/lsC5WM7WenGSu5+hzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485970; c=relaxed/simple;
	bh=NBXngBXuXUS1CuveS8CMCH5HMn+Pd3wVJYjajc/z6d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3OLjotfryviLKZwFtJBFOsCz+XXJddyXWdw35J97LRgsj5GnPFZjug+2pLUrJy3WfjRcS9O4F7ubjb9leucXCokeAe1Gb9vSORo/W4jrPNHxNl+qov42mhh7e2v+YvMn+wZZT0TH1ezc+00D3AzSXwV7YVCWus2wq+dXCiNph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QBcfiSKy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QBcfiSKy"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so8193944a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485966; x=1735090766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=QBcfiSKyIwQvTDJOSPx/j3TREN9zPHCPRzXN++/miIo7VTMNO9P+pfANZ6XsKSxpRT
         1xtBXJQ3xZhbAsmf+iJ+T1j4IHF7wiB3VDfzmwyi8F3H6CeukQ4zul5FSVg49JwwWRbc
         OTBEXx94zwfAatxYFsputJUWu08gzkK0bJe4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485966; x=1735090766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=r1SQPWnHw5hO69ZVfFO9CHQQhWrZp1qHgI0se/IYWZYfySDmW/jQ+2RBLVtbSzh46R
         71fwRx+oPCQkebTolAW3u5w+3zUP2FJ9TvGFt9RRPegSz5eT66vA2UjCovOJXK4HJqpr
         R6CCNEtoKDH4kqBHZkkXnggDQWsPjuwAKZIwWmxoSRITAiPMz5hJJli0L1vjsZQLzgFQ
         y8gIbFbXRDbVC0p6nKXY8PehGNuNl1ENPG+W9LQ2/lnvDw0d/SSB0H45Mkmuc0HXArLC
         9w4YwvpLo9l1CyDBW8B4s9fdfMu9czovO/W5Snb9SatN1R3Tenvy6JSm5k4s17qL2cGT
         lshw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qd4peZRCE2IkdOPyJQ+u/g+n91RM8YeYQ4Fz6RI3UIYqpeBLp86nNP+vAvcouL5MFKkVH9uB+51mAl/4U3WLbdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfPwQfb0OY5br+5g0/VkDrvWgq+jlfi0rykSv5s/TAfxLnxaj
	UzrOqFcNaQzbGbm1BguZq9t4QbMtjYPcJp4FmcqNQo8j5wV01RW8Dh34uK7bR4t2zfCL/Yktnen
	MXKk=
X-Gm-Gg: ASbGncuTDP7ZU93UVU6cM9nHTVOOcxd3Wf/G2sdwraSIMmqtQTKkNY46jZXy7LjVk9f
	9+3dv3GT7U3SDwP1MN0HN1INKh5AVEA8KLaJnATTBKRfWA8t9+FOb7Fk/0G22lHbsycfxFR6Aa9
	GN8CDE6xdbWoVbM+stugOPZvi1udY4DPHLQwTps++/jsLxyxtU/03sDtUm1gUfyul/AEBNAj4vT
	is9po94RZ6XYDogL5S2lwR3ZDLMuDOkCKmKKhYCC/Be7jqRBy2FbMgLahDnI0cV/Ce8Nz41Ff2M
	wRp/QQrN1XaxnLok4wNAQVmz2ectt1c=
X-Google-Smtp-Source: AGHT+IFZeM4OstopU2TW/BcxXAS1L5NJK7yLGbZ+2N6JEGx6hUdk/c6UM+MTudGfaVvi16Th35BNnQ==
X-Received: by 2002:a05:6402:354b:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5d7ee406095mr938957a12.23.1734485966590;
        Tue, 17 Dec 2024 17:39:26 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab523esm5067594a12.11.2024.12.17.17.39.23
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:39:24 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e44654ae3so919747366b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhIKVh7qFnJ25eiPLUW/o3SPEeMbygNZr+US3bYMz46Xa2gut6+qVkTXoq27FinX5gs+6xshNfwASr9fximKEKqdg=@vger.kernel.org
X-Received: by 2002:a17:906:3119:b0:aa6:894c:84b7 with SMTP id
 a640c23a62f3a-aabf470d31dmr63561966b.12.1734485963656; Tue, 17 Dec 2024
 17:39:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com> <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
In-Reply-To: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:39:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@google.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 17:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me go separate that part out and maybe people can point out where
> I've done something silly.

Ok, that part I had actually already locally separated out better than
some of my later patches in the series, so I sent it out as

  https://lore.kernel.org/all/20241218013620.1679088-1-torvalds@linux-foundation.org/

but I'm not guaranteeing it's right. Consider it a WIP thing, and only
a first step.

           Linus
