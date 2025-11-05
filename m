Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC422B8C5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309255; cv=none; b=tsNMNPH8CYX04Yvx7lSP+jLmI6TAt8zhL8bO9BhPWc3wLUUfsjKQzxKtn7snqkFbLqhuUWxxrfRrlVh/AnndzsqRsjc4/EW9/yertRLqC+vreFfTpaDdoWKFCwzr5ROLfLa58Zt4sZUbQN3NRALIXI1cpG7AoQ9gU+gjBFIuAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309255; c=relaxed/simple;
	bh=d6l6tVF+v3U1LUHA0g9+cdbVvSINZoTbFW1zscKaebc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f//bTwvk/stgJdwNRugnDQ3YHFmlwUJlerhN/f3ek1a3Fiiv6AM66IKdU+2oYC1KEHS1GWYXJGUxGTQLzUKmj9Wh7F5HC0l8rlQnnFa9qhRAGPXMuCK5W1XTiCAmBvgbobCdYSnCy50APDDMA/brQBGnZLzp3iEPIQxGGNwsvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEVRAVwe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEVRAVwe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42421b1514fso3611660f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762309253; x=1762914053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NuKJL9csLaw12N6dK7YM5v1m0+h0XQOxVo2kPLl2ec=;
        b=XEVRAVwe2euyQF7G/9x6EAC84nUAyuQ+fv0pr5omFTr5kLYT6cS/a0LhHc7IQ34uR2
         reDV1tESysD0vFcH+eMQUF2K5OBMcABzH049qi8ofUJkmHtipW0sG1Sumu3eXd+0walJ
         MSqdZrc1Km++KJ4NRwVNtZur31ILtxt7N/q21xmzDA58y0HsphGVM7rtr/TEgLB1CFPH
         tncbwUb48GqW3uMkYFOdgvMX/Cpij5bF2x+p00J6ywXfuOX3EZLsEhT6BapXTc6N/lsq
         NBjB5yUKLnR7rDRnCcESxKm8s8mRbufufOHQcZ7kxPaBCOqsd1cd2aeodNR+2wO2TI3Z
         bLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762309253; x=1762914053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NuKJL9csLaw12N6dK7YM5v1m0+h0XQOxVo2kPLl2ec=;
        b=jdMaTBraYclNMynYC3gXm1YbBtfNxSnFsI9m2MowDLJN8aNzWJoIducLgV+y/nckS7
         WBA97RIA9ZnB9LHDMQZWJqPY60TpNFf1wgg9Kxt3elVGHi1JLcsrANpE6FwQvX7x1DL1
         Ig+Tkjp40a0FY7g8bWykxQyvm9/DIWgyU0nJl90DeLTdH2B96B6IgkQy6fdf92GPZNiR
         eHJFiAl5hhtDj2EEYpL9cKe3Jcpvicf7+9m08cGvThV8/stH4Oan5WwxeospsJv49xtF
         1AbIyGy3XceGIoNYRYt8q6YNKDy7NCBesxrjaXgOmi54KNqtfXXsyYmpNAr7k6gcCL6c
         n6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWot+39OxX5Ibx67QoXFOdcgBsHdrIPX0xqw3gwaF+rmWC/XXZ832HuRb9hJuEEX572PBSmntDd4de7+1pikqUWGdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sUpz+XaZdlI/UoGTdURZIqDgeZ4WPzRDdZdws7Cp7bis13s6
	K5VJjEIuWlA98HzANInSyo8UWfX5p7KvWpkXz5tOHTY2gwI1D/Ob7xEzoNSKaevNrnAgLWk84T6
	/S55J3cucgyL7+1dvSc0f9EJIE1g+ySY=
X-Gm-Gg: ASbGncv8JuKygfkteSS6POGAIWceTe9eNzzKWsBkAMQRpjDTAaazJBw44awfNuAZu5v
	UR5yGQsKG3fMygIafYXg6YvrKrrG4u8yHvw1cKS7r3i61XRJv8Q/q115dB8kkIq+em0bD21HS9D
	YM+jjGhtSpOV6z6qBYxo7krvfNc4sAtOsb77U+9pnb75UCWYKZK2RzvAoH/00XYQMElSAU5PJEG
	pNsbAOkPSygl7EUqa9o6Gu54AKyy/esSnrLV+sgkFkJDkEfmwyiwmunQVEhXgKGoyqeJ9uysRGE
	5nAbi6Csel2nX9DaJw==
X-Google-Smtp-Source: AGHT+IFrCx0K1L2HZkJ5pnD1XQUKG6I7hM1iTGY2qycDhc55Y4PzeSyl1wwsRSjMpqpwA0n8AddbO+fqahmtLQNjXj0=
X-Received: by 2002:a05:6000:2711:b0:429:8d50:8d2 with SMTP id
 ffacd0b85a97d-429e32df73bmr548726f8f.6.1762309252449; Tue, 04 Nov 2025
 18:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104215405.168643-1-jolsa@kernel.org>
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 18:20:41 -0800
X-Gm-Features: AWmQ_bmi4UR0I02UKHa0SHf9_b1Ol0r0yaOdgoZOC7E5qYdtKd4zLVKxJ9ne1zs
Message-ID: <CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:54=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> sending fix for ORC stack unwind issue reported in here [1], where
> the ORC unwinder won't go pass the return_to_handler function and
> we get no stacktrace.
>
> Sending fix for that together with unrelated stacktrace fix (patch 1),
> so the attached test can work properly.
>
> It's based on:
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>   probes/for-next
>
> v1: https://lore.kernel.org/bpf/20251027131354.1984006-1-jolsa@kernel.org=
/
> v2: https://lore.kernel.org/bpf/20251103220924.36371-3-jolsa@kernel.org/
>
> v3 changes:
> - fix assert condition in test
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
> ---
> Jiri Olsa (4):
>       Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
>       x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
>       selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_m=
ulti
>       selftests/bpf: Add stacktrace ips test for raw_tp
>
>  arch/x86/events/core.c                                  |  10 +++----
>  arch/x86/include/asm/ftrace.h                           |   5 ++++
>  arch/x86/kernel/ftrace_64.S                             |   8 +++++-
>  include/linux/ftrace.h                                  |  10 ++++++-
>  tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 150 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  49 ++++++++++=
+++++++++++++++++++++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    |  26 ++++++++++=
+++++++
>  7 files changed, 251 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

Steven, Peter,

How should we route this?

If you take it into your tree, please send it to Linus right away,
so we can pull it into bpf/bpf-next trees.
The conflicts in selftests/bpf in the last merge window
were annoying. I don't want to see a repeat.
