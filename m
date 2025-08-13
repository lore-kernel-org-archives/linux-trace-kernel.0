Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679E8248C;
	Wed, 13 Aug 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052272; cv=none; b=eMls98E0KiZHHPNM8GscMKj4VB4jKZoZfnXxOwZDfHyfgKdmc6rY+CDgob4BzdHBdyhXcRm/8vN3QN/nRoVUxDfsiJg3PEpnX6/euF/pK30WB9in9Njl4O6l481GsAN9J18s4DIt7neSNww89MnkaMBhxTncmu3gjFs3iG/ZCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052272; c=relaxed/simple;
	bh=xSsuCHzCrsw36yf7bTY2cHxu4/YLUNUVP1IbUqh6OiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0HsaaAWd5ybR+58m08MdggTsqeJvsOOYYBTXIKpMBxcGRxZK22tGllD6NJYnsTwCZ/nuaVTyb0mCavPJOonDTH/6achltKpXRqjZkvP9w+4PYEem3M9IzJxKMaArOir0Pyi5RXio2CDJsLxhlrgk3CnLtSzEygKembnu1tJ7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1sn66jZCzKHMqX;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 311DE1A0899;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCXExTn+JtoJBUADg--.30982S4;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next 2/2] ftrace: Fix potential use-after-free for set_ftrace_{notrace,filter} files
Date: Wed, 13 Aug 2025 02:30:44 +0000
Message-Id: <20250813023044.2121943-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813023044.2121943-1-wutengda@huaweicloud.com>
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExTn+JtoJBUADg--.30982S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1UKr1Utry7Wr1UCF43trb_yoW7Zr18pF
	WSyFZ8Gr18AFsrKwn7W3WDtr18XryFyryxta97tw13Xr9Iqw15uFy7Zr95Xr4ft3srJr9x
	uF429w15K3yUXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUolk3UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Concurrent read/write operations on the set_ftrace_{notrace,filter}
files may probabilistically trigger the following issues:

[ 2715.745293] BUG: unable to handle page fault for address: 00000003da393970
[ 2715.753736] CPU: 1 UID: 0 PID: 1324 Comm: read Not tainted 6.16.0-next-20250808 #1 PREEMPT(full)
[ 2715.755292] RIP: 0010:ftrace_lookup_ip+0x40/0x70
[ 2715.761114] Call Trace:
[ 2715.761462]  <TASK>
[ 2715.761705]  t_func_next.isra.0+0xaa/0xd0
[ 2715.762049]  t_start+0xa3/0x140
[ 2715.762207]  seq_read_iter+0xe8/0x4a0
[ 2715.762564]  seq_read+0x101/0x140
[ 2715.762769]  vfs_read+0xbd/0x340
[ 2715.763014]  ? preempt_count_add+0x4b/0xa0
[ 2715.763311]  ? do_sys_openat2+0x8c/0xd0
[ 2715.763623]  ksys_read+0x65/0xe0
[ 2715.763797]  do_syscall_64+0x4e/0x1c0
[ 2715.764049]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue can be reproduced with the following script (using the
set_ftrace_notrace file as an example):

  while true; do
    echo __probestub_initcall_level > /sys/kernel/tracing/set_ftrace_notrace &
    cat /sys/kernel/tracing/set_ftrace_notrace &
  done

The root cause is that ftrace_regex_open and ftrace_regex_release
do not properly handle concurrent synchronization for notrace_hash.
Consider a race scenario between a reader and a writer:

1. The reader first obtains the value of notrace_hash via
   ftrace_regex_open().
2. The writer then updates notrace_hash via ftrace_regex_release()
   and frees the memory pointed to by the old notrace_hash.
3. Later, the reader accesses the old notrace_hash memory while
   ftrace_hash_empty() and ftrace_lookup_ip(), leading to a UAF.

CPU 1 (read)                                    CPU 2 (write)
ftrace_regex_open
  hash = ops->func_hash->notrace_hash;
  iter->hash = hash;
                                                ftrace_regex_open
                                                ftrace_regex_release
                                                  orig_hash = &iter->ops->func_hash->notrace_hash;
                                                  old_hash = *orig_hash;
                                                  free_ftrace_hash_rcu(old_hash);
t_start
  ftrace_hash_empty(iter->hash)
  t_func_next
    !ftrace_lookup_ip(iter->hash, rec->ip)

Since the reader's hash is always tied to its file descriptor (fd),
the writer cannot directly manage the reader's hash. To fix this,
introduce a refcount for ftrace_hash, initialized to 1. The count
is incremented only when a reader opens it, and decremented when
either a reader or writer releases it, thereby controlling the timing
of ftrace_hash deallocation.

Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/ftrace.c | 27 ++++++++++++++++++++++++---
 kernel/trace/trace.h  |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cade13595b08..be4842054254 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1060,6 +1060,7 @@ struct ftrace_func_probe {
 static const struct hlist_head empty_buckets[1];
 static const struct ftrace_hash empty_hash = {
 	.buckets = (struct hlist_head *)empty_buckets,
+	.refcount = REFCOUNT_INIT(1),
 };
 #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)
 
@@ -1282,6 +1283,22 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 	call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
 }
 
+static void get_ftrace_hash(struct ftrace_hash *hash)
+{
+	if (!hash || hash == EMPTY_HASH)
+		return;
+	if (!refcount_inc_not_zero(&hash->refcount))
+		WARN_ON(1);
+}
+
+static void put_ftrace_hash_rcu(struct ftrace_hash *hash)
+{
+	if (!hash || hash == EMPTY_HASH)
+		return;
+	if (refcount_dec_and_test(&hash->refcount))
+		call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
+}
+
 /**
  * ftrace_free_filter - remove all filters for an ftrace_ops
  * @ops: the ops to remove the filters from
@@ -1316,6 +1333,7 @@ static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 	}
 
 	hash->size_bits = size_bits;
+	refcount_set(&hash->refcount, 1);
 
 	return hash;
 }
@@ -3362,7 +3380,7 @@ static int __ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 	ret = ftrace_hash_move(ops, enable, orig_hash, hash);
 	if (!ret) {
 		ftrace_ops_update_code(ops, &old_hash_ops);
-		free_ftrace_hash_rcu(old_hash);
+		put_ftrace_hash_rcu(old_hash);
 	}
 	return ret;
 }
@@ -3714,7 +3732,7 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 		*orig_subhash = save_hash;
 		free_ftrace_hash_rcu(new_hash);
 	} else {
-		free_ftrace_hash_rcu(save_hash);
+		put_ftrace_hash_rcu(save_hash);
 	}
 	return ret;
 }
@@ -4666,8 +4684,10 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 			trace_parser_put(&iter->parser);
 			goto out_unlock;
 		}
-	} else
+	} else {
 		iter->hash = hash;
+		get_ftrace_hash(iter->hash);
+	}
 
 	ret = 0;
 
@@ -6544,6 +6564,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		mutex_unlock(&ftrace_lock);
 	} else {
 		/* For read only, the hash is the ops hash */
+		put_ftrace_hash_rcu(iter->hash);
 		iter->hash = NULL;
 	}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..4936cd218c36 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
 #include <linux/ftrace_regs.h>
+#include <linux/refcount.h>
 
 #include "pid_list.h"
 
@@ -905,6 +906,7 @@ struct ftrace_hash {
 	unsigned long		count;
 	unsigned long		flags;
 	struct rcu_head		rcu;
+	refcount_t		refcount;
 };
 
 struct ftrace_func_entry *
-- 
2.34.1

