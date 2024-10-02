Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0071D096B;
	Wed,  2 Oct 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885340; cv=none; b=TQYkwBpK6dK5x85kKpkCff/Jx+AM5STh84alaUTLIoZcoA4rf40JXJ7cp1dApxcLMmvH57BxRhWRx7qY1NinrApU+FZ3YfcuIgmOD7Pnwa+bpmHIHxcqdjEszyke0uH4vLbJofIOkw6abUzhoNa9Lzd8P4G5aDstC/k1zgQ4CTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885340; c=relaxed/simple;
	bh=Ph1JSH3so2QDpuJP4xo6S6knDf1xV5EBulULkB1cgbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbvX3eOcNXUb1RaybNHqGimMBW4IuK/Wq/6yGO3m9zKfuHhOmJJ6Pw8xPfKMX3xTIvPU9G+P5qCyWiph0ttIHoV09oazmJueYTIgXE8DKxYpaQ+wYCbyfwEoLn6AdHD/51AEq5EJGY+D0dJLBcrw9jvFqFVBvtmeyYXXgEqZth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=Wl/qGGKH; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="Wl/qGGKH"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2065060A59;
	Wed,  2 Oct 2024 19:08:53 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-Eli2J3P3;
	Wed, 02 Oct 2024 19:08:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885332;
	bh=4BDwgTNznoqh19FbW1xbxFVkO1uBqVi3RNsbBRD27Tk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Wl/qGGKHTSFA9wWN1bbDi0YbwEitbGlvPpRRrKsCp6ccao0ouB11BBtvPJ8m+RQU9
	 S1A+woHBqqO/jmqdf0EgywyOtxMlp2iXTZwnlRl9UdmwlHpLYKiFEQdpmQ5pmgN62h
	 H2VfuCOascBrttGcumZxN4A5bl1+FwHOgUl+Ts/8=
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
Subject: [RFC PATCH 1/7] kstate: Add kstate - a mechanism to migrate some kernel state across kexec
Date: Wed,  2 Oct 2024 18:07:16 +0200
Message-ID: <20241002160722.20025-2-arbn@yandex-team.com>
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

kstate (kernel state) is a mechanism to describe internal kernel state
(partially), save it into the memory and restore the state after kexec
in new kernel.

The end goal here and the main use case for this is to be able to
update host kernel under VMs with VFIO pass-through devices running
on that host.
We are pretty far from that end goal yet. This and following patches
only try to establish some basic infrastructure to describe and migrate
complex in-kernel states. And as a demonstration, the state of trace buffer
migrated across kexec to new kernel (in the follow up patches).

States (usually this is some struct) are described by the
'struct kstate_description' containing the array of individual
fields descpriptions - 'struct kstate_field'.
Fields have different types like:
   KS_SIMPLE  - trivial type that just copied by value

   KS_POINTER - field contains pointer, it will be dereferenced to copy
     the value during save/restore phases.

   KS_STRUCT - contains another struct,
       field->ksd must point to another 'struct kstate_dscription'

   KS_CUSTOM - something that requires fit trivial types as above,
               for this fields the callbacks field->save()/->restore() must
	       do all job
   KS_ARRAY_OF_POINTER - array of pointers, the size of array determined by the
                         field->count() callback
   KS_END - special flag indicating the end of migration stream data.

kstate_register() call accepts kstate_description along with an instance
of an object and registers it in the global 'states' list.

During kexec reboot phase this list iterated, and for each instance
in the list 'struct kstate_entry' formed and saved in the migration stream.
'kstate_entry' contains information like ID of kstate_description, version
of it, size of migration data and the data itself.

After the reboot, when the kstate_register() called it parses migration
stream, finds the appropriate 'kstate_entry' and restores the contents of the
object.

This is an early RFC, so the code is somewhat hacky and some parts
of this feature isn't well thought trough yet (like dealing with
struct changes between old and new kernel, fixed size of migrate stream
memory, and many more).

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h | 118 ++++++++++++++++++++++++
 kernel/Kconfig.kexec   |  12 +++
 kernel/Makefile        |   1 +
 kernel/kstate.c        | 198 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 include/linux/kstate.h
 create mode 100644 kernel/kstate.c

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
new file mode 100644
index 0000000000000..c97804d0243ea
--- /dev/null
+++ b/include/linux/kstate.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTATE_H
+#define _KSTATE_H
+
+#include <linux/atomic.h>
+#include <linux/list.h>
+#include <linux/stringify.h>
+
+struct kstate_description;
+enum kstate_flags {
+	KS_SIMPLE = (1 << 0),
+	KS_POINTER = (1 << 1),
+	KS_STRUCT = (1 << 2),
+	KS_CUSTOM = (1 << 3),
+	KS_ARRAY_OF_POINTER = (1 << 4),
+	KS_END = (1UL << 31),
+};
+
+struct kstate_field {
+	const char *name;
+	size_t offset;
+	size_t size;
+	enum kstate_flags flags;
+	const struct kstate_description *ksd;
+	int version_id;
+	int (*restore)(void *mig_stream, void *obj, const struct kstate_field *field);
+	int (*save)(void *mig_stream, void *obj, const struct kstate_field *field);
+	int (*count)(void);
+};
+
+enum kstate_ids {
+	KSTATE_LAST_ID = -1,
+};
+
+struct kstate_description {
+	const char *name;
+	enum kstate_ids id;
+	atomic_t instance_id;
+	int version_id;
+	struct list_head state_list;
+
+	const struct kstate_field *fields;
+};
+
+struct state_entry {
+	u64 id;
+	struct list_head list;
+	struct kstate_description *kstd;
+	void *obj;
+};
+
+static inline bool kstate_get_byte(void **mig_stream)
+{
+	bool ret = **(u8 **)mig_stream;
+	(*mig_stream)++;
+	return ret;
+}
+static inline void *kstate_save_byte(void *mig_stream, u8 val)
+{
+	*(u8 *)mig_stream = val;
+	return mig_stream + sizeof(val);
+}
+
+static inline void *kstate_save_ulong(void *mig_stream, unsigned long val)
+{
+	*(unsigned long *)mig_stream = val;
+	return mig_stream + sizeof(val);
+}
+static inline unsigned long kstate_get_ulong(void **mig_stream)
+{
+	unsigned long ret = **(unsigned long **)mig_stream;
+	(*mig_stream) += sizeof(unsigned long);
+	return ret;
+}
+
+#ifdef CONFIG_KSTATE
+bool is_migrate_kernel(void);
+
+void save_migrate_state(unsigned long mig_stream);
+
+void __kstate_register(struct kstate_description *state,
+		void *obj, struct state_entry *se);
+int kstate_register(struct kstate_description *state, void *obj);
+
+struct kstate_entry;
+void *save_kstate(void *stream, int id, const struct kstate_description *kstate,
+		void *obj);
+void *restore_kstate(struct kstate_entry *ke, int id,
+		const struct kstate_description *kstate, void *obj);
+#else
+
+#define __kstate_register(state, obj, se)
+#define kstate_register(state, obj)
+
+static inline void save_migrate_state(unsigned long mig_stream) { }
+
+#endif
+
+
+#define KSTATE_SIMPLE(_f, _state) {			\
+		.name = (__stringify(_f)),		\
+		.size = sizeof_field(_state, _f),	\
+		.flags = KS_SIMPLE,			\
+		.offset = offsetof(_state, _f),		\
+	}
+
+#define KSTATE_POINTER(_f, _state) {			\
+		.name = (__stringify(_f)),		\
+		.size = sizeof(*(((_state *)0)->_f)),	\
+		.flags = KS_POINTER,			\
+		.offset = offsetof(_state, _f),		\
+	}
+
+#define KSTATE_END_OF_LIST() {	\
+		.flags = KS_END,\
+	}
+
+#endif
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff4..d8fecf29e384a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -151,4 +151,16 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+config KSTATE
+	bool "Migrate certain internal kernel state across kexec"
+	default n
+	depends on CRASH_DUMP
+	help
+	  Enable functionality to migrate some internal kernel states to new
+	  kernel across kexec. Currently capable only migrating trace buffers
+	  as an example. Can be extended to other states like IOMMU page tables,
+	  VFIO state of the device...
+	  Description of the trace buffer saved into memory preserved across kexec.
+	  The new kernel reads description to restore the state of trace buffers.
+
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbed..6bdf947fc84f5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KSTATE) += kstate.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kstate.c b/kernel/kstate.c
new file mode 100644
index 0000000000000..0ef228baef94e
--- /dev/null
+++ b/kernel/kstate.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/kexec.h>
+#include <linux/kstate.h>
+
+static LIST_HEAD(states);
+
+struct kstate_entry {
+	int state_id;
+	int version_id;
+	int instance_id;
+	int size;
+	DECLARE_FLEX_ARRAY(u8, data);
+};
+
+void *save_kstate(void *stream, int id, const struct kstate_description *kstate,
+		void *obj)
+{
+	const struct kstate_field *field = kstate->fields;
+	struct kstate_entry *ke = stream;
+
+	stream = ke->data;
+
+	ke->state_id = kstate->id;
+	ke->version_id = kstate->version_id;
+	ke->instance_id = id;
+
+	while (field->flags != KS_END) {
+		void *first,  *cur;
+		int n_elems = 1;
+		int size, i;
+
+		first = obj + field->offset;
+
+		if (field->flags & KS_POINTER)
+			first = *(void **)(obj + field->offset);
+		if (field->count)
+			n_elems = field->count();
+		size = field->size;
+		for (i = 0; i < n_elems; i++) {
+			cur = first + i * size;
+
+			if (field->flags & KS_ARRAY_OF_POINTER)
+				cur = *(void **)cur;
+
+			if (field->flags & KS_STRUCT)
+				stream = save_kstate(stream, 0, field->ksd, cur);
+			else if (field->flags & KS_CUSTOM) {
+				if (field->save)
+					stream += field->save(stream, cur, field);
+			} else if (field->flags & (KS_SIMPLE|KS_POINTER)) {
+				memcpy(stream, cur, size);
+				stream += size;
+			} else
+				WARN_ON_ONCE(1);
+
+		}
+		field++;
+
+	}
+
+	ke->size = (u8 *)stream - ke->data;
+	return stream;
+}
+
+void save_migrate_state(unsigned long mig_stream)
+{
+	struct state_entry *se;
+	struct kstate_entry *ke;
+	void *dest;
+	struct page *page;
+
+	page = boot_pfn_to_page(mig_stream >> PAGE_SHIFT);
+	arch_kexec_post_alloc_pages(page_address(page), 512, 0);
+	dest = page_address(page);
+	list_for_each_entry(se, &states, list)
+		dest = save_kstate(dest, se->id, se->kstd, se->obj);
+	ke = dest;
+	ke->state_id = KSTATE_LAST_ID;
+}
+
+void *restore_kstate(struct kstate_entry *ke, int id,
+		const struct kstate_description *kstate, void *obj)
+{
+	const struct kstate_field *field = kstate->fields;
+	u8 *stream = ke->data;
+
+	WARN_ONCE(ke->version_id != kstate->version_id, "version mismatch %d %d\n",
+		ke->version_id, kstate->version_id);
+
+	WARN_ONCE(ke->instance_id != id, "instance id mismatch %d %d\n",
+		ke->instance_id, id);
+
+	while (field->flags != KS_END) {
+		void *first, *cur;
+		int n_elems = 1;
+		int size, i;
+
+		first = obj + field->offset;
+		if (field->flags & KS_POINTER)
+			first = *(void **)(obj + field->offset);
+		if (field->count)
+			n_elems = field->count();
+		size = field->size;
+		for (i = 0; i < n_elems; i++) {
+			cur = first + i * size;
+
+			if (field->flags & KS_ARRAY_OF_POINTER)
+				cur = *(void **)cur;
+
+			if (field->flags & KS_STRUCT)
+				stream = restore_kstate((struct kstate_entry *)stream,
+							0, field->ksd, cur);
+			else if (field->flags & KS_CUSTOM) {
+				if (field->restore)
+					stream += field->restore(stream, cur, field);
+			} else if (field->flags & (KS_SIMPLE|KS_POINTER)) {
+				memcpy(cur, stream, size);
+				stream += size;
+			} else
+				WARN_ON_ONCE(1);
+
+		}
+		field++;
+	}
+
+	return stream;
+}
+
+static void restore_migrate_state(unsigned long mig_stream,
+				struct state_entry *se)
+{
+	char *dest;
+	struct kstate_entry *ke;
+
+	if (mig_stream == -1)
+		return;
+
+	dest = phys_to_virt(mig_stream);
+	ke = (struct kstate_entry *)dest;
+	while (ke->state_id != KSTATE_LAST_ID) {
+		if (ke->state_id != se->kstd->id ||
+		    ke->instance_id != se->id) {
+			ke = (struct kstate_entry *)(ke->data + ke->size);
+			continue;
+		}
+
+		restore_kstate(ke, se->id, se->kstd, se->obj);
+		ke = (struct kstate_entry *)(ke->data + ke->size);
+	}
+}
+
+unsigned long long migrate_stream_addr = -1;
+EXPORT_SYMBOL_GPL(migrate_stream_addr);
+unsigned long long migrate_stream_size;
+
+bool is_migrate_kernel(void)
+{
+	return migrate_stream_addr != -1;
+}
+
+void __kstate_register(struct kstate_description *state, void *obj, struct state_entry *se)
+{
+	se->kstd = state;
+	se->id = atomic_inc_return(&state->instance_id);
+	se->obj = obj;
+	list_add(&se->list, &states);
+	restore_migrate_state(migrate_stream_addr, se);
+}
+
+int kstate_register(struct kstate_description *state, void *obj)
+{
+	struct state_entry *se;
+
+	se = kmalloc(sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+
+	__kstate_register(state, obj, se);
+	return 0;
+}
+
+static int __init setup_migrate(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	migrate_stream_addr = memparse(arg, &end);
+	if (*end == '@') {
+		migrate_stream_size = migrate_stream_addr;
+		migrate_stream_addr = memparse(end + 1, &end);
+	}
+	return end > arg ? 0 : -EINVAL;
+}
+early_param("migrate_stream", setup_migrate);
-- 
2.45.2

