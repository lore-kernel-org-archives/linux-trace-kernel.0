Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429413;
	b=sfh0HjogNu8h9VM+aQlx8goaVbwWWn31//VT/ke61hiTFIMZ+pYdoKv0Je4h4q586MIl
	 fchKJol4DvgT4S89cC0CW4tJ+wHUA4pcoH0zH8/JYse28bSpC3kvGS/0svUR97g5pk/+C
	 plfTLaj7tZhQWAd2cB3D3G7XEYQoVVuzLPqC/v11lBnAGu7IOSLMhUyWKHqBTaBqMk76w
	 12hjQFueoLfTdF5+95W6FC7QdZXe3c7IwyuLnt3tVD0s2gGzEEJZ8U+bj79jqy37Dr8vh
	 spiFQnIJPPjOUqlIvB4L8ZJ8AfRjRGe6wKI7PIOTcMAU/iLrlw4n6gzzGKvT/WC+eNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429413;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IG2i4eM11A8lVv+NbNC7CjJ7zEpmOtNYGqSnK/Rh/6Y=;
	b=W4sK46/dbqO4xMA6cjlmGS27PUm6TPx97Y5ilmtH68vU40S9k+PD1FYCMWx9pR8rnIJI
	 6rs1/evUuPO0yGpdHOOs/o2lCUyNv9T3psrVfH82Ar8vcW99hYMliRcW7Ze+0qVSdCvIm
	 VDaZpxjzA3igr1LsiIplZgzeOwESufMLLaa5P+jvNnydsknPHMxX13YjW04itgTS2H57o
	 op828LW1bM3w5pBTQ+autvAN8deM/aprG3vcLj2T8wvYRlqjeVdC8Z2UzeBGL//2eSMOX
	 xnG6lmC0FXnXfRjSTKCx61lNAXd7LyS4UJvkPKwlgjBHxcpg70kosCFeIABB8ozbKrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ALp+ZqNe;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1D606A88E;
	Wed, 11 Nov 2026 20:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E1D606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ALp+ZqNe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794429407;
	bh=IG2i4eM11A8lVv+NbNC7CjJ7zEpmOtNYGqSnK/Rh/6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALp+ZqNezrOAxayzvPcDAUX20E5pghRS59g6lOQSA2zej8fZoYWUwg6rL1ZSV17YD
	 sGTIIb+53qYGxyuLe2xHUY+6lASwNHa5sjz3rdQNed6KddL9rF7kfx5JssGDJIY4XS
	 0BjSNkXziuJ/WZYP5NXR+SfzipTUGkBp2fxNM40Vpo/AAQ4/GZDsZ2+bxV9/iNxgSc
	 kLvqwkGfDppndZrqnnfVeGy5nvWt0KBCaK259IxQ1mKycTcqHLfxYTnG/pIvrCH8ye
	 9AU+ieilBaQ/IECjOJs27hzUhF41Y9GEqlYFX1Yr2P3hu3pPeqWaxh3DsAIXjwGwDS
	 9sU6gb9AQ/mNA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPwKp6tFLzP3s;
	Wed, 11 Nov 2026 15:36:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [RFC PATCH v25 11/14] mm: shmem: use a limit counter for the tmpfs size limit
Date: Wed, 11 Nov 2026 15:36:23 -0500
Message-Id: <20261111203626.95838-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size limit of tmpfs (the size= mount option) is a struct
percpu_counter. Each block allocation checks it with
percpu_counter_limited_add(). That check takes no lock only while the
mount is more than batch * nr_cpus pages below its size. With the
default batch size of 768 at 384 CPUs, this is 294912 pages, 1.1 GB.
A smaller mount, such as a 64 MB /dev/shm, takes the counter spinlock
and sums all CPUs on every page. On a 384-CPU host with 384 processes
allocating, 99.5% of the time goes to that spinlock.

Use a hierarchical limit counter instead. Its batch size is chosen from
the size. When the size allows, its accuracy is within 1/4 of the size.
Block allocations then sum the CPUs only in the last 1/4 of the size.
They take no lock. The limit stays strict.

Near a full mount, an allocation can fail although it fits. This
happens while a concurrent allocation of a few pages, which does not
fit, is being undone. A large folio is checked before it is added, so a
large folio which does not fit has no such effect.

A mount without a size limit never counts its blocks. A remount cannot
add a limit. So such a mount no longer allocates the counter.

A remount keeps the batch size. A mount grown by remount thus keeps the
smaller batch size of its first size. Under concurrent allocations, a
remount to a smaller size can be refused although the use fits.

Test: fallocate() of one page at a time into one file per process, all
on one mount. This is a will-it-scale variant. It ran in a 384-vCPU
guest pinned to a 2-socket AMD EPYC 9654 host, on v7.4-rc2. In
thousands of calls per second:

  size=  processes   before    after
  64 MB          1      208      483
  64 MB         64      256    17771
  64 MB        384      126    54275
  1 GB         384      125    93879
  2 GB         384    93851    93476
  16 GB        384    93737    94806

Below 1.1 GB, the mount scales again with the number of processes. At
2 GB and above, the results are within 1% of before. Within the last
1/4 of the size, each allocation sums both counters over all CPUs. With
one process, this is 37% slower than before. With 384 processes, it is
about 100 times faster.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/shmem_fs.h |  3 ++-
 mm/shmem.c               | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index f89b4b151133..b37adf32e4ef 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -7,6 +7,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pagemap.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu_counter_tree.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 #include <linux/userfaultfd_k.h>
@@ -76,7 +77,7 @@ struct shmem_quota_limits {
 
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
-	struct percpu_counter used_blocks;  /* How many are allocated */
+	struct percpu_counter_tree_limit used_blocks; /* How many are allocated */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_ispace;  /* How much ispace left for allocation */
 	raw_spinlock_t stat_lock;   /* Serialize shmem_sb_info changes */
diff --git a/mm/shmem.c b/mm/shmem.c
index b8399bb71997..2e368d7b0e41 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -231,13 +231,13 @@ int shmem_inode_acct_blocks(struct inode *inode, long pages)
 
 	might_sleep();	/* when quotas */
 	if (sbinfo->max_blocks) {
-		if (!percpu_counter_limited_add(&sbinfo->used_blocks,
-						sbinfo->max_blocks, pages))
+		if (!percpu_counter_tree_limit_add(&sbinfo->used_blocks,
+						   sbinfo->max_blocks, pages))
 			goto unacct;
 
 		err = dquot_alloc_block_nodirty(inode, pages);
 		if (err) {
-			percpu_counter_sub(&sbinfo->used_blocks, pages);
+			percpu_counter_tree_limit_sub(&sbinfo->used_blocks, pages);
 			goto unacct;
 		}
 	} else {
@@ -262,7 +262,7 @@ static void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 	dquot_free_block_nodirty(inode, pages);
 
 	if (sbinfo->max_blocks)
-		percpu_counter_sub(&sbinfo->used_blocks, pages);
+		percpu_counter_tree_limit_sub(&sbinfo->used_blocks, pages);
 	shmem_unacct_blocks(info->flags, pages);
 }
 
@@ -4048,9 +4048,11 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = NAME_MAX;
 	if (sbinfo->max_blocks) {
 		buf->f_blocks = sbinfo->max_blocks;
+		/* Under concurrent allocations, the sum can be above the size. */
 		buf->f_bavail =
 		buf->f_bfree  = sbinfo->max_blocks -
-				percpu_counter_sum(&sbinfo->used_blocks);
+				min(percpu_counter_tree_limit_precise_sum(&sbinfo->used_blocks),
+				    sbinfo->max_blocks);
 	}
 	if (sbinfo->max_inodes) {
 		buf->f_files = sbinfo->max_inodes;
@@ -5020,8 +5022,8 @@ static int shmem_reconfigure(struct fs_context *fc)
 			err = "Cannot retroactively limit size";
 			goto out;
 		}
-		if (percpu_counter_compare(&sbinfo->used_blocks,
-					   ctx->blocks) > 0) {
+		if (percpu_counter_tree_limit_precise_sum(&sbinfo->used_blocks) >
+		    ctx->blocks) {
 			err = "Too small a size for current use";
 			goto out;
 		}
@@ -5187,7 +5189,7 @@ static void shmem_put_super(struct super_block *sb)
 	shmem_disable_quotas(sb);
 #endif
 	free_percpu(sbinfo->ino_batch);
-	percpu_counter_destroy(&sbinfo->used_blocks);
+	percpu_counter_tree_limit_destroy(&sbinfo->used_blocks);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	list_lru_destroy(&sbinfo->shrinklist);
 #endif
@@ -5212,6 +5214,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	static struct lock_class_key shmem_unused_huge_lock_key;
 #endif
 	struct shmem_options *ctx = fc->fs_private;
+	unsigned long batch;
 	struct inode *inode;
 	struct shmem_sb_info *sbinfo;
 	int error = -ENOMEM;
@@ -5286,8 +5289,18 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	ctx->mpol = NULL;
 
 	raw_spin_lock_init(&sbinfo->stat_lock);
-	if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
-		goto failed;
+	/*
+	 * A mount without a size limit never counts its blocks. A remount
+	 * cannot add a limit. Otherwise, pick the batch size from the size.
+	 * When the size allows, its accuracy is within 1/4 of the size. A
+	 * block allocation then sums all CPUs only within the last 1/4 of the
+	 * size. A remount keeps the batch size.
+	 */
+	if (sbinfo->max_blocks) {
+		batch = percpu_counter_tree_batch_for_accuracy(sbinfo->max_blocks / 4);
+		if (percpu_counter_tree_limit_init(&sbinfo->used_blocks, batch, GFP_KERNEL))
+			goto failed;
+	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (list_lru_init_memcg_key(&sbinfo->shrinklist, sb->s_shrink,
-- 
2.47.3

