Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85C386570
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121990; cv=none; b=I5khtmCsft4HDLb31g80CpsG729ydE/c3JROrutx7sQYIZoEn+ySlOwv7WzUvWwwNQrnX5Xdaen/vEyxdE+EEyPf7nxWzFeLEeLnJY5KDBn8f3uuQfJCS1FwfkxHK3j54qa5DspuiGkd4Jj3CFCln7YEO/X3XsE3wcqIrgECk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121990; c=relaxed/simple;
	bh=4ECgb/AfeI/g65ADzXXjhXc34kvosRuBpZwZRATvnTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRivDGRzhwYoHwjoX8wWckVO8kTQPr16fP0hwRxm6FuDZvMHBoekg3hMZpjqNghYZtT5tFAcdwfizAAIzOYNzphoy2PeQSwVVBH1A757Vh7a8JeT/IPiCYUN5vGh7zM4+P6PfwkiGnCoeHgYO3ymyW9NlXTTdEkrd1xGnQAh/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK7aYTF2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK7aYTF2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso390809a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121982; x=1775726782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJn/mu9tI/GhEXXW9g1aC2S5Xq1EhBmi8P2sfsvCv7U=;
        b=PK7aYTF2nKbGhR80fVoxFVk22YR5yod0PSzWIb3AzHJgjIksMRbn02SaHf4aoIDKXi
         AOyBoWjEhaSFB3ynLqe+0EcAvJeW+GZgqx9M+yF3PC0c2G1tcEDr6QV1PvLNT2eygfsL
         O6lYgU6Uqn1fDjijkiup2AAVfB/qOry1PZ5WUWMilS6Fhj6AtX+4aZ2sijMC0NQLwmIT
         wWOyEn9Aawj3BQjq65DWW0epcftQsbhCv3t34WKIKC4YueVGBAH94JolYW6bXDYsNKc2
         PWf+f2H+QUcAc1SqmP64zRsDnNCBd3aSL64+DqFIo0DX6e2HuOHodcHXkkPXHuKvu69a
         K6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121982; x=1775726782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJn/mu9tI/GhEXXW9g1aC2S5Xq1EhBmi8P2sfsvCv7U=;
        b=ZotxM/w28TxxW62yEf4SFrNY+/9FBiD2oBlUtQOca33RCvHTOholhIW6+VXlLh+YeQ
         rat/2vDrIXiB2/G25+YJe/sc0NFZUgSLs2QNGlkWBfu5aDxg8l2HRh/9qpmxdXwnG6hp
         i2pVmURmNGEeDasjjgqV9KIVJ+4WZgKIIBIWuB/4R18O8bFm/QLEi7EfV+1IJ7KO1zsQ
         MALpk0lm9D//GFTTgMDi0zXCpP9VirnwF9dD8Ji/d6dWhJ4feWg+PQhc9R9l3tviatMv
         oAm0ww9DXYq7iQTt0VJg2BfSwuVP3Z1ZKKstBaZ4GGmqMNk91eObas2Doka9akScbRen
         z4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqU0ihK41AQKaY759pk3RBMxlGcF9X6rnB300C+J80gyBcXyogUzFTQB3dLgPQJT9N6k/0acmD1MobGqNK3uEcCAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYwXhztN652cj1NNw2tDkTwb00dx3cmgVBhG83wiEbjbFEwtv
	6yz6ebHXyKuESr6kt7moaJJ3ZKtlr+uh5+Cx9j62Apybtv7jQQXHZ1ZV
X-Gm-Gg: AeBDiev1K+yQyY0v7EcDl1N9MCOZdF2cpcFWby9TktTzuOMm1q+4PozK7/3jjPjb99s
	t2MrWOIUaI8z6ozvd/55Hffx7fh+/b8roWy1ptcgsMlVR+Zj4YCxNfMhw0kYOsWKfCR2dbeyTkB
	+6To/flT9niEDjhaCO8FewBph4MBFTokV4noqKjbPcRYeaoXx9JhLPWfTX8UqV58r/Rn/pOsv7M
	HbbTjLFcdGKMgyF21BagoRB/QvWFgt/3rWTk+peXaKaMeNofpBmJ1mbdKHwmYITRHxLkw+nJUUM
	7c90x5/f2LuD7ckui4pkXqfALjiDlCNwcVKoa5Ree8zuo8E1CvNLCyPd1spzlg807pNcotgSC+I
	wHK6yiZFlmzX23jZ/fsAiaIoHvXQPKT10pljXdKs9Lt3BeXfKj+AknpqF5eqMl2m5dJC3lxRoPl
	/bjyBVnTaRVU/ws7Nktpzl+EWnHbnVv1aV/3zsLs5fim3H
X-Received: by 2002:a17:90a:c107:b0:35b:a656:a5fe with SMTP id 98e67ed59e1d1-35dc6e77dcemr6086211a91.3.1775121982115;
        Thu, 02 Apr 2026 02:26:22 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding for livepatched functions
Date: Thu,  2 Apr 2026 17:26:03 +0800
Message-ID: <20260402092607.96430-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatching allows for rapid experimentation with new kernel features
without interrupting production workloads. However, static livepatches lack
the flexibility required to tune features based on task-specific attributes,
such as cgroup membership, which is critical in multi-tenant k8s
environments. Furthermore, hardcoding logic into a livepatch prevents
dynamic adjustments based on the runtime environment.

To address this, we propose a hybrid approach using BPF. Our production use
case involves:

1. Deploying a Livepatch function to serve as a stable BPF hook.

2. Utilizing bpf_override_return() to dynamically modify the return value
   of that hook based on the current task's context.

A significant challenge arises when atomic-replace is enabled. In this
mode, deploying a new livepatch changes the target function's address,
forcing a re-attachment of the BPF program. This re-attachment latency is
unacceptable in critical paths, such as those handling networking policies.

To solve this, we introduce a hybrid livepatch mode that allows specific
patches to remain non-replaceable, ensuring the function address remains
stable and the BPF program stays attached.

Furthermore, this mechanism provides a lower-maintenance alternative to
out-of-tree BPF hooks. Given the complexities of upstreaming custom BPF
hooks (e.g., [0], [1]), this hybrid mode allows for the maintenance of
stable, minimal hook points via livepatching with significantly reduced
maintenance burden.

Link: https://lwn.net/Articles/1054030/ [0]
Link: https://lwn.net/Articles/1043548/ [1]

Yafang Shao (4):
  trace: Simplify kprobe overridable function check
  trace: Allow kprobes to override livepatched functions
  livepatch: Add "replaceable" attribute to klp_patch
  livepatch: Implement livepatch hybrid mode

 include/linux/livepatch.h   |  2 ++
 kernel/livepatch/core.c     | 50 +++++++++++++++++++++++++++++++
 kernel/trace/Kconfig        | 14 +++++++++
 kernel/trace/bpf_trace.c    | 14 ++++++---
 kernel/trace/trace_kprobe.c | 49 ++++++++++++------------------
 kernel/trace/trace_probe.h  | 59 +++++++++++++++++++++++++++----------
 6 files changed, 139 insertions(+), 49 deletions(-)

-- 
2.47.3

