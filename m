Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E628A417;
	Wed,  7 May 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626364; cv=none; b=Dj4e3Ayyq+30FTY0ztvaEsP+AC86Mv7h8MLkxFJMKZgQMg4aZSOwN+cXmy84OmhF+dlatOa15MW4XAyAANNQU9k7ikP4rFCu+toROCwQ8zj/0uyDIIVKV31eOqhsIBY70dvhMpWqqWOFEGkfdcTbxtGZ/r/kH/srtgO1D91SboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626364; c=relaxed/simple;
	bh=qpPpjPkDozcy5jgX8RhIBQhSELSohfhD5jq4EfrO1ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3j7tRY1JfaBA0JLFCLya8ks59ENdEYl3mLJuMAjQ3j/3DXLkmzCFQYjF9JlJGQ67sgN14WQumhgtl7ZQRgqf3evZzklHx/YYywMN4waMsif40nJfzPGd4lxcpV09Y5ErioMJuZOmqVzPH/xX3HflWOV0A3m4Q8wqtkFoC2RW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4VJ+TdB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4VJ+TdB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30ac5cc0df4so520412a91.2;
        Wed, 07 May 2025 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626362; x=1747231162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRZE9bjBywYum8goRrvBjahJKDmj3sVBnK8ZO2q5NsE=;
        b=I4VJ+TdBMY/NTL2snmt8Yzh0lHPX/Nx0RGDMyjzBE1qY/Iu1y9pOfAaMNmCK3YiBcl
         YBPWWPNIGwoVwdq55wISPsb5NZ8/TJP8nrTVYzycQpu8rlDb434qBfmDyiwGXno2aS3c
         WT+G7DMHqUgl0ZRl0L/e6jk8oihkmOTKyTklqw2c3J0jtNWmBS9rcv48FQyH0u3EKGfz
         TdY8/3jF8XuPkH4DulitbLDPT+Awba5fWoEIQnNi+QYqO6EmmzLtxkUWvRNDNAiLjPJj
         qbYFy7wmPdkqrjszb7OCmCwcXId8FTNKsNrB123MfIRia1WAAgeQDYQcA06TjTk/bu8W
         aZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626362; x=1747231162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRZE9bjBywYum8goRrvBjahJKDmj3sVBnK8ZO2q5NsE=;
        b=t2m/y/9gR2zbIDMMP9qKMhOHB3ujnZIwfQUqQSyW1d6DBmQesFOpwHGkYHeF3Cy1UY
         0+sijqynkU4LOBZXUCh5EY3UIW0ePozDtWVnrVB0jGGopyadDacwCdOAJFVD+AC6xFRP
         kGwhtuPxykOwro0aVn06JaTrSDOvMfQyYT51AzSffFti2OLmKtdU8RLJrtJcM1nt4bTb
         6GmV8nJuaAfbCE5wzsRWfPxTx7LEx5LAeJxt+dMsTJlwAdxZ9BBY/YMZkpVD7mkdQ8UL
         JqJ11/rIac3FNFmFqM3KlQzNjZ9Vf69YQpXdqfrGOVivWYGfkVDTlHJqOzsKk4nXgv8o
         /Bag==
X-Forwarded-Encrypted: i=1; AJvYcCVJeL+TP8qDiNTVZfpX/ZtZ6UC5qTnhPKFiGkOlE2DKemT5qeIyTpRrLR+Ua9GC/ZNtQ9y931Iahbb59CQ6B3lREwFw@vger.kernel.org, AJvYcCWQ7bZZvIDs+8f7/M4paPKQInhLN8f3i5876wYekkORLPqj7u6s8m9DuGRzvx6mtDBNviRYjabKu3ufJC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2syKjAtmMgyRO0ozsFJmwRyEJW18QrbIe72JrYsKStWteAYk
	iamc+Nl6yBdrTnWnYPTS2puCArH6wri291jBpuhTdlWXnOKARXXQFZFCddoNp4IpkcaVfK1B/f6
	Mx16Jyz5utNT2SY4m3YM7wi7hWiU=
X-Gm-Gg: ASbGnctiWiveyMWOQT1j4bNrDZuG7+UmymbOqZhK8NKx5lvviw5mqBKeGFTO9Siy1+f
	GyvBiDp+RVCd+T0+x/tQ49dUv2hTfWM6ECT5DDoeKqkInxg2f/WFvoABKOhSTIfah3/oI7/J+Fl
	HtrEuOeMHOnG51Nt+ct+98
X-Google-Smtp-Source: AGHT+IGKPvWebpmE6RbC+GCCzm93i17O7KloPl1bWsraU80bnvn2iERMqlrbvMhRQCaMRtNtOzlAbl9ZlQ6V/HW7llM=
X-Received: by 2002:a17:90b:3e89:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-30aac1ac148mr4769028a91.19.1746626361548; Wed, 07 May 2025
 06:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180838.42877-1-andybnac@gmail.com> <871ptz940f.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <871ptz940f.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 7 May 2025 21:58:00 +0800
X-Gm-Features: ATxdqUE83Y2DtfAddxJYScpLl8V6kg0oQXzg1sjF6H1Mk9WOUeQFVVN5vXTUb48
Message-ID: <CAFTtA3M86-iL8zARtoGwcX5yAi0LOC0tzcocVwaKLdnyGSAxJw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] riscv: ftrace: support fastcc in Clang for WITH_ARGS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, 
	palmer@dabbelt.com, Steven Rostedt <rostedt@goodmis.org>, Andy Chiu <andy.chiu@sifive.com>, 
	Evgenii Shatokhin <e.shatokhin@yadro.com>, Nathan Chancellor <nathan@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
	paul.walmsley@sifive.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:05=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> (Trimming the Cc:-list a bit)
>
> Hi Andy!
>
> Andy Chiu <andybnac@gmail.com> writes:
>
> > From: Andy Chiu <andy.chiu@sifive.com>
> ...
>
> (Oh, if you send another revision, please add a cover, so it's easier to
> comment around the full series.)

I am so sorry about this! I wrote a cover letter but apparently I
didn't send it. I am attaching the original cover letter below. Please
let me know if there is any better way to address this trouble.

>
> Thanks a lot for doing the lion part of this series, Andy! With this in
> place, *finally* stop machine way of text patching is past us, and we
> can move RISC-V out from the 20th century. ;-)
>
> I applied your series, and Steven's series [1] to [2], and ran that on
> QEMU (riscv64, ~RVA23), and on Milk-V Jupiter (Spacemit K1) with:
>  * CONFIG_FTRACE_STARTUP_TEST
>  * ftrace kselftest
>
> No visible regressions, and now the ftrace kselftest can actually
> complete! For the series:
>
> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> [1] https://lore.kernel.org/all/20250409151549.788068911@goodmis.org/
> [2] commit 3b07108ada81 ("Merge tag 'linux_kselftest-fixes-6.15-rc2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest")
>
>
> Bj=C3=B6rn

This series makes atomic code patching in ftrace possible and eliminates
the need of the stop_machine dance. The major difference of this version
is that we merge the CALL_OPS support from Puranjay [1] and make direct
calls available for practical uses such as BPF. Thanks for the time
reviewing the series and suggestions, we hope this version gets a step
closer to happening in the upstream.

Please reference the link to v3 below for more introductory view of the
implementation

Added patch: 2, 4, 10, 11, 12
Modified patch: 5, 6
Unchanged patch: 1, 3, 7, 8, 9
(1, 8 has commit msg modified)

Special thanks to Bj=C3=B6rn for his efforts on testing and guiding the
series!

[1]: https://lore.kernel.org/lkml/20240306165904.108141-1-puranjay12@gmail.=
com/

Changes in v4:
- Rebase on top of v6.15-rc1
- Add a fix tag and R-b from Bj=C3=B6rn (1)
- Remove unused code enclosed by !WITH_ARG and unused macros (2, 5)
- Export ftrace_sync_ipi for its use in riscv (3, 4)
- Fix a bug with kprobe after probing at the start of symbol is allowed,
  by correcting ftrace_call_adjust (5, 11)
- Synchronize update of ftrace destination and the data passed to it
  (5)
- Include Puranjay's patch for CALL_OPS (10)
- Support direct calls based on CALL_OPS (11)
- Add a documentation that breifly explain CMODX for dynamic ftrace (12)
- Link to v3: https://lore.kernel.org/r/20241127172908.17149-1-andybnac@gma=
il.com

Changes in v3:
- Add a fix tag for patch 1
- Add a data fence before sending out remote fence.i (6)
- Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace-v4-=
v2-0-1e5f4cb1f049@sifive.com/

Changes in v2:
- Drop patch 1 as it is merged through fixes.
- Drop patch 2, which converts kernel_text_address into notrace. As
  users can prevent tracing it by configuring the tracefs.
- Use a more generic way in kconfig to align functions.
- Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v4-v1=
-0-1a538e12c01e@sifive.com

Andy Chiu (11):
  riscv: ftrace: support fastcc in Clang for WITH_ARGS
  riscv: ftrace factor out code defined by !WITH_ARG
  riscv: ftrace: align patchable functions to 4 Byte boundary
  kernel: ftrace: export ftrace_sync_ipi
  riscv: ftrace: prepare ftrace for atomic code patching
  riscv: ftrace: do not use stop_machine to update code
  riscv: vector: Support calling schedule() for preemptible Vector
  riscv: add a data fence for CMODX in the kernel mode
  riscv: ftrace: support PREEMPT
  riscv: ftrace: support direct call using call_ops
  riscv: Documentation: add a description about dynamic ftrace

Puranjay Mohan (1):
  riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS

 Documentation/arch/riscv/cmodx.rst |  46 +++++-
 arch/riscv/Kconfig                 |   8 +-
 arch/riscv/Makefile                |   4 +-
 arch/riscv/include/asm/ftrace.h    |  62 ++++----
 arch/riscv/include/asm/processor.h |   5 +
 arch/riscv/include/asm/vector.h    |  22 ++-
 arch/riscv/kernel/asm-offsets.c    |  13 ++
 arch/riscv/kernel/ftrace.c         | 241 +++++++++++++++--------------
 arch/riscv/kernel/mcount-dyn.S     | 117 ++++++++------
 arch/riscv/mm/cacheflush.c         |  15 +-
 include/linux/ftrace.h             |   1 +
 kernel/trace/ftrace.c              |   2 +-
 12 files changed, 327 insertions(+), 209 deletions(-)

--
2.39.3 (Apple Git-145)
