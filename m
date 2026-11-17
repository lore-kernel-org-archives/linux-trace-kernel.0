Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893077;
	b=ysxg3k5cAY808MGkapBPmib1a+xp2eJE7SKTXXrPfQPPECBShisfhUOBbLoZm2D4U/f9
	 hUC+AK/IhjjGDPrfubRx+/t/VxGC9gLWx5IN03KW6nq6TRCiXLMHNk3SpbkClOBuMzM0E
	 cg+Wn8956eWUDHfh/Wy4ekVEwLdxw4tc2iVQn6b8UL1Cj8MoYnOaLCDW4ytsz+/C0j+sY
	 sb9yKhoZ9Qb5Dfzzf4TUNCtK0yXA28U++WISY3KeNnM1Oq75JVECRGomcXoWXxEiE2PxE
	 v0JF32Zidfc3I/fUypELbiIVjPQo03KL4ph2fZfYGhJPhVlgd4B4RE7wWM/KsRg9kMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=92iLM9PE3+0NUQh9S/WcBgYVX45/LD+uF4QmzjutD40=;
	b=PfXjOmsNQT2AYhtopZSTwXU+DauVDVLP+If08iKD0q1sdBv+C545/Z9UIi/eC2+HjtSm
	 I4Jli8vPXcqVyMeCAb9lHD7+Azkv4OliPc/1GiwIqr+kebs2+2lxVDEvFIjNW11/uy41e
	 zKPaFq6QuRozglViPIplQBu+rsZHTrx/U9CeO1rDALr1OB6Ba/hk+5+SD5H5UeG9VilQ/
	 I6h7U+OeejVgZNAfz+b4N3onzwTul1HEme+bFrmpU7Ws7fQZDY+cZ1Fj+bucV9uaqtJED
	 o6dS213YUlFdwYnv1epVk8AYwsC3P4Y3F6/4xJaO2ArXbJKyzGOV0fPyxt1naFBnGPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZN5eayI2;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC5606A332
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 05:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DC5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZN5eayI2
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3bbe7925eso29858a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 21:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794893076; x=1795497876; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92iLM9PE3+0NUQh9S/WcBgYVX45/LD+uF4QmzjutD40=;
        b=ZN5eayI2Xlw1biAy43IblBYsfXrWirhPgtWguYGIMxCMTNw2ar3F3eICDg66bXGkfz
         a5T/JO97wWmOSgRwl/L0B8y4UmeM16L6Kz38SEZ+pMzD1M9z1XxYrqHWcIolZGMVDzEc
         CMYOnCWlxIRfoJ+ltZWf1qZ+h3JM/69OxOLPylJCnIY0Tjos7bBfhx3yPyA0+uRZKD+1
         JZFyY2PF0ppO4QTrSN5tCV/4jHfhzi5dng7zrqShksCEwvV7lfEwqZS0x0O9nBnwQLMZ
         q4LSIkg/9IGTJrnlclNkB7n6BE+r9jjOLizBx6xn2ouv7drX+j3feBkz+51rnKDw1/Hq
         gOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893076; x=1795497876;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92iLM9PE3+0NUQh9S/WcBgYVX45/LD+uF4QmzjutD40=;
        b=zvaXp1LYsDW/c0SUgRtfDugUqeTLeSFE1BfOLT0RE220BieEJovgvQurEM1fC1ITGq
         d0+6qwsQJ9vAa74/nhqsNABWOKRfv5akLFXgZPunqzlUeq7lQUHe7jOCu0W7X51EFu4z
         T2k4+xSoC4mb1Rw6PqSQyAsMClpyFCG9UfwWMbWwrWIA4MZeIk7WXVshYRMlFSq8a0kG
         yOczlMwQC18klXpMjhi3oUG+STtpKJvE9pLMF9w4O85s/fG5ZKcO3ZZo5gzT+/0ftASV
         AWCcqYXg1C1/KgNJxPhaHonobB0degp/Gk6Lte3LyhUXkDLrxf8XiIDhF/sesZ85OsbQ
         NLCQ==
X-Forwarded-Encrypted: i=1; AL+hErH8uWfdNhILHt/6cauWGV/2KycVpn843ZkusDyxGWN31sF7aUBkBpN7c8a8Gtde3D7/1z84eT3K9fGW3YKl6QGiI+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gHL38KbsCoaJ6wF75RVWiNfAi2MaSAkyRGJdAY96vEgV5Qmtw
	7axHQ1D0rZlfp+G+hzR9LL5kDd6tQyb0z8uBajkWgy76MZemkjF56l3f4cXbxg==
X-Gm-Gg: AZFdTZcihuvwD4AuAI4x5VYz3xQrwWATnwqgZvgj7xMg5eT2QDZueNzLLQBmBWM07Wa
	e9yir/WJDjsSAvbAUeyiRLjHbxZge9BnyBx9QqkvDpXzUEhslVX/pjTqdW8koD6RQiiD7P3O4mD
	sN1cDgpV3nDajcncs42BwqcGTxSzZsv4vxUFN1gAkd9gggXSG69zUGfEGSFASW2PbqIdAmDnPwz
	0BrEsD9EG43VGZC3pudI2v7INUHbUeE5ZMDa6Yr6RabwPrbePCL9BPPih2Hi7ioqG/sgnniyYik
	b0fXSre2JGFQ4r/PhPi9mF7F8xI+PusvGEDEhfL5gJpEApiw5CD7lW4DDuv9IIRJLAtkyjF8pJa
	zIq5KbWb1Bda+8Jht0IEbmQAJOEQ+plSrqeTJbZK+c70IOJE44up9vauBbJ4AiSFby4XDyt+ggS
	0mqsVqMbLEhYkFKtk07rNlAhAgeqpUaPi/55gkek0ius8Q/nKnlsELq3+ktolTLDVe7gsEOhBpi
	shyXHic1dj8YA6KX2AC2gb96Rr72jBq/qXu7qW2gMMsE5w5aul3kBzDwAWSNVZf4kOsmQWNhcss
	97ad5jUpxb8vfU7r+8GkfII7nRoKH6qzQb0k9VIdeBwvzz9Azi1a6R2VMH5Jn+REDSG9y00TpCA
	sKu580qU2f4BL/P/FEE124zszFdJYEP6c/EM=
X-Received: by 2002:a17:90b:1dc8:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b1b0b5b89dmr12632432a91.10.1794893075609;
        Mon, 16 Nov 2026 21:24:35 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac29a846sm2093493a91.9.2026.11.16.21.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:24:35 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 05:24:34 +0000
Message-Id: <DMX8HR7NDP9V.CDDWGLZ98C0K@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "KP Singh"
 <kpsingh@kernel.org>, "Matt Bobrowski" <matt@bobrowski.net>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/9] bpf: Add log support for tracing_multi
 link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261114150610.84507-3-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev> <20261114150610.84507-3-leon.hwang@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 07:06 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> -	if (!cnt || !uids)
> +	if (!cnt) {
> +		bpf_log(log, "tracing_multi.cnt cannot be zero.\n");
>  		return -EINVAL;

The user sees cnt == 0 in his own code.
He can't see which of up to 1 << 20 ids the kernel refuses.
That part stays silent:

  bpf_tracing_multi_attach()
    check_dup_ids()                      -EINVAL
    bpf_trampoline_multi_attach()
      bpf_check_attach_btf_id_multi()    -EINVAL, -ENOENT, -EOPNOTSUPP
        btf_attach_func_proto(NULL, btf, btf_id)
        btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel)

The last two have messages. They get NULL.
That loop runs before trampoline_lock_all(), so bpf_log() is fine there.
can we pass the log down and name the id ?

> +	if (cnt > MAX_TRACING_MULTI_CNT) {
> +		bpf_log(log, "tracing_multi.cnt is too large.\n");
>  		return -E2BIG;

that's not a helpful message. -E2BIG says the same.

> +	if (attr->link_create.flags) {
> +		bpf_log(log, "Invalid flags.\n");
>  		return -EINVAL;

Each value but zero is refused. "flags must be zero." would make it clear.

> -int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
> +			     struct bpf_verifier_log *log)
>  {
>  	return -EOPNOTSUPP;

The stub has the log now and knows the reason.

Consider something like:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3f6364..efff0fa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1646,7 +1646,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-				struct bpf_tracing_multi_link *link);
+				struct bpf_tracing_multi_link *link,
+				struct bpf_verifier_log *log);
 void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 				 struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
@@ -1764,7 +1765,8 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	return false;
 }
 static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-					      struct bpf_tracing_multi_link *link)
+					      struct bpf_tracing_multi_link *link,
+					      struct bpf_verifier_log *log)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 716330b..bf2aef5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2183,7 +2183,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			 struct bpf_insn *insn_buf, int insn_idx, int *cnt);
 
 /* Functions exported from verifier.c, used by trampoline.c */
-int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+int bpf_check_attach_btf_id_multi(struct bpf_verifier_log *log, struct btf *btf,
+				  struct bpf_prog *prog, u32 btf_id,
 				  struct bpf_attach_target_info *tgt_info);
 
 /* Functions in fixups.c, called from bpf_check() */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d4608..93fead8 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1724,7 +1724,8 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
 	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-				struct bpf_tracing_multi_link *link)
+				struct bpf_tracing_multi_link *link,
+				struct bpf_verifier_log *log)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_attach_target_info tgt_info = {};
@@ -1737,9 +1738,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	for_each_mnode(mnode, link) {
 		rollback_cnt = i;
 
-		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
-		if (err)
+		err = bpf_check_attach_btf_id_multi(log, btf, prog, ids[i], &tgt_info);
+		if (err) {
+			bpf_log(log, "Cannot attach to btf_id %u.\n", ids[i]);
 			goto rollback_put;
+		}
 
 		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce11e78..ce7f530 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24420,7 +24422,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
-int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+int bpf_check_attach_btf_id_multi(struct bpf_verifier_log *log, struct btf *btf,
+				  struct bpf_prog *prog, u32 btf_id,
 				  struct bpf_attach_target_info *tgt_info)
 {
 	const struct btf_type *t;
@@ -24447,10 +24450,10 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	tname = btf_name_by_offset(btf, t->name_off);
 	if (!tname)
 		return -EINVAL;
-	t = btf_attach_func_proto(NULL, btf, btf_id);
+	t = btf_attach_func_proto(log, btf, btf_id);
 	if (!t || !btf_type_is_func_proto(t))
 		return -EINVAL;
-	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
+	err = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
 	if (err < 0)
 		return err;
 	if (tgt_info->fmodel.ret_size > 8 &&
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a3964d7..a7954e0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3890,7 +3890,7 @@ static void ids_swap_r(void *a, void *b, int size __maybe_unused,
 	swap(*id_a, *id_b);
 }
 
-static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
+static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt, struct bpf_verifier_log *log)
 {
 	void *data[2] = { ids, cookies };
 	int err = 0;
@@ -3904,6 +3904,7 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 
 	for (int i = 1; i < cnt; i++) {
 		if (ids[i] == ids[i - 1]) {
+			bpf_log(log, "btf_id %u is in tracing_multi.ids twice.\n", ids[i]);
 			err = -EINVAL;
 			break;
 		}
@@ -3935,15 +3936,16 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
 		return -EINVAL;
 	}
 	if (cnt > MAX_TRACING_MULTI_CNT) {
-		bpf_log(log, "tracing_multi.cnt is too large.\n");
+		bpf_log(log, "tracing_multi.cnt %u is above the limit %u.\n",
+			cnt, MAX_TRACING_MULTI_CNT);
 		return -E2BIG;
 	}
 	if (attr->link_create.flags) {
-		bpf_log(log, "Invalid flags.\n");
+		bpf_log(log, "flags must be zero.\n");
 		return -EINVAL;
 	}
 	if (attr->link_create.target_fd) {
-		bpf_log(log, "Invalid target_fd.\n");
+		bpf_log(log, "target_fd must be zero.\n");
 		return -EINVAL;
 	}
 
@@ -3969,7 +3971,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
 		}
 	}
 
-	err = check_dup_ids(ids, cookies, cnt);
+	err = check_dup_ids(ids, cookies, cnt, log);
 	if (err)
 		goto error;
 
@@ -3998,7 +4000,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
 	link->cookies = cookies;
 	link->fexits = fexits;
 
-	err = bpf_trampoline_multi_attach(prog, ids, link);
+	err = bpf_trampoline_multi_attach(prog, ids, link, log);
 	kvfree(ids);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
@@ -4019,6 +4021,7 @@ error:
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
 			     struct bpf_verifier_log *log)
 {
+	bpf_log(log, "This kernel does not support tracing_multi.\n");
 	return -EOPNOTSUPP;
 }
 
