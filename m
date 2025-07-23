Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DE215F4B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302735; cv=none; b=PDJ0OdXAbnfDkm9+8eiQAvUuEUBDaqTm9O0qXvMeSSrHmEpbILmaZYx33ZGi8OKe+LL7CxDdz/JQsI7C9XnvW8FwBIEl8GPzcnOJs2S9nXyG48E1Af9at70vjMlRbj6RXGGY5gvmqXdVd0+ZSP/YsK/gQglCUn09c7iM25L1lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302735; c=relaxed/simple;
	bh=GTXQscJU4LPgrl6bU/T+prkMwqEg/02bZaCUdUkEXXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQsL7bB6/pYup2sn4MOk8pj4nxJSZILOugxUqu4ID3ipH2fJhd26e4TSjTYYzE5RUUuoFbRw4UERKftwrUad0t7dFl5rVsNYFHFSU7H5EDKXbiWmf9sWBw6SQAVEfS462evy4h3F78cbnIlhVQzoEKjBJbVg9++MhBU5XqJcuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=agOw8FS3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="agOw8FS3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so41438666b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753302732; x=1753907532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tW3QBWuerrQdiuDXr9GW4Ls+mtrfwnWITMUravp8ZU=;
        b=agOw8FS3MFe0VihildgV8MBzCpyjHlJOM5mxuK3RJfIWFpk5JqVbDhB4AoZ2VX5s5v
         Hb2MWXdtgcQvO8r8kLzpVro7u4kIeo9WQYg9y9pVwlk2U0F6ZRNeWlRPi0PWTcFW89ks
         r80DjOx82i7hRK9CYptH0WyU+7n7sq9HRaYY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302732; x=1753907532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tW3QBWuerrQdiuDXr9GW4Ls+mtrfwnWITMUravp8ZU=;
        b=B0vwAbOI8cJd+v3OfoaMWyWfVFzcwFkwzeCY/imQxZxkFWKudw6sY/eISGQJkLih/M
         JuCTLczoFtnQczLUg2wzvV3PJL/GGX+qIcnZ37Y3YicxfGqwyGwF+G3ni22g7kzV09sk
         cmfbmcrPHjY7CIA8BrYLz/gM0vLCwZ/6I1yM3+ZQBZbrAtMyxWwdvlZH3GImDSVSwzDA
         tPIczvEtfj2qRoWmBHYd3K0Uo+ISU3BYbPLqGFSFvGBNwvBY2tqUn16vGHV2wjPMASuj
         LaFJbK6GEoJeBHY55D5m9TQQ8yLUIGcWrbHkJ3PL1XCrQXMteZVaVAjRlvEd6fZN+HYL
         1Vjg==
X-Forwarded-Encrypted: i=1; AJvYcCW16rbxGWBPJUf5r10oDWNxoaNmR34CvnFZrqcVfE01Fzz0QjG05rgHs2OKxBuzfziekREpKIlLkIa9lHJNXy8dBFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrMRw1p0/qlMe+6h/QJDIM1MrJotKMk47WIoyFme9enRI4rwz
	ARnQ0uSPiwfpF9kxVsf+Db+mFSVN89IU3cZZgbbyO7i0RHipipeMUyCiSFgmMX+Mfh9AgViShhU
	zbupHKQg=
X-Gm-Gg: ASbGncvfCMei19g2B78JJLWjP7OIYYUtaj1oJa0nYFmsXP6bTYRDkR2JGqIW130GfUP
	1xqyBNtDixtBLrudhCYhMR5bGdXTy7DfDdS3h5VRHdmUdT2s7Yv65NR1N0lXFNTWL9YxcW2ylHS
	4zEmE4RpRVNwcgPbsQ8pJwlXNctg/HF3za0YML+E1MdR2QDRTVn+gtMAzWiBxCO6k/6ABH0HouK
	9S+g1bT0Gds2u6IVzKqb5xw9zh2YT2V/ee2gJU0vFTkgXl6Gd6odXTUCSP6M1wsUqBO2W2XkTHE
	sCqodtCJ+UanquMBBs/yIYTiHWKiGi7K+QFRubHUXXjfM325CC1GgNYaVPmDXGjQuj31qvDPGQy
	wpBacEHgLmrfgIbBsHRiTJoIgi9X4Um3fGqEtXB1KeJeirAr/G1j1r2B4DMuW/tRc7J2XAe3s
X-Google-Smtp-Source: AGHT+IFWz5urI7re3bl65QLMe4Me/aUBZS3X4524Ax+vWuG/GPokw3OEVNwELmfmle1pUjcqoYWodA==
X-Received: by 2002:a17:907:1c8d:b0:ad5:a121:6ebc with SMTP id a640c23a62f3a-af2f32ef18dmr392047866b.0.1753302731783;
        Wed, 23 Jul 2025 13:32:11 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44d736sm2892866b.92.2025.07.23.13.32.09
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 13:32:09 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so594301a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtTORebIQ6l1oV1IDXZy3f8PwTlqvRiDwyVLYa/DvvYGw69BCV5CqpAyENsBVQrWRbr1n7YjUv0OVbhClTRNVzBYk=@vger.kernel.org
X-Received: by 2002:a05:6402:2682:b0:60c:4667:b29e with SMTP id
 4fb4d7f45d1cf-6149b5ada7fmr3885377a12.31.1753302729207; Wed, 23 Jul 2025
 13:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723194141.617125835@kernel.org> <20250723194211.768813368@kernel.org>
In-Reply-To: <20250723194211.768813368@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 13:31:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com>
X-Gm-Features: Ac12FXwxyPrv8gGTCI226Aa0lB-U1g53Om9xi3Ol5z0sTqQ_za5i5iEvuIY4KFk
Message-ID: <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tracing: sorttable: Add a tracepoint verification
 check at build time
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 12:42, Steven Rostedt <rostedt@kernel.org> wrote:
>
>  kernel/trace/Kconfig              |  19 +++

Annoying "one step forward, two steps back" change.

You literally sent a "remove one pointless Kconfig option" patch
within ten minutes of sending out this "add two pointless Kconfig
options" patch.

Because as long as it's a build-time thing, please just fix the
problems it points out, and it should have no real cost to being
enabled.

We don't want to ask people questions that don't matter.

Of course, because you *used* to check this at run-time, you put the
new "__tracepoint_check" table in a section that is actually loaded
into memory, and it appears to be still there.

Just put it in the discard section, the same way we have (for example)
the export_symbols table that we also check at build-time without
actually ever making it part of the kernel.

                 Linus
