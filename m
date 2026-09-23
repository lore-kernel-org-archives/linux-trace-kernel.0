Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC31455635
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149348; cv=none; b=gaT1eZk1tDK63CcdnIH//PdElGjOUTKEhjNp6TsYf4RdSb4bnFi8Clik4cQj3B8ifGzT2hQ1FdaqPrG8CnzHGmRmgJ2SM1jTol+mme4sT0tPV9swoRqOob5N8hLTn5/k3gHi9X+lzjeGYjotR93AuQ+ccG8nxOB+2zY8yvAVE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149348; c=relaxed/simple;
	bh=YMyLmGEnwKFDxzmdHh0N11WIuaHQ/byRCKCpA1/x4r4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H0aG8dRrtg9X0fsVT2vGC7qT91yoKQH4bxlCioP3Sw1RqKoy+HY4kH2t2ZqOTKfIu0u6l3mCB4F4yV4joyDvnz2UAnaPTEQ12AEIOhbAMY/wz2QchJyAnfYoEAEuZVHoc3pWNhp5VI34djXy797OZNkemUI/PViZgU78zI4kl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXOUtDTZ; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXOUtDTZ"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486f9d150c3so371382f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149342; x=1790754142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SKMAy2InHjp3FXMfVN35EHq0oszHWkWnOoyikT1MYuk=;
        b=KXOUtDTZ+tblaceljyq0dfbcMXuqh5QBOQj9D+clCblw8SMlaIg1s8kvMUbcljJzeT
         XOGgds6gwoq9NkKmB3/rWV8lcKGAbcxiO9bCeoDeAfA7VZnxv9g8qyYlRr9K2DWR0cSe
         higETK7KLbN6knNQ4IsuqyiSiMiGkgibQZhA9Rd5ZGr/Cos5ZB31a6M/CvNwYAjJQUhu
         ywf3y13qTElGdKh6CeQZ6hcDZtjwhxBsTJqnkzd5QlDIKnJdio/u4UVspfFanZ4nBf3n
         IWf5Q7oL7qb+NRBOuc/O6EiMV+Kx575N8YYzKo8GlhtHadz/Gj8fo4aofB2+YMGVbevg
         5Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149342; x=1790754142;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKMAy2InHjp3FXMfVN35EHq0oszHWkWnOoyikT1MYuk=;
        b=SJJTkbgPrXeq5cGSdrY+KCXk8WEz4yu/yebjhKIL3LFdQGs3Q7nZ1cXZiP6J8/VXeJ
         kPsMJ8JEyrBdyuUtL4JTFtRgNhYl2IlapUwhtNQ1Uw29r0rb3Rq+ArpHikwav78Sr9G8
         yXYACS+PvDQwplf+GPNxKMzz65xT7udw44Un90gnJeq76gCm7i2v/kyTYItPuKhHoSzj
         h2ceRCII469f/BHeztJ8U/IrRd6SqSoaJMM1J9ia9qr0snhYyCJ6VyeDq6bdnMoArZwK
         fVz02Rk3y841WzDc/A8xjFhbacyVK2dENAuFwY+kt80QYeh18xVWriaIwe5SrUJ1RKP+
         +U9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwnUkTReroQZ1x+jI7XfUJ23QL2pj4sEYcqZjdR3YXQpcn8Zw1PO0yzKaMRpdIsDDYF+DK/6g0L9h/r20atNtQkwck=@vger.kernel.org
X-Gm-Message-State: AFuF++msmQpTotiBO44gJWENF0/sphyHD9zAgvKBGjzZVI1fgQsUYIOD
	lmWiqarLuZ0CNYvrKgXyHoqn8xu2S2H/NhgdN0cUSu62H1ueoA7EZDbcFQMeYZd92u1LkN0lQBY
	2pTYhvQXY4JXW3ZSJ433cew==
X-Received: from wmmu21.prod.google.com ([2002:a05:600c:d5:b0:49e:71f4:5b79])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e14:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-49fdeffd80cmr20298145e9.24.1790149341765;
 Wed, 23 Sep 2026 00:42:21 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923074213.3077182-1-vdonnefort@google.com>
Subject: [PATCH 0/3] tracing: Fix simple_ring_buffer symbol checking on parisc
 and sparc64
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Here's a series of fixes following Guenter report [1] of build
failures on parisc and sparc64 with allmodconfigs.

[1] https://lore.kernel.org/all/5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net/

Vincent Donnefort (3):
  tracing: Fix empty symbol names in simple_ring_buffer undef check
  tracing: Fix simple_ring_buffer undef check on parisc
  tracing: Fix simple_ring_buffer undef check on sparc64

 kernel/trace/Makefile         | 5 +++--
 kernel/trace/undefsyms_base.c | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0.1082.g2b9226bbc0-goog

