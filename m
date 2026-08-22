Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735F3CBE6E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406863; cv=none; b=mrePl44rV7Fcl0vVEfpv9VIRZkYyLhME+Wh15JcAcJtcoDI4XI0/w7cec/JYPF0kTvnxS4vTZv8ms2uw64GHktIJtubDPJDsZVXBozsFyp2cXJTR5Ig+/wgU7XBkxKB9NCJE+GBKiZ1e4kbUpmZaSIKufBJ125vnGqIeXd+0V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406863; c=relaxed/simple;
	bh=FmB/MEpIx8L1P7CFC1Vukrpcog8HIRySaKtpuR1ShSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiEfra9U3ZzKO8JEh+B0/pbML5U/7tdeAIooIzFdqeP5DNJjyQ8ScZzghZYQdy7yvPvSPwud7R0WkW1+FY/QzDD2PSL4ht2RCQzVQK4kJaABaKuP3kSz4mMkhmK7TccXLtrQ4sHfpacs9iGV2fgmXw0pOGFKZWzxpaJcbmbkpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKUlheSb; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKUlheSb"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f84ac1990so1032979f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406853; x=1788011653; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lE3r1MZLrWL74IP7BP3pqzwy+IxcMr+2cYN0bFzQAQ=;
        b=XKUlheSb9LAFFWBDr2RVqAiyRqAiRf12vHjfH3JDhmzXzR5kPd+UjaDj0KwT2XlKUm
         nOY08O2uW4Ht8Ony5cNNrgK/EGraKdHeWqwbDzc2Y6drSL33FuyMHMGdq6eJavUxTTxL
         /riQCR1w2SF6miq4VOPl+4Eejsc+mY7nb2e7FB1VGRsmd9s/7aPSVV22LOI9zZ/7BgjA
         pK0fd/mGH2dhMBiWvnSpTjSIGHY+mtbaYIKeL2QFGLK1vvKIsLldLrCG3m8iyzll22v2
         Opo/rlUrpQcPjv+e76Mamyaws1xaWoZxBW+xUx2esxrgjOghmDN5P2nezFHEhpFMtfnZ
         ECWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406853; x=1788011653;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lE3r1MZLrWL74IP7BP3pqzwy+IxcMr+2cYN0bFzQAQ=;
        b=kzhDRklfctUedyID8hFc/kN1pYdUY9rAQlikWAgCerThZGL0gbFmQRpwgSo9Qdj3i8
         vrziECmv8xPTt2PNhP3jQsueRqTLnN/nZoeLRxISit/vldMtl9gVx+M5Hg6lJlab7NWu
         vG39sPqTpgAmur6zrNq2LxFsIm/ps1oxnLxFYQ6eO2L9/Il6dxjW6Q1Z8wKLaVuO0djD
         IER1vxUcQ0vf9zyFO+FR7eRYAdZinCLBLY/8kDROuGamUF+kFtua7LK+RobZyzHZLVkr
         M1s9SqzoSlJFTiT81YMAFmqMM0DwbPgEroiP9oItdIAMy85y1EdIe35fct8XmKOHACAH
         A8fQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLkNxfm7wZM1sRd9BMw6EyTl8ma9sU4cIPusLgqbzzi5C5WMsDNejUZ6BIlTX+eoXQU+fXICFLfb35N7QzFk2LxI0=@vger.kernel.org
X-Gm-Message-State: AFuF++nRKP4uRHtMG6Afb5pePcU/s3hgjALt9BdwG7Fy7/Xk7xjw7p9j
	RN/CfEWUyoHedUhgrMkxHsyRlrbhF2GVy08+LiAwzE1MmtdzDJ8tlb6VNXUHUK58iKnYnEzVgA=
	=
X-Received: from wrbgf1.prod.google.com ([2002:a05:6000:27c1:b0:462:567a:6591])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6f13:0:b0:47f:e9fd:80d8
 with SMTP id ffacd0b85a97d-482c0bb40bemr18991596f8f.21.1787406852902; Sat, 22
 Aug 2026 06:54:12 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:30 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5799; i=ardb@kernel.org;
 h=from:subject; bh=5Vh9JPqa1jt8juFWDYh0K543ecP29Z3LFYkXXDIJ0JE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5f0rrx+s+jGrVkH3hJXknjsl122VL1WsEJX3nyc5J
 3SrBmd9RykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIp2BGhvu/oyTzD638eknh
 x5azWglPZFe66t+aGDBlhfIq+S9TPy9gZJj348O6+Lw9ldcEz9Z/ZujJu/c0/uE08dwNgV7bPq9 szmYAAA==
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-19-ardb+git@google.com>
Subject: [RFC PATCH 8/9] arm64: module: Combine init and core PLT entries again
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

It is no longer possible for .init.text to end up being placed out of
direct branching range of the .text section of the same module, so the
PLT array of core and init code can be combined again.

It also means there is no longer a need to allocate PLT entries for
cross-section calls within the same module, and so the upper bound
for the number of needed entries can be lowered again as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/module.h     |  1 -
 arch/arm64/include/asm/module.lds.h |  1 -
 arch/arm64/kernel/module-plts.c     | 35 +++++---------------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..9328fadb4a95 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -15,7 +15,6 @@ struct mod_plt_sec {
 
 struct mod_arch_specific {
 	struct mod_plt_sec	core;
-	struct mod_plt_sec	init;
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 0c3aea98e116..24fc9401c514 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,6 +1,5 @@
 SECTIONS {
 	.plt 0 : { BYTE(0) }
-	.init.plt 0 : { BYTE(0) }
 	.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index bde32979c06a..e30876b90e30 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -70,8 +70,7 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 			  void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym)
 {
-	struct mod_plt_sec *pltsec = !within_module_init((unsigned long)loc, mod) ?
-						&mod->arch.core : &mod->arch.init;
+	struct mod_plt_sec *pltsec = &mod->arch.core;
 	struct plt_entry *plt = (struct plt_entry *)sechdrs[pltsec->plt_shndx].sh_addr;
 	int i = pltsec->plt_num_entries;
 	int j = i - 1;
@@ -101,8 +100,7 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 				void *loc, u64 val)
 {
-	struct mod_plt_sec *pltsec = !within_module_init((unsigned long)loc, mod) ?
-						&mod->arch.core : &mod->arch.init;
+	struct mod_plt_sec *pltsec = &mod->arch.core;
 	struct plt_entry *plt = (struct plt_entry *)sechdrs[pltsec->plt_shndx].sh_addr;
 	int i = pltsec->plt_num_entries++;
 	u32 br;
@@ -169,17 +167,17 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 		case R_AARCH64_CALL26:
 			/*
 			 * We only have to consider branch targets that resolve
-			 * to symbols that are defined in a different section.
+			 * to symbols that are not defined in the same module.
 			 * This is not simply a heuristic, it is a fundamental
 			 * limitation, since there is no guaranteed way to emit
 			 * PLT entries sufficiently close to the branch if the
 			 * section size exceeds the range of a branch
 			 * instruction. So ignore relocations against defined
-			 * symbols if they live in the same section as the
+			 * symbols if they live in the same module as the
 			 * relocation target.
 			 */
 			s = syms + ELF64_R_SYM(rela[i].r_info);
-			if (s->st_shndx == dstidx)
+			if (s->st_shndx != SHN_UNDEF)
 				break;
 
 			/*
@@ -281,7 +279,6 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned long core_plts = 0;
-	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
 	Elf_Shdr *pltsec, *tramp = NULL;
 	int i;
@@ -293,8 +290,6 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
 			mod->arch.core.plt_shndx = i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
-			mod->arch.init.plt_shndx = i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
@@ -302,8 +297,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
 
-	if (!mod->arch.core.plt_shndx || !mod->arch.init.plt_shndx) {
-		pr_err("%s: module PLT section(s) missing\n", mod->name);
+	if (!mod->arch.core.plt_shndx) {
+		pr_err("%s: module PLT section missing\n", mod->name);
 		return -ENOEXEC;
 	}
 	if (!syms) {
@@ -332,12 +327,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (nents)
 			sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		if (!module_init_layout_section(secstrings + dstsec->sh_name))
-			core_plts += count_plts(syms, rels, numrels,
-						sechdrs[i].sh_info, dstsec);
-		else
-			init_plts += count_plts(syms, rels, numrels,
-						sechdrs[i].sh_info, dstsec);
+		core_plts += count_plts(syms, rels, numrels, sechdrs[i].sh_info,
+					dstsec);
 	}
 
 	pltsec = sechdrs + mod->arch.core.plt_shndx;
@@ -348,14 +339,6 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.core.plt_num_entries = 0;
 	mod->arch.core.plt_max_entries = core_plts;
 
-	pltsec = sechdrs + mod->arch.init.plt_shndx;
-	pltsec->sh_type = SHT_NOBITS;
-	pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	pltsec->sh_addralign = L1_CACHE_BYTES;
-	pltsec->sh_size = (init_plts + 1) * sizeof(struct plt_entry);
-	mod->arch.init.plt_num_entries = 0;
-	mod->arch.init.plt_max_entries = init_plts;
-
 	if (tramp) {
 		tramp->sh_type = SHT_NOBITS;
 		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-- 
2.55.0.860.g4b6b3295ed-goog

