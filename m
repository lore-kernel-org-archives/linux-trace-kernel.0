Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029834;
	b=LPVye2/AryeVcRI2N0MSCLIuXul4J5BsnWMuqQtyWu0SXDF7czyExoj2MzySxlH9vma/
	 Ixea3KRBZSXAXm84wxo4sdHwqbzpW1Rp0B0qFofjb8pYUCHXj+VHeiD3ONoXawlW7oBnb
	 Mq9kYILE2wltsS6cLTK1lahCvtl9iUTpXA1K8XIQkgWJLSWCq6zOZQ2jO3PGzjBxkFc8c
	 IGxql/gd9uAUtix8WNlKCBl6L36df2nMLueq9BpR5dS4gBZ/n4qWLHTIHYAlg2PQooXEH
	 9lLI3CY3szu1EOTAEzD2I279qjPSMOK+vmxr0aHJ+JPk/EJdenBwivkKznHp8CH9/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029834;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bPzOvuX5VgrTU9yIIudolJJSPSRHz/AbtYrEX5LP0UI=;
	b=PJc1+KCzrFgz4y8KBJgo5qLi/+2rf9QdJCvXUoB01eb+J3qGw6zdsa+6MyF2WLZXx3+h
	 r+/PEJxntj/HqcNi5Lxy31dGC2nXjTz7jpvl5VbP6/GTOo/7zVBLmVljDrf43ltpQC2qK
	 7guHUg4bZ5G2hQuk6efMbheGcEO/8v3Mo+UvzaqHrLoeDbpkpe8olZTIT4LODs107s92x
	 7h9ywXOJrVtWSdRaeNi9NgwFFcCf5j+GOq7AVRdzrEOWDc4wc0kgWp6qVHFQZwKVASZHw
	 pOKRDmu30DB/W7HV9j/q7Kurz0Qm38BunvONmxQn9wV0Wsbcg3OmJkTraNMKcOXQBPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MBF0qe5e;
	arc=none smtp.remote-ip=91.218.175.88
Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D2606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MBF0qe5e
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=miCtniVHMbA/PYAbgBN5voicnBaPD8dFe3tGyzcmStY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793029831; v=1; x=1793634631;
 b=MBF0qe5eCnHpG7DK3QcgGiOttHOj1CRmcwdBGM7SO2Av36+rLuCaAEjUe6QW4vSq/w0bE1Nh
 js2t+g5wN4C3+pKGAjgHnzg3CvBtTjHlTPQXK4an3INLTI2T15cOmKilPJ5Nl0xke0x3yl8dTuV
 EqRvFsWZGK6xGaxkivEPhAYM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id db4da94b28b9c1d8;
	Mon, 26 Oct 2026 15:50:15 +0000
X-Mizu-Trace-ID: db4da94b28b9c1d8
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v5 1/6] bpf: Add syscall common attrs support for link_create
Date: Mon, 26 Oct 2026 23:49:42 +0800
Message-ID: <20261026154948.99408-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026154948.99408-1-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
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

Similar to the syscall common attrs support for map_create [1], add the
syscall common attrs support for link_create.

Create and finalize the internal verifier log instance.

Then, report the error messages for invalid prog fd, invalid attach type,
and invalid prog type.

Links:
[1] https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.org/

Link: https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.org/
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc7230afa8..db870e795d04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5862,8 +5862,11 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 }
 
 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
 	int ret;
 
@@ -5873,14 +5876,24 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
 		return bpf_struct_ops_link_create(attr);
 
+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
 	prog = bpf_prog_get(attr->link_create.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		bpf_log(log, "Invalid prog_fd.\n");
+		ret = PTR_ERR(prog);
+		prog = NULL;
+		goto out;
+	}
 
 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
-	if (ret)
+	if (ret) {
+		bpf_log(log, "Invalid attach_type.\n");
 		goto out;
+	}
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5959,12 +5972,20 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
+		bpf_log(log, "Invalid prog type.\n");
 		ret = -EINVAL;
 	}
 
 out:
-	if (ret < 0)
-		bpf_prog_put(prog);
+	if (ret < 0) {
+		int err;
+
+		err = bpf_log_attr_finalize(&attr_log, log);
+		ret = err ? err : ret;
+		if (prog)
+			bpf_prog_put(prog);
+	}
+	kfree(log);
 	return ret;
 }
 
@@ -6536,7 +6557,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
-- 
2.55.0

