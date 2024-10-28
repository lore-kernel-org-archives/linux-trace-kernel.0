Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6F19007E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153109; cv=none; b=Rw0697Jhf0qwZbWO/xYH/bc6fuYJ4aExIn3vDyRJ7d832akGy+xu4n3o0Hp6bxN7awwMwDYwNYC4IeW0RejSH3UjjymEOUxGQEOJjimst4nhQHmP9135LQNlVgdVjZeNGnaHI7frXd1JuDV3QtEHRD356XXFTI80p1Eem0Zln14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153109; c=relaxed/simple;
	bh=0hoHck181vRn1NSr2f2PwuVWiPIZTgKgLGSUOf4IQxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxCu55TTd86gvZkhDNid4+34vw85TgpdBBkriO0DbMYV/Cv5Z67vVWNMiYLw9KqjxOEBFodzp4StyU6MJg5MqOvLe6YZjNPpChIVDJbrHdCkHFx49rHBYyb6Yjj1nhFJos8o9OoHKBTUrMCCRCCV/KE5i9Hc6hza3U/cSgmiews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx69UkXP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx69UkXP"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so8855802276.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153107; x=1730757907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=Mx69UkXPMwQkgGdN/igewvdBssfAnJIUmSPMX1dVSFcmQptL2aKyzHFv12uwgTkGi+
         9QXQOAnvHaC7d3rxZ8gPM+FM1l/SiIJEjesgVVUoWfMoqNxu7jJ97muVPKtRMMcGWYOH
         nIIKfI2QGF6bK/3RMdBqHXP5LYklBzFrvmSRDMxs12uv+hNyXERiBXziiF+2FTnufiXP
         WjsFNlyxIcCp8iTjyEveW2bDAmGcDLTGBkuV5SxXAfHNt43s0whqouNBpIZpeHofCOWF
         i+Ambb0jQmhN/YFFbSF+B4m8ZzJWfgPGyFfEeXvUWHb+ZHTv8zAdHUgE59Ef7gvFFu6Q
         ZLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153107; x=1730757907;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=OAOjuPiwEbuNH85u8V/YeNsZdeFX875tCy07AWV31xm0hfG54TPUQZfi85fTw7nf8Z
         D7lIRe00LxqOhAmOJr6KV+UhWTr9YXGcmGO4/Ck9a4ossI4Q37A0RV+uIsQHHB2649B4
         qeXOHecyLWyYi5tsZcUPcpIcIsJtx3QErBfxB3dzqSIGafuZS0Pm36fvruN5Cosm1QEO
         dwNCTCwqY0uUEUEYJEgNhOV7xefH1pRmsm07ZPSbj0iUQWBw0sWEWuCxddrV/3ufeOD9
         84avaMZtuuRTTr4GhoSQ2KjoMkPuef9KyWnjF+U7oYB4GgKdUT7oyYjBtPdLOLxIIeyK
         TJwA==
X-Forwarded-Encrypted: i=1; AJvYcCXFjud3Fi//57FBlE0HvXOTiEsylCwFiPzJ8nSYP1vuMMvaFZMbaW6XhISm/rXeQ1mY5nn0hT8GIZrZkGxPwDwzleM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbN4paJuw2VHa5Agcs0oxpZ/hep9PBXkzN8gO3TX0igd9v/pko
	3/WMN8YlecCuxKaxIlT5nfEiH1hU2Hap7qqKeSXiJt//P8SULVudgXMrtK6BQpJvfV+dyBI+oHz
	PzzyXI1Z1F3bCGnFTDL/byg==
X-Google-Smtp-Source: AGHT+IEAnCfdVLBm6ktQBhqpFyGMf87tkH/Lnfvvyg2A06ArHO+JMopPeHeJSfmCQLpmkvHXVSBQbL+oME5hPCmQMQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:521:b0:e29:7dd4:a945 with
 SMTP id 3f1490d57ef6-e308784b3c3mr25736276.2.1730153106526; Mon, 28 Oct 2024
 15:05:06 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-1-kaleshsingh@google.com>
Subject: [PATCH 0/3] Tracefs gid mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series is based on v6.12-rc4. It fixes an issue with the  tracefs
gid mount option. Adds test case to prevent future breakages and updates
the tracefs readme to document the expected behavior of this option.

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test
  tracing: Fix tracefs gid mount option

 fs/tracefs/inode.c                            |  12 ++-
 kernel/trace/trace.c                          |   4 +
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
--
2.47.0.163.g1226f6d8fa-goog

