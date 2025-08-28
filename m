Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6A2D7384;
	Thu, 28 Aug 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366483; cv=none; b=uAodioZa0V6jpT1x7Um9qT7TEU8upjfo8+A+Vzcnxh0mMxrfygItYekJzuqSMDE4J1Ck5T4v9lVHkx4w9B68bo2AVV6Kgy02L+NW2HIWw8mXCyVxqsRbBA5kKlxetCh4/0xr0/XYDymRgIfbxRgfcrD5LE3Fh16R0VjnLJs0eXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366483; c=relaxed/simple;
	bh=Ovdo5hgFo2bBbWAKUVD3LPmdNb2YG1mi6w9uAqUbgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLy0setwk3/3v1Lo2lrnsCXC6MbTKRuhtIWo3VGBdSjBIu/JwE9YsNj/H0UEu8nEHph9hPQZi7iatXhDda0OGy54Pedj+zOC5kBFP3Vw/AKtEAWpk76il35Mdb9oxl7QPr7lt+AidNI6b0WtJ+7FzAFc2fDZNzW5WQWP9wj1xvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUZeC6ox; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUZeC6ox"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7720c7cbcabso486643b3a.3;
        Thu, 28 Aug 2025 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366481; x=1756971281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dROQY+DQQxgfw8aR1H7lwjWnAl7BOjoXCnJTNltx2NI=;
        b=gUZeC6oxQfLGCOjH7ZS7ifuU/ILZEkAKaxcQGSChUUxSsxNB0RUPjT7S969FAdn4WJ
         3ZdpuxblkAT10Qu74N1h1WL2DfyJM683rPdt+6PMLVabBn6vhgge6e8brAf0nPdkx0am
         5pYwblMtKPsoAxMB40vWD4kg81wsWPIIU4lNrIzOthToiv91R8K7IdcJaE6WHrZ5mBpm
         Ch0cZduLU0cQI5A9GF+XEXOJ/BSuOB59H82+rPajouaFmGj8qFZMmmWmfRhQ64PaOt6b
         X+w3yIa8GWFNY23toL6a3u+/fZkE7w9QDHd8tMEtZSM10omEuYKMqi+ohZq/Ge93M5uK
         fJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366481; x=1756971281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dROQY+DQQxgfw8aR1H7lwjWnAl7BOjoXCnJTNltx2NI=;
        b=IAGQsq84vrz02lrcJp3/5Du0PtGh9jA2DXgctc2xHf7o4AMivfI5Pt4NnRMLvjskiy
         BfOMhJEWF1DdIFYef9SSGKv2K4Rs/bSG0h7CocHpGms1ip3R/tWmzxVAWK7y7tiY+90k
         H37evNCFrAz1Jo00MY9jw1QPbOg9ycpwpSfWWk2jj13gMyG3+7P8TjWQ5kfuTPtlCmGX
         cGrWWFZSklxBe5W0Gb9JpefpNr+KTy4EsV02J9sfIK8VQMny5qGIVdjHBAHU4x5grYNR
         OfytMhNNc9LqAbaeee3f/a0ML6qq7L3aucPE31O+BjOdGgpDxvRzav/MWlkrkdPIkLLq
         jYsg==
X-Forwarded-Encrypted: i=1; AJvYcCUEbZgMfYbKzfZPWYz85zHT8fhmIELMyZI6J7T6RmjCg6SZ8vE0sriMbUIOYd5MVLOddrLXMyvWNFN9ET3ZGgmDFTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycljG6zDZZPmMzMHbqs9faIk+U1FkX8kFj3m7R7SSrvyc4Sc8T
	wWslrvfo9u1DQKXQtkQKD7zW8Wd1HbBB6XNmPdCvKUnNOC+uAMEcoiCW
X-Gm-Gg: ASbGncsHuX42XOjZtLBNN/UTW44hYofL2DQosoj/Q3sZ22I9j78o+ZFkaE21Gd+6tDq
	zps9gj13Zf6h8reV5EYuYgm4Tzv9s+2Z1Xs30VkOVf+/o+SlD1qwoPYsM6oD/feipNkwddWlVil
	LqfsQmXbl2Iw9aeKzlewD36MVXK/d6rryEEBHMxw9QTM+tRAnJwdPG+DdB/uoPwh3p31cQbNGsP
	5a9fD79KJLGzJ/+etN/Hj/9XcP2uM6tI8uwuON6kDvkEMviNbpPBdWfGuf80EZfr2rLitm3TanR
	YJ+90ZsxiQqocUB7wrX2KxVy3V+7B61RQ3akVV7iVwJjVFChKL109/JnXxSjJA2ndqg5Y5bSl2R
	bAE14/A2es4mQYyvXJAU1lPLnm/kX/Os9vFGhl8XbF4ZIvd8n+w==
X-Google-Smtp-Source: AGHT+IHOzcFsWLv4OBgcDeQy4TpdPl7zO4VoKoUPzbnA5fEUxzCOhCFvpJStWdJxL53EzHY8tsoBbQ==
X-Received: by 2002:a05:6a20:9145:b0:243:9845:4137 with SMTP id adf61e73a8af0-243984542bemr10262081637.26.1756366481086;
        Thu, 28 Aug 2025 00:34:41 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:40 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 09/17] mm/ksw: add per-task recursion depth tracking
Date: Thu, 28 Aug 2025 15:32:42 +0800
Message-ID: <20250828073311.1116593-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement depth tracking for KStackWatch to support stack-level filtering.
Each task's recursive entry depth is stored in a global hash table keyed by
pid:

 - get_recursive_depth()/set_recursive_depth() manage per-task depth
 - reset_recursive_depth() clears all tracked entries
 - entry/exit handlers increment or decrement depth and skip  if the
   current depth does not match the configured depth.

This works even across task scheduling or in interrupt context, since depth
is tracked per-task, ensuring KStackWatch can selectively monitor a
specific recursion level without redundant triggers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 105 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 1d9814a58fde..fe4cc1352cb1 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/fprobe.h>
+#include <linux/hashtable.h>
+#include <linux/hash.h>
 #include <linux/interrupt.h>
 #include <linux/kprobes.h>
 #include <linux/percpu.h>
@@ -12,6 +14,81 @@
 
 struct ksw_config *probe_config;
 
+#define DEPTH_HASH_BITS 8
+#define DEPTH_HASH_SIZE BIT(DEPTH_HASH_BITS)
+
+struct depth_entry {
+	pid_t pid;
+	int depth; /* starts from 0 */
+	struct hlist_node node;
+};
+
+static DEFINE_HASHTABLE(depth_hash, DEPTH_HASH_BITS);
+static DEFINE_SPINLOCK(depth_hash_lock);
+
+static int get_recursive_depth(void)
+{
+	struct depth_entry *entry;
+	pid_t pid = current->pid;
+	int depth = 0;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_possible(depth_hash, entry, node,
+			       hash_32(pid, DEPTH_HASH_BITS)) {
+		if (entry->pid == pid) {
+			depth = entry->depth;
+			break;
+		}
+	}
+	spin_unlock(&depth_hash_lock);
+	return depth;
+}
+
+static void set_recursive_depth(int depth)
+{
+	struct depth_entry *entry;
+	pid_t pid = current->pid;
+	bool found = false;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_possible(depth_hash, entry, node,
+			       hash_32(pid, DEPTH_HASH_BITS)) {
+		if (entry->pid == pid) {
+			entry->depth = depth;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found && depth > 0) {
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (entry) {
+			entry->pid = pid;
+			entry->depth = depth;
+			hash_add(depth_hash, &entry->node,
+				 hash_32(pid, DEPTH_HASH_BITS));
+		}
+	} else if (found && depth == 0) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+	spin_unlock(&depth_hash_lock);
+}
+
+static void reset_recursive_depth(void)
+{
+	struct depth_entry *entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_safe(depth_hash, bkt, tmp, entry, node) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+	spin_unlock(&depth_hash_lock);
+}
+
 /* Find canary address in current stack frame */
 static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
 {
@@ -122,10 +199,21 @@ static struct fprobe exit_probe_fprobe;
 static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
+	int cur_depth;
 	int ret;
 	u64 watch_addr;
 	u64 watch_len;
 
+	cur_depth = get_recursive_depth();
+	set_recursive_depth(cur_depth + 1);
+
+	/* depth start from 0 */
+	if (cur_depth != probe_config->depth) {
+		pr_info("KSW: config_depth:%u cur_depth:%d entry skipping\n",
+			probe_config->depth, cur_depth);
+		return;
+	}
+
 	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
 				      &watch_len);
 	if (ret) {
@@ -135,8 +223,8 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 
 	ret = ksw_watch_on(watch_addr, watch_len);
 	if (ret) {
-		pr_err("KSW: failed to watch on addr:0x%llx len:%llx %d\n",
-		       watch_addr, watch_len, ret);
+		pr_err("KSW: failed to watch on depth:%d addr:0x%llx len:%llx %d\n",
+		       cur_depth, watch_addr, watch_len, ret);
 		return;
 	}
 }
@@ -145,6 +233,17 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 				   unsigned long ret_ip,
 				   struct ftrace_regs *regs, void *data)
 {
+	int cur_depth;
+
+	cur_depth = get_recursive_depth() - 1;
+	set_recursive_depth(cur_depth);
+
+	if (cur_depth != probe_config->depth) {
+		pr_info("KSW: config_depth:%u cur_depth:%d exit skipping\n",
+			probe_config->depth, cur_depth);
+		return;
+	}
+
 	ksw_watch_off();
 }
 
@@ -153,6 +252,8 @@ int ksw_stack_init(struct ksw_config *config)
 	int ret;
 	char *symbuf = NULL;
 
+	reset_recursive_depth();
+
 	/* Setup entry probe */
 	memset(&entry_probe, 0, sizeof(entry_probe));
 	entry_probe.symbol_name = config->function;
-- 
2.43.0

