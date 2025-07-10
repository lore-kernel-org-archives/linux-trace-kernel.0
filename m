Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6D279DA0;
	Thu, 10 Jul 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163062; cv=none; b=KhLfAHnC297TGXQ2bN+OwcysNyWTtc5k4mMwhfn0l+1WOhglS20GtUK2Z+iZSAU5gpEr+qXLvzerGEJDjbYnNUt5zm5FHjQcdY3iWJNGz8zJE4EBsgK68B3+Cd+o+36M8oIeqXAsQlH/hh5e7mU07b0S3rbUntriSzDc0avTdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163062; c=relaxed/simple;
	bh=lFZcBY3URVFrvN1SU2OnNL6+oWxyKK5PS2R0CTUJbu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl928np0ar0UnMJTwU9tgKHW4NqK9tZYT4TPpw13Yt3//W84IpRLeZ1gi1qGGS9wOa4iYS9+DfRNQM3xSeV8malJRdbiseTLgAN9I1yX287/Kq/TWMYmPRZlqijjp6FXbkhWHWWdLWtXVScZChM0FRDs4jHKzin8+mH5g1QLkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmn4w510; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmn4w510"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so244399966b.1;
        Thu, 10 Jul 2025 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163057; x=1752767857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyFwto6duT8k2J6PKEM3Zq5e4wrdh9RzheYLqE65elg=;
        b=Cmn4w510/dOnHMjGxqxzKEEENYUfboPRoS24tVcSSxXI2RwMWAHh7w8+Y/FWmCeYIV
         yU/w8aw9enJkA2mQOtHGydLtNUe1+x+e1s4i4a4yo3jgzwu7Ngpawa5Es0v5NUS2RI0K
         VgXxvdccW2yNkR8UCGphmadRdfXkLs4bb9NAiD1oawBO7BP6+bN1mh6azNXxcxOeaU9v
         Mlmvw7lMWXsC7CisyMN/tWeEmYxIHUx9y4kKFMrQVL3UKKwipFp4hF+CCPTtsRNsHZCB
         Ah/kNOBMTT1HdG/uanE9YY5YZxCTAUtBK5e/2n3LzX0dhDOLENS+65L8CJ93MNAjzrJA
         3Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163057; x=1752767857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyFwto6duT8k2J6PKEM3Zq5e4wrdh9RzheYLqE65elg=;
        b=YQXZgQnj3H2CFwiAhhMHt4l5AWfrz7kYaRMSBjGOW/WDHmyXKZH357R+daLFCVhH5H
         4XeUmfq/lBltdrxlD5GBG7ZfpTQLDDKbyzvc5RI2B3DXBuYrzHiUKBVqKNqAkTMeHRQl
         DGlJ2lFXmcQWECldanJANW/QD805DSJy2UE3qu4zB7UfneVk2KToz2alGNsXQmMdW7Yl
         XVLvM7KeWciKsq0JKAO7N0YicB9UvfbuTD3ITn0Kg8SmIiW4F/MKhyEWkgaAeTuqAwa5
         UYnSWuB7c6dBWJRiZaHgsho2gpwP/glstFB8R5zwuf6xiah7/CPUhKJ5ZL/LFfAOxIOx
         2uog==
X-Forwarded-Encrypted: i=1; AJvYcCVnAjIMK0Bv11rWROXB45wO0o3y3iIGOhxjU2jqYfUsCdVRwQNtjvf5lBwXQuI04yPGmizYICkMKcYQ/R51MgwqUY4D@vger.kernel.org, AJvYcCXvCkcH/yEZA7R6KI4N5FiuGtV9/NYLDApfFBWN8Y5oSP0svm83+tLv6bAV2wfVk3QW827CX/AZgEw/sKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqqlkHFMRkGfJO3mvvBC2EyhRcOiXr7BhXRoLT+fjrkdAcDAW
	UuIl10JQ0e2nMNXidwYvuthux1VlNH3A62maK9dn4QBtIm/bg2Mw2DgoWGRF/SOMp13FnSplmLR
	DoUyC8JTTtzvwkX8zGaUYrSveRreH62Q=
X-Gm-Gg: ASbGncvtfBP8Hw/+Hw6iah79vqofR5fZz3dzJs8/aClFiE0ytTu3aBBsppnR/uT1QlS
	ENTK1zHnxpS0aAyOKss2YumSWOM7ZJupWPSNXURvP3wUQnQZyVvKVMLaC03wr2F1HRAF68Q6/x/
	2BtcKCPJ+OCMuFvlGWOx7Ij7MGDC/ViAR/lJoPJvZZ8UY=
X-Google-Smtp-Source: AGHT+IFDjIdZXlAQN0o9gcQft8bdsUVAZWKdpbA0Umxqt7nH2dtNl+9/RBdEY1alElz7unAk1Y4PgfpvrjfUKZtYKls=
X-Received: by 2002:a17:907:7f24:b0:ae3:bb0a:1ce9 with SMTP id
 a640c23a62f3a-ae6e23472c0mr495513166b.12.1752163056970; Thu, 10 Jul 2025
 08:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aG3A8Jirg+TxNza/@rli9-mobl> <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
 <CAKxVwge4=cagaVDesKWe0BE88U0YmNn5LLDJvJG=F7EEP2=-LQ@mail.gmail.com> <7204f633-5b35-41ce-b847-7dfbaedbac47@ghiti.fr>
In-Reply-To: <7204f633-5b35-41ce-b847-7dfbaedbac47@ghiti.fr>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Thu, 10 Jul 2025 23:56:59 +0800
X-Gm-Features: Ac12FXwpHGHrqNJMYOCJrRAIJPU1S5sbSrf6kJb2PGDBA5iQ-Twvb8GXnLf4awU
Message-ID: <CAKxVwgdoK6wSt-1LNZ8Tn3MPaETR58RThbcdydijrKPbfpE68g@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE selection
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: kernel test robot <lkp@intel.com>, Linux RISCV <linux-riscv@lists.infradead.org>, 
	oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alex,

I found where the error is, but there's a problem here:

config PORTABLE
  bool
  default !NONPORTABLE
  select EFI
  select MMU
  select OF

select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU &&
(CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)

Because HAVE_DYNAMIC_FTRACE depends on the MMU=E2=80=94of course, it's
reasonable for DYNAMIC_FTRACE to depend on the MMU=E2=80=94*but since
NONPORTABLE is enabled by default, this causes PORTABLE to default to
n, thereby preventing the MMU from being enabled*. So, should I change
NONPORTABLE to default to n?

Thanks,

Alex

Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8810=E6=97=A5=
=E5=91=A8=E5=9B=9B 22:33=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 7/10/25 14:34, Miao Chen wrote:
> > Hello Alex,
> >
> > Sure, I'll checkout it. Btw, this is my first commit, so can u tell
> > how to reproduce failed case? Using the reproduce and .config.gz gived
> > by build-bot?
>
>
> Yes exactly!
>
>
> >
> > Thanks,
> >
> > Chen Miao
> >
> > Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:53=E5=86=99=E9=81=93=EF=BC=9A
> >> Hi ChenMiao,
> >>
> >> On 7/9/25 03:08, kernel test robot wrote:
> >>> Hi ChenMiao,
> >>>
> >>> kernel test robot noticed the following build errors:
> >>>
> >>> [auto build test ERROR on fda589c286040d9ba2d72a0eaf0a13945fc48026]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/ChenMiao/riscv=
-ftrace-Fix-the-logic-issue-in-DYNAMIC_FTRACE-selection/20250706-231907
> >>> base:   fda589c286040d9ba2d72a0eaf0a13945fc48026
> >>> patch link:    https://lore.kernel.org/r/20250706151830.25091-1-chenm=
iao.ku%40gmail.com
> >>> patch subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAM=
IC_FTRACE selection
> >>> :::::: branch date: 2 days ago
> >>> :::::: commit date: 2 days ago
> >>> config: riscv-randconfig-r112-20250708 (attached as .config)
> >>> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project =
cd708029e0b2869e80abe31ddb175f7c35361f90)
> >>> reproduce: (attached as reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090650.YGY56SIA=
-lkp@intel.com/
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>>> <instantiation>:1:14: error: operand must be a symbol with %lo/%pcr=
el_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >>>      addi sp, sp, -FREGS_SIZE_ON_STACK
> >>>                   ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>>> <instantiation>:2:18: error: unexpected token
> >>>       sw t0, FREGS_EPC(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:3:17: error: unexpected token
> >>>       sw x1, FREGS_RA(sp)
> >>>                      ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:7:17: error: unexpected token
> >>>       sw x6, FREGS_T1(sp)
> >>>                      ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:9:17: error: unexpected token
> >>>       sw x7, FREGS_T2(sp)
> >>>                      ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:10:18: error: unexpected token
> >>>       sw x28, FREGS_T3(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:11:18: error: unexpected token
> >>>       sw x29, FREGS_T4(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:12:18: error: unexpected token
> >>>       sw x30, FREGS_T5(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:13:18: error: unexpected token
> >>>       sw x31, FREGS_T6(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:16:18: error: unexpected token
> >>>       sw x10, FREGS_A0(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:17:18: error: unexpected token
> >>>       sw x11, FREGS_A1(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:18:18: error: unexpected token
> >>>       sw x12, FREGS_A2(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:19:18: error: unexpected token
> >>>       sw x13, FREGS_A3(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:20:18: error: unexpected token
> >>>       sw x14, FREGS_A4(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:21:18: error: unexpected token
> >>>       sw x15, FREGS_A5(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:22:18: error: unexpected token
> >>>       sw x16, FREGS_A6(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:23:18: error: unexpected token
> >>>       sw x17, FREGS_A7(sp)
> >>>                       ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>       ^
> >>>      <instantiation>:25:15: error: operand must be a symbol with %lo/=
%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >>>       addi a0, a0, FREGS_SIZE_ON_STACK
> >>>                    ^
> >>>      arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro insta=
ntiation
> >>>       SAVE_ABI_REGS
> >>>
> >>> Kconfig warnings: (for reference only)
> >>>      WARNING: unmet direct dependencies detected for DYNAMIC_FTRACE
> >>>      Depends on [n]: FTRACE [=3Dy] && FUNCTION_TRACER [=3Dy] && HAVE_=
DYNAMIC_FTRACE [=3Dn]
> >>>      Selected by [y]:
> >>>      - RISCV [=3Dy] && FUNCTION_TRACER [=3Dy]
> >> To avoid that, we should check HAVE_DYNAMIC_FTRACE too:
> >>
> >> select DYNAMIC_FTRACE if FUNCTION_TRACER && HAVE_DYNAMIC_FTRACE
> >>
> >> That fixes the build error for me. Can you send a v3 with this change?
> >>
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
