Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78230149D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120164; cv=none; b=l97sNX2/FYx+oq+tmAwNBViGZBtVeZ2sp/jciNKJ+18bGB6k6ab8oReq8w82ZyIdPsUUSYopPfOhjKnF0wnU4Ky1cM4K1CoP805SxwsX6S+lBsHrcA+P7Ev+p54ZmYoF4klVHv5iM2iCZRWmefYNWjGZxUaCO9PaMLof7Q6o7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120164; c=relaxed/simple;
	bh=DCzyFIbpikPRP2UAtaUmSGdLbo/AF3f2zrHDNDUS3SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgKsDIAOZpQBZLGloCtwb9KkhAca81iCQOuWDgRjLdKB8GVeh/NROl6XfFytdEw8xzjsfe2L/N2kJbLiFI73aIBby9kpymsSX8BEcjsaCkylpdqAPSmfBD5PTB6cobi1HeroSab5uwS3F5fbWzb0aGNFHcssJt/Go/ckXMsqmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8TqDHUp; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8TqDHUp"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-290a3a4c7ecso70401905ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120162; x=1761724962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3TInaAKPrQjAk2+lHfppwgKawbjH1I2biVgx7F87cg=;
        b=P8TqDHUpKgbNrpsf8Wkz14Wc1Wupj9bT8t3hXgNkk4BzmfoDT/aXd1HGyBCL+kn5ZJ
         6tsZ0gdxwa6XCCW31Gg8JssGA97AsODvJ9/LVq7mcXFOT3B61t92XQafM50BySDhIY8w
         XtYW1SrCQBYXo9xBHcftjQPVYvLw0/MxTePQarIMcNpFrSn/2cbTSmuXwgbSQncf4uT6
         UNQKO0L/S4cbNebP9M5FFg8U0kKczZGllMUzWiuvt723007mH4PS2msreNwimnomyWxR
         RSuB4RN/bUk++SqKa/vt3DlD1Op9SH6QgXpfO3EuHcOxam89mwrbi/mBN8T9AhoQHA+Z
         3dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120162; x=1761724962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3TInaAKPrQjAk2+lHfppwgKawbjH1I2biVgx7F87cg=;
        b=tskqyHEJ0qX8bj8E3saVHba3kChY5dHR0VwctyDVIv+RLWIv6fX3+EYVJ61Eh/3yOm
         alUnq1xhkraU2NA4dD3crAvNFppQqguGRKX2ZjtK2mCu8mugc0y5uRBh+fKTB2p+GYUY
         9nlMSTF6aJuT/KWR0gWLT/cgWUCKiHVtIjbJOXkiuTKXnZ89VDO2GiKkBbAvDwWMBCb0
         xqJBZOmnv+9Fh0lmWMa17E8xsMbX/BCz9bz8/a8s70m4/NAkkGldsAXWu742CQxGoJDH
         ykCLMUj2gtnQz75/8f4DkrPrzrIKiqdQfRtfGLwfsYU0Jtn/Y/T8XeqcbJjoGw0E0CQS
         hmHg==
X-Forwarded-Encrypted: i=1; AJvYcCVNAoLtguBmMx0eFECpOKacH0n9EKVRBmJTP2eGvRgH6P2G3BnmvdRtMttBlEELA8O6BIw7fi++4DxIvCoqpDCJ8vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/F3VsQtxI1gX0WVkbM8Lr8R1k5wLLkK6l6Yr7FuADt4TYku0E
	bw/bWGgp7PRVFhbBShmHw4uaWBGRhVkXZultyNktLGxKxsomCjBMXAbv
X-Gm-Gg: ASbGncuv2+T2eF5TG2yzrPnPPvY6n0cU6iveD0cRyNPjAjYC1LYfxn2X+rng7IYKYrQ
	mCo7ZNfQFytvrJ6STDBvufNDG/ZWmy9c3sfTbp/ww9C76WZkrvdOyxYUTnp2u5Cex+F973V/NEW
	78uUM4kPjxFiFyRFqW/UCPx0RmGS3Vy/kIZlstFxT1QKhoevZXSf5gSt3LJiDl195Xit326IDFT
	y8pI72a1d89Ry4bhRsBsjuy0lZNz3PxTELvwlH2ZGLE5SAg9o592VAU0kVApfEcQvTncA6Y7dIE
	8Zk9CFCvToJioZkCw68w9If92eZFrwTUAFWyXeHOY8LSXmtkM9PqRSdKPw+q+4DUlJenf59SP/S
	A7NXJSwy5R58C31nAMrremdjogkfybCvC/uXoRyFDnXpqBiT6zvp25AYUsXn29wcoX2pETXJ7
X-Google-Smtp-Source: AGHT+IEpHP0gIlTzVj4v8YevyryMxicJ0wLlmYL1oMdZSD8zMPXKRUlXkUQqGW5JEtt+oQNUmn6mFA==
X-Received: by 2002:a17:902:f542:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-290ca121a5amr259220495ad.31.1761120162366;
        Wed, 22 Oct 2025 01:02:42 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:42 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 06/10] libbpf: add support for tracing session
Date: Wed, 22 Oct 2025 16:01:55 +0800
Message-ID: <20251022080159.553805-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_SESSION to libbpf and bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/bpf.c        | 2 ++
 tools/lib/bpf/libbpf.c     | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..534be6cfa2be 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_SESSION:			return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..caed2b689068 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
@@ -917,6 +918,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 		return bpf_raw_tracepoint_open(NULL, prog_fd);
 	default:
 		return libbpf_err(err);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..e582620cd097 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_SESSION]		= "trace_session",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9607,6 +9608,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.51.1.dirty

