Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D783FE7;
	Tue, 19 Aug 2025 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585335; cv=none; b=RIKfgGuj81g9U0+EgRUFMwMJPnH02UKhtlQtm/nHKu+NqjPfc2uP1+uFStuNPa1VZGdF2Y2nfsKuDBQwF5dCTE6YaMRDaQ6cMIZlJC3kOTFtiMbCd8NBzgYq2Nx3xXWVmaNfR+fy4CGL7Cfw0EajB/ueuMbVBo12BZ1ZAJG07zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585335; c=relaxed/simple;
	bh=HRj4l2EGfZhLBAunGlrrUthdaret96N7ZU072++bGlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pBChVrbquTKa+HcGz4Cb5FuF4JzurfcmefIZvmjOB2CoY9DlPkfAPCFu+zqgcMLmgSfrtxARZgOtn90sBC5NzlGGACcAiPJFWF3vAhFWj9F7TppgvSW+r4ROoM2LUwyY112Y4erXaOnUsFfxHNwGJj5D7hROEleG5T9D27hYHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fK9VZziO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fK9VZziO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INxuI3002398;
	Tue, 19 Aug 2025 06:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nSPgEhJuoihhpFA0l0O974
	0kOLrXBNfXEzcayACwKZs=; b=fK9VZziOfJfkVeIjJ43UIVHb1JbZ3PrwGVjYJJ
	/De9CUIU+dPY2rNYkkUvY1MtGA40W9AnR9UL9tRHMiZ4URQRQ9BqzcN42pvOgDGW
	GV76xadZTadFfL2xh/qsCSBtP+qgEsrpYmKt34FIMNvFqNLxF+InFYQ+TJIgTZyO
	a5EptAojgCZctLrvJosKdiurw3CnF3c6w4itSNP5t+S4CqyeJdoUHoespBgrtHV9
	q112JHaY0SA6v7JhyJEPAghJQPjN5KE0+cLsw5Lzd4oWLmmZsMCMumoiXVR+2yYV
	vkBMu+bZRFxwx8vFvIgzIlFXKrS8tDLl6STM4OMdP0n8tuXw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vjdxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 06:35:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57J6ZKfc031272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 06:35:20 GMT
Received: from hu-panfan-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 23:35:20 -0700
From: panfan <panfan@qti.qualcomm.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <panfan@qti.qualcomm.com>, <samitolvanen@google.com>,
        <song@kernel.org>, <ardb@kernel.org>, <dylanbhatch@google.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <kdong@qti.qualcomm.com>
Subject: [PATCH v1] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Mon, 18 Aug 2025 23:34:18 -0700
Message-ID: <20250819063418.1263119-1-panfan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX5/2ISPEnklR0
 2IjzffwxTkU1ld6bIYIRWETjc4Si69TnLkkzuM+lUnND6SLLCOGiMn7eZHuIsx21dVZuioTNY3P
 JyEqOFycw0qE6YghY9NlgNwnj5NWkKesvNN/H7FC2PyX0RXx7/6/TuKHYybfyMQclADB4P//CaO
 GD1ZrszSktSSmhkJEjWG4KPWFSbEcHhC39JePfElC8n4b/uzmaXKkLjrcy3Vh6giBXTQFtmTw8L
 7jIqBGEw5YvUnhHexw8KAUJZN3WZkDSXY5YPwZtdCexRhncaY/kCvtzXKnOH+OrCBXsGJ/84cE5
 hCYiahO05xW53VC26Aaf9JBbkfAqGSAxUAFTGI9jlAhCwZ8UoQOrZTo8+0UA5QPaEBUM+0KnK0q
 FqZnuOhW
X-Proofpoint-GUID: TJJOlxOm8QA_FaMQVnevoIeX8EEgYKu8
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a41b29 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=rSl61HDpvd9wl2GIgggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TJJOlxOm8QA_FaMQVnevoIeX8EEgYKu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

with the previous patch [PATCH v3 6/6] arm64: module: rework module VA
range selection, the module region can use a full 2GB for large modules.

On arm64 with CONFIG_DYNAMIC_FTRACE, due to the ±128 MB range limit of
the `BL` instruction, ftrace uses a PLT entry to branch indirectly to
ftrace_caller when modules may be placed far away.

Currently, this PLT(.text.ftrace_trampoline) resides in MOD_TEXT,
so call sites in .init.text cannot reach it by `BL` if .init.text
and .text are allocated in different 128 MB regions.

For example, init_moudle in tz_log_dlkm.ko can not reach PLT or
ftrace_caller by `BL`:

module_direct_base = 0xFFFFFFC07B270000   128M
module_plt_base = 0xFFFFFFC003270000  2G

mod = 0xFFFFFFC07FF65880 -> (
    state = MODULE_STATE_COMING,
    name = "tz_log_dlkm",
    init = 0xFFFFFFC00370F01C,

    mem = (
      (base = 0xFFFFFFC07E7E8000, size = 12288,  // MOD_TEXT -- direct
      (base = 0xFFFFFFC07FF65000, size = 12288,  // MOD_DATA
      (base = 0xFFFFFFC07FFFB000, size = 12288,  // MOD_RODATA
      (base = 0xFFFFFFC07DDA9000, size = 4096,   // MOD_RO_AFTER_INIT
      (base = 0xFFFFFFC00370F000, size = 4096,   // MOD_INIT_TEXT -- plt
      (base = 0xFFFFFFC003711000, size = 12288,  // MOD_INIT_DATA

    arch = (
      core = (plt_shndx = 8, plt_num_entries = 0, plt_max_entries = 35),
      init = (plt_shndx = 9, plt_num_entries = 1, plt_max_entries = 1),
      ftrace_trampolines = 0xFFFFFFC07E7EA730 -> (   //
.text.ftrace_trampoline in MOD_TEXT

PLT in .text.ftrace_trampoline:
0xFFFFFFC07E7EA730            adrp    x16,0xFFFFFFC080014000
0xFFFFFFC07E7EA734            add     x16,x16,#0xF64   ; x16,x16,#3940
0xFFFFFFC07E7EA738            br      x16; ftrace_caller

Here, init_module() in MOD_INIT_TEXT cannot branch to the PLT in MOD_TEXT
because the offset exceeds 128 MB. As a result,
ftrace fails to update `nop` to `BL` and inserts `brk #0x100` instead:

0xFFFFFFC00370F01C  init_module:    mov     x9,x30
0xFFFFFFC00370F020                  brk     #0x100           ; #256

[   36.290790][  T835] label_imm_common: offset out of range

[   36.333765][  T835] Kernel text patching generated an invalid instruct
ion at init_module+0x4/0xfe4 [tz_log_dlkm]!

[   36.335728][  T835] Call trace:
[   36.335735][  T835]  init_module+0x4/0xfe4 [tz_log_dlkm]
[   36.335750][  T835]  do_init_module+0x60/0x2cc
[   36.335761][  T835]  load_module+0x10e0/0x12ac
[   36.335771][  T835]  __arm64_sys_finit_module+0x240/0x348
[   36.335780][  T835]  invoke_syscall+0x60/0x11c
[   36.335791][  T835]  el0_svc_common+0xb4/0xf0
[   36.335801][  T835]  do_el0_svc+0x24/0x30
[   36.335810][  T835]  el0_svc+0x3c/0x74
[   36.335821][  T835]  el0t_64_sync_handler+0x68/0xbc
[   36.335831][  T835]  el0t_64_sync+0x1a8/0x1ac

To fix this, introduce an additional `.init.text.ftrace_trampoline`
section for .init.text. This provides a PLT within MOD_INIT_TEXT, ensuring
that init functions can branch within range using `BL`. This section
is freed after do_one_initcall, so there is no persistent cost.
The core text continues to use the existing PLT in MOD_TEXT.

Signed-off-by: panfan <panfan@qti.qualcomm.com>
---
 arch/arm64/include/asm/module.h     |  1 +
 arch/arm64/include/asm/module.lds.h |  1 +
 arch/arm64/kernel/ftrace.c          | 11 ++++++++---
 arch/arm64/kernel/module-plts.c     | 12 +++++++++++-
 arch/arm64/kernel/module.c          | 11 +++++++++++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..fb9b88eebeb1 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -19,6 +19,7 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
+	struct plt_entry	*init_ftrace_trampolines;
 };
 
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index b9ae8349e35d..fb944b46846d 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -2,6 +2,7 @@ SECTIONS {
 	.plt 0 : { BYTE(0) }
 	.init.plt 0 : { BYTE(0) }
 	.text.ftrace_trampoline 0 : { BYTE(0) }
+	.init.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 	/*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5a890714ee2e..bf2d08d8c547 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -258,10 +258,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod)
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 {
 #ifdef CONFIG_MODULES
-	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+	struct plt_entry *plt = NULL;
+
+	if (within_module_mem_type(addr, mod, MOD_INIT_TEXT))
+		plt = mod->arch.init_ftrace_trampolines;
+	else
+		plt = mod->arch.ftrace_trampolines;
 
 	return &plt[FTRACE_PLT_IDX];
 #else
@@ -332,7 +337,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod);
+	plt = get_ftrace_plt(mod, pc);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index bde32979c06a..7afd370da9f4 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -283,7 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *pltsec, *tramp = NULL;
+	Elf_Shdr *pltsec, *tramp = NULL, *init_tramp = NULL;
 	int i;
 
 	/*
@@ -298,6 +298,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name,
+				 ".init.text.ftrace_trampoline"))
+			init_tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -363,5 +366,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
 	}
 
+	if (init_tramp) {
+		init_tramp->sh_type = SHT_NOBITS;
+		init_tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		init_tramp->sh_addralign = __alignof__(struct plt_entry);
+		init_tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 40148d2725ce..d6d443c4a01a 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -466,6 +466,17 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
 	mod->arch.ftrace_trampolines = plts;
+
+	s = find_section(hdr, sechdrs, ".init.text.ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	plts = (void *)s->sh_addr;
+
+	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
+
+	mod->arch.init_ftrace_trampolines = plts;
+
 #endif
 	return 0;
 }
-- 
2.34.1

