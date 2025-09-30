Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B326B74D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200360; cv=none; b=ICiRIGNKhPLvN42XrPJTptW49v7SZZx26U0NKi4iAbS7WHwWHezJnPHdNSp91EhQE7FohqpKDRCPbSmZgqgBkY+jxB67UOgEoXIPcKZLTqq0iSDOojh+fCilOjHy9OZap2FUyIgEszuMQDbryMGSRxiNd3zJtMPNCaBO0QOHpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200360; c=relaxed/simple;
	bh=fxWJKkmTlJVGhf37wzDyuZOWELAg09qlFO66bjAfLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAZmmjQQr3SpmKwIFBDowMi4WWTHdXbCtryCWhYg41sGlHoa+voeLDPkAsm6VfqGjW8aq8augEmGUota/8piWtU2ERrhSmk6OZT5sQ+tjjc+8tf6XdmWN1Qi0dOyi4sz1Sa8kYGZSfcTHg59mU4iEXJXAZKm87dydFb3qNYYULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8CNtn4R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8CNtn4R"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5506b28c98so3706241a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200358; x=1759805158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSXL/rVpDaFhkpWTVL2v5h6JspYJZAfxl9VpOD0Az0s=;
        b=U8CNtn4RlFwDL+Bu5RLENJnTv/cgcIZ1KYanSNGhHfhVeiWA5sn+4i4QC/y63JiFbd
         Z6UpeBaVFiySVJZ3eo8LLsh43/LEu9UQEcFQygbSyGabRKxrG1I2jHAwsv0B5UXRtp6C
         O6L+yA+nWDAfNWAj3b/vn+v9fAu4MgcIe3dO2UCgw0CfOi57uXlBvf76Yj7VULB+wI9+
         L47GzsnCeXfH72g0ipzVRj1LhjKmvM0aZ8olFO7oTpVcSjFQzrK3t01ycsIxi1F9K2SG
         eq/QpqxDvWBwssAmMnpnDcmQZHp2SPuMKkOWC0toSSovuvuAQgs+SXtY7iBgvRx5tqqx
         6S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200358; x=1759805158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSXL/rVpDaFhkpWTVL2v5h6JspYJZAfxl9VpOD0Az0s=;
        b=tVDZNUmc7HJAkpyBuuXlYfFHtTNMnAP6L6Fgo5LHOhSD/Fo5hIZCjqwDcxEAwGrURk
         we9jNFkzThWfzWGZitp5wgiu3sIQmT74TWmSnamhU+QIe54R9DLyPtC8oDCuj117fY6K
         GN002PZUoaQq7d1h+u2pImQddhFOutGkQc5SyOFriPcNKYz3gqQIX8yCI8X80BDOE0PE
         ReHZKxolpVtMFu1goy/J2uOa7YmhK+oLfFMuldG/0swhLi3a6vc0MuOcKCCNVPIoD/mw
         mReOQcT9n41EruwbCjYTDNZmIsalQCR+PcIxcE37H7Sqc81Da8N84wPrZly+CPkmC+iI
         5eYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgZTzrq64+2iQ41KU0g513okiYlRzgDWHpIRAeUj48p6+SR9HR1J9hmS+bBRFd1GLtiONQUF+Z8Q+AqdnS1PPzYyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTCDOcPkWp2GSkE0J50Q/mYEnWzdLFpxUcDloHqG/zJKZldfF
	0MOboYRu8jvxmtSYdqJtQTiD4JK6Rk2DSGfAFrR3HGbgSlJoWATTFWZP
X-Gm-Gg: ASbGncvONomvGwLirXzYoTaXcnYdBiGasVogFVcRicG5TtN47uCaffCSa0pqP1PVPs1
	LwnwjZViSPb39xp4zWdqCsUDNB7e/NUOd5wnV+ncQn1snr1n+o6EZZOvKlVxNxcVkDvi/9XC4mN
	tDxDJ4enDE+haYHS2tquathDbPBOxQ6fRp6FC6T3ehYQWz4NcQq3E3iUyT2rjRdzIptgq9s6Puc
	p32Stk9f4irRETw7Yb59yG639ddxJyf6JL0FQ7rt23muvYOsp5TG1r1JFrlffIG7RHCsXznyZ9D
	F46LUzNpr+sW6Q+6QMXGiqUo+UFzVLw8n8gWl9RoAFYGCTdbE7mf9fZIAXzXnTRI09zs629KsxG
	fY5XPR2lJunEiztbhZNTtGDqv7XaRG14dNUt4vtmO5k8hrsHDV+m3fpQMnsTPFZPJXw==
X-Google-Smtp-Source: AGHT+IH6gM/KNPy+EKuwDpqrsR2PCtVeobdVuJ/I6iYU/PVMeQcdMhYmE/6vu80Fhzh9wbuUwcXL7Q==
X-Received: by 2002:a17:903:19f0:b0:26c:e270:6dad with SMTP id d9443c01a7336-27ed4ae51c6mr173137795ad.60.1759200358349;
        Mon, 29 Sep 2025 19:45:58 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69ba58csm144532905ad.121.2025.09.29.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:57 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 20/23] mm/ksw: add multi-thread corruption test cases
Date: Tue, 30 Sep 2025 10:43:41 +0800
Message-ID: <20250930024402.1043776-21-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests share a common structure and are grouped together.

- buggy():
  exposes the stack address to corrupting(); may omit waiting
- corrupting():
  reads the exposed pointer and modifies memory;
  if buggy() omits waiting, victim()'s buffer is corrupted
- victim():
  initializes a local buffer and later verifies it;
  reports an error if the buffer was unexpectedly modified

buggy() and victim() run in worker() thread, with similar stack frame sizes
to simplify testing. By adjusting fence_size in corrupting(), the test can
trigger either silent corruption or overflow across threads.

- Test 3: one worker, 20 loops, silent corruption
- Test 4: 20 workers, one loop each, silent corruption
- Test 5: one worker, one loop, overflow corruption

Test 4 also exercises multiple watchpoint instances.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 186 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 203fff4bec92..2952efcc7738 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -20,6 +20,20 @@ static struct dentry *test_file;
 #define BUFFER_SIZE 32
 #define MAX_DEPTH 6
 
+struct work_node {
+	ulong *ptr;
+	u64 start_ns;
+	struct completion done;
+	struct list_head list;
+};
+
+static DECLARE_COMPLETION(work_res);
+static DEFINE_MUTEX(work_mutex);
+static LIST_HEAD(work_list);
+
+static int global_fence_size;
+static int global_loop_count;
+
 static void test_watch_fire(void)
 {
 	u64 buffer[BUFFER_SIZE] = { 0 };
@@ -62,6 +76,164 @@ static void test_recursive_depth(int depth)
 	pr_info("exit of %s depth:%d\n", __func__, depth);
 }
 
+static struct work_node *test_mthread_buggy(int thread_id, int seq_id)
+{
+	ulong buf[BUFFER_SIZE];
+	struct work_node *node;
+	bool trigger;
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	init_completion(&node->done);
+	node->ptr = buf;
+	node->start_ns = ktime_get_ns();
+	mutex_lock(&work_mutex);
+	list_add(&node->list, &work_list);
+	mutex_unlock(&work_mutex);
+	complete(&work_res);
+
+	trigger = (get_random_u32() % 100) < 10;
+	if (trigger)
+		return node; /* let the caller handle cleanup */
+
+	wait_for_completion(&node->done);
+	kfree(node);
+	return NULL;
+}
+
+#define CORRUPTING_MINIOR_WAIT_NS (100000)
+#define VICTIM_MINIOR_WAIT_NS (300000)
+
+static inline void silent_wait_us(u64 start_ns, u64 min_wait_us)
+{
+	u64 diff_ns, remain_us;
+
+	diff_ns = ktime_get_ns() - start_ns;
+	if (diff_ns < min_wait_us * 1000ULL) {
+		remain_us = min_wait_us - (diff_ns >> 10);
+		usleep_range(remain_us, remain_us + 200);
+	}
+}
+
+static void test_mthread_victim(int thread_id, int seq_id, u64 start_ns)
+{
+	ulong buf[BUFFER_SIZE];
+
+	for (int j = 0; j < BUFFER_SIZE; j++)
+		buf[j] = 0xdeadbeef + seq_id;
+	if (start_ns)
+		silent_wait_us(start_ns, VICTIM_MINIOR_WAIT_NS);
+
+	for (int j = 0; j < BUFFER_SIZE; j++) {
+		if (buf[j] != (0xdeadbeef + seq_id)) {
+			pr_warn("victim[%d][%d]: unhappy buf[%d]=0x%lx\n",
+				thread_id, seq_id, j, buf[j]);
+			return;
+		}
+	}
+
+	pr_info("victim[%d][%d]: happy\n", thread_id, seq_id);
+}
+
+static int test_mthread_corrupting(void *data)
+{
+	struct work_node *node;
+	int fence_size;
+
+	while (!kthread_should_stop()) {
+		if (!wait_for_completion_timeout(&work_res, HZ))
+			continue;
+		while (true) {
+			mutex_lock(&work_mutex);
+			node = list_first_entry_or_null(&work_list,
+							struct work_node, list);
+			if (node)
+				list_del(&node->list);
+			mutex_unlock(&work_mutex);
+
+			if (!node)
+				break; /* no more nodes, exit inner loop */
+			silent_wait_us(node->start_ns,
+				       CORRUPTING_MINIOR_WAIT_NS);
+
+			fence_size = READ_ONCE(global_fence_size);
+			for (int i = fence_size; i < BUFFER_SIZE - fence_size;
+			     i++)
+				node->ptr[i] = 0xabcdabcd;
+
+			complete(&node->done);
+		}
+	}
+
+	return 0;
+}
+
+static int test_mthread_worker(void *data)
+{
+	int thread_id = (long)data;
+	int loop_count;
+	struct work_node *node;
+
+	loop_count = READ_ONCE(global_loop_count);
+
+	for (int i = 0; i < loop_count; i++) {
+		node = test_mthread_buggy(thread_id, i);
+
+		if (node)
+			test_mthread_victim(thread_id, i, node->start_ns);
+		else
+			test_mthread_victim(thread_id, i, 0);
+		if (node) {
+			wait_for_completion(&node->done);
+			kfree(node);
+		}
+	}
+	return 0;
+}
+
+static void test_mthread_case(int num_workers, int loop_count, int fence_size)
+{
+	static struct task_struct *corrupting;
+	static struct task_struct **workers;
+
+	WRITE_ONCE(global_loop_count, loop_count);
+	WRITE_ONCE(global_fence_size, fence_size);
+
+	init_completion(&work_res);
+	workers = kmalloc_array(num_workers, sizeof(void *), GFP_KERNEL);
+	memset(workers, 0, sizeof(struct task_struct *) * num_workers);
+
+	corrupting = kthread_run(test_mthread_corrupting, NULL, "corrupting");
+	if (IS_ERR(corrupting)) {
+		pr_err("failed to create corrupting thread\n");
+		return;
+	}
+
+	for (ulong i = 0; i < num_workers; i++) {
+		workers[i] = kthread_run(test_mthread_worker, (void *)i,
+					 "worker_%ld", i);
+		if (IS_ERR(workers[i])) {
+			pr_err("failto create worker thread %ld", i);
+			workers[i] = NULL;
+		}
+	}
+
+	for (ulong i = 0; i < num_workers; i++) {
+		if (workers[i] && workers[i]->__state != TASK_DEAD) {
+			usleep_range(1000, 2000);
+			i--;
+		}
+	}
+	kfree(workers);
+
+	if (corrupting && !IS_ERR(corrupting)) {
+		kthread_stop(corrupting);
+		corrupting = NULL;
+	}
+}
+
 static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *pos)
 {
@@ -90,6 +262,15 @@ static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 		case 2:
 			test_recursive_depth(0);
 			break;
+		case 3:
+			test_mthread_case(1, 20, BUFFER_SIZE / 4);
+			break;
+		case 4:
+			test_mthread_case(20, 1, BUFFER_SIZE / 4);
+			break;
+		case 5:
+			test_mthread_case(1, 1, -3);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -112,7 +293,10 @@ static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
 		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
 		" test0 - test watch fire\n"
 		" test1 - test canary overflow\n"
-		" test2 - test recursive func\n";
+		" test2 - test recursive func\n"
+		" test3 - test silent corruption\n"
+		" test4 - test multiple silent corruption\n"
+		" test5 - test prologue corruption\n";
 
 	return simple_read_from_buffer(buffer, count, ppos, usage,
 				       strlen(usage));
-- 
2.43.0

