Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626281D0E1B;
	Wed,  2 Oct 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885349; cv=none; b=FUP4f20hXt90ZDRVBmJtjTVtBBbDlZ2TM2/zf9AiQ7KcaYYuhoVxPBa5JJxEbFA/D4wouUDCxvykXXeFUFUZDXLziXnwavSx2jruLiWPA5cmFmjaXAH+SR1VZWrY2yIUYloKDVgCvHVpPB3Jo2ajC5tqRg/QdBqNuQ94OJilV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885349; c=relaxed/simple;
	bh=vnnWpNAcaXOZPTAhlNQ8w9M/4YoI/vFJdPQ9pACtY0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQOk2w5JubUX1lU3kQMOZWq8gOSGA7rfuzEx0ZmeGLZLIffqgugMu61oZjhC/su0glqsjjFjtj6Q7BpQUb9928mzL6kplSEt2fdVIKt/uz31Eicxqt9U9KYNeSfDSNEKakANwauDzwFpfuPCHtg5uXfIYR5F9oJ+bSzFFWXBqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=QJ6MOGmC; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="QJ6MOGmC"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E548260A23;
	Wed,  2 Oct 2024 19:09:05 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-nRmmw9QO;
	Wed, 02 Oct 2024 19:09:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885345;
	bh=0gXnv/qrKYuE/cS8ZBx3ikqYeKs1eCUWKuL7cMB0Reg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=QJ6MOGmC2WXQfZHzJZ1VaR1B8rKzNr7QnMVdzqdp+QQv3P0S3FHMiPewEj2rscP08
	 wpInBKldjvUn90+GV+UmlmIIYMJDqh6JpsBqKYkROXaqaEMgJ2zuIgRq06YpaV+5qL
	 OvdxqE3T7r9VwN+6lIu4k91/bcBG6keVqTB4vvQk=
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
Subject: [RFC PATCH 6/7] kstate, test: add test module for testing kstate subsystem.
Date: Wed,  2 Oct 2024 18:07:21 +0200
Message-ID: <20241002160722.20025-7-arbn@yandex-team.com>
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

This is simple test and playground useful kstate subsystem development.
It contains some structure with different kind of data which migrated
across kexec to the new kernel using kstate.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |  1 +
 lib/Makefile           |  2 +
 lib/test_kstate.c      | 89 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 lib/test_kstate.c

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 855acb339d5d7..2ddbe41a1f171 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -31,6 +31,7 @@ struct kstate_field {
 enum kstate_ids {
 	KSTATE_PAGE_ID,
 	KSTATE_RSVD_MEM_ID,
+	KSTATE_TEST_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af416..2432e47664c35 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -354,6 +354,8 @@ obj-$(CONFIG_PARMAN) += parman.o
 
 obj-y += group_cpus.o
 
+obj-$(CONFIG_KSTATE) += test_kstate.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
diff --git a/lib/test_kstate.c b/lib/test_kstate.c
new file mode 100644
index 0000000000000..e95e3110f8949
--- /dev/null
+++ b/lib/test_kstate.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/io.h>
+#include <linux/kstate.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+unsigned long ulong_val;
+struct kstate_test_data {
+	int i;
+	unsigned long *p_ulong;
+	char s[10];
+	struct page *page;
+};
+
+struct kstate_description test_state = {
+	.name = "test",
+	.version_id = 1,
+	.id = KSTATE_TEST_ID,
+	.state_list = LIST_HEAD_INIT(test_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_SIMPLE(i, struct kstate_test_data),
+		KSTATE_SIMPLE(s, struct kstate_test_data),
+		KSTATE_POINTER(p_ulong, struct kstate_test_data),
+		{
+			.name = "page",
+			.flags = KS_CUSTOM,
+			.offset = offsetof(struct kstate_test_data, page),
+			.save = kstate_page_save,
+		},
+		KSTATE_SIMPLE(page, struct kstate_test_data),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+static struct kstate_test_data test_data;
+
+static int init_test_data(void)
+{
+	struct page *page;
+	int i;
+
+	test_data.i = 10;
+	ulong_val = 20;
+	memcpy(test_data.s, "abcdefghk", sizeof(test_data.s));
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4)
+		*((u32 *)page_address(page) + i) = 0xdeadbeef;
+	test_data.page = page;
+	return 0;
+}
+
+static void validate_test_data(void)
+{
+	int i;
+
+	WARN_ON(test_data.i != 10);
+	WARN_ON(*test_data.p_ulong != 20);
+	WARN_ON(strcmp(test_data.s, "abcdefghk") != 0);
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4) {
+		u32 val = *((u32 *)page_address(test_data.page) + i);
+
+		WARN_ON(val != 0xdeadbeef);
+	}
+}
+
+static int __init test_kstate_init(void)
+{
+	int ret = 0;
+
+	test_data.p_ulong = &ulong_val;
+
+	if (!is_migrate_kernel()) {
+		ret = init_test_data();
+		if (ret)
+			goto out;
+	}
+
+	kstate_register(&test_state, &test_data);
+
+	validate_test_data();
+
+out:
+	return ret;
+}
+__initcall(test_kstate_init);
-- 
2.45.2

