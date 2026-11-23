Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397924;
	b=MxgAlUO6KUbcwHnxw40y1met6R0ArTpcXim7w8VHq6UrFRpDFxo51G+DKyeWwTjp256n
	 iL8OMrWtb+02ycc0BFxTPiXwouqbXA/ACUdn1RpCKlS0d6d+RJ+3nh2TnvmNKqvqyFY6e
	 B1KsO2JZqO89D/HlCdix2JvMRI4hMzwbxqbypEuYx3IvPE05feqPt6XTHQt1tMO/6gtLA
	 qaZ2TyZMGaaW1HpHC0zBLVFrkGFXrw/FBAkVSUiP4ud26LazrLzP5mKtO2fyXo+POnl2n
	 pypw/oyD6wAw72gs8Dgp3hgIVCfpKNv9wqAmF+9u0mkDj7YY9oObkMJYs5hL/brH/jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OzdWwIURVMbPTW+Xfal3SQDD4YIlEfjP+LtWK/UeHRg=;
	b=dRYTVuYx3yjlEd9TcOwSVUCVHqY1m2D+nK7lu6ia/QBiLCJ78ONWNbRWe6tKXJLNaCVC
	 7uVbWgwKCZEggWiMs5zdYYtus6/KpICbPGEGATwnCSnv+4B1eoS8RWtMAimKd0NFqo+9b
	 T6EU3/yPt0fvIkd9l1DLuHRbI08DgEAlzvbnYQKSTiJuXu8MNisA0VnCheDyNOHzJvW6x
	 5A+WIcBIomMRFNYNY4hwcaBCJePx19RiBZLyqwu3SkMP5wSD8UTyeSgoVDR+KED6Gw4cd
	 8dc2E7lIN0VxQVHlrRjjCQ4/TzddjNIxBzZxppHvPhQnrTyJA6veD9hT9zcdldjg8jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekDeGNAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549D606A31A;
	Mon, 23 Nov 2026 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekDeGNAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5001F000C4;
	Mon, 23 Nov 2026 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397923;
	bh=OzdWwIURVMbPTW+Xfal3SQDD4YIlEfjP+LtWK/UeHRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekDeGNAREkWRWl8uzkOmS/m+GpfsHHKqLON10xPqc+3U7RVLUx5xQMYS8WR6WUieR
	 rCDDzBAxOVaT8H7VcDOpl4J1bKEtQK6Y/eztHcrr8FwAt8on6wCVtxNggTzr7TsP/R
	 oKZv26xEuzw1021JomitVTVNJq7l0fScaSGrojIunVIrZi1ErR82VEAXaCGvaWR+a9
	 2KZ6eM33n/QJJXGKpMu/AnphfQc9KWGgCV59+1CPeyYibNwD421tZLntvOa3kvmP7A
	 DjHNt8G9ISF+4QbmjyxTNeYOmp207gNW3ze3M5KdCYChnsq2xsA/4kyCvyV5A2/0np
	 MlUtpA1rtB7BA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: pablo@pablofraile.net
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Denys Vlasenko <dvlasenk@redhat.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
Date: Mon, 23 Nov 2026 10:38:39 +0900
Message-ID: <undine-1795397919173953264-7ce8b3af1dd99739@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
References: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Pablo,

Thanks for the report and the patch, and thanks to Rick and Sashiko for
the additional findings.

When I checked this issue with LLM, the problem goes deeper than just the
missing 2-byte opcode check in uprobes. The x86 instruction decoder was
originally designed around instructions typically emitted in the kernel,
and as uprobes uses it on arbitrary user-space encodings, several gaps
around REX2 and VEX/EVEX/XOP have been found:

1. x86 instruction decoder / insn-eval issues:
   - insn->opcode.nbytes represents the physical opcode byte count (used
     by insn_offset_modrm() etc.), not what opcode map is used.
     We need a helper function to identify the opcode map.
   - As Sashiko pointed out, insn_is_nop() in arch/x86/lib/insn-eval.c
     mutates insn->opcode.value in-place for REX2 M0=1 without updating
     opcode.nbytes, corrupting struct insn for subsequent callers (and
     shifting it twice when called from both can_optimize() and
     branch_setup_xol_ops(), sigh...).
   - insn_get_opcode() never checks INAT_NO_REX2 / INAT_REX2_VARIANT or
     invalid REX2 encodings such as REX2 M0=0 + 0x0f (0xd5 0x00 0x0f) or
     REX2 M0=1 + 0x38/0x3a. In addition, gen-insn-attr-x86.awk currently
     skips emitting INAT_REX2_VARIANT for 0xa1 (JMPABS) because the check
     is placed after 'if (length(flags) == 0) continue'.
     (Note: Historically, the x86 insn decoder is designed for decoding
     kernel text, and has assamption that decoding begins at the function
     boundaries. Thus, it may not be able to perform verification
     correctly.)
   - insn_masking_exception() checks opcode.bytes[0] without verifying
     map 0, so it can misidentify non-map-0 instructions (REX2 M0=1 or
     VEX/EVEX/XOP) with opcode 0x1f/0x8e as POP SS / MOV SS.

2. Related map-0 assumptions in arch/x86/kernel/uprobes.c:
   - uprobe_init_insn(): clearing bit 0x0f in good_insns_{32,64} and
     dispatching via the logical opcode map is needed so that REX2 M0=1
     is checked against good_2byte_insns, VEX/EVEX/XOP are not checked
     against map-0 tables, and unsupported REX2 JMPABS (0xa1) / EVEX
     map 4 (APX) instructions are rejected.
   - branch_setup_xol_ops(): does not exclude VEX/EVEX/XOP or REX2, so
     ordinary AVX instructions like VZEROUPPER (c5 f8 77), VPSHUFD
     (c5 f9 70 ...), or VPOR (c5 .. eb) can be misidentified as branches.
   - arch_uprobe_analyze_insn(): switches on OPCODE1(&insn) without
     checking map 0, so e.g. VCMPPS/VCMPPD (VEX.0F.C2) matches case 0xc2
     (RET) and skips UPROBE_FIX_IP.
   - riprel_analyze(): clears bit 0 of the first REX byte, which for a
     2-byte REX2 prefix corrupts 0xd5 into 0xd4 instead of clearing
     B3/B4 in the second byte.

3. Regarding Rick's point about newly rejected 2-byte instructions:
   - Group 15 (0f ae: lfence/mfence/sfence, fxsave/fxrstor, {rd,wr}{fs,gs}base,
     etc.) is currently 0 in good_2byte_insns even though the comment notes
     they are user-executable. We should audit whether 0f ae (note that
     Grp15 also includes CET instructions like INCSSP/CLRSSBSY) should be
     enabled in good_2byte_insns to avoid regressions on existing workloads.

I am preparing a patch series that fixes the x86 instruction decoder
issues first and then updates uprobes on top of it (with Reported-by
credit to you). I will post it shortly for review.

Thank you,


