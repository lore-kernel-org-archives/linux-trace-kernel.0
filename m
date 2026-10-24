Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856243;
	b=dYwYJTIUV/g5B0BnU8qUUfs9ybCr7ljWbHKp27WDj9ThOSAYTkIGu3ycvN7oHm+48JyL
	 zrQPsn687SCsYviMH9KDQbXNWbNbkQzhwPKS7JMGrwO4HhZVyNfnvs3gRmbChoyIZWBMh
	 I5Ss6N/jMTMfjwKFCDMRO5AAmIecK/V9X8AeKS4vM+gCecZRR5Xn7ZbG6DkEJwe97fPOr
	 oK/vpkBxSqeon5gG6uWDzyCEpaaxIQeB4kXOtoZ8ZwVqw0yQaY1ZFjopZarQHSq/6bPVz
	 axDJmY6YC+8zZlF058vBd/zMGxx4nZqNPTlJO56AlVQH7kLh73FxaUXCKV+rdZvij3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856243;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Pvjw8HRLnHni+FZwWrlUa2T4PGWR53RxB/HrY99yOw=;
	b=NDrze7iIbq7Xv+JWDpsY8SNeKQepc2xVpo+N3RP81e3ixvrt1pE0vAV+BF8va6lPN1jc
	 UJDQusOl6b3k5BoNOVHvBXC26eIiVnkPq8WzoMpBKW5i2yTEwOWsNjDzKyYoThI4l6GBR
	 6JNJmKnAiyMONLDa/eV1X5nT4uD5QHTfmsEd8DdTbJYZwH6oFM2DPm9R6mtmYG7to6Vuq
	 Rvhe6a3/HXKgKGAZOnbhiqw11cMePeTRCBXSpw+YBaPAuHJcK1iFV2yLimHXIIwiOknDW
	 bCT0K5huI5zdY4maio2V5/sOlT2Fv02QbRhgRTxIs0jz+nDnC9YyWKmKXZUH0LDNRhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WmYUaefL;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA59606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 15:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA59606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WmYUaefL
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zJC9ty/LE7pzfzpMn8wblErHaCPAeoPMnKwSsk4yqEw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792856241; v=1; x=1793461041;
 b=WmYUaefLhVXM3AUT3y9mM0zREYdHkAzlgM+IUe/UYGu3YdLoDrA+e4qHiRRPbHVp9UEe9pLt
 8u28GYNpjKpFykMWAtaqlIcVS1dfODYomU9MjqTJvXP0vJY+Qs0shd0dfkkjc4XTC9ceq27zTIf
 9uRw6Ksy89nKNMJNIuHy/0W8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b106be7095f877d4;
	Sat, 24 Oct 2026 15:37:21 +0000
X-Mizu-Trace-ID: b106be7095f877d4
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
Subject: [PATCH bpf-next v4 5/6] libbpf: Add log_opts support for bpf_link_create
Date: Sat, 24 Oct 2026 23:36:06 +0800
Message-ID: <20261024153608.58569-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024153608.58569-1-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev>
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

Since the iter_info and iter_info_len in struct bpf_link_create_opts are
legacy, reuse the slot of iter_info to place log_opts.

When adding log_opts support for iter link_create in the future, we will
move the iter_info and iter_info_len to the last union, see below. And,
keep the backward compatibility meanwhile, that uses iter_info if
iter_info_len is set.

struct bpf_link_create_opts {
	/* ... */
	union {
		/* ... */
		strut {
			struct bpf_iter_link_info *info;
			__u32 len;
		} iter;
	};
};

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 20 +++++++++++++++++---
 tools/lib/bpf/bpf.h |  5 ++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9a2107d4f6d8..00efa90a6ed9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
 	__u32 target_btf_id, iter_info_len, relative_id;
+	union bpf_iter_link_info *iter_info = NULL;
+	struct bpf_log_opts *log_opts = NULL;
 	int fd, err, relative_fd;
 	union bpf_attr attr;
 
@@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
 	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
 
+	if (iter_info_len && attach_type != BPF_TRACE_ITER)
+		return libbpf_err(-EINVAL);
+
+	if (iter_info_len)
+		iter_info = OPTS_GET(opts, iter_info, (void *)0);
+	else
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+
 	/* validate we don't have unexpected combinations of non-zero fields */
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
@@ -824,7 +834,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 
 	switch (attach_type) {
 	case BPF_TRACE_ITER:
-		attr.link_create.iter_info = ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+		attr.link_create.iter_info = ptr_to_u64(iter_info);
 		attr.link_create.iter_info_len = iter_info_len;
 		break;
 	case BPF_PERF_EVENT:
@@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	default:
-		if (!OPTS_ZEROED(opts, flags))
+		if (!OPTS_ZEROED(opts, iter_info_len))
 			return libbpf_err(-EINVAL);
 		break;
 	}
 proceed:
-	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
+	fd = __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);
 	if (fd >= 0)
 		return fd;
 	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
@@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (err != -EINVAL)
 		return libbpf_err(err);
 
+	/* bpf_raw_tracepoint_open() does not support log_opts */
+	if (log_opts)
+		return libbpf_err(err);
+
 	/* if user used features not supported by
 	 * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
 	 */
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..fe3b7fd8512b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;
-	union bpf_iter_link_info *iter_info;
+	union {
+		union bpf_iter_link_info *iter_info;
+		struct bpf_log_opts *log_opts;
+	};
 	__u32 iter_info_len;
 	__u32 target_btf_id;
 	union {
-- 
2.55.0

