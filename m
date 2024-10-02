Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293551D14E8;
	Wed,  2 Oct 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885347; cv=none; b=l8nornXXjiu8hZouxwP2kQBqJtvySR2au7nYKX+CXalW98w5YrxGhhff/9hIP71h4tcZVrpYgprA9mTF1Na0xR8IJNXFTOIsLKAHnS5YdSIPFpKbCl7mca7ruowPkuy4mgi/wBN1YphQwtBOMlc9pyZmH4C76LbBzS1pu0JfoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885347; c=relaxed/simple;
	bh=lWXlRd4W012qkR+2KrtnHm7j963tppJFb5Bms4EKxPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBJ/kSe5WeDy5UmKNA30BGeIhNodH1alo22gcUvSStCeP+meeE0bak152ROSSY/xE2X4akd1locsf85qhQhUnUowjD6RdHLVQ8FzPJ0CnVIXcI5hkuyS6nLbOAbC43tDtEx1DkVO8AIhNeKASAT8H/EgncbJgJn6j/iY4jOw8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=Q0TLXURt; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="Q0TLXURt"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 62E2A609C4;
	Wed,  2 Oct 2024 19:09:03 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-vYLh3gEa;
	Wed, 02 Oct 2024 19:09:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885342;
	bh=vDCJtHtK3uU2sdBk8J/tnuJVXLHuR9McbyPPpAX4VPs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Q0TLXURt2M11h05HQcTCotDXqV17/pTO/eYHxyvF7CpIRwLEfbBfbhK5guCrZhW7i
	 FTOE8WK8gOdDKUCtCqsclUk1GbjcM0KngfLxMtHpSJRo9cn3UXM9NGQ39FLI8zLwTl
	 y0g4IX5ZfCyGA9n7LHUYQ9btKkyR6EMQ9Tfr2MTA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 5/7] kstate: Add mechanism to preserved specified memory pages across kexec.
Date: Wed,  2 Oct 2024 18:07:20 +0200
Message-ID: <20241002160722.20025-6-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

This adds functionality to preserve memory pages across kexec.
kstate_register_page() stores struct page in the special list of
'struct page_state's. At kexec reboot stage this list iterated, pfns
saved into kstate's migrate stream. The new kernel after kexec reads
pfns from the stream and marks memory as reserved to keep it
intact. Also it marked with MEMBLOCK_PRSRV flag indicating that
'struct page' itself shouldn't be reinitialized.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 arch/x86/kernel/kexec-bzimage64.c |  2 +-
 arch/x86/kernel/setup.c           | 81 +++++++++++++++++++++++++++++++
 include/linux/kstate.h            |  6 +++
 kernel/kstate.c                   |  7 +++
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 71c82841e6b12..d769d08cf9a8a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -406,7 +406,7 @@ static int load_migrate_segments(struct kimage *image)
 
 	kbuf.memsz = 8*1024*1024;
 
-	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.buf_align = PAGE_SIZE;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f1fea506e20f4..cfddc902e266b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -15,6 +15,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
+#include <linux/kstate.h>
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
 #include <linux/pci.h>
@@ -638,6 +639,85 @@ static void __init e820_add_kernel_range(void)
 	e820__range_add(start, size, E820_TYPE_RAM);
 }
 
+#ifdef CONFIG_KSTATE
+struct state_entry mem_kstate;
+
+struct mem_state {
+	unsigned int nr_pages;
+	struct list_head list;
+};
+struct page_state {
+	struct list_head list;
+	int order;
+	struct page *page;
+};
+
+struct mem_state m_state = { .list = LIST_HEAD_INIT(m_state.list) };
+
+int kstate_register_page(struct page *page, int order)
+{
+	struct page_state *state;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->page = page;
+	state->order = order;
+	list_add(&state->list, &m_state.list);
+	m_state.nr_pages++;
+	return 0;
+}
+
+static int kstate_pages_save(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct page_state *p_state;
+	void *start = mig_stream;
+
+	list_for_each_entry(p_state, &m_state.list, list) {
+		mig_stream = kstate_save_byte(mig_stream, p_state->order);
+		mig_stream = kstate_save_ulong(mig_stream, page_to_phys(p_state->page));
+	}
+	return mig_stream - start;
+}
+
+static int __init kstate_pages_restore(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct mem_state *m_state = obj;
+	int nr_pages, i;
+
+	nr_pages = m_state->nr_pages;
+	for (i = 0; i < nr_pages; i++) {
+		int order = kstate_get_byte(&mig_stream);
+		unsigned long phys = kstate_get_ulong(&mig_stream);
+
+		memblock_reserve(phys, PAGE_SIZE << order);
+		memblock_reserved_mark_preserved(phys, PAGE_SIZE << order);
+	}
+	return 0;
+}
+
+struct kstate_description kstate_reserved = {
+	.name = "reserved_mem",
+	.id = KSTATE_RSVD_MEM_ID,
+	.state_list = LIST_HEAD_INIT(kstate_reserved.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_SIMPLE(nr_pages, struct mem_state),
+		{
+			.name = "pages",
+			.flags = KS_CUSTOM,
+			.size = sizeof(struct mem_state),
+			.save = kstate_pages_save,
+			.restore = kstate_pages_restore,
+		},
+
+		KSTATE_END_OF_LIST()
+	},
+};
+#endif
+
 static void __init early_reserve_memory(void)
 {
 	/*
@@ -989,6 +1069,7 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
+	__kstate_register(&kstate_reserved, &m_state, &mem_kstate);
 
 	/*
 	 * Needs to run after memblock setup because it needs the physical
diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index c97804d0243ea..855acb339d5d7 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -29,6 +29,8 @@ struct kstate_field {
 };
 
 enum kstate_ids {
+	KSTATE_PAGE_ID,
+	KSTATE_RSVD_MEM_ID,
 	KSTATE_LAST_ID = -1,
 };
 
@@ -87,6 +89,10 @@ void *save_kstate(void *stream, int id, const struct kstate_description *kstate,
 		void *obj);
 void *restore_kstate(struct kstate_entry *ke, int id,
 		const struct kstate_description *kstate, void *obj);
+
+int kstate_page_save(void *mig_stream, void *obj,
+		const struct kstate_field *field);
+int kstate_register_page(struct page *page, int order);
 #else
 
 #define __kstate_register(state, obj, se)
diff --git a/kernel/kstate.c b/kernel/kstate.c
index 0ef228baef94e..7f7e135bafd81 100644
--- a/kernel/kstate.c
+++ b/kernel/kstate.c
@@ -182,6 +182,13 @@ int kstate_register(struct kstate_description *state, void *obj)
 	return 0;
 }
 
+int kstate_page_save(void *mig_stream, void *obj,
+		const struct kstate_field *field)
+{
+	kstate_register_page(*(struct page **)obj, 0);
+	return 0;
+}
+
 static int __init setup_migrate(char *arg)
 {
 	char *end;
-- 
2.45.2

