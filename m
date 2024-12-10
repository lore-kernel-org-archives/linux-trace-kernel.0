Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41C2080C0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848344; cv=none; b=LAYH8rqByCM0/Nv2vL7dOC/QUZ4X9abosclgEY2j3BPP59yu65eyXmP3396fyGpoPLbJR/Vy47eAmuAA+34B+RwdK6XPjEQE1PgL/FlRYKvVx1A1YrNiPSTn+/iYtTJOdFYGNawJQgnB6QTTh7xiIGhs6APU1yEonoGpdxqCHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848344; c=relaxed/simple;
	bh=+b7M+jY9PJIO36eSkDLJJ9VE98VsbGgXtmTuW7php98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+3yPNSRRgIX2A0Gz+DtknmQDoAgGsqV6DuTfgRDv+J9UmGxvC8FV2jsnUL1avCLeMmXyYYLXyQ6KOwtrhQTKIketpvcQZ5VDk9+4SEIc9vqUbMGapnO8WkbMUaeeDXfvFLty745vOLi9+1tcp4Cw1YVHRqDrSWn8Xgq62Jq5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiI5NHGE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiI5NHGE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so50825e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733848340; x=1734453140; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/gn1UbKj9vnFhh2xTSV92DWl+lvkKwbOmPeVeHbAqw=;
        b=fiI5NHGEiO4n+b2sdi8Gn5lluoVlBt0EYv+8yAQM51ewD7whipEJyqx8pTBNBo/N5b
         5dCPeJ8AlvrcAUq/l72VDUAhn5IpOgVbY4G4dGCUoDjRrE8B2AP7e76QylL/zzkzKV+3
         /wLk3YJGwSX6ehJXvVSz/uECkydhpeL06lV4jz1cpVZNTje8/nVcAtgF7+NuKU7ISBhD
         oVVw8yhFp9j1sPw8W5Qf64DJ3w5GfFvi6vugCrdy+ZxpG/m3JnL2TpAr32YRNgu+3n1P
         +tcmzbMmsUUx2PUjl44EP8mdPcMdt+9dsem4+E/NbQWWnTVe47BN2k0WBGFhGptV8tby
         95KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848340; x=1734453140;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/gn1UbKj9vnFhh2xTSV92DWl+lvkKwbOmPeVeHbAqw=;
        b=qVPpVdXOYVilPb5HmPGTzOOdP7IlTv4EGtBkIngLq1jIX81SqcI5jpyxpEgbS2HLqq
         n8EM+U89ENkGymfWBWeJQQRRVqUmR4mpg18JXLrRWlG+tW+5iB9hxkjRTgdzUGkwpGbu
         SSrErV9+4CE7EFkgsHDDpQxomk+TBV/eEk1dWQqePVvkCodjhL4CHL1pLjz0hzCj05RG
         jhLdF9s31wucjM9FXOQ6Fo7TYLh7/5HtKmR0rkSccXwDy0r8JYU5KLP7ZLK0tKauLpYe
         GH7Y0M65/ZSrT4pVUeUCyd9XGpgCmwdIAzW1TsH7gXtyajYY3lkeePcX9LRT3n5GDBdo
         yEwA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/YUN1IkRG/ZWRuSklzHcUnsJ7aMBliDXVmpyo3hewuET8+XO+M35Dffjoq5R5+injSIOqT4Mwn19N2aTbwA3zQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfX6OfWn8SL31fSlNpR7sK1b3EIkZxAggjLu3pf578Y9xVWfM/
	/Pr9X8E2EMEXWEvkajNI22MU90Tjpiij1KQ7AHhVK1n4NQUsW+jwBOoQ6pHpcA==
X-Gm-Gg: ASbGncuEBcAZZ+5fDUCtrD8b+N3/FhxrbnHbI8DbNJcf5WTuK+eZGPUCi8xrGttXyfZ
	PV6sVGQcNcQC0FS6ccTqAZHn0U1kIv0/b5WywFj2WW59sJGQeidvCnFkvZBznHjnTTCUd2Y7OR1
	m82nyO6/vu8zWYUDUuHfP7QHu+GxgODhT7eeT90Qa89CVZNNysZ7KLCeuuB4hdDvs9rBRf6a1aY
	YqZyhPkUk0AB8B53wRayt6DTiTCm7RY8wtRA+A2d0s=
X-Google-Smtp-Source: AGHT+IGJX8Z20qexK7oymokLsdpvHPHCKMTUzEu5sEKq663Uu0XauOt9N9AnILN+AinqcJUc7xO6fg==
X-Received: by 2002:a05:600c:6b06:b0:434:9e1d:44ef with SMTP id 5b1f17b1804b1-43539dd9773mr1346455e9.7.1733848340098;
        Tue, 10 Dec 2024 08:32:20 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:deb9:87dc:18b2:3f1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862b923419sm13837305f8f.2.2024.12.10.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:32:19 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Dec 2024 17:32:13 +0100
Subject: [PATCH] bpf: Fix UAF via mismatching bpf_prog/attachment RCU
 flavors
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bpf-fix-actual-uprobe-uaf-v1-1-19439849dd44@google.com>
X-B4-Tracking: v=1; b=H4sIAAxtWGcC/x2MQQqAMAzAviI9W+imXvyKeKiz04Lo2JwI4t8dH
 gNJHkgSVRL01QNRLk167AVMXYFbeV8EdS4MlmxrrCGcgkevN7I7M2+YQzwmwcweidk2rSMh6qD
 0IUoR//cwvu8Hz4c2zGsAAAA=
X-Change-ID: 20241210-bpf-fix-actual-uprobe-uaf-0aa234c0e005
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Delyan Kratunov <delyank@fb.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733848336; l=1632;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=+b7M+jY9PJIO36eSkDLJJ9VE98VsbGgXtmTuW7php98=;
 b=OzxHpe5WGAO/ha2AVHzpagLfEW5ShM/GDQZc0Eov17h+nQF4RLseZnL3X4yU25WPDp3u+C/Un
 iCw9wAHXoqEBDTg0qeyo6DphEylK0ulrKHqxr3W7mYDWvGNPJ1aRthX
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Uprobes always use bpf_prog_run_array_uprobe() under tasks-trace-RCU
protection. But it is possible to attach a non-sleepable BPF program to a
uprobe, and non-sleepable BPF programs are freed via normal RCU (see
__bpf_prog_put_noref()). This leads to UAF of the bpf_prog because a normal
RCU grace period does not imply a tasks-trace-RCU grace period.

Fix it by explicitly waiting for a tasks-trace-RCU grace period after
removing the attachment of a bpf_prog to a perf_event.

Cc: stable@vger.kernel.org
Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/trace/bpf_trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 949a3870946c381820e8fa7194851b84593d17d9..a403b05a7091384fb08e8c47ed02fad79c1a4874 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2258,6 +2258,13 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+	/*
+	 * It could be that the bpf_prog is not sleepable (and will be freed
+	 * via normal RCU), but is called from a point that supports sleepable
+	 * programs and uses tasks-trace-RCU.
+	 */
+	synchronize_rcu_tasks_trace();
+
 	bpf_prog_put(event->prog);
 	event->prog = NULL;
 

---
base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
change-id: 20241210-bpf-fix-actual-uprobe-uaf-0aa234c0e005

-- 
Jann Horn <jannh@google.com>

