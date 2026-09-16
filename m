Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF464611CA;
	Wed, 16 Sep 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547255; cv=none; b=On7+SvS1qRlsOvxsoyWiD+dn2/s9OnqN95sp7y1/oAlGZpsGpQv/8mErbxB4WlvxmMpnE2usLCe3OHnz76+Y3dP0Os0VTQhbHRIrlXfMp4Y7TDA7TjOTAbbvrAxHJjhicmrR4+svSr7tNXLf7b5brFM9Bl6oKI1ykIwWUW5MLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547255; c=relaxed/simple;
	bh=kaMuPBNAL0Xf+33m9XPS+o0EofYOoG03QZnXngwMiI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxZ1lj7OBDcFHKIHNNAsDTPxoWOYdh3FUt+oyeLl1Q2jQo+YWBYV2yH14LIYBiw+ekQlguEzKxyYg8lfQwm6kgYdujJXuDA6/a21jWisaGqKfxHVLuXV+jW39KD4G6HQtV8wZF46amkrOoJpc1usupkrFpnvsXMBnBUjzYKR0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e30b7d4b1a811f19a56ed5b684f684d-20260916
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f75cb316-c261-40f3-8627-357742c070d0,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:f75cb316-c261-40f3-8627-357742c070d0,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:1c621f5028f912094a09010e4bcc998c,BulkI
	D:260916162723LPNMNM1Q,BulkQuantity:0,SF:17|19|38|66|78|102|127|865|898,TC
	:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e30b7d4b1a811f19a56ed5b684f684d-20260916
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(223.153.93.195)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 199724518; Wed, 16 Sep 2026 16:27:18 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [RFC PATCH] ftrace: speed up module enable by binary searching module symbols
Date: Wed, 16 Sep 2026 16:27:15 +0800
Message-ID: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loading a module with many functions takes seconds, almost all of it in
ftrace_module_enable().  amdgpu modules stall for about ten seconds, and
disabling CONFIG_DYNAMIC_FTRACE makes the stall disappear.

Every record is validated by test_for_valid_rec(), which resolves its ip
through kallsyms_lookup(); for a module address that ends up in
find_kallsyms_symbol(), which walks the whole module symbol table from
index 1.  The core kernel instead binary searches its sorted kallsyms
table in get_symbol_pos().  So only modules pay, and the cost is
quadratic: both the record count and the symbol count grow with the
module.  An amdgpu.ko from this tree has 17282 records and 55332 symbol
table entries.

Fix this by collecting the addresses of a module's symbols once, sorting
them, and binary searching that array instead of walking the table once
per record; a loaded module's symbol table cannot change, so the array
stays valid for the whole pass.  What comes back is what the linear scan
returned: the same entries are skipped - SHN_UNDEF, unnamed and mapping
symbols - and the closest address not below the base of the record's
memory region is taken.  Whenever the array cannot answer, because it
could not be built or because no such symbol exists, the record is handed
to test_for_valid_rec(), so the rest of kallsyms_lookup() still has its
say and no verdict can change.

On the machine that reported the stall, modprobe of that amdgpu.ko takes
12.242 s before and 2.870 s after, and the time spent inside ftrace_lock
drops from 9.368 s to 1.585 ms - 15.195 ms if the price of building the
array is included, that build being 13.6 ms, 0.15% of the 9.37 s saved.
The array costs O(symbols * log symbols), it does not grow with the
record count.  Across the 74 modules loaded at boot, total lock time
drops from 491 ms to 2.33 ms.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/ftrace.c | 131 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 673a54fdf392..92ba9a4dfa69 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -26,6 +26,7 @@
 #include <linux/uaccess.h>
 #include <linux/bsearch.h>
 #include <linux/module.h>
+#include <linux/module_symbol.h>
 #include <linux/ftrace.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
@@ -8010,11 +8011,137 @@ void ftrace_release_mod(struct module *mod)
 	}
 }
 
+#ifdef FTRACE_MCOUNT_MAX_OFFSET
+/*
+ * ftrace_module_enable() validates every record with test_for_valid_rec(),
+ * which walks the whole symbol table of a module for each address in it, so a
+ * large module loads in quadratic time.  Search a sorted copy of the symbol
+ * addresses instead, the way get_symbol_pos() searches the kallsyms table.
+ * The array is an accelerator only; records it cannot resolve are tested the
+ * old way, so the verdict does not change.
+ */
+struct ftrace_mod_syms {
+	unsigned int	nr;
+	unsigned long	addr[];	/* sorted, @nr entries */
+};
+
+static int ftrace_mod_syms_cmp(const void *a, const void *b)
+{
+	unsigned long va = *(const unsigned long *)a;
+	unsigned long vb = *(const unsigned long *)b;
+
+	return (va > vb) - (va < vb);
+}
+
+static struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
+{
+	struct mod_kallsyms *kallsyms;
+	struct ftrace_mod_syms *syms;
+	unsigned int i, nr = 0;
+
+	/* mod->kallsyms is not replaced until do_init_module() returns. */
+	rcu_read_lock();
+	kallsyms = rcu_dereference(mod->kallsyms);
+	rcu_read_unlock();
+
+	if (!kallsyms || kallsyms->num_symtab < 2)
+		return NULL;
+
+	syms = kvmalloc(struct_size(syms, addr, kallsyms->num_symtab),
+			GFP_KERNEL);
+	if (!syms)
+		return NULL;
+
+	/* The symbols find_kallsyms_symbol() would consider. */
+	for (i = 1; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+		const char *name = kallsyms->strtab + sym->st_name;
+
+		if (sym->st_shndx == SHN_UNDEF || !*name ||
+		    is_mapping_symbol(name))
+			continue;
+
+		syms->addr[nr++] = kallsyms_symbol_value(sym);
+	}
+	syms->nr = nr;
+
+	if (nr > 1)
+		sort(syms->addr, nr, sizeof(syms->addr[0]), ftrace_mod_syms_cmp,
+		     NULL);
+
+	return syms;
+}
+
+/* The verdict test_for_valid_rec() would give, without walking the table. */
+static bool ftrace_mod_rec_is_valid(struct module *mod,
+				    const struct ftrace_mod_syms *syms,
+				    struct dyn_ftrace *rec)
+{
+	unsigned long base, best;
+	unsigned int lo, hi;
+
+	if (!syms)
+		return test_for_valid_rec(rec) != 0;
+
+	/* A record is in executable memory; anything else kallsyms answers. */
+	if (within_module_mem_type(rec->ip, mod, MOD_TEXT))
+		base = (unsigned long)mod->mem[MOD_TEXT].base;
+	else if (within_module_mem_type(rec->ip, mod, MOD_INIT_TEXT))
+		base = (unsigned long)mod->mem[MOD_INIT_TEXT].base;
+	else
+		return test_for_valid_rec(rec) != 0;
+
+	/* The closest address at or below @rec->ip, if there is one. */
+	best = 0;
+	for (lo = 0, hi = syms->nr; lo < hi; ) {
+		unsigned int mid = lo + (hi - lo) / 2;
+
+		if (syms->addr[mid] <= rec->ip)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+	if (lo)
+		best = syms->addr[lo - 1];
+
+	/*
+	 * No symbol, or only ones below @base: let kallsyms_lookup() answer,
+	 * as it also looks in the BPF and ftrace trampoline tables.
+	 */
+	if (best < base)
+		return test_for_valid_rec(rec) != 0;
+
+	return rec->ip - best <= FTRACE_MCOUNT_MAX_OFFSET;
+}
+#else
+struct ftrace_mod_syms;
+
+static inline struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
+{
+	return NULL;
+}
+
+static inline bool ftrace_mod_rec_is_valid(struct module *mod,
+					   const struct ftrace_mod_syms *syms,
+					   struct dyn_ftrace *rec)
+{
+	return test_for_valid_rec(rec) != 0;
+}
+#endif /* FTRACE_MCOUNT_MAX_OFFSET */
+
 void ftrace_module_enable(struct module *mod)
 {
+	struct ftrace_mod_syms *syms;
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
 
+	/*
+	 * Allocates, so build it before taking ftrace_lock.  It is skipped when
+	 * ftrace never came up, where the loop below would not run anyway; that
+	 * also makes reading ftrace_disabled without the lock safe.
+	 */
+	syms = ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);
+
 	mutex_lock(&ftrace_lock);
 
 	if (ftrace_disabled)
@@ -8050,7 +8177,7 @@ void ftrace_module_enable(struct module *mod)
 		cond_resched();
 
 		/* Weak functions should still be ignored */
-		if (!test_for_valid_rec(rec)) {
+		if (!ftrace_mod_rec_is_valid(mod, syms, rec)) {
 			/* Clear all other flags. Should not be enabled anyway */
 			rec->flags = FTRACE_FL_DISABLED;
 			continue;
@@ -8087,6 +8214,8 @@ void ftrace_module_enable(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	kvfree(syms);
+
 	process_cached_mods(mod->name);
 }
 
-- 
2.43.0

