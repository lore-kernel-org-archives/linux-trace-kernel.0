Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDE38734D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677588; cv=none; b=gduH9v8ALQtQiWwktKHng834wf7H0zvho1JsQLJNPOz33Exh9ZDHI+aIJmNUagGuzCtGGg8hOuQLy3WM/G44ZjlobefWLJHMAqZh7nNIOgKBsXmP0DEnHa45mMhttV8EuVnF5k7m5gjbtGdbShM+waZF8fYF2TDWRylSU7WD1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677588; c=relaxed/simple;
	bh=+rvwX7gwJZC2juKcMr8uZ3pGLfEuR7/ohcD4RK9yjgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GqNECIz4nBzTPvuE6A/LCMC/qBqa4Z425ruPbYdFNE38JsaLjYEVyBuKumSgbUdbQhs19VSAzmQPRfBcX1e4Rigl0KzmSMEL6kcfdgZ3DmzZbslwNmU2Q1ffpPpP3VpPZFzY1sF7/FGkGPgDs+fZwYGRSGAOjFJTRF/5Bej467s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFlyAfCK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFlyAfCK"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so15553825e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677584; x=1781282384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlw54DmZyVizG7wMFhMwgTDLyF3kgVLfGdzJ0e7FyR0=;
        b=ZFlyAfCKC7hUP5TTlWQbOHv0Pe5ty+/57ZErB8hnzv8foHDamPQGHPAdP/RJXqSTgZ
         dqs2q+UR62zp/mKPT5V1qOIZaHjUMHTWDp8MS2Mlyq3qasBz1MjIc+9TMxujP2mnMb7L
         EulZf7J//pSR8aq7/lU+4G1WOL+peK2pH5hI0rYr+hDatcSSpqPwR98JUAQ1FiNjUD7g
         n552RJpy1HghSALhb5WEUCD57WHwHFTCG4I+yHEUzZ5VvAtsOGdfYXeSsnZT7YRRo4In
         MJC0AKN76vQK4Xz0czm26p9xG40cIXRF1bUjXUYdPZVoePB0z4gvu8BBy6rni2dLDgJ1
         X4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677584; x=1781282384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlw54DmZyVizG7wMFhMwgTDLyF3kgVLfGdzJ0e7FyR0=;
        b=EJHAlsr6te7tmlQ5OnnZNeukmUII3eaPKlyOFS4zPGsM5TmeLpm28Z7ZAsmtukupZN
         r7DW9hpt/Ip0qEAjNsbvzeg4/0yoeGvFw4EujyvcDrz/ctJW0+EglbcKidyn+N8oE7Qy
         FvblmyRBQNo4jp62HbJjgO3g7WOw4xx+jjGytiSSbtH/PKmW4KekPfQ/Fn7VN4JpuEix
         JRdDvg8hSNt3FSU1dVnkT+K5vXiOaB+jvEOaMM4Kibylbwjq6U+G2msQEoG54jutrBzI
         DZhrf/1RuYzpezEY8XnkT2JfEjNoCkcI3frdIadnYWJOz9/UlN6LrnkaczjOXQOKRyHD
         SPBw==
X-Forwarded-Encrypted: i=1; AFNElJ9O92TLrSDRl4TYmI8pmJ5qiuc5HwJ52L/0ETfcfP4/pMp3ONT25mazeJpafy2yi/qzVpie07kF3hsVVz+ZcPBuBUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHjyBL1iUteRx0pID+M2AGMpUk25SeEb6nGei6VHo+smbFnQH
	07BdWlKzGuYv+yZnYh1oF2U+LYtnMIsAVYWXlid/sF2zZSBTwhkxcUDli2qk0U75xfOXibNWHil
	58/IxXHbikzYLDw4zOydPFg==
X-Received: from wmmr8.prod.google.com ([2002:a05:600c:4248:b0:490:bd6f:3b92])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d1:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490c26055aemr66935435e9.19.1780677583795;
 Fri, 05 Jun 2026 09:39:43 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:15 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-9-vdonnefort@google.com>
Subject: [PATCH v2 08/18] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid interleaving run tests by prefixing the hypervisor folder.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.54.0.1032.g2f8565e1d1-goog

