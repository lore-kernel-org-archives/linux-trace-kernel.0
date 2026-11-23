Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447747;
	b=Y0gsaUgykfEW66RdJioIWcCDP0ZCp5z8uE0VXFBVk5DzL9XHSf/h5cx3orA0bmUaMeWg
	 723Napbq31DsHBkGY5s+BPO4ijBRQZxflre3gxX9ZllSHUYGpvsXu91kktqPUp/ZWixgw
	 L9xbiuRR16BQ6pSuh0zkahZXlNne9LCEFC3SkLKu/2KcDAwq9D8VNqej/I1mn8z0QhbOs
	 v2gL+gM0IWQshjfVbaP9pVyEK9ND7CsE9s8uD1iFu26gw+PbFKRHN9KSThBw0jipMMs8h
	 O2S0c5z3VvkNB2zLWIG8q8FxpnP71Qngi9R7ySp8F+NUicGFwEhiEsS/3AIJHX34u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447747;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=512KT+dszHg+efwS3BYuJV7mtcBzhHtr0Z9hlCoHSL0=;
	b=YnKoV4AS/22ObIpnfQu5LzVSV72yZuXY5TT7Po4CghIV9GncNhvEOZffwHgGwFklm2nB
	 KeByGnq4m6zXKEFjCeFBWfURqfNv63YFQjpAfqQOb+mzG+HITYXzT2f9L/g2SJVR6Itsv
	 NxwJujLQTple52QWcPqihqahHaUc473Xty/hwL7pQPFum07aXhvfegtDfltsnvfX07Kka
	 zMgTs/Fe7j8UwFvLRe3tUZA57Slc0l1RmHKbEfXaRn8y31I7LBMkXl0HsG8dzI5K5hnhK
	 0mg0rJkIUKnZtdXuOk9oIOer4FIGVgpsoDcsyj29ktKf85pmPNJGsk09YVL3JW4AMeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QMwKXs1q;
	arc=none smtp.remote-ip=91.218.175.220
Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC669606A31F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC669606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QMwKXs1q
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z4IB+Ki3a8PjnrMq6MarlatYObpvI30K+1qs+OUo6t0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795447745; v=1; x=1796052545;
 b=QMwKXs1qA2kOZaHo1/ugPA/kdtZIwB4TiPnro4Mq8xDS1hEq7m/0j1RvC2jPF8ukuNOGB7Jh
 AiPoA+JbIzmmK4DZunO6vibAnbqDoZDZEA1Y3vLCtsvL3RvMZA7zsMnNxACrgUuD2zQygqSgCJ9
 ijBGYO8BV+rrYnpLE73BEP/4=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 56450bac7452779c;
	Mon, 23 Nov 2026 15:29:04 +0000
X-Mizu-Trace-ID: 56450bac7452779c
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
Subject: [PATCH bpf-next v3 5/9] libbpf: Add log_opts support for BPF_TRACE_ITER
Date: Mon, 23 Nov 2026 23:27:39 +0800
Message-ID: <20261123152743.19629-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123152743.19629-1-leon.hwang@linux.dev>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
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

Meanwhile, add log_opts support for bpf_program__attach_iter() API.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c    | 23 +++++++++++++++++------
 tools/lib/bpf/bpf.h    |  8 ++++++++
 tools/lib/bpf/libbpf.c |  5 +++--
 tools/lib/bpf/libbpf.h |  3 ++-
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31e8c0e..ad6b356cc48c 100644
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
@@ -821,6 +816,22 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 	}
 
+	if (attach_type == BPF_TRACE_ITER) {
+		if (iter_info_len) {
+			iter_info = OPTS_GET(opts, iter_info, (void *)0);
+		} else {
+			log_opts = OPTS_GET(opts, log_opts, (void *)0);
+			iter_info = OPTS_GET(opts, iter.info, (void *)0);
+			iter_info_len = OPTS_GET(opts, iter.len, 0);
+			if (iter_info_len && target_btf_id)
+				return libbpf_err(-EINVAL);
+			if (!OPTS_ZEROED(opts, iter))
+				return libbpf_err(-EINVAL);
+		}
+	} else {
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+	}
+
 	memset(&attr, 0, attr_sz);
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
@@ -970,7 +981,7 @@ int bpf_link_create(int prog_fd, int target_fd,
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
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..612eba0ff4f0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14813,8 +14813,9 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_iter_attach_opts))
 		return libbpf_err_ptr(-EINVAL);
 
-	link_create_opts.iter_info = OPTS_GET(opts, link_info, (void *)0);
-	link_create_opts.iter_info_len = OPTS_GET(opts, link_info_len, 0);
+	link_create_opts.log_opts = OPTS_GET(opts, log_opts, (void *)0);
+	link_create_opts.iter.info = OPTS_GET(opts, link_info, (void *)0);
+	link_create_opts.iter.len = OPTS_GET(opts, link_info_len, 0);
 
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 49f1120f4021..56300be81016 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1000,8 +1000,9 @@ struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	union bpf_iter_link_info *link_info;
 	__u32 link_info_len;
+	struct bpf_log_opts *log_opts;
 };
-#define bpf_iter_attach_opts__last_field link_info_len
+#define bpf_iter_attach_opts__last_field log_opts
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
-- 
2.55.0

