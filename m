Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA96223714
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729391; cv=none; b=KD223CtQEkBsAlSjFA6RJhzfiKTOzKZNJNlJykRQLNpzgB4DVQ/S7CrAIOCTONZJCNtKjCKfIIQ6J+2wRidjWdiDoRAEcmPWZbw4f6ddYPCgMc8m9KfR597ts5qNbpxpzOgRTDCwgLScATTkGYYstFYmesJb1YfiizBh3nGISFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729391; c=relaxed/simple;
	bh=lfBOzGo2w8TegsMN/okVNt545ojtH3LSDwiGDmOvrfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8HJRiuzNx7MPmyRthvydnlHlV3NeKmDW7pVGbm46kFklA8ngzvKJQA+woqbQ4Y5dCoJGnBQ7rUM56RNxJEmz75ueY6QkaIceppMPlDL2OR+bvyO1Sx9+HiEUi5G4K4+potQxYjmFu/MHXnr01q2PdgkMut4uDi+xLq6PzWUlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pBs3pgyV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBs3pgyV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749729377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yeGanY3faZzIQt7AidE+BWD380NKCiKNmhDjjFNsWXI=;
	b=pBs3pgyV7Xmupm+7PGjCdm5eKZKavVrCWgEbrcURfG1FCbli8HyRJuh/IWwSZrPtBwn1nW
	qmMpLnSy3NW9/ogNQOph0nBlIKOVgmvxKR7oEwQfS6nE2TVFT4PKiZgD/R1bUHPPaOmOuY
	ENKGIqj8gb5S4PgxfnapLncfGmgeiXc=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Add show_fdinfo for uprobe_multi
Date: Thu, 12 Jun 2025 19:55:55 +0800
Message-ID: <20250612115556.295103-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show uprobe_multi link info with fdinfo, the info as follows:

link_type:	uprobe_multi
link_id:	9
prog_tag:	e729f789e34a8eca
prog_id:	39
type:	uprobe_multi
func_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
offset:	0xa69ed7
ref_ctr_offset:	0x0
cookie:	3
offset:	0xa69ee2
ref_ctr_offset:	0x0
cookie:	1
offset:	0xa69eed
ref_ctr_offset:	0x0
cookie:	2

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..c4ad82b8fd8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+	char *p, *buf;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	p = d_path(&umulti_link->path, buf, PATH_MAX);
+	if (IS_ERR(p)) {
+		kfree(buf);
+		return;
+	}
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "func_cnt:\t%u\n"
+		   "pid:\t%u\n"
+		   "path:\t%s\n",
+		   umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+					 "uretprobe_multi" : "uprobe_multi",
+		   umulti_link->cnt,
+		   umulti_link->task ? task_pid_nr_ns(umulti_link->task,
+			   task_active_pid_ns(current)) : 0,
+		   p);
+
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "offset:\t%#llx\n"
+			   "ref_ctr_offset:\t%#lx\n"
+			   "cookie:\t%llu\n",
+			   umulti_link->uprobes[i].offset,
+			   umulti_link->uprobes[i].ref_ctr_offset,
+			   umulti_link->uprobes[i].cookie);
+	}
+
+	kfree(buf);
+}
+#endif
+
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
 	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
+#endif
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
-- 
2.48.1

