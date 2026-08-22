Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784A3C3F7F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406861; cv=none; b=T5Srp6t0tKsrrU287RCD5SUDUWoT/Y8jbNHUaZmcUIOqPMLxzuzIbINApGygG5fwlwhouNRFrStigGiqLMk2kVHMnP5a2mwmZ/moNNyXPUDmUJKZiXXo46lZ7wlf/4eNrwAr8uwLP0kldb1a8xBSr0vphLI20i59WThdF0FPtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406861; c=relaxed/simple;
	bh=KzkGg2FO9EGkV0PFVKpsKMx4fbZaAn79KH1T1TlQHZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3X12QBN4KvnTxOPRJxtUKMT3SNoVSPpdKr0npjwKbryEwRG4vOnfoYXRF992qIbNsQHB/NhC4CQW3FuR6mXMdvyWUPlMsCxo+dl8xNlGhtOhacT6iM3jrcJy1DclRVFxUOa8Phdp1mtowUSkBtgSJKiqkTbzgjjb+hL+dqsuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH9BZJvT; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH9BZJvT"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499900c9d99so14428345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406854; x=1788011654; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fli+nS6RhVan3nt659uJs8jpsHJEZUSGw+6iw8TgCBk=;
        b=gH9BZJvT8mpN0tqhrjCbcss3fLgqWSU0Ci0dWRCyp7PP4DaIu3giSwmHA0yoyPJInI
         eBk3vgbHCgZjn102R+5EiK2d70aunBm1p4U8uGjmJ5d3Y83lcKWmYEREnRofLfr7Ja8v
         pSOI9DLgZIoc4OcrYLepYd3GwPOU51RuuFBRQPwDH8rK02jfTuiSMCO6vdz6cJBhHVUt
         UPsfg7eudzGiAF4CZAZb23CjazxMZMKK/Ek90/hxLURvPdV9nr/hdT7evfdLaH/M2ZHa
         gFBNTcfbQGehIvVFaO26fxPGWXTubqSPGLRVhPQ+m4oHYVR9CYlpkO9Yzrx22bqlTatT
         wIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406854; x=1788011654;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fli+nS6RhVan3nt659uJs8jpsHJEZUSGw+6iw8TgCBk=;
        b=RStPt4XOnyB5AWhTMi4iPqL5RCDehWpuSshyVV4q/mtJMEwDBl7q1rUklV1KDUqiA2
         7y5Yg8O0yGrUckbWjLJrK0Ly3t0/tah6sQf5AZSWvkBSitlWm4McdoiQVCxDmNp1Gf52
         8rt7hpG5Sp739xrW1aivx1Cm5E3gKcLw0kK+yAMOlEf22vgfr5h4ddWjlCPdf7m9cFQ2
         1Z0CYAKkopPcSsSoSPDMD9qafXWRBLq+J2j7CO5AxmBvaF9mQIxjz8RYnfAqxCRBpFhx
         Qld8fcTBlZSnv9Zlda0niR8ti9WcXbrA3sCn8kHwn1zsWVYBjbZAm+olKyboO/KFsY6R
         ba3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrxYYvtS7TWawJIW6RGz4fR7l/APZZjY3UMAdyJ5i+ueUHm86jRQn1wCHu8yzsfpL2DEIE6y07XnUoqnQP1VOIG5No=@vger.kernel.org
X-Gm-Message-State: AFuF++lI4MZGOG/GZ6VUtXqxeJjaopZhm3olqpZZekz0+yYHmyXmz4WC
	bzphYAX1QnlefUrHh4hD18NLrjskC7CKWHWhg6gzwd5d3pn5NZeABnJOOE5K3ZIAt1GZgdhfBg=
	=
X-Received: from wmfu6.prod.google.com ([2002:a05:600c:1386:b0:495:4396:e1fc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f87:b0:499:5a50:b022
 with SMTP id 5b1f17b1804b1-499b830d220mr157719645e9.3.1787406853968; Sat, 22
 Aug 2026 06:54:13 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:31 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3229; i=ardb@kernel.org;
 h=from:subject; bh=E47PSMirXFpI2/XCsflkCaR86s287Dpi3LlkrwYeMZU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5YP+Sf2p1kr7Q6vXvzG479h57WWiGrOK0SxDm5Zur
 rn/05U6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETM0hj+xzDKsHPO3dNxlH9C
 0+uIc6a1D/ek6rI+m2n6kfsH+/Iz2xj+xz1lvlS6rabo2mvOz1OevZxXu7UtMFJsxfK5+yQPz9Z 5ygoA
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-20-ardb+git@google.com>
Subject: [RFC PATCH 9/9] arm64: ftrace: Simplify PLT handling
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

Instead of emitting the ftrace trampoline PLT into a separate ELF
section, allocate them at the start of the ordinary PLT array, so
that no special sections are needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/module.lds.h |  1 -
 arch/arm64/kernel/module-plts.c     | 18 +++++-------------
 arch/arm64/kernel/module.c          |  9 +--------
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 24fc9401c514..95540e956b41 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,6 +1,5 @@
 SECTIONS {
 	.plt 0 : { BYTE(0) }
-	.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 	/*
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index e30876b90e30..6900d2242f1b 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -275,12 +275,14 @@ static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
 	return i;
 }
 
+static const int ftrace_plts = IS_ENABLED(CONFIG_DYNAMIC_FTRACE) ? NR_FTRACE_PLTS : 0;
+
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0;
+	unsigned long core_plts = ftrace_plts;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *pltsec, *tramp = NULL;
+	Elf_Shdr *pltsec;
 	int i;
 
 	/*
@@ -290,9 +292,6 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
 			mod->arch.core.plt_shndx = i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name,
-				 ".text.ftrace_trampoline"))
-			tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -336,15 +335,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
 	pltsec->sh_addralign = L1_CACHE_BYTES;
 	pltsec->sh_size = (core_plts  + 1) * sizeof(struct plt_entry);
-	mod->arch.core.plt_num_entries = 0;
+	mod->arch.core.plt_num_entries = ftrace_plts;
 	mod->arch.core.plt_max_entries = core_plts;
 
-	if (tramp) {
-		tramp->sh_type = SHT_NOBITS;
-		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-		tramp->sh_addralign = __alignof__(struct plt_entry);
-		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
-	}
-
 	return 0;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 6e5b488a219e..620c2b70115e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -454,14 +454,7 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 				  struct module *mod)
 {
 #if defined(CONFIG_DYNAMIC_FTRACE)
-	const Elf_Shdr *s;
-	struct plt_entry *plts;
-
-	s = find_section(hdr, sechdrs, ".text.ftrace_trampoline");
-	if (!s)
-		return -ENOEXEC;
-
-	plts = (void *)s->sh_addr;
+	struct plt_entry *plts = (void *)sechdrs[mod->arch.core.plt_shndx].sh_addr;
 
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
-- 
2.55.0.860.g4b6b3295ed-goog

