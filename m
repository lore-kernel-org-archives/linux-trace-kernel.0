Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C625BF14
	for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447742; cv=none; b=rGAKkSUY4wSDJkaw4nPfxpO3+wmUR9XU/EEwwV3kZgSCF05eDHNfEvXgIHnS3FKM+VWpwpU+JWNs59hdXS+ZrWT6CB00WkHnDdy5KJyVwbgXDofNkg+JMEZDIo0mDrVgD28rq1MVR+YmhG9U61ND83Js2uwfWVDM/zQ+PssidBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447742; c=relaxed/simple;
	bh=GuQCFueyfn/NObmpfJmrdR72fVp0TkDQ5S2HEwT1H3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9N/MvVk0vRLsGXKz5JU5BKeD0Vg0RieZzJ/waLvlr3Q84FCo+vyd8ApNeFykcFsSAeUW+bK+vMPQ8K+MotTGOI4Kcfoq8+MCRWxn9tobSkfjL2jzeIkvize8tbEMo1nqMCOB6YVXRxfYKwvxFNIjJxCVmL8ls7YJj/NLxbgxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWgDQdHD; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWgDQdHD"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6cf07258e8so2414027a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447739; x=1762052539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUOMYuKJiVL10Vf/aBjRKKIq/GvniLJo4ZiI6vGstps=;
        b=YWgDQdHDAtXoElxx5CnGKV/TgEz36w8+uuxtC+GMnMcHLBnJbZM7/7omz82BJa/lcf
         Kt4EuLwfbuSTLm59z12h2680ZPPfGA0sfFNt/N1uzdzpD5J68cDj0wcJO9C71QJ5phCE
         ivv3gP37sB3iWVw1xYV8VG3WVjo55kC2sXqg8KSmUY75I657AHITvJH3inXOBZClNUCh
         j76ixUtg3FbukyWIdPRl4Qvr86/UwkGaEAmn8zQEC+Vaa23DWz2wV5XQVBT66aA96E4q
         M3qHi6rOhX34/7xQb5CoqyPxcB6bL70Xn73C+uiYRHV/zPyL7BzjoYO9Y2ZGP1jWXzUW
         297w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447739; x=1762052539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUOMYuKJiVL10Vf/aBjRKKIq/GvniLJo4ZiI6vGstps=;
        b=Biv2GXZj4KtpyPH8IOdpWMBkp9QCRZOCcfyPvNP9Xyj1UBjpeYWaZKIOu+LJlVvgs6
         QqyCW3PtS0nNxLJsbFucHrJ35zVQ7LqEGayZQXu/P8ZSEBoR8JNBEoPkGEhJ+/vFnYZo
         pmluGbw9iKzZXbDH42xi6AnrU/BH1aUF6ych6fJN15DETy336IHd2Xb7dE1b6aBAf9aN
         zl2V16lMQF6IzlPq+4wA7M0zv/KI0Ypb0j8xxhJ7SrOgJGdGvC8NG/nwsIUMZb4R+UZU
         vEBUuhInMhCkFXBfKPiCAmeJthOvWb9tHiHe61kIeAJFdAQbM6MKzXTVEhIWNMaCtJux
         LwQw==
X-Forwarded-Encrypted: i=1; AJvYcCX9wjW3DbVyYTrh2iC991/jrx4FurT5D2QjCx8HXhoe3pU6EtQGmSOjk5LxNnziUcCwhwSRl2dwe62nQrABy/0/FD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUtmbk7bTSNYXpLRjMJDT3NZml7OskXDJ7tflyqjCGDryjBCQ
	ti/JbyMtwj4e72mA/nA0XUUSbME034GEjsCgUs0riticDlzNLW2uPmKJ
X-Gm-Gg: ASbGncvzvkm7y1Z50bDEjvAdWx1pHoFZcLNzpR+i1iVJKmltH/nHvOoCPVmRPEGOfcy
	08c7eU2uOcBJq+j0WiGxa7enTBPsdDp6amxv9Z1Ww8rksrwMpKhMRAxS+CRcih7B+zLh6dx8ETR
	kMrfLqhTCl7O7KWyruOIA/w2n6du7dJYVVY4Q4p3vDmo6dnVcxVS+HEOFiFRnUGFgr47Nckgs62
	Acb/HRfjpFJxONd5byPun3CekOMTxzr1Wl7hJh2H1km18PI4DUl9JTVeKfa60RJgmvwCzmbnBoL
	ODvfpz9uawlm46GqF9IanmG+vJHzog8U368ncCkhHbbQLpJGnBHXA0g5M6TGNdMePb3B8qG4qDQ
	WKAefaHjo9MQykeodVLVMrL4VSTmTLvTLymFDYn0zIjw3CClTUlRszHJxTalYivmgZXgB65dFmF
	fBIc/iJsi3z8w=
X-Google-Smtp-Source: AGHT+IGcA7pHr4jE0Gm+8ckx81Sfog4EhdhLlaxTxBPWluCuyJcg7FGtnsCogj3Zbc3RxSb9u6qqzw==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr359938645ad.51.1761447738936;
        Sat, 25 Oct 2025 20:02:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:18 -0700 (PDT)
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
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/7] libbpf: add support for tracing session
Date: Sun, 26 Oct 2025 11:01:41 +0800
Message-ID: <20251026030143.23807-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
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
index b90574f39d1c..50d10d01315a 100644
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
2.51.1

