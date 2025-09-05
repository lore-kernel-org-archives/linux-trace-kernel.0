Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A0EEBD;
	Fri,  5 Sep 2025 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042620; cv=none; b=hSXWXA2HzSivGYQQI97Iqutedpamqm9b3cIC1A6s2yq5yLY1+7dNxv4+4hSOw1s0Xg76FKkbpuBlcfzzhLKX2/qSYh/88tkW/44sKTigukh/9HI51uVP3SQ0hMNUgoKUi9I+JIO8zpt8Dpy+MzPttc7h+dNOW9Qh9NRhyzPdFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042620; c=relaxed/simple;
	bh=kWHPFInfkxBP79BsV47l2SdNdgqm7eP19dXNcrd2Nlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dmHnjWBEZ556Kvyx2rLWWbNHzMkMKMoyc7ea6Uanv/AsazTqh60e1YQktr84q525wy0tEPD9LxrKZGoVgAhoC4gI6aRT8gMF+g4mxvvkwz3vPXy+399cuIv9UlKbVWNu0KkMTm/+qpn9MH9P1PrAHI1A157Ao8Db45IZPmBUwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVkwHsRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVkwHsRQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IrD3U022162;
	Fri, 5 Sep 2025 03:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bZY1FQK+PTrKFmQKdUegMK
	hl+tdKa5m24gfzDGZOIcE=; b=UVkwHsRQ4kbjhtfYmVj+Kw3hAdfeAHrI/0JO0x
	/XryTSaVGnavS5TjxtPAYcK/NuhRjWKnVdcPNI6KTPNKsoW96MXn9Z8DWb67Fm/B
	hI5BU9bYljm9Wztc2CFKv8RQ5ag9ZwZJLINvcaq+JUnbSGs2JdtmhOrqFbh3CQF9
	uHJwffeVikNJ4CAmmOzonC/IwOvXehLJV8HuKqR2F51GhoOZlpXnv0YVm+Knz778
	Jp8TZEbe/OGc+t6Y+A1XD00AGfTGmp6P5qbPKaZimU2mKSr3Xx1vi/xwod9aX87z
	+15KjOArvK+F4lwvQNhM83/XAyS0oysVPJ317QbgsHNeJlzA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk99gfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 03:23:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5853NRLL015294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 03:23:27 GMT
Received: from hu-panfan-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 4 Sep 2025 20:23:26 -0700
From: panfan <panfan@qti.qualcomm.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <panfan@qti.qualcomm.com>, <samitolvanen@google.com>,
        <song@kernel.org>, <ardb@kernel.org>, <dylanbhatch@google.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <kdong@qti.qualcomm.com>,
        <haijianc@qti.qualcomm.com>
Subject: [PATCH v2] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Thu, 4 Sep 2025 20:22:36 -0700
Message-ID: <20250905032236.3220885-1-panfan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HV9T0RRsknncE9UG9d85IRGELm2k2ifG
X-Proofpoint-ORIG-GUID: HV9T0RRsknncE9UG9d85IRGELm2k2ifG
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68ba57b0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XwCMDglm2lP2NyoYPEUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX+dwZZouyTGrj
 ys6+5wyqui1ZsAbllT4z/35qC9p/6NCMt8aPxQvUYeVTPKpQhaF61XTzOfSUHyEnQOUHUKf2yL8
 LSe4kK/BpSJ4lfw7cfQwKRGPSLg0/zIeJQKdnuuAw+EDU/s1ptolM09BQqr/E+RKaaxUZQC5eX8
 bTdtJHkgUnpeW5byEQtqDOTnX/ladChzPTrGzEH2YSAAr54qNdf6qYuz7Z3aTP8d3kYgQOm22le
 P9rG9uZrlVkgupUsrn7bz4agJIaXY4dEGQHMwEDag0Tce33rpBv/ASB2wpUIz/gXDOiuzv1IcBe
 5WjeEW7sB64R64EUKm2yA8Ooibp/WiwVdW0NauEe4b/JBxC390nzwVukj87HbIZPVNS6ejsVcoh
 WppNg2bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On arm64, it has been possible for a module's sections to be placed more
than 128M away from each other since commit:

  commit 3e35d303ab7d ("arm64: module: rework module VA range selection")

Due to this, an ftrace callsite in a module's .init.text section can be
out of branch range for the module's ftrace PLT entry (in the module's
.text section). Any attempt to enable tracing of that callsite will
result in a BRK being patched into the callsite, resulting in a fatal
exception when the callsite is later executed.

Fix this by adding an additional trampoline for .init.text, which will
be within range.

No additional trampolines are necessary due to the way a given
module's executable sections are packed together. Any executable
section beginning with ".init" will be placed in MOD_INIT_TEXT,
and any other executable section, including those beginning with ".exit",
 will be placed in MOD_TEXT.

Fixes: 3e35d303ab7d ("arm64: module: rework module VA range selection")

Signed-off-by: panfan <panfan@qti.qualcomm.com>
---
v2:
   - Add an explicit check to ensure the address is within MOD_INIT_TEXT
     or MOD_TEXT.
   - Simplify the commit message.

Link: https://lore.kernel.org/all/20250819063418.1263119-1-panfan@qti.qualcomm.com/   # v1
---
 arch/arm64/include/asm/module.h     |  1 +
 arch/arm64/include/asm/module.lds.h |  1 +
 arch/arm64/kernel/ftrace.c          | 13 ++++++++++---
 arch/arm64/kernel/module-plts.c     | 12 +++++++++++-
 arch/arm64/kernel/module.c          | 11 +++++++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index 5a890714ee2e..5adad37ab4fa 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -258,10 +258,17 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
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
+	else if (within_module_mem_type(addr, mod, MOD_TEXT))
+		plt = mod->arch.ftrace_trampolines;
+	else
+		return NULL;
 
 	return &plt[FTRACE_PLT_IDX];
 #else
@@ -332,7 +339,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
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

