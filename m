Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892939;
	b=cTTpEYJi1X3q5XtMusESr6sGxi5E6I6ppF0KIc/f4SdJbCKTNxuAHRkMe+r4+rWRm7FF
	 FXoQGrN5m5m/sWeU97E1wJIjHU0Og4/IcG41SBHR5ziAIv7eswpLDkVM4qbFQq5xTJAVM
	 +HBaEl1JiWoY3xEARUkBcL+qtaI0q6jRmdmpvm1+SsAPQXh5E/Yy3f1E0be12kj1hwpwV
	 DB6S0dea5Pb+SVOqC8SyIVVQTalowREibr3MgMWrOnb3hhfUiGxQwoLrCQt3Gvjj2CpB2
	 RC7/S/uiB2BLLYc/4pNgWTLb5grm/DtShiHndJb8abh4BkM41A9SlyWgwokMN+GuDTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KH2EdOZQFCM29AQgS9x2MTO2Oio7leMA6Gbor09I+Fo=;
	b=qc4W8rEDLLICP5yxpu9HfFM+HC1f/VbJB9ZmvHn5AuwoB7gJbeKaeiGoeqd2nPhijXl1
	 P4FE2PUao2Bxzrn3ksM3zgjHPza5ZMWdFWBaYYC2EJYWkqHoOVayU8dMVGxPve0EYkvG3
	 knSK8TJ7r+tuBBk3WzDl+3/NmSNsXN6X1vyGfZ3R/YDD7tP+dEIbwqfyiZ8XH0LrwQ7/a
	 Hf/7AcUZrEu/60pyFh0AosZQLaJgrbULohi5VmPTakk4ONkRDYEWqZ9kiOUAsH6QYe2QK
	 oqFM1Ksm6+wAK+snuDZu055C6UAphLaytES0GnYAGKGGf17pwM4Tb2w/B2XAxH5GkGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgpotozO;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E6606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 05:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66E6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgpotozO
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb684859cbso2975147a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 21:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794892938; x=1795497738; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KH2EdOZQFCM29AQgS9x2MTO2Oio7leMA6Gbor09I+Fo=;
        b=QgpotozOIwafP7uLbeWT2TODTeVPHollYT3PV4rkXSBXMCIZTTiFHVXcgv5LmUHUAB
         sM6H4SaB+swTJKPebfWdVgNSVhx7Ai2xMgBDufHrFUmSndxJZ4iU4RgEs8IbmCwL44H/
         RnD5BGk7CmQL0gY1bXjT8+5gHGmgOIr7KJ6wJX5KWiZOe0s7QYwEOOaJ8MXVixzFXSCa
         1VMiM5KSBUz6okr0kI9ILn/Bnje5qU8Ge1mOccIz4SKGjP/ftcIb34IS5Xkmuk+vov+n
         dgREl+PhzdtQgnIdT8DpMGklQkSQIzOcNzs6VzOfLvEJvqP16HuoeznE6BuY2LKXBF4o
         tDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892938; x=1795497738;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KH2EdOZQFCM29AQgS9x2MTO2Oio7leMA6Gbor09I+Fo=;
        b=OOAe3BfHmNRmSVfPOjO6g63oL6eAgXGMMMfDb0uCtG7G3rMaj94EwK1RXVdyXM8B1H
         +s1cMlGFrJzDsurlDK9hQMDaFkG6erzjDu2vGOKI4jKxuauxCtKr39EiSRs9C/psXAMf
         FlxgPTW6Es5koVWqncSqdfASD5yteV5IDFeWH6N1GA8PxYzpmLbZsozvF6CDXn3exLLn
         3ljZFtm7sQnP7vFSQUXcAZbgjYGAniuEvwG3RhV3sBCwlr/mfD2+dL44CcyalOYuMnCt
         1yg1xMpzDZ9nf3lpAQ30H41CT+DYJIobzD5qcTI6ytUHv8JtPS0ZkmQ3JodeaU+cLUIR
         rPVA==
X-Forwarded-Encrypted: i=1; AL+hErHSLKjZlUBDKjj79ETBzLGEN2tUXLbjIGuv7XkpZvHG+kVUTG1lVzlawuBJO7xQWMFH4psDV0knNhi/TAKkGycYB5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VsX2xpxMBGb0AkclimkUygJlgtRWBxefj7C5LN+QtKMtoqLH1
	qc3Wr0s+ipHuLU3WeZAGdcfHoq4HfO7zy/f15p5y3aSkm8pczM/fFm3n
X-Gm-Gg: AZFdTZe7lfRjPmeTgBe6R9BJwh3IVkB+LzxfsK2EYDg/T/Im8nLX7ogLFl5effOp6Ls
	CA5S1lJ+wEw2h02KDwv+CG8gqJcDRprGFj8sEnJwQ1rC2XwfT5JXQBLjVTDybEngW3pXSjf2JWQ
	menu0M4bHJF/OFpweeeV7taGSL6T115BVQtA77Q7zPdfuuGll1ob2Rau3jsFMn6GxCOemKZ9rgc
	45MrnTDVKCeZEeEiAXYjswbq0x2t+wxikZ+VnmVZaTZsbZ5BOHG5VkgfQG/UU1hblxEzYwgUx5G
	LEixy/xJJH9T5QzcGZi87VpRtMJTtLt/XWZZGSVOR7HqDZX8/w6S9nK2ITjj+pwAbf860eoQMoa
	3LSaBoIx0gP6LRiEdMNJSiHDwK28pdZcrF1kQhXFRLjAfch1awOS5CaJHRzT/raNm+d58+Wx/cd
	XQk0VtCMQ5atjh+Xza7+RMkAdhj713689MbLE86htwwVB9nFR+y2eY5Oi0rAugqdOLQYFX5UAtO
	4YU8KQXOVZGCU8nrJU6vfOhJKexKt1MrFIAI6VnQvg4i7Zob2W7zqLfC9PMC33LwLBsk9KoTd1H
	rIEzn0KeKZB9EYzKJOl+hhwguUldK7JocbPZ5zs7R2LcA9zpi8ZqDjn3vmWOIgFyfgONy0/x0c1
	H1xbmatu9IA3KDaKh8MbVw59RAj/EoysTWw==
X-Received: by 2002:a17:902:d4c5:b0:2ed:3ad6:141d with SMTP id d9443c01a7336-2ee0dad017bmr119363765ad.25.1794892937999;
        Mon, 16 Nov 2026 21:22:17 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a4114csm7909205ad.38.2026.11.16.21.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:22:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 05:22:16 +0000
Message-Id: <DMX8G01GB597.2KEEFI12YK9V0@gmail.com>
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
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Add log support for tracing
 link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261114150610.84507-2-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev> <20261114150610.84507-2-leon.hwang@linux.dev>
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

tldr: pls use uapi names where possible:

> +		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");

The uapi fields are target_fd and target_btf_id.
tgt_prog_fd and btf_id are arguments of this function.
Patches 2, 3 and 4 say target_fd for the same field.

> +			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");

I think this one misleads. A freplace prog can re-attach.
It has to pass target_fd and target_btf_id.
The comment above the check says so.

> +			bpf_log(log, "Invalid attach_btf.\n");

attach_btf is a field of bpf_prog_aux. The user never set it.
NULL means that the prog was loaded with attach_prog_fd.
Such a prog can't re-attach at all.

> +		bpf_log(log, "Invalid kprobe_write_ctx.\n");

Another bit of bpf_prog_aux.
The rule is that both progs write to pt_regs, or none.

> +			bpf_log(log, "Invalid tracing attach_type.\n");

LSM progs get here too.

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35f8a71..85d97cb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3712,7 +3712,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (!!tgt_prog_fd != !!btf_id) {
-		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");
+		bpf_log(log, "target_fd and target_btf_id must be both set or both unset.\n");
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -3725,14 +3725,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * attach_tracing_prog flag is set.
 		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
-			bpf_log(log, "tgt_prog_fd is only allowed for freplace prog.\n");
+			bpf_log(log, "target_fd is only allowed for freplace prog.\n");
 			err = -EINVAL;
 			goto out_put_prog;
 		}
 
 		tgt_prog = bpf_prog_get(tgt_prog_fd);
 		if (IS_ERR(tgt_prog)) {
-			bpf_log(log, "Invalid tgt_prog_fd.\n");
+			bpf_log(log, "Invalid target_fd.\n");
 			err = PTR_ERR(tgt_prog);
 			tgt_prog = NULL;
 			goto out_put_prog;
@@ -3787,13 +3787,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		if (prog->type != BPF_PROG_TYPE_TRACING &&
 		    prog->type != BPF_PROG_TYPE_LSM) {
-			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");
+			bpf_log(log, "Re-attach of freplace prog needs target_fd and target_btf_id.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
 		/* We can allow re-attach only if we have valid attach_btf. */
 		if (!prog->aux->attach_btf) {
-			bpf_log(log, "Invalid attach_btf.\n");
+			bpf_log(log, "Cannot re-attach a prog that was attached to a bpf prog.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -3849,7 +3849,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 */
 	if (prog->type == BPF_PROG_TYPE_EXT &&
 	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
-		bpf_log(log, "Invalid kprobe_write_ctx.\n");
+		bpf_log(log, "Only one of freplace prog and its target writes to pt_regs.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -5921,7 +5921,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
 		if (attr->link_create.attach_type != prog->expected_attach_type) {
-			bpf_log(log, "Invalid tracing attach_type.\n");
+			bpf_log(log, "attach_type is not expected_attach_type of the prog.\n");
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce11e78..ce7f530 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23873,7 +23873,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
-			bpf_log(log, "Target program bound device mismatch");
+			bpf_log(log, "Target program bound device mismatch\n");
 			return -EINVAL;
 		}
 
@@ -24133,8 +24133,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
 		    (!tgt_prog || prog->aux->saved_dst_prog_type != tgt_prog->type ||
-		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type))
+		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type)) {
+			bpf_log(log, "Target differs in type from the target at load time\n");
 			return -EINVAL;
+		}
 
 		if (tgt_prog && conservative) {
 			/*
pw-bot: cr
