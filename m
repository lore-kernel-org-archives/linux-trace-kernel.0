Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9A3BFE2D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509057; cv=none; b=bc1tlkfQXYkSB6QKru4AVKYoF8FLoZA5OTRn33/g215ZvbnBoUxb3cgxUYxyqmorOBqRim9P0mymau1jR9I3mpfHjWvMtuALUI97qUPE7lfZfFNq4y5BJ9PbB3XmdXvz7KtWD+UXYiz4HBMjYuCrOJugOWJtcAabYMchHE/5tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509057; c=relaxed/simple;
	bh=15MJoGxYOwokbmT2ep4uqwHb+W57i2z4LwR8os1gSQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+F9kPT+iHobaGhCtvpzt933WOiJd/jh+9Wuu0gxQdue0LoyxXo2np4y77tqjtRFjR7luuA9nsZ79g/WoIyDhpkrKRgj7D5C1LKO6ZbK1OgQ/QsOCAI/iWeIqYZ63mprRXD/hF6pcOKfp8XG8yBpXoKfK5RemZGI+w+2v7up5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNDf6A1p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNDf6A1p"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so13143145e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509054; x=1783113854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFQ1mVg2iTV+EaFy1f7FWUdfqYgzR/zjDq+1fIdDKT4=;
        b=MNDf6A1pmpd+xMUQ11tnQMQ9kACO4bD04O6gBhotIiLyQFGf4oHTjPoeP/g/CZ5EHL
         QX1pKK56q5lHhX3A9EzzLfAL4VzQkgZGtZd82SD8Q4FDqqhOReVo6MTAxW0Nr5SG6tjR
         bevLm6v/RDHFcalDXLrwiHfbvsj/uudZaLzJFq6h49ZDQYgNiNb5K/CSPbnsfM4nzY05
         I+YaVAuDrViz5Q1rU03k/kpfwxRyAXqp3YMDjMYBMmEYWtQ6lDVd+9djeb9rOwUKAUY3
         9q/X5nO7cEd4eY1Y8je+hU7+hXH3JsHoQ99jvH8a3VAnw2W2YVWuw+mmtEprq/iv0EJn
         /MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509054; x=1783113854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFQ1mVg2iTV+EaFy1f7FWUdfqYgzR/zjDq+1fIdDKT4=;
        b=no2+CTF2taW4xbHCNl3sNDlkmADHRpxF0/WlvvfFN6dd7OLEEyIUvA5ei1MxrFeYx0
         jnSml66GttE0JOP//57O7+k7cK0w3JncozeSu4f3Qd+3cMls4qOt3O3Wgr/fLboPTbHE
         uWeb1R7QLEMSYCMYHaIHFK4px4P71NzFfw6DAs1cFgJBOK/at+R4mPyGb9rnc9Wmofle
         dAi712hcZDdql+32vl+4DoVPxkBeagVaSy84mFK2oA04bbd1owaenQC8+hKch7mKWIwP
         gJmmwSNSBMQfjPP7vukuXpNMGqU6eXq30dNNpglvmkbeeu7uxwcRl/7gcVHpTEPA3ckB
         QOwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8b4n2jNK67didkq03MxjEZIo35wmHvP1/Xanpfter+Xhb6e7oyC3IB6CTE//vHtKTah3bD7i9u1jHs7MpJ0Sq+Bcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDt26NLML9e/oifTafZOAcvFRfm4YrsiYMwsNFBldvoDSVaPNT
	m5D4WU6STwV8HbtenxNMPXjnBhK4xX5uYZWVSFJzOZu8Kdq9qjK2WgkNbnVpPWx6
X-Gm-Gg: AfdE7ckrNW3lqG1dBKRrmBl3ylpriYQpSzG0NlpNgO/N/OP3t7/EOUvYY5sWTgizVa5
	pikrmepZuDLjgqQ6gEWFnH0w6stwASxf6WOmyUVdwKKKw86BIvGYpgi9oSILyL8DxZAsdElQJa3
	uEgP2EDIXEgRFbMmy1ho074s0fkZELUlh0/XejoZSyFV1nO/biggQxO2X3T0ViZYd4TPcadWOj+
	ll7ecbRzdOOGWN2LlgHDVP3c3e3nd1cX3+v4+lyL2E10PuMtl1+9hPDFXrr5sr5Sh/1JYGt7GEI
	SqBSJ6xolA3BAOnUimaSRgjh1Awe6bsKvmxbYRZTobQvcOm+nvln1RsKMo3LE8Z+W9fKsPQC5yG
	N7IlbG6Tk/awJ44WQwr1JeJTnwakOEg1sszolcvs4szJqR/lYWhumWfr/7yk4HtJoKjKWk8bv1l
	EesqyVSmiHfcBuZWJ/BqrhKsCnQqiQ6psaOXgXsfinYG0S61FrD94zAdJExapmVTMZQsLnkw==
X-Received: by 2002:a05:600c:4e54:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-49266891f79mr126335715e9.19.1782509054164;
        Fri, 26 Jun 2026 14:24:14 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e95f3d71fsm11505686f8f.12.2026.06.26.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:24:13 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Date: Fri, 26 Jun 2026 22:23:56 +0100
Message-Id: <20260626212356.64150-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260626212356.64150-1-david.laight.linux@gmail.com>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than have two separate dynamic arrays on the end of struct
saved_commandlines_buffer have a single dynamic array where each
entry contains the pid and associated task->comm[].
This simplifies the initialisation and lookup.

Don't bother trying to initialise the pid field no a non-zero value,
it only matters in the tracing_saved_cmdlines_seq_ops code.
Allocate entry [0] first so that the tracing_saved_cmdlines_seq_ops
code can just index the array with the file offset.

The code now uses the correct size when determining the page 'order'
to free the structure. The smaller size will always give the same
'order'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Is there any reason why this code uses alloc_pages() rather
than vmalloc()?
map_pid_to_cmdline[] is 64k*sizeof(int) so the whole structure
expands to 512k with about 64k/20 (about 3200) pid entries even
though the default is 128.
AFAICT there is only one copy of the data - so it could be static.
Perhaps with pointers to map_pid_cmdline[] and (after this patch)
pid_comm[], both of which could be separately resized.

I also noticed that map_pid_to_cmdline[] contains indexes into
pid_comm[], restricting these to 16bits would half the data area.

 kernel/trace/trace_sched_switch.c | 97 +++++++++++++------------------
 1 file changed, 39 insertions(+), 58 deletions(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 972883643097..5e7c8cf444b8 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -167,27 +167,21 @@ static size_t tgid_map_max;
  * where interrupt is disabled.
  */
 static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+struct pid_comm {
+	pid_t pid;
+	struct trace_comm comm;
+};
 struct saved_cmdlines_buffer {
 	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
-	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	struct trace_comm saved_cmdlines[];
+	struct pid_comm pid_comm[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
-/* Holds the size of a cmdline and pid element */
-#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
-	(sizeof(struct trace_comm) + sizeof((s)->map_cmdline_to_pid[0]))
-
-static inline struct trace_comm *get_saved_cmdlines(int idx)
-{
-	return &savedcmd->saved_cmdlines[idx];
-}
-
-static inline void set_cmdline(int idx, const struct task_struct *tsk)
+static inline void set_cmdline(struct pid_comm *pid_comm, const struct task_struct *tsk)
 {
-	struct trace_comm *comm = get_saved_cmdlines(idx);
+	struct trace_comm *comm = &pid_comm->comm;
 
 	BUILD_BUG_ON(sizeof(comm->comm) > sizeof(tsk->comm));
 
@@ -212,7 +206,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	int order;
 
 	/* Figure out how much is needed to hold the given number of cmdlines */
-	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
+	orig_size = sizeof(*s) + val * sizeof(s->pid_comm[0]);
 	order = get_order(orig_size);
 	size = 1 << (order + PAGE_SHIFT);
 	page = alloc_pages(GFP_KERNEL, order);
@@ -224,16 +218,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	memset(s, 0, sizeof(*s));
 
 	/* Round up to actual allocation */
-	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
+	val = (size - sizeof(*s)) / sizeof(s->pid_comm[0]);
 	s->cmdline_num = val;
 
-	/* Place map_cmdline_to_pid array right after saved_cmdlines */
-	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val];
-
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
-	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
-	       val * sizeof(*s->map_cmdline_to_pid));
 
 	return s;
 }
@@ -247,6 +236,7 @@ int trace_create_savedcmd(void)
 
 int trace_save_cmdline(struct task_struct *tsk)
 {
+	struct pid_comm *pid_comm;
 	unsigned tpid, idx;
 
 	/* treat recording of idle task as a success */
@@ -272,14 +262,16 @@ int trace_save_cmdline(struct task_struct *tsk)
 
 	idx = savedcmd->map_pid_to_cmdline[tpid];
 	if (idx == NO_CMDLINE_MAP) {
-		idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;
-
+		idx = savedcmd->cmdline_idx;
 		savedcmd->map_pid_to_cmdline[tpid] = idx;
+		if (++idx >= savedcmd->cmdline_num)
+			idx = 0;
 		savedcmd->cmdline_idx = idx;
 	}
 
-	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
-	set_cmdline(idx, tsk);
+	pid_comm = savedcmd->pid_comm + idx;
+	pid_comm->pid = tsk->pid;
+	set_cmdline(pid_comm, tsk);
 
 	arch_spin_unlock(&trace_cmdline_lock);
 
@@ -288,8 +280,8 @@ int trace_save_cmdline(struct task_struct *tsk)
 
 static void __trace_find_cmdline(int pid, struct trace_comm *comm)
 {
+	struct pid_comm *pid_comm;
 	unsigned map;
-	int tpid;
 
 	if (!pid) {
 		strcpy(comm->comm, "<idle>");
@@ -301,12 +293,11 @@ static void __trace_find_cmdline(int pid, struct trace_comm *comm)
 		return;
 	}
 
-	tpid = pid & (PID_MAX_DEFAULT - 1);
-	map = savedcmd->map_pid_to_cmdline[tpid];
+	map = savedcmd->map_pid_to_cmdline[pid & (PID_MAX_DEFAULT - 1)];
 	if (map != NO_CMDLINE_MAP) {
-		tpid = savedcmd->map_cmdline_to_pid[map];
-		if (tpid == pid) {
-			*comm = *get_saved_cmdlines(map);
+		pid_comm = savedcmd->pid_comm + map;
+		if (pid_comm->pid == pid) {
+			*comm = pid_comm->comm;;
 			return;
 		}
 	}
@@ -521,42 +512,34 @@ const struct file_operations tracing_saved_tgids_fops = {
 	.release	= seq_release,
 };
 
-static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
+static struct pid_comm *saved_cmdlines_entry(loff_t off)
 {
-	unsigned int *ptr = v;
+	struct pid_comm *pid_comm;
 
-	if (*pos || m->count)
-		ptr++;
-
-	(*pos)++;
+	if (off >= savedcmd->cmdline_num)
+		return NULL;
 
-	for (; ptr < &savedcmd->map_cmdline_to_pid[savedcmd->cmdline_num];
-	     ptr++) {
-		if (*ptr == -1 || *ptr == NO_CMDLINE_MAP)
-			continue;
+	/* Entries are used in sequence and never freed */
+	pid_comm = &savedcmd->pid_comm[off];
+	return pid_comm->pid ? pid_comm : NULL;
+}
 
-		return ptr;
-	}
+static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	loff_t off = *pos;
 
-	return NULL;
+	v = saved_cmdlines_entry(off);
+	if (v)
+		*pos = off + 1;
+	return v;
 }
 
 static void *saved_cmdlines_start(struct seq_file *m, loff_t *pos)
 {
-	void *v;
-	loff_t l = 0;
-
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 
-	v = &savedcmd->map_cmdline_to_pid[0];
-	while (l <= *pos) {
-		v = saved_cmdlines_next(m, v, &l);
-		if (!v)
-			return NULL;
-	}
-
-	return v;
+	return saved_cmdlines_entry(*pos);
 }
 
 static void saved_cmdlines_stop(struct seq_file *m, void *v)
@@ -567,11 +550,9 @@ static void saved_cmdlines_stop(struct seq_file *m, void *v)
 
 static int saved_cmdlines_show(struct seq_file *m, void *v)
 {
-	struct trace_comm buf;
-	unsigned int *pid = v;
+	struct pid_comm *ptr = v;
 
-	__trace_find_cmdline(*pid, &buf);
-	seq_printf(m, "%d %s\n", *pid, buf.comm);
+	seq_printf(m, "%d %s\n", ptr->pid, ptr->comm.comm);
 	return 0;
 }
 
-- 
2.39.5

