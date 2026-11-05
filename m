Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849089;
	b=cLuha3Hfjn/Ofam7vj9aUQsfxb3D5fdgs/acF7PbgcLV+sBW5Inup2XZ4Fu3z8bJie4Q
	 5erYbiM2oqI4W11pttKaQwrCUTovbP5OnaCn3XVIIhL0GTmZmF6UpUg+2blKvMupqozOj
	 nJiPehtqGob6P5Hd1it99QaHrBCRgH9IFSw1nq3Vl6DixI8zrfghown7q7qQD9BdGRo9J
	 sdifpl+eNsG7Il5FNAxMO1DrVim7/A4nascxJgde+M7zntDDDCp1NYKySRLhovdwY/4w2
	 H6DupC6LNip2EWjCX9iub8VP+sKLVpXG0RfGxw6nY19V0amYlBz15gJUcltV+9aq30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Xm8rL1GwHu4r8B5iRjSenpHkcebJlj/5pUrpZbIBUs=;
	b=TK4m7IWRC/9GIEa62472I8HsPTY9N2ftueXeHLkr4W3G1i8Bk6TTJQGF03z3mRTRv1EV
	 n4eYlPGSbnv7JxG9bE2YFnduoDmthlnabOTabXV1j+uan3G84AHZfWXyLjp/BO5fJenPK
	 EgHd6JfTFSl3+ZbQ667o2ufKlr4O4aw+XvxN2ItMtVi3mBHdJet9IKlYGOaAVIleBV0Cw
	 P96YTriBTKQVOqqDr/4shz6WTKNOk9E3nUgvk9XoN5MKS9UZW4JfXyWFIg4m6uadISQy5
	 oQQWp2VfJ3NJM4GFrnun6zCchGIMOxwDTBshiS5o2uJ7B8Ixn5P4u7ZgR86D2fhLoaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IpC/cYK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD3606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpC/cYK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B0F1F000C1;
	Thu,  5 Nov 2026 03:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793849088;
	bh=1Xm8rL1GwHu4r8B5iRjSenpHkcebJlj/5pUrpZbIBUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IpC/cYK/v/XJ/b/yfESS9isZVryeFSPCMxMEHAEF2qECRI4GxY4ynRPXQ4/X0PG99
	 Lzi9Kxcm3TAepqbRNnCGfRjDC41dF+gNe5aMZczVWTxYC2DjKZH+ak4qPANytqN3we
	 +a9GegsPY9CSZyEDSUIcYc+TgtG0ht8DYlDrDqMycjkRcXI/XY1l60whZ+g4W1a3Zu
	 qu/t+icbSirjfYQIo85Av/YCw26aP8uDUouO8Ctc54Dgpx93gi1S3O7ACi9ukXScJN
	 muC6L60OwADvGyKfAtn4heNBMPdX3DpUowi26MWAzOPO3zNO38IIz8U8YeVt9TnvjZ
	 OVVcsE26mXI/w==
Message-ID: <sashiko-outbox-198512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ftrace: speed up module enable by binary searching
 module symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaxiong Tian" <tianyaxiong@kylinos.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105031530.280442-1-tianyaxiong@kylinos.cn>
References: <20261105031530.280442-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 03:24:47 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] ftrace: undeclared function is_ignored_kernel_symbol() breaks build
--

commit 4bde25e1c49a34cddab8dbd106c29413a3f1f699
Author: Yaxiong Tian <tianyaxiong@kylinos.cn>

ftrace: speed up module enable by binary searching module symbols

This commit speeds up ftrace_module_enable() by collecting and sorting a
module's symbol addresses once and binary searching them to validate
ftrace records instead of linearly scanning the module symbol table for
each record.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d36de..255e813fe70e1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -26,6 +26,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/bsearch.h>
>  #include <linux/module.h>
> +#include <linux/module_symbol.h>
>  #include <linux/ftrace.h>
>  #include <linux/sysctl.h>
>  #include <linux/slab.h>
> @@ -8034,8 +8035,129 @@ void ftrace_release_mod(struct module *mod)
>  	}
>  }
> =20
> +#ifdef FTRACE_MCOUNT_MAX_OFFSET

[ ... ]

> +static struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
> +{
> +	struct mod_kallsyms *kallsyms;
> +	struct ftrace_mod_syms *syms;
> +	unsigned int i, nr =3D 0;
> +
> +	/*
> +	 * mod->kallsyms stays valid until do_init_module() replaces it later
> +	 * in this thread, so no RCU read-side section is needed.
> +	 */
> +	kallsyms =3D rcu_dereference_raw(mod->kallsyms);
> +
> +	if (!kallsyms || kallsyms->num_symtab < 2)
> +		return NULL;
> +
> +	syms =3D kvmalloc(struct_size(syms, addr, kallsyms->num_symtab),
> +			GFP_KERNEL);
> +	if (!syms)
> +		return NULL;
> +
> +	/* The symbols find_kallsyms_symbol() would consider. */
> +	for (i =3D 1; i < kallsyms->num_symtab; i++) {
> +		const Elf_Sym *sym =3D &kallsyms->symtab[i];
> +		const char *name =3D kallsyms->strtab + sym->st_name;
> +
> +		if (sym->st_shndx =3D=3D SHN_UNDEF || !*name ||
> +		    is_ignored_kernel_symbol(name))
> +			continue;

[Severity: Low]
Does this break the build on architectures defining FTRACE_MCOUNT_MAX_OFFSET
(such as x86 with CONFIG_HAVE_FENTRY or powerpc)?

ftrace_mod_syms_alloc() calls is_ignored_kernel_symbol(), which is not
declared or defined in any kernel header in this tree. In
include/linux/module_symbol.h, the helper is still named is_mapping_symbol(=
):

include/linux/module_symbol.h:
static inline bool is_mapping_symbol(const char *str)
{
	if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
		return true;
	if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
		return true;
	return str[0] =3D=3D '$';
}

and find_kallsyms_symbol() in kernel/module/kallsyms.c calls
is_mapping_symbol():

kernel/module/kallsyms.c:find_kallsyms_symbol() {
	...
		if (*kallsyms_symbol_name(kallsyms, i) =3D=3D '\0' ||
		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
			continue;
	...
}

Should ftrace_mod_syms_alloc() call is_mapping_symbol(name) here instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105031530.2804=
42-1-tianyaxiong@kylinos.cn?part=3D1
