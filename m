Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233355;
	b=iXQYni+uoZPYt9480K/A5I3JUBogjmgurMqTusHQIh9bfKVxyDTJ67avasuSWWJUe96s
	 7sGcW8mEprxxrCF5EzX3NuDCoSDsgt6N8dsdsa9nkO+7Fnbr6mrvXoU2fNHTPEK8+Yz9u
	 tqci/n3PYZjNPkecdP/bBpF8V0sWE6E0KHiCTxwos/Rz/URCh2xSTUhBic1Z3eIEEw2I5
	 RudMyfNq4td0z/jVAK2MonhFHDfpswLcS4XWXHmM9llrJrcgtPjUtvAh11x9CB/2HtFcK
	 H8IdyfzKW4T4XnlWQ5ukq+QC6HDYjTOiR0CdsvVXwREu8TXTPn/DjiAK2WzchXe/RZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233355;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iQ50Z8GrZdVWvlWB3gtz0AyrON7bR4KOzGZo59Q0ECI=;
	b=ZZB9wKMaLdRWlpHWRKFvWjFs1sIF0a2q7lCzg/DBZ2aMAKwxR9iYf4nID49zsGzgFzWQ
	 1kPmNVlcIGxWMhVzCjOHAY/Kqr/BkzAxicFIvoZwAVHSSTF3crbDm7WsUJTpC7KE+RnJb
	 3ni5zozd5JxPe4rBVKQhRdBvYOKklYKBlA0rQkD8YKLkFVzHz04dtKvWQ8UO9rp0Ul90k
	 U7Sv13Gzn0Trp2SH4YnU75SdABdlTSnIt1Kz3wzJGdEjuzYB0hIX4yAkA0mFuAqG+i9zk
	 A5WuH/ogSN1g1FBqLK6FI5djmsPGmyinTM7dnf7ois99PAejNBI3t6VdFuPaNspi6wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7FEH9b3;
	arc=none smtp.remote-ip=91.218.175.211
Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04439606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04439606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7FEH9b3
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eInuAVUPIVJ9rBRgFXv1dy5BH1QgCtuQ2/F9w6eAqww=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233353; v=1; x=1794838153;
 b=U7FEH9b3omA+VvEanH6hiqgA/eWVuZVRl3XkFcaEhHle9eK0HYCaoSs/98ZjFShLw+5kX5/u
 bDxKBHbJzayUfBzGxCun3Fa8bPqnHN3rNfh1JgTBNhk5BFwQz9kmJ0AWa4BYCy0qXS/Jz+KNW5g
 SxtazHX3mzWy9GSb08uzNnbA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7db8cf0a1ec2ca8c;
	Mon, 09 Nov 2026 14:09:13 +0000
X-Mizu-Trace-ID: 7db8cf0a1ec2ca8c
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 5/9] libbpf: Add log_opts support for BPF_TRACE_ITER
Date: Mon,  9 Nov 2026 22:08:12 +0800
Message-ID: <20261109140816.5196-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109140816.5196-1-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
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

Add iter.info and iter.len to pass iterator information separately from
log_opts. Keep the existing iter_info and iter_info_len fields working
for callers that do not request logs.

Thereafter, log_opts can work for iter link_create.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 17 +++++++++++------
 tools/lib/bpf/bpf.h |  8 ++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31e8c0e..174a8bfaf663 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -808,11 +808,6 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (iter_info_len && attach_type != BPF_TRACE_ITER)
 		return libbpf_err(-EINVAL);
 
-	if (iter_info_len)
-		iter_info = OPTS_GET(opts, iter_info, (void *)0);
-	else
-		log_opts = OPTS_GET(opts, log_opts, (void *)0);
-
 	/* validate we don't have unexpected combinations of non-zero fields */
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
@@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 	}
 
+	if (iter_info_len) {
+		if (OPTS_GET(opts, iter.len, 0))
+			return libbpf_err(-EINVAL);
+		iter_info = OPTS_GET(opts, iter_info, (void *)0);
+	} else {
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+		iter_info = OPTS_GET(opts, iter.info, (void *)0);
+		iter_info_len = OPTS_GET(opts, iter.len, 0);
+	}
+
 	memset(&attr, 0, attr_sz);
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
@@ -970,7 +975,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	default:
-		if (!OPTS_ZEROED(opts, iter_info_len))
+		if (!OPTS_ZEROED(opts, log_opts))
 			return libbpf_err(-EINVAL);
 		break;
 	}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fe3b7fd8512b..2ac143fd1102 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,6 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;
+	/*
+	 * iter_info and iter_info_len are deprecated, use iter.info and
+	 * iter.len instead.
+	 */
 	union {
 		union bpf_iter_link_info *iter_info;
 		struct bpf_log_opts *log_opts;
@@ -478,6 +482,10 @@ struct bpf_link_create_opts {
 			const __u64 *cookies;
 			__u32 cnt;
 		} tracing_multi;
+		struct {
+			union bpf_iter_link_info *info;
+			__u32 len;
+		} iter;
 	};
 	size_t :0;
 };
-- 
2.55.0

