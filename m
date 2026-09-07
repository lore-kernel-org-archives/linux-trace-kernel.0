Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66B524AF9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809210; cv=none; b=u9pmLPjD0JxUp7Ue0VUuPDZwY0gJaM2twVaZQNRO53TBYnaJ33hfmcOG+4gzu32WEsOu1XS22+ASVtwtonFlTOMvgBn6/0/X4v0wf0Exr77U5x5I/e/mbdYou3wWxjuAY4TNxqbGBb/ZkWuhAHSgK7pkMUi3QGQ77+FcD1wJKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809210; c=relaxed/simple;
	bh=CtJ8q8kbEUd6g45ORVI0A6KWkYr13cHySrmAqLHjPKY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MJoCQhsp5LqKKApzqVm6QrR71bgp83dt7SwkK6yJVo69ZENHV1MOPkd8OwOas+cVWXx74F3GsOJ5+OX7NMTK4WY/CXRfAHcEjlCDAAOvjEfiWf2jBifnTzY2QaJYm8tgw38LpLQD8YfMf+lBYZlVUPpBvaWSY7gLuP7x3g4zh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKWEa+hZ; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKWEa+hZ"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so32311765e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788809206; x=1789414006; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=of6uK1RnEyk+91wfito6ZrIb5ocLj56BZQd0yrWJWW8=;
        b=BKWEa+hZ9dnttBb6C4hOLX6BW9QYNEAi4sHoVFyfNWHKks+//N1SpaZiHzzUm0Uk/V
         zF0aSfERng1LEPJ6FPaTbrwEI7WPoSdYP5CVYgOarYgL4sH3LHhQcId9JQyYLEvnAGIb
         vPTDJswpG21cxT03huhGhqe4dqJc2nuf71kboIP4sK0vx8rrtKvoL/C7y7U9DY9hB4iS
         Owrggo5Tnq7C+q7XiDrJck+y1McB7it1dntvwhQv4gEZn4zhF8/AnWyI5y/X4D8p/2/c
         W5zcGjzqGIEvUZQrj8NCAkk/R1fbh/1aqaTC8l/fIEkuP84VolYkEPcoDMCBU51zToAY
         /fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809206; x=1789414006;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=of6uK1RnEyk+91wfito6ZrIb5ocLj56BZQd0yrWJWW8=;
        b=D4Ru7b/O6qYCfgWiU2luKacJJ3YmXRf5cM93OkXJw4nbQLqBJEo4qKDSJs8Q1aCquf
         ZXrtH5icyOQWf7Vu2CUw1oTCZys9cBK+dgs2Jlb0ieU89IQDL/DZyOxPLiYPncmgnDNY
         MvdRd+s4SbN0V3nTsokd99ikZ4WDDQbw1xXO19v3Il9mRnTV8wClm0nAq5icnaux2itf
         The3RhmK8LfsxMvQOXNaaFHgarrMAGu+hio5BeUZWDsJI1zl2EVzXmWm9vpwylrF4vyB
         wl7gQM1VbcYNyeihWfqQgJ75o2vSzjKx/u0joNbqGhwDdQoCIWfsttMDN6DlDbtBmLg/
         gHQg==
X-Forwarded-Encrypted: i=1; AKwUvBxraSSBI2P9nz1ZtC6b09G/QocitvvZX8o6ThhAqKPe0wiLSiP0JFZXexy5ScNZSVyh+EZLuIE7y3ibOz9Yao85l20=@vger.kernel.org
X-Gm-Message-State: AFuF++lN0egoMzxOPmhps2Y0gm7rg28rPKVOvkoja2UXdIK+xJmm8qu1
	Etsk++up4pG3Uso6AMwFo37kBfRBhCowDRhY2THfCEraZSjHyPZLbjuxda7vRalWQn7777FXD3S
	BQPHuKnOHpHHDt1ViWsoHpw==
X-Received: from wmpw35.prod.google.com ([2002:a05:600c:9a3:b0:49d:84d:6053])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628c:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49d17a8745bmr22250585e9.12.1788809205887;
 Mon, 07 Sep 2026 12:26:45 -0700 (PDT)
Date: Mon,  7 Sep 2026 20:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907192643.42513-1-vdonnefort@google.com>
Subject: [PATCH v1 0/2] ring-buffer: Fix and unify size and page calculations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This short series unifies minimum page calculation for ring buffers and
fix a small issue with the number of pages calculation for trace
remotes.

Vincent Donnefort (2):
  tracing/remotes: Account for ring buffer page header in size
    calculation
  ring-buffer: Unify ring buffer minimum page calculations

 include/linux/ring_buffer.h       | 21 ++++++++++++++++++++-
 kernel/trace/ring_buffer.c        | 30 ++++++++++++------------------
 kernel/trace/simple_ring_buffer.c |  4 ++--
 kernel/trace/trace_remote.c       |  6 +++++-
 4 files changed, 39 insertions(+), 22 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0.979.g7e5102b832-goog

