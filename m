Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F636E46C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272417; cv=none; b=eL3kXccRH2H0xbgTjoKaZYBbZ5DyRXC6IR75XIXlvJX9Hmdoqb3/mlFIxuY5eT8yOYX6lLwS7C02QYYA8OBKm7vubDVe4ny6SgGk+i8aJRTLCQMsZKT/9x6ZLn5L/hdxoP65w5zkDbzlOUzxMPI5qdQsoNPa7a+0mKdOX+Ncl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272417; c=relaxed/simple;
	bh=7RU4fKtzVTHWFSROoZACA8Eva32HBiFOZYQATXuq0uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=id9kR0+v14eqrEdiAaryCQDzpp+Hx6xSfGxGk1kpTEXzdi2EUktwfuSHkbTYBgGvzu6iNYjDZ4xSPiUBMubFQrLYlMXhkkhrdC51g5dxbN07z7R6Nq5Pk966+6iaRRK8Fg7yt9PAWm/NX4hIdfK1uFmG3ITvcoR+WcqS/CDBTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqfdNAIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqfdNAIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81DD1F000E9;
	Tue,  1 Sep 2026 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272416;
	bh=q0SnkpTbfi4lJne94BaXsyOZ9USDEnVO9RP9XMf/gaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqfdNAIv8CZ1krFuSroDyKxRC3GK0x72Id+UzS0W1hzZDwRX+Quku+AucloiXjb6t
	 U0OOX06IXIqXuzAQnADpB9K7nG7zAuxfG5rFVVnq8TnjNJzdIDzIzoS6cGQFiN4UYE
	 FGaDuu7q8gogOr4RNa9y0ojAPOBgooGC/Y0uW0ua2OKXeOpy5I5gyZIqAsZ/cY8smp
	 W1IkRcHSR35hnRfeQaj4Cntgi5SGytuiwBWEm5Pwc/ImLHWHIQemprSlv2N5BdoTHU
	 m3VN8B6dtZnD2n+TVXwyWGa8VRniS+ehrC+tJH5lorUJUl95/eBwVbGPhNMJxzb/lc
	 EFk+unksL0Qdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] tracing: Update funcgraph-retval documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donglin Peng" <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901134604.4052265-4-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
 <20260901134604.4052265-4-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:20:15 +0000
Message-Id: <20260901142015.C81DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Undefined behavior in `btf_trim_retval()` when evaluating `GENMASK=
()` for zero-sized types like empty structs.
- [Medium] Zero-extension of signed return values breaks display formatting=
 for negative integers.
--

commit 9a068f6032f17c7055ec2012793c0a9a00b1e9a0
Author: pengdonglin <pengdonglin@xiaomi.com>

tracing: Update funcgraph-retval documentation

The existing documentation for funcgraph-retval is outdated and partially
incorrect, as it describes limitations that have now been resolved. Recent
changes (e.g., using BTF to obtain function return types) have addressed
key issues.

> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.=
rst
> index 7261f25f8b4ba..696bfbede5905 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
[ ... ]
> +- Under certain procedure-call standards (e.g., arm64's AAPCS64), when t=
he return
> +  type is smaller than a general-purpose register (GPR), the caller is r=
esponsible
> +  for narrowing the value; the upper bits of the register may contain un=
defined data.
> +  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hol=
d arbitrary
> +  values, especially when larger types are truncated (explicitly or impl=
icitly). It
> +  is therefore advisable to inspect the code in such cases. If CONFIG_DE=
BUG_INFO_BTF
> +  is enabled (y), the return value is automatically trimmed to the width=
 of the return
> +  type.

[Severity: High]
Does the trimming logic in btf_trim_retval() handle empty structs correctly?

Looking at btf_trim_retval() in kernel/trace/trace_btf.c:

    msb =3D BITS_PER_BYTE * t->size - 1;
    *retval &=3D GENMASK(msb, 0);

If a function returns a zero-sized type (like an empty struct), t->size is =
0.
This causes msb to underflow to 0xFFFFFFFF, which means GENMASK(0xFFFFFFFF,=
 0)
attempts a shift by 64. Can this trigger undefined behavior and potentially=
 a
UBSAN panic if CONFIG_UBSAN_SHIFT is enabled?

[Severity: Medium]
Also, does this zero-extension break display formatting for negative intege=
rs?

When a function returns a negative value, btf_trim_retval() zeroes out the
upper bits. Later in kernel/trace/trace_functions_graph.c:print_graph_retva=
l():

    if (!IS_ERR_VALUE(err_code))
        err_code =3D 0;
    // ...
    trace_seq_printf(s, " ret=3D%ld", err_code ?: retval);

For non-error negative values (like -5000) or small signed types (like s8),
IS_ERR_VALUE() evaluates to false, resetting err_code to 0. The code then
falls back to printing the zero-extended retval as a positive number using
%ld. Won't this cause these negative returns to be printed as large positive
numbers instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901134604.4052=
265-1-dolinux.peng@gmail.com?part=3D3
