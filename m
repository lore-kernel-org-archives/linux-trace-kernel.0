Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE7223DF1;
	Thu, 10 Jul 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150927; cv=none; b=eC5frsC6VjqDJ8huGt47BmesbWr6y+hGPpNlzg9tNrq+RHMF1dM+TtskaBLmBKR0lTny0Au5umhptliOpnjpTK7p07nZzyrbaYhD2qnlksfxvzHsjv4QCzzsfZiPf8BKl1Uz4kvaZYdOWLPFQqNcfG0FIMpif3fYOKc/Qznn7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150927; c=relaxed/simple;
	bh=LG/1ebUuJmEyed8LnLcwSnJXIFtKciPHzdZFR+vJsTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avxXMmeRN2k0RSs6qBjbKc19lLJV5574v3x3CwppQTVZ4jRP7wc/QxYBqlM2RTVY2FeALD1VuP+7iPL9aT/1AGQGCsEz5odatfnVsW/yEY10mrvI6bNyHGTFrt7VateMwDWDDA7FdS2K0dwTk4Xm78PqhDr/N+dJnltcBoVdH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O98CG3vv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O98CG3vv"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adfb562266cso144483766b.0;
        Thu, 10 Jul 2025 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752150922; x=1752755722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYqkWjUbgDgAMhDOaLlsy2feUWXhugPze0zXdTjzjHk=;
        b=O98CG3vvXClDmwUP/3JwklXrTezEtXX6mKQr18QQeeF50a578bPYL9Uprtn6MKDlL3
         jgxn+A5yxJ42IGEsezcSXBGxNkK1MkoBrzEe7lDxP+iZBoXPkBg6D7asA90UkRtKpWen
         dIajYdr5d3t6un/+2HOTzzJ+SNp/RTcEe6fpV7rAf+QXmBmm990ruJdPgMt1XPaINrDP
         b/B1Bhq6rNSz2EVqF7DG+JuNQI7SRgrUaR872h8ixFlFe4sny/7w9OUnyeKNYkGX1Btx
         GxBVybTP3Kodg2p0/Zk0aZV0lv+qxVhBtY6u+ni5aWxxX19/LZc9RQloKhd6wIIt4LpA
         yYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150922; x=1752755722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYqkWjUbgDgAMhDOaLlsy2feUWXhugPze0zXdTjzjHk=;
        b=SLQYGkq2sjRDuEyxNpt4LN8CAS7aIKy/JCnCfR8G+Mq6dudqW1aprYkHGBTGVBuhwu
         bDMsHkKGbqOmpB2w2eeKLgbJBKtD/EPeVmzjemgGa6YABes1rnNTXf4u6hKptVmjX2Gt
         KBIqvH3IaGBwp+fFCi2oM5n4oY4IuOgeszR6/McMDWtlxnVzcbzR61ugrG7k8xf9Iuwp
         Tks4hkhACXcmnQnwET+laQiPLFXRci/kfFB4qpZJIffIlEfQ0+b968cywI7k96ioJDRJ
         tnVYZ4BYHP5OfY8ToX0ROoqsgrK37NaMrbh3pu+KEc96tm8f3Z2piuFmF4dz53N9FoYv
         Ew+g==
X-Forwarded-Encrypted: i=1; AJvYcCULu+b2ndAyA2mgBLV1Nytxmwtgzq4apUfNVVEwVUjjX1fJfx2ePB+4+wOyOTUCjma7QVnWxwYTbVZS3EDYrEBiiltc@vger.kernel.org, AJvYcCUwohpTBOmUkpNxrrXz0NCaweq0FT+R8h6sBpruIHGlL85DR2/6qCdTHidvn7rM9fRSd3GwBtwiIYodX1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZF0Tw7zoEfNDklrf/83ZBz0WIE3Gwr29JK2AVI/IMoCnqij1
	sp5CjisEd7liItgioMugrMCJiDxOTzihR0dqUem8M7VF7n8TgPDbtJNtEdxwm6p9hz5vYOedsjQ
	wp6/tkaxM08IDtxxC2gSOiCbfG5ruifo=
X-Gm-Gg: ASbGncvlPM0YjAvhThRammbM7NN789+Mv9lr6KnEvcBLGMM7EkFe4PhUFbJo/PjI8L6
	2B+IsOVW8ltQvmor0M/70qx3Z2stIm/3yEYnRfw1T2Sl//IBnxAPQULesHovblnzlTF34X55D7s
	SUGy1kir0DHF8M2UAFytKy7ZgmLPzVA5oT0kzF5FIj5VM=
X-Google-Smtp-Source: AGHT+IHX3T7PV+QykAyNuRR2dadti9v2Ie7wRir36J2u9mQCz2nSMY967MJ2BBYwJz7saaIfCMnr2xs/Ohboe+eEpZM=
X-Received: by 2002:a17:906:6d96:b0:ae3:6cc8:e431 with SMTP id
 a640c23a62f3a-ae6cfbb7884mr544526266b.57.1752150922268; Thu, 10 Jul 2025
 05:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aG3A8Jirg+TxNza/@rli9-mobl> <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
In-Reply-To: <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Thu, 10 Jul 2025 20:34:45 +0800
X-Gm-Features: Ac12FXz3YDmx_bCl1jwLRzCqzWV1jsBoaUE9F5V_xEYIQNA0e0JwLEYjqB_I24M
Message-ID: <CAKxVwge4=cagaVDesKWe0BE88U0YmNn5LLDJvJG=F7EEP2=-LQ@mail.gmail.com>
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

Sure, I'll checkout it. Btw, this is my first commit, so can u tell
how to reproduce failed case? Using the reproduce and .config.gz gived
by build-bot?

Thanks,

Chen Miao

Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8810=E6=97=A5=
=E5=91=A8=E5=9B=9B 19:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ChenMiao,
>
> On 7/9/25 03:08, kernel test robot wrote:
> > Hi ChenMiao,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on fda589c286040d9ba2d72a0eaf0a13945fc48026]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/ChenMiao/riscv-f=
trace-Fix-the-logic-issue-in-DYNAMIC_FTRACE-selection/20250706-231907
> > base:   fda589c286040d9ba2d72a0eaf0a13945fc48026
> > patch link:    https://lore.kernel.org/r/20250706151830.25091-1-chenmia=
o.ku%40gmail.com
> > patch subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC=
_FTRACE selection
> > :::::: branch date: 2 days ago
> > :::::: commit date: 2 days ago
> > config: riscv-randconfig-r112-20250708 (attached as .config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd=
708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce: (attached as reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507090650.YGY56SIA-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> <instantiation>:1:14: error: operand must be a symbol with %lo/%pcrel=
_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >     addi sp, sp, -FREGS_SIZE_ON_STACK
> >                  ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >>> <instantiation>:2:18: error: unexpected token
> >      sw t0, FREGS_EPC(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:3:17: error: unexpected token
> >      sw x1, FREGS_RA(sp)
> >                     ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:7:17: error: unexpected token
> >      sw x6, FREGS_T1(sp)
> >                     ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:9:17: error: unexpected token
> >      sw x7, FREGS_T2(sp)
> >                     ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:10:18: error: unexpected token
> >      sw x28, FREGS_T3(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:11:18: error: unexpected token
> >      sw x29, FREGS_T4(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:12:18: error: unexpected token
> >      sw x30, FREGS_T5(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:13:18: error: unexpected token
> >      sw x31, FREGS_T6(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:16:18: error: unexpected token
> >      sw x10, FREGS_A0(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:17:18: error: unexpected token
> >      sw x11, FREGS_A1(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:18:18: error: unexpected token
> >      sw x12, FREGS_A2(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:19:18: error: unexpected token
> >      sw x13, FREGS_A3(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:20:18: error: unexpected token
> >      sw x14, FREGS_A4(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:21:18: error: unexpected token
> >      sw x15, FREGS_A5(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:22:18: error: unexpected token
> >      sw x16, FREGS_A6(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:23:18: error: unexpected token
> >      sw x17, FREGS_A7(sp)
> >                      ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >      ^
> >     <instantiation>:25:15: error: operand must be a symbol with %lo/%pc=
rel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >      addi a0, a0, FREGS_SIZE_ON_STACK
> >                   ^
> >     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instanti=
ation
> >      SAVE_ABI_REGS
> >
> > Kconfig warnings: (for reference only)
> >     WARNING: unmet direct dependencies detected for DYNAMIC_FTRACE
> >     Depends on [n]: FTRACE [=3Dy] && FUNCTION_TRACER [=3Dy] && HAVE_DYN=
AMIC_FTRACE [=3Dn]
> >     Selected by [y]:
> >     - RISCV [=3Dy] && FUNCTION_TRACER [=3Dy]
>
> To avoid that, we should check HAVE_DYNAMIC_FTRACE too:
>
> select DYNAMIC_FTRACE if FUNCTION_TRACER && HAVE_DYNAMIC_FTRACE
>
> That fixes the build error for me. Can you send a v3 with this change?
>
> Thanks,
>
> Alex
>
>
> >
