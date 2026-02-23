Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096428505E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859915; cv=pass; b=rRaivRn9blhvKW/puKhqwCIoXm32fjC0m5yHt7eJjHWj2jznx2tpwms7c7ITWO4N7jPmSCiN0CI0oZXX6J21qNJ3QFGnpTyTGifgQ299F3LwCpjmRYfTJ/Bn8Bqd3ipgVlSNVETW21D1cHkY3PcBG6y+Ux9/U+B5pPG4yQoH8y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859915; c=relaxed/simple;
	bh=Lvo6HDNcAYHdH+XP8vSwC94W7dGDj1WmpN8XPNoytFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPINvN5t31X+TzQjJ/QrHBhVRFbGdgr/0wELcBwrXzQMcSvIDeCo6o9QBpPQBjz+RTJG5fZNZTnAuguG6mPwBt1gO1nksYHaguTdjwTxZgGM5AuRGfai8ng/pbJdh43MXJJI73Dxc8HWbTaf60kWW1HxWh32gPX5ZKRwBnsG6AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfddtJrr; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfddtJrr"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a11e565a9so4804892a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 07:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771859912; cv=none;
        d=google.com; s=arc-20240605;
        b=jdbfy4c+ZnIAW5BVMGz1+ZARn9jNu9t3sieS/zXBTUoO/WO7lFy2hT2EwJldbWOHC8
         dcCiJ9PvP/aYaOkDMTUDnrfrZfBOR+bIdmjwj3pCAexaQaAunBXaXG3wZ3xpen+iPTHH
         IOfvLqs4xijaHo3y84IcZchGLdpIqKZiztm8LtODVvAqfeWs/GR+C91hTPatTWcTLFP7
         V8wpGjtcXtQ967/fpwqAnCALd/aViyg1JFlywB+LtKwE9MsrJk6m8gl9Ws1Btk8KVEXc
         EgEWcc356nu8bRh54gbp8wH+v2LthtQNz6Fj0Khzua1CYluq4/h9HZUtNEkNrPKpqnsB
         uTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IR6gdiFdbL0vuUVLb+VE0oZt1IbckfphGrja6I7jXEs=;
        fh=9C3PxoUJDRbHusYGQzEF98vAjDkT3f9FTliA/DkgGRE=;
        b=ZmHFDCy8HcWi7bHoX5lArOvms/Tsbb9q22MTw64lPPrdofbeyDrtxi/i4NqN+OjfMd
         biKV53bm8C6rToZu037CWUl+YGUZnG6Wsjp/hnm36Ghx4uMpq7S/W3WmHvMuyMy3aUA2
         aO/Rra3lJ8V9nkhSwzL/QefFSKXUDwFYwt5zJ5m8mkWZ0DtB8u2qs5BpMdYSIWn4mULg
         E9dFr8lamJ4AL0602EfcL4+LDQSCnnVeaZXtAvmPhTypPTJ+ytmw1ViCB2Uxtf0Zoh0D
         vLFfwtRjp15vLNlIOgQ32aI3u23JFyxsm9bcAuH2T4sccHLPhbzyOJGue7RvTeYeVuQU
         TX5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859912; x=1772464712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR6gdiFdbL0vuUVLb+VE0oZt1IbckfphGrja6I7jXEs=;
        b=ZfddtJrrRvEwKpDHS3nHwuq+BOo7gmnuszzOcz9TFRdYCpwOzCbuHcFZ17dh77bPEt
         59SoxNqG8A98YbccVR3uNJeJdcYpQO4hNx3YY24Rdq55vDyzaf6ugNYCb1YAEEjSFQpQ
         tqYYc+jHmJtdEO9FXPysf//vgcPOmFe6XP17aaXvIW/BcCPNSC9OzZD5R2xBq/fyQyRM
         ugwxJCMUItHsRUm+YaZPAuTScJBus/V9hVj/MSdLkHeFzcYMIq4qu1Zky8fRv+ZgETcg
         Rd5wbja5EOX1XUIqeKh6G8uQeCgRJ/Xtpt85alBEzKm4BEVuv95TobeZaVEBui0ayMPy
         1MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859912; x=1772464712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR6gdiFdbL0vuUVLb+VE0oZt1IbckfphGrja6I7jXEs=;
        b=En61ZC6JrhfTSAMXCebzhE3GpcCnAzJ2ozfxxgsTjN+KaCAZMO2PcMe3Bgll5HP6Jw
         Y/xPNVPWyvgPdE8APkdqihAN+Txc6a5miardZExOgNr7+cZRVcs8QahNBy+9mMTzFR+Q
         B88djGlJd4I2WdlKqZUd/f4ox4NXm2ZQ40f/9OR/szqX0V1t41lSyZ1UTtNN6+SrHBs2
         JZ8AtZX+IJ/KjTZhdqnk2TgeAqaz4avqYB00HbAZq3jxAfA4JDYORpqqXioWc7E6FtD9
         QXonwF8yhkqNK2lKTPpzKJfGhjVwxyW9lK+xOSwyvFdOJOC0uFkIe9bIRt1/zolsLlQQ
         ST9A==
X-Forwarded-Encrypted: i=1; AJvYcCWNDOUK2fc564HkFdwvFzxBCwBBVMKwqB2PkLXd7786+XxWDiwXhy2izC6j9k8g8scGgHDBznIcAB8hdSgoWKD15Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WOusP/NCkO1GqgQnVTmV37h/ILVeceAVch6SeYuncBNv9AEh
	W2iYab/si4Agovkmjh1+qLeYXdZ/kvpnYFCsS0SLE6B+HhzGhlrdU4l6FqvpV1/Z83OpMxR5YrD
	/NP7edvYkIZw+TFoX1MCoPMg/n/WxYhc=
X-Gm-Gg: AZuq6aJg8rjjKoJOGUA4qJ3XpaBCy4y7nWxbxvXbPm7XJKFKG1rYvftcW6I1lV0Tw1r
	ebRlG6JZWv/vGxt0HRv9rLqcfsO9g7/x8cu2q+MIoDny049Pa6f/2hVyX69qDgtZNeNGAWTQzGG
	mcZ2QSMGsYFWU5EtyT2clbU/Y8KNbRyL6ZxorTpGAOxQrdSVtYwFpMMv46i1fCOV9waR5U53F+y
	+1H5A/DXjusy6ns2oJpm3ZbcLlo6D5nprog6NP/7GiCEYojyB1WYxQWDgzKdTFGZqkd3+u319ca
	YfgHkHKOlMA9WGeOwMcuEX8=
X-Received: by 2002:a17:907:3f1b:b0:b83:1327:920d with SMTP id
 a640c23a62f3a-b908170ccefmr553703966b.0.1771859911884; Mon, 23 Feb 2026
 07:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180838.42877-1-andybnac@gmail.com> <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud>
In-Reply-To: <20260221-repeal-emphatic-ddc2e9b94208@spud>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 23 Feb 2026 15:18:17 +0000
X-Gm-Features: AaiRm52DnZ_Fi6BjtZnXoERYPFEqT0aOWuS77yBEdHyKdXHXlOMFl2b2Fb35Czc
Message-ID: <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Conor Dooley <conor@kernel.org>
Cc: Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org, 
	alexghiti@rivosinc.com, palmer@dabbelt.com, 
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

On Sat, Feb 21, 2026 at 12:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey,
>
> On Tue, Apr 08, 2025 at 02:08:34AM +0800, Andy Chiu wrote:
> > From: Puranjay Mohan <puranjay12@gmail.com>
> >
> > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> > This allows each ftrace callsite to provide an ftrace_ops to the common
> > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > functions without the need to fall back to list processing or to
> > allocate custom trampolines for each callsite. This significantly speed=
s
> > up cases where multiple distinct trace functions are used and callsites
> > are mostly traced by a single tracer.
> >
> > The idea and most of the implementation is taken from the ARM64's
> > implementation of the same feature. The idea is to place a pointer to
> > the ftrace_ops as a literal at a fixed offset from the function entry
> > point, which can be recovered by the common ftrace trampoline.
> >
> > We use -fpatchable-function-entry to reserve 8 bytes above the function
> > entry by emitting 2 4 byte or 4 2 byte  nops depending on the presence =
of
> > CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a pointer
> > to the associated ftrace_ops for that callsite. Functions are aligned t=
o
> > 8 bytes to make sure that the accesses to this literal are atomic.
> >
> > This approach allows for directly invoking ftrace_ops::func even for
> > ftrace_ops which are dynamically-allocated (or part of a module),
> > without going via ftrace_ops_list_func.
> >
> > We've benchamrked this with the ftrace_ops sample module on Spacemit K1
> > Jupiter:
> >
> > Without this patch:
> >
> > baseline (Linux rivos 6.14.0-09584-g7d06015d936c #3 SMP Sat Mar 29
> > +-----------------------+-----------------+----------------------------=
+
> > |  Number of tracers    | Total time (ns) | Per-call average time      =
|
> > |-----------------------+-----------------+----------------------------=
|
> > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        0 |          0 |        1357958 |          13 |             - =
|
> > |        0 |          1 |        1302375 |          13 |             - =
|
> > |        0 |          2 |        1302375 |          13 |             - =
|
> > |        0 |         10 |        1379084 |          13 |             - =
|
> > |        0 |        100 |        1302458 |          13 |             - =
|
> > |        0 |        200 |        1302333 |          13 |             - =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        1 |          0 |       13677833 |         136 |           123 =
|
> > |        1 |          1 |       18500916 |         185 |           172 =
|
> > |        1 |          2 |       22856459 |         228 |           215 =
|
> > |        1 |         10 |       58824709 |         588 |           575 =
|
> > |        1 |        100 |      505141584 |        5051 |          5038 =
|
> > |        1 |        200 |     1580473126 |       15804 |         15791 =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        1 |          0 |       13561000 |         135 |           122 =
|
> > |        2 |          0 |       19707292 |         197 |           184 =
|
> > |       10 |          0 |       67774750 |         677 |           664 =
|
> > |      100 |          0 |      714123125 |        7141 |          7128 =
|
> > |      200 |          0 |     1918065668 |       19180 |         19167 =
|
> > +----------+------------+-----------------+------------+---------------=
+
> >
> > Note: per-call overhead is estimated relative to the baseline case with
> > 0 relevant tracers and 0 irrelevant tracers.
> >
> > With this patch:
> >
> > v4-rc4 (Linux rivos 6.14.0-09598-gd75747611c93 #4 SMP Sat Mar 29
> > +-----------------------+-----------------+----------------------------=
+
> > |  Number of tracers    | Total time (ns) | Per-call average time      =
|
> > |-----------------------+-----------------+----------------------------=
|
> > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        0 |          0 |         1459917 |         14 |             - =
|
> > |        0 |          1 |         1408000 |         14 |             - =
|
> > |        0 |          2 |         1383792 |         13 |             - =
|
> > |        0 |         10 |         1430709 |         14 |             - =
|
> > |        0 |        100 |         1383791 |         13 |             - =
|
> > |        0 |        200 |         1383750 |         13 |             - =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        1 |          0 |         5238041 |         52 |            38 =
|
> > |        1 |          1 |         5228542 |         52 |            38 =
|
> > |        1 |          2 |         5325917 |         53 |            40 =
|
> > |        1 |         10 |         5299667 |         52 |            38 =
|
> > |        1 |        100 |         5245250 |         52 |            39 =
|
> > |        1 |        200 |         5238459 |         52 |            39 =
|
> > |----------+------------+-----------------+------------+---------------=
|
> > |        1 |          0 |         5239083 |         52 |            38 =
|
> > |        2 |          0 |        19449417 |        194 |           181 =
|
> > |       10 |          0 |        67718584 |        677 |           663 =
|
> > |      100 |          0 |       709840708 |       7098 |          7085 =
|
> > |      200 |          0 |      2203580626 |      22035 |         22022 =
|
> > +----------+------------+-----------------+------------+---------------=
+
> >
> > Note: per-call overhead is estimated relative to the baseline case with
> > 0 relevant tracers and 0 irrelevant tracers.
> >
> > As can be seen from the above:
> >
> >  a) Whenever there is a single relevant tracer function associated with=
 a
> >     tracee, the overhead of invoking the tracer is constant, and does n=
ot
> >     scale with the number of tracers which are *not* associated with th=
at
> >     tracee.
> >
> >  b) The overhead for a single relevant tracer has dropped to ~1/3 of th=
e
> >     overhead prior to this series (from 122ns to 38ns). This is largely
> >     due to permitting calls to dynamically-allocated ftrace_ops without
> >     going through ftrace_ops_list_func.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >
> > [update kconfig, asm, refactor]
> >
> > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> I bisected a boot failure to this commit [c217157bcd1df ("riscv:
> Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")] yesterday, that appears
> to be affecting all LLVM versions that I currently have installed. From
> some initial testing of Kconfig options, it looks like the issue is
> CFI_CLANG related because when I disable CFI_CLANG things work once
> more. Since this option depends on !CFI_CLANG, but is def_bool y, I
> modified Kconfig to force disable it at all times and tested
> !DYNAMIC_FTRACE_WITH_CALL_OPS && !CFG_CLANG, which did boot.
>
> I dunno anything about what's going on in this patch, but so little in
> it relates to having DYNAMIC_FTRACE_WITH_CALL_OPS, that I was able to
> figure out that the problem is -fpatchable-function-entry=3D8,4
>

DYNAMIC_FTRACE_WITH_CALL_OPS can't work together with CFI_CLANG.

arm64 has:

select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
   (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))

would need something similar for riscv if not already done.

Thanks,
Puranjay
