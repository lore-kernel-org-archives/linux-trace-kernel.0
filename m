Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DD27FB18
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861304; cv=pass; b=e9ei6RdGdqdBb4NxFMUVq1aNl9UaWS9BCAHMEs3eJBU5TshZueqcf4TkvBVMiMWd2Tdek1UpPozrqlYo7iksccTIgTTAURcqpuesAbXDAu3iWzC7EhjOf/ZBbAKHsjsJ+5/ZAIWqGptZRz3xp9vP3m3jGHO6hJv/w6fT9XPnhfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861304; c=relaxed/simple;
	bh=+xOBx+UCo3QzeE1kqlENhtc/iVWEKspgc0vb6UbUrZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktYa5HAOMaaasygvqqu5pGSMcwpdJa3u8ugoPlubaMU/zGOwcNM6DashxozQv2hhOQFEDl5j6JzRQiVD8y/mzlFYYS7mRtVQVGL2PPa2A6AzCML7Ec7MATcRT7l4Q7Vgpfk4weUoJNia9mYulCU3jz29jGY1DL9rUt+97pFLTwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPrvFz4m; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPrvFz4m"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65a380b554bso8742018a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 07:41:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861300; cv=none;
        d=google.com; s=arc-20240605;
        b=bFsBc4yD7nlqWvX02xDuPfFdTX9ZJVvi8ai865MvWHmJQQv5KUJRiv7iTVpolfF3Bf
         B+j3RmOPIPdJdhzHmzdNDIR0uSNTehfbDtSMXT1BcorWVUwOctleCkWaxEYN41B+GTjS
         9GmDWn5HJkJi6C+hl8ejA7kXF75buTdm+8Y/5FjausBOfV+O3Bgp85tXa/u1IL96XfLT
         w795L9h4hTgrXD9UgkJcPlAfGL3fv1vpYheElF5WUA2gNN4OadotMNVlmYZuo10SnIXh
         oXsC4svwAyVfTZUzh0L3UYpqXIuhuxeJeqAq3uLOSA9rvuWfIk4Py/TwyFQDNj7tIXW7
         65Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2P6NQWOxLOESUY715izY2+hrTfFuAY4zsORUdRvY0d0=;
        fh=oQzjtUYGglGUzTgIDJgccXnmjsgq5E7G8dalyJFs/kc=;
        b=hUTfqI9Z/2iggbUOb2uPRvuuKkpAvyRly47ixJ9xCg6dzdrMBPZ3uxCdZJG9YEU5RT
         3YbRywH+0nebNTOncTUJH5wbNwMtzuLN64QjQwllhz7W5w1UZEbeLaNZrMXAOFGUUeCt
         duxk/n2OB9ajFTZb6mfk7j4k+wUUmQjBL0whxNOCVYX7IWAY1+C+sRiodRz/ODeWN+RN
         vH1lc7v23+JYSZBYYz2SPPegzzOakbXEaYguK/Ue8Phs49bGoJfWvLNvuuza0LJeVrys
         VSqjObl0CUB3uewYngV79WZUAB6X/yvPwtjPHtjNsINWPUNcjNk/DSvMsuAyWjlKrejg
         WUxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771861300; x=1772466100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P6NQWOxLOESUY715izY2+hrTfFuAY4zsORUdRvY0d0=;
        b=QPrvFz4mOYasa/p+Lvszc2XpYredxh7mEircQFwVO74ufzp/NFwYNxq4R1Wn6kUBDV
         +zpsi9OL+aIOKJ/HrYM5Sbb2BRZaEE/nqoLciTqdKddmDCRITg/qIYyY4Atrz51F4g7Q
         OTOgiHZYj3v1sMWry+Wfe5rZ0PPfrqiIMphDuEeerDUEc0sLmqD84Ok97jlEw9Yf1qWP
         7/UGAsFzjZve5yJUowJ7ACPgFiOzm5IXxhnWsdayGlk6RoKdUTtckJ8dFYURBbmLGTVE
         CN+sBnFqrZd3DuIQjUE4CzWDD8q1pRh7wWQgLOZriaJsFRwYx1Q0q3rsgQSDifzfSSXB
         bKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861300; x=1772466100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2P6NQWOxLOESUY715izY2+hrTfFuAY4zsORUdRvY0d0=;
        b=HL32M89WMtz4yZjBGnpsYfGhs7pC6yxwtWZTaeFbSIVWMmQ3DcBMog51giATT4LsCN
         OyH96igDik11+An9+KQQ4GtTSa27ntuKdPAYhHfglD7xEmuc+ZxOm6eKunfjczzl9dLs
         HvK5U9Jzsw4fbG5Q31MRnmfqXrxEWEIE9/vryBSpMRaMsbeQuY9cNj2Hs1Ka85cYbYQO
         R1gqcHqtWpbri3+bcZA0gortmdMCrJOyWX30crzdYhEa9FLuE7G+0FtXmlQgjsF8Oxq6
         HLTKDQDUuoMCg9Ny97MR4/NNAPvFj68J02DUey3gRwy/6dC2bZazoYc5uDQC2j2trbbR
         B/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUijJBVK70mO+hxSJrbvKKncK8jYnyfDJlDf1uF03ZXXqoAGhKBwNZwnfRwtqr/XGQvoR+D7277l0JX/dF4y2jPBvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFp3NvuMkaL2dzwEQ4hacrq8YdkTrPsXjVasSaL0Qyar6S121N
	dW9Y2B+HdE0zNvXvQ9jS67xhaDPq6wuXzKugFP6AGonaHBtkrRf5vzMRus7I3uxCYzUJjJMWPnq
	Ezig0DNXqGCepny4PDN259W2+tTc4p14=
X-Gm-Gg: ATEYQzwuFsQArXpqOqwexnUzYf3wDV6MyAnlpG/+eHPltNNo39ZG5G/ns+y+tXLtkYZ
	XWExuhxSBoG30ER81EHt0eVJ1iz2dHmiGHFGlhvoth723SDQqBsvbCN/BKwJv696J71V/kZQsCN
	9KwlH2/hU7fAl2u3S9jz4Ds/xMxei/By4R2mxr4ALd8nefG5hpnU5doCUPWJgttVSrCIu8wzyOK
	e+V2HDCvhmujfZK10EXTmNHSAGSpfejI3FCE6ZPOj4ARP6YZk7ny45Si2MrNLlJS8DdXaunY3MM
	JpuqnDfvSIaNKi24xSoWHK4=
X-Received: by 2002:a05:6402:399b:b0:65a:1a4e:7011 with SMTP id
 4fb4d7f45d1cf-65ea4ec7ce6mr3925099a12.12.1771861300030; Mon, 23 Feb 2026
 07:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180838.42877-1-andybnac@gmail.com> <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud> <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
 <20260223-respect-chaste-60c3403b5bc9@wendy>
In-Reply-To: <20260223-respect-chaste-60c3403b5bc9@wendy>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 23 Feb 2026 15:41:26 +0000
X-Gm-Features: AaiRm50JojpYOsvZRBJUEVlyRq3y2KfKJDvSlcDyzxZ4600W8UZy2QIVGXuTlWo
Message-ID: <CANk7y0jdzCeFaLVpj6-mnWiSZvv+rJF=9kgWDYF7g_rjCpiYsw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, palmer@dabbelt.com, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Mark Rutland <mark.rutland@arm.com>, paul.walmsley@sifive.com, 
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com, 
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com, 
	yongxuan.wang@sifive.com, samuel.holland@sifive.com, olivia.chu@sifive.com, 
	c2232430@gmail.com, arnd@arndb.de, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	pjw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Feb 23, 2026 at 03:18:17PM +0000, Puranjay Mohan wrote:
> > On Sat, Feb 21, 2026 at 12:15=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > Hey,
> > >
> > > On Tue, Apr 08, 2025 at 02:08:34AM +0800, Andy Chiu wrote:
> > > > From: Puranjay Mohan <puranjay12@gmail.com>
> > > >
> > > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC=
-V.
> > > > This allows each ftrace callsite to provide an ftrace_ops to the co=
mmon
> > > > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > > > functions without the need to fall back to list processing or to
> > > > allocate custom trampolines for each callsite. This significantly s=
peeds
> > > > up cases where multiple distinct trace functions are used and calls=
ites
> > > > are mostly traced by a single tracer.
> > > >
> > > > The idea and most of the implementation is taken from the ARM64's
> > > > implementation of the same feature. The idea is to place a pointer =
to
> > > > the ftrace_ops as a literal at a fixed offset from the function ent=
ry
> > > > point, which can be recovered by the common ftrace trampoline.
> > > >
> > > > We use -fpatchable-function-entry to reserve 8 bytes above the func=
tion
> > > > entry by emitting 2 4 byte or 4 2 byte  nops depending on the prese=
nce of
> > > > CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a poi=
nter
> > > > to the associated ftrace_ops for that callsite. Functions are align=
ed to
> > > > 8 bytes to make sure that the accesses to this literal are atomic.
> > > >
> > > > This approach allows for directly invoking ftrace_ops::func even fo=
r
> > > > ftrace_ops which are dynamically-allocated (or part of a module),
> > > > without going via ftrace_ops_list_func.
> > > >
> > > > We've benchamrked this with the ftrace_ops sample module on Spacemi=
t K1
> > > > Jupiter:
> > > >
> > > > Without this patch:
> > > >
> > > > baseline (Linux rivos 6.14.0-09584-g7d06015d936c #3 SMP Sat Mar 29
> > > > +-----------------------+-----------------+------------------------=
----+
> > > > |  Number of tracers    | Total time (ns) | Per-call average time  =
    |
> > > > |-----------------------+-----------------+------------------------=
----|
> > > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (=
ns) |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        0 |          0 |        1357958 |          13 |           =
  - |
> > > > |        0 |          1 |        1302375 |          13 |           =
  - |
> > > > |        0 |          2 |        1302375 |          13 |           =
  - |
> > > > |        0 |         10 |        1379084 |          13 |           =
  - |
> > > > |        0 |        100 |        1302458 |          13 |           =
  - |
> > > > |        0 |        200 |        1302333 |          13 |           =
  - |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        1 |          0 |       13677833 |         136 |           =
123 |
> > > > |        1 |          1 |       18500916 |         185 |           =
172 |
> > > > |        1 |          2 |       22856459 |         228 |           =
215 |
> > > > |        1 |         10 |       58824709 |         588 |           =
575 |
> > > > |        1 |        100 |      505141584 |        5051 |          5=
038 |
> > > > |        1 |        200 |     1580473126 |       15804 |         15=
791 |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        1 |          0 |       13561000 |         135 |           =
122 |
> > > > |        2 |          0 |       19707292 |         197 |           =
184 |
> > > > |       10 |          0 |       67774750 |         677 |           =
664 |
> > > > |      100 |          0 |      714123125 |        7141 |          7=
128 |
> > > > |      200 |          0 |     1918065668 |       19180 |         19=
167 |
> > > > +----------+------------+-----------------+------------+-----------=
----+
> > > >
> > > > Note: per-call overhead is estimated relative to the baseline case =
with
> > > > 0 relevant tracers and 0 irrelevant tracers.
> > > >
> > > > With this patch:
> > > >
> > > > v4-rc4 (Linux rivos 6.14.0-09598-gd75747611c93 #4 SMP Sat Mar 29
> > > > +-----------------------+-----------------+------------------------=
----+
> > > > |  Number of tracers    | Total time (ns) | Per-call average time  =
    |
> > > > |-----------------------+-----------------+------------------------=
----|
> > > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (=
ns) |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        0 |          0 |         1459917 |         14 |           =
  - |
> > > > |        0 |          1 |         1408000 |         14 |           =
  - |
> > > > |        0 |          2 |         1383792 |         13 |           =
  - |
> > > > |        0 |         10 |         1430709 |         14 |           =
  - |
> > > > |        0 |        100 |         1383791 |         13 |           =
  - |
> > > > |        0 |        200 |         1383750 |         13 |           =
  - |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        1 |          0 |         5238041 |         52 |           =
 38 |
> > > > |        1 |          1 |         5228542 |         52 |           =
 38 |
> > > > |        1 |          2 |         5325917 |         53 |           =
 40 |
> > > > |        1 |         10 |         5299667 |         52 |           =
 38 |
> > > > |        1 |        100 |         5245250 |         52 |           =
 39 |
> > > > |        1 |        200 |         5238459 |         52 |           =
 39 |
> > > > |----------+------------+-----------------+------------+-----------=
----|
> > > > |        1 |          0 |         5239083 |         52 |           =
 38 |
> > > > |        2 |          0 |        19449417 |        194 |           =
181 |
> > > > |       10 |          0 |        67718584 |        677 |           =
663 |
> > > > |      100 |          0 |       709840708 |       7098 |          7=
085 |
> > > > |      200 |          0 |      2203580626 |      22035 |         22=
022 |
> > > > +----------+------------+-----------------+------------+-----------=
----+
> > > >
> > > > Note: per-call overhead is estimated relative to the baseline case =
with
> > > > 0 relevant tracers and 0 irrelevant tracers.
> > > >
> > > > As can be seen from the above:
> > > >
> > > >  a) Whenever there is a single relevant tracer function associated =
with a
> > > >     tracee, the overhead of invoking the tracer is constant, and do=
es not
> > > >     scale with the number of tracers which are *not* associated wit=
h that
> > > >     tracee.
> > > >
> > > >  b) The overhead for a single relevant tracer has dropped to ~1/3 o=
f the
> > > >     overhead prior to this series (from 122ns to 38ns). This is lar=
gely
> > > >     due to permitting calls to dynamically-allocated ftrace_ops wit=
hout
> > > >     going through ftrace_ops_list_func.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > >
> > > > [update kconfig, asm, refactor]
> > > >
> > > > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > > > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > >
> > > I bisected a boot failure to this commit [c217157bcd1df ("riscv:
> > > Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")] yesterday, that appear=
s
> > > to be affecting all LLVM versions that I currently have installed. Fr=
om
> > > some initial testing of Kconfig options, it looks like the issue is
> > > CFI_CLANG related because when I disable CFI_CLANG things work once
> > > more. Since this option depends on !CFI_CLANG, but is def_bool y, I
> > > modified Kconfig to force disable it at all times and tested
> > > !DYNAMIC_FTRACE_WITH_CALL_OPS && !CFG_CLANG, which did boot.
> > >
> > > I dunno anything about what's going on in this patch, but so little i=
n
> > > it relates to having DYNAMIC_FTRACE_WITH_CALL_OPS, that I was able to
> > > figure out that the problem is -fpatchable-function-entry=3D8,4
> > >
> >
> > DYNAMIC_FTRACE_WITH_CALL_OPS can't work together with CFI_CLANG.
> >
> > arm64 has:
> >
> > select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
> >    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> >
> > would need something similar for riscv if not already done.
>
>
> I think you've misunderstood my email. We already have:
>
>         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_=
ARGS && !CFI)
>
> The problem is that the patch broke using CFI_CLANG, due to the
> fpatchable-function-entry change.


Yeah, sorry I did not see the patch,
the original one I sent had:

+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
+ifeq ($(CONFIG_RISCV_ISA_C),y)
+ CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
+else
+ CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
+endif
+else


The basic Idea is that we can't put nops before the function entry
when using CFI_CLANG, because they both interfere with each other.

the fix should be something like:

-- >8 --

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 371da75a47f9..94100810a6a4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,11 +14,19 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
        LDFLAGS_vmlinux +=3D --no-relax
        KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
 ifeq ($(CONFIG_RISCV_ISA_C),y)
        CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
 else
        CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
 endif
+else
+ifeq ($(CONFIG_RISCV_ISA_C),y)
+       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
+else
+       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
+endif
+endif
 endif

 ifeq ($(CONFIG_CMODEL_MEDLOW),y)

-- 8< --


Thanks,
Puranjay
