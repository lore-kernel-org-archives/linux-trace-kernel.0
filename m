Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589150292;
	Wed,  1 May 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554861; cv=none; b=j6RxaAdmssQGAiqypvcJbT48xmesLS0BTklWiNB5DMS4ZkumJ07cwN/6bzGmMIOetciPbqdAmBU+YJR0eu5uIhj4XOp0ATVwoANMsyecdUxfHJsMgJ1tHe2DXlh9zE0D48tK+jIJulQaIHmjT3vkAwGGYfZpLH/4N7tsQrZUe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554861; c=relaxed/simple;
	bh=7iwCUPmgbAilYH+cT6NBLywDyu+dsovWKl+e0m1QWu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mx2JiYV5k9Rg+ztVmb79CpLIGn1LXuxzknEKnDgPpzhlv6uJuf3aZkdHpJQQfLRUcryxXwgE9z/XAk5B11kJczeqK6v30QKq3KlLH7Du9B8EzxgTum7WxpWHfxmkbnsd81cQc0yu7tVpJXG8uFfORjMpKPsUVMlz/XHOJ59LFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eMPiFVtn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eMPiFVtn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XZgPAplKGsbYVTcUmYpJ5ug+4DYIsNnlBBZ+/UCzGHA=; t=1714554859; x=1715159659; 
	b=eMPiFVtnxwm42yog2knNnBG2BuxV63hgLneJ05Zmj3n23rqCMYkOPqmzGxSK2wgldlYQZOV4KZY
	tIfsBnN0SuxtI9RgwDXw3QDA09o1z5CAeuxNQZTu1jDv0AvM/YeJ80KS64OYb2Qzgp3rVV7vCr2RY
	hheDbZ3PNaSZ29Pl2akwLkcXnH6dd8iC8+wJvOluy661hv/Opjn2tPhaVuyPUiuy+SW3HDZBowNP+
	cDawmXGls1WaiXeeUH+QlUMEtN+/JsqbSx0hV+wdgvNCLJ9ciIBQgL90v3Y4SeeLsJEGTzs42SVte
	DeUETjQSg2mz9GwA6ENhMtVDNnVqSi3EXMxA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s262X-000000004uI-1wn8; Wed, 01 May 2024 11:14:13 +0200
Received: from dynamic-078-054-136-214.78.54.pool.telefonica.de ([78.54.136.214] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s262X-000000006ag-0xO0; Wed, 01 May 2024 11:14:13 +0200
Message-ID: <952ee5e1f9492bc3f3799582ccc47c1f31d26fe8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 00/20] sh: Fix missing prototypes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mark Rutland <mark.rutland@arm.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,  Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-sh@vger.kernel.org,  linux-trace-kernel@vger.kernel.org
Date: Wed, 01 May 2024 11:14:12 +0200
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series fixes several "no previous prototype for <foo>"
> warnings when building a kernel for SuperH.
>=20
> Known issues:
>   - The various warnings about cache functions are not yet fixed, but
>     I didn't want to hold off the rest of this series,
>   - sdk7786_defconfig needs "[PATCH/RFC] locking/spinlocks: Make __raw_*
>     lock ops static" [1],
>   - Probably there are more warnings to fix, I didn't build all
>     defconfigs.
>=20
> This has been boot-tested on landisk and on qemu/rts7751r2d.
>=20
> Thanks for your comments!
>=20
> [1] https://lore.kernel.org/linux-sh/c395b02613572131568bc1fd1bc456d20d1a=
5426.1709325647.git.geert+renesas@glider.be
>=20
> Geert Uytterhoeven (20):
>   sh: pgtable: Fix missing prototypes
>   sh: fpu: Add missing forward declarations
>   sh: syscall: Add missing forward declaration for sys_cacheflush()
>   sh: tlb: Add missing forward declaration for handle_tlbmiss()
>   sh: return_address: Add missing #include <asm/ftrace.h>
>   sh: traps: Add missing #include <asm/setup.h>
>   sh: hw_breakpoint: Add missing forward declaration for
>     arch_bp_generic_fields()
>   sh: boot: Add proper forward declarations
>   sh: ftrace: Fix missing prototypes
>   sh: nommu: Add missing #include <asm/cacheflush.h>
>   sh: math-emu: Add missing #include <asm/fpu.h>
>   sh: dma: Remove unused dmac_search_free_channel()
>   sh: sh2a: Add missing #include <asm/processor.h>
>   sh: sh7786: Remove unused sh7786_usb_use_exclock()
>   sh: smp: Fix missing prototypes
>   sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
>   sh: kprobes: Make trampoline_probe_handler() static
>   sh: kprobes: Remove unneeded kprobe_opcode_t casts
>   sh: dwarf: Make dwarf_lookup_fde() static
>   [RFC] sh: dma: Remove unused functionality
>=20
>  arch/sh/boot/compressed/cache.c         |   3 +
>  arch/sh/boot/compressed/cache.h         |  10 ++
>  arch/sh/boot/compressed/misc.c          |   8 +-
>  arch/sh/boot/compressed/misc.h          |   9 ++
>  arch/sh/drivers/dma/dma-api.c           | 143 ------------------------
>  arch/sh/include/asm/dma.h               |   7 --
>  arch/sh/include/asm/fpu.h               |   3 +
>  arch/sh/include/asm/ftrace.h            |  10 ++
>  arch/sh/include/asm/hw_breakpoint.h     |   2 +
>  arch/sh/include/asm/syscalls.h          |   1 +
>  arch/sh/include/asm/tlb.h               |   4 +
>  arch/sh/kernel/cpu/sh2a/opcode_helper.c |   2 +
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c  |  14 ---
>  arch/sh/kernel/dwarf.c                  |   2 +-
>  arch/sh/kernel/kprobes.c                |  13 +--
>  arch/sh/kernel/return_address.c         |   2 +
>  arch/sh/kernel/smp.c                    |   4 +-
>  arch/sh/kernel/traps.c                  |  10 +-
>  arch/sh/kernel/traps_32.c               |   1 +
>  arch/sh/math-emu/math.c                 |   2 +
>  arch/sh/mm/nommu.c                      |   2 +
>  arch/sh/mm/pgtable.c                    |   4 +-
>  arch/sh/mm/tlbex_32.c                   |   1 +
>  23 files changed, 68 insertions(+), 189 deletions(-)
>  create mode 100644 arch/sh/boot/compressed/cache.h
>  create mode 100644 arch/sh/boot/compressed/misc.h
>=20

For the whole series:

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

I would still like to get feedback from Yoshinori on patch #20 though, i.e.

	"sh: dma: Remove unused functionality".

On the other hand, we could just merge this series and re-add the functions
later if we decide they're still needed.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
