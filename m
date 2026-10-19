Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424257;
	b=ZA0xVj/cUYXbLBEoz7fUX7JTK225+HqnVulaNOS6f29DRXo4/XuN4fE+4Pe84xQvBysh
	 Yho1usZ75V/Wdbw8QtGDdNrCfPFDTnBJhTZABOAdjXozOvHJAHuDeEeqVH9si02K2pS5F
	 2sW6TJNddKvaDTcNn2CwnG1/8HGBpPlsAZALiuwGWl9bgHsZIrQLBm+brZFvyN4NMux3v
	 PZeLeLsv9ujZBu1O1hhTR4HbsqRK/dtESBgL+WMbhD5GyuOtAsZ5hogwLZdj7MzvsPCqC
	 4+gNRDQnmOwjZqoOYEfT3r3OR+IyP46/3IrRweeMW1SHp+tfMSYTIws/xkPKhbCj9PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424257;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dUJTYJsLlzyXXUY346kwM0qbEb7/ZcRCJp3v3CTcxII=;
	b=zldXUFZBkzQTFF+/HfS0Hg17RlnMYb4aqYtp6Zvh88KucK5jpqbS9Ez0kucWfHCZpt/r
	 Iu1+UqrwgA/EM35vKPPU+ytYCYpZZ/zsTUMm6AemBWS24q/yk3WAp4y6XIqK8SXPLlkUB
	 OYEiYKV9On/eFLoMId23hQ69Z7eVT7IF7Diff1iWR+/Nv6J8dLsGkqPy/2GR29rIWrl7c
	 +Rfhm7jMUZncrtgWFh1a67pa2T78f/foIhOMnwE2+wRxCTGAjyTg5pbIlfU6896knkHsm
	 OY82u61wY6E8ulGMnxxehCxaBBU6e3VNx57VYk/Yl/rn/tDgX5lmTRteVc6iJCLvt6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NB+MtaXv;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF7606DA51
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 15:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CF7606DA51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NB+MtaXv
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oA/tXzZewa3e1Eee5uSA/aYj+j+eif8gKx6dS9PYgCk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792424255; v=1; x=1793029055;
 b=NB+MtaXvTaeOYBOzBzOpI+ex4jCH7doRKORA+v/0S5q77izL4FdeG19kF2Nhp5avEyXtGkkR
 jC/2ulPQPdDi7zPYbXzVAhAsMYqVzkCgVdSuEzoklRy2ICLRQ/VvoOBgoYKzl7w+MIJVFDpjNoX
 mlk4XryaMk4QcIvZoxYru6xM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1854e421e9778bac;
	Mon, 19 Oct 2026 15:37:35 +0000
X-Mizu-Trace-ID: 1854e421e9778bac
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
Subject: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
Date: Mon, 19 Oct 2026 23:36:27 +0800
Message-ID: <20261019153628.15912-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019153628.15912-1-leon.hwang@linux.dev>
References: <20261019153628.15912-1-leon.hwang@linux.dev>
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

Add a new API to accept the log opts, instead of extending the existing
struct bpf_link_create_opts.

Appending log_opts to struct bpf_link_create_opts would place them after
attach-type-specific fields of varying sizes, making it difficult to
extend the struct while preserving forward compatibility.

For example, adding log_opts would prevent extending uprobe_multi
directly with a new build_id field. Instead, a separate union would
be needed:

struct bpf_link_create_opts {
        /* ... */
        union {
                /* ... */
                struct {
                        /* ... */
                        __u32 path_fd;
                } uprobe_multi;
        };
        struct bpf_log_opts *log_opts;
        union {
                struct {
                        __u64 build_id;
                } uprobe_multi_ext;
        };
        size_t :0;
};

Without log_opts, build_id could be added directly to uprobe_multi:

struct bpf_link_create_opts {
        /* ... */
        union {
                /* ... */
                struct {
                        /* ... */
                        __u32 path_fd;
                        __u64 build_id;
                } uprobe_multi;
        };
        size_t :0;
};

Introduce bpf_link_create_log() to accept struct bpf_log_opts separately,
preserving the forward compatibility of struct bpf_link_create_opts.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c      | 28 ++++++++++++++++++++++++----
 tools/lib/bpf/bpf.h      |  5 +++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9a2107d4f6d8..263a1d516a02 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -788,9 +788,10 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
 	return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
 }
 
-int bpf_link_create(int prog_fd, int target_fd,
-		    enum bpf_attach_type attach_type,
-		    const struct bpf_link_create_opts *opts)
+static int __bpf_link_create(int prog_fd, int target_fd,
+			     enum bpf_attach_type attach_type,
+			     const struct bpf_link_create_opts *opts,
+			     struct bpf_log_opts *log_opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
 	__u32 target_btf_id, iter_info_len, relative_id;
@@ -965,7 +966,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		break;
 	}
 proceed:
-	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
+	fd = __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);
 	if (fd >= 0)
 		return fd;
 	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
@@ -975,6 +976,10 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (err != -EINVAL)
 		return libbpf_err(err);
 
+	/* bpf_raw_tracepoint_open() does not support log_opts */
+	if (log_opts)
+		return libbpf_err(err);
+
 	/* if user used features not supported by
 	 * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
 	 */
@@ -999,6 +1004,21 @@ int bpf_link_create(int prog_fd, int target_fd,
 	}
 }
 
+int bpf_link_create(int prog_fd, int target_fd,
+		    enum bpf_attach_type attach_type,
+		    const struct bpf_link_create_opts *opts)
+{
+	return __bpf_link_create(prog_fd, target_fd, attach_type, opts, NULL);
+}
+
+int bpf_link_create_log(int prog_fd, int target_fd,
+			enum bpf_attach_type attach_type,
+			const struct bpf_link_create_opts *opts,
+			struct bpf_log_opts *log_opts)
+{
+	return __bpf_link_create(prog_fd, target_fd, attach_type, opts, log_opts);
+}
+
 int bpf_link_detach(int link_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_detach);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..dedaf8086902 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
 			       const struct bpf_link_create_opts *opts);
 
+LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
+				   enum bpf_attach_type attach_type,
+				   const struct bpf_link_create_opts *opts,
+				   struct bpf_log_opts *log_opts);
+
 LIBBPF_API int bpf_link_detach(int link_fd);
 
 struct bpf_link_update_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index eeba4072a5da..f6eb57151f7d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -475,4 +475,6 @@ LIBBPF_1.8.0 {
 } LIBBPF_1.7.0;
 
 LIBBPF_1.9.0 {
+	global:
+		bpf_link_create_log;
 } LIBBPF_1.8.0;
-- 
2.55.0

