Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2823ABAC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Jun 2025 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304675; cv=none; b=k75e1AnUpSF6SwYESwMvzcdF11/qTm8qu75qZLwQH6+rAZDaZtd1uoYLpnCSeTKOu2Q1XGDhZ2TjKD0un43b2gmnvMT8JBkdORfEAz6jW4ICfvc061bjOyFHb8d2s4In5jQfwAvUXnsVDuoygzosbeI6SGeYm/v/3dhjuYhu1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304675; c=relaxed/simple;
	bh=IJ41739AEi4TJs1OyUX+L9si+OJptbFYqv204T64G/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz94fsvQf4NG4BRPj0JedixFDFzN1+BdtbQSlZ+DERl67+oHH7JrXiL7Jww+nQOVZObwKu3I1HN37753vg4wnF+VV7oB6UliNFpakCflnoZCLMBEzlfduWiheRXFwFUQWS+1ko1xv8AGSD2QSQqGpjGitoT47q2kRvfQ8NA+a6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwH3sI3w; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwH3sI3w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750304671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxT+zg0gvTS3emh0pHIyn4KqG6GSv2UuUJVE3nnXviU=;
	b=nwH3sI3wOiYNpI+uchyr15M2maSvM9gunTJZdc49OscSgmPVKidCbR6LQH0YykoZpscPl5
	X4DgBGidQ++GYJ1gkygIUr9K7cQD1IM5zPN/rZ8ipn4SisKwYlHcB83qj2n4wT0EHR9hc6
	3KGv942S6+nilzNvpB1oZ6xWyiZZbTA=
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
Subject: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
Date: Thu, 19 Jun 2025 11:42:57 +0800
Message-ID: <20250619034257.70520-2-chen.dylane@linux.dev>
In-Reply-To: <20250619034257.70520-1-chen.dylane@linux.dev>
References: <20250619034257.70520-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show kprobe_multi link info with fdinfo, the info as follows:

link_type:	kprobe_multi
link_id:	1
prog_tag:	a15b7646cb7f3322
prog_id:	21
type:	kprobe_multi
kprobe_cnt:	8
missed:	0
cookie           func
8                bpf_fentry_test1+0x0/0x20
2                bpf_fentry_test2+0x0/0x20
7                bpf_fentry_test3+0x0/0x20
6                bpf_fentry_test4+0x0/0x20
5                bpf_fentry_test5+0x0/0x20
4                bpf_fentry_test6+0x0/0x20
3                bpf_fentry_test7+0x0/0x20
1                bpf_fentry_test8+0x0/0x10

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d422f897ac..99a1044b294 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,10 +2623,40 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "kprobe_cnt:\t%u\n"
+		   "missed:\t%lu\n",
+		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
+					 "kprobe_multi",
+		   kmulti_link->cnt,
+		   kmulti_link->fp.nmissed);
+
+	seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%-16llu %-16pS\n",
+			   kmulti_link->cookies[i],
+			   (void *)kmulti_link->addrs[i]);
+	}
+}
+#endif
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_kprobe_multi_show_fdinfo,
+#endif
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
-- 
2.48.1

