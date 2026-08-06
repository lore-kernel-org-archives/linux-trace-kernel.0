Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48A41D4EA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050798; cv=none; b=pSoPWeAxLWb2HT85HZIfFGs5+q+VCGGnKAdXYPQf4HOgR7kjWmW2FG9dVMyZ+3kZDv8SRMYcJEqJc8+93Cdi2cD6NbGexdiVEeDp/6PmJeMaaIunl8Gf6vGhHGRriEOWpVu2erPUtVN/24/xn2Q47ais4Af/yp2zIhIy9HLGVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050798; c=relaxed/simple;
	bh=Tggc3vrqTOr9eDO+3q+x6RDbfK5z6u/pfVFxIWyDlAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DbmKOqoFQN6XBkpzuwSBLwWNSfbrCn4/lKZkzvCmccUzhPhQZZcB6KDAg2QdbnmkbU5s0PD7K+dJb4VDAgG9AqOlPhkYibOaz5a59HCYn/K2O5nVNmCmNfrcXsUslxh12ZqYqpVcc+TxV0HJeOaEl7vnse/ImmGEC5rJR0PZdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7G37Krg; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7G37Krg"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a18e266026so1599756a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050795; x=1786655595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnkVJV14Kp6C+F71DStSpJSJIVkbeyv5rgwgVjI7yaU=;
        b=W7G37KrgNIaX8xUmbHAOc+RtK14KY9i7WE7hjZM0CPBdmHE2TvwRPtZ0yJ73M6YGRS
         OPowQYg1MOiiLkuFusuCq3L3B+iIPiJ8praGiBefWCMBVHSFVIgkwxRGExjc5jWrwE+H
         fl/7+5bL3aAf2K7JKt0hHBBtliNg5n8ks5x+RNJHnldSDKHtPOFpaD/c/Pu3q2VqnIo5
         Tv5sSwcYzF12WyppZk6kldrEJVNaXKfYfoLOdutchTmDVPs95WPWTOK+HaqB/md12RPM
         Ck5wMpJlUh08R9FkZ9U41VDEjvedEa9NLicALlt2BBYzDBKOEsMhOiF6WtFNn0X1ZuP1
         IIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050795; x=1786655595;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnkVJV14Kp6C+F71DStSpJSJIVkbeyv5rgwgVjI7yaU=;
        b=OfqSJVr2n62bjKgi7VYHqi1oeyiRVoFgHh/jVja35WpECqjww1xzZeerte0m7iPqLm
         g/v0rDC7sjynnrmPPsP+iXmSCbSzMxkwm0Kj05/qtGoI0XYhoPWciPr/t5S5UWZMDqHl
         jXDbLnTzBkOZ/WhBLywUPqXIybWT+C3GNCFj+BbGMiW1e1AUbq8AWxksTnxqhHGeCRmz
         +d6baVcwnIOZ2fJNQ8c+FOHh6PLtuCr8j25NCGobKNFD+LKFW5fXT9jb4tmiJPvhBDP6
         R/5fS84QK/UYmL/q0h8tYODC4A2TykIgVqYDiCzUWxjwgk0Os13KPD5B6k5jT2CQ+Wl0
         rjNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTLQCSAgjq0gqDnWcfz3T9o7QZXYDANvVmxcKniQbHyGbZFlFAvgpwcneffDWvydV0g7kkDYR5kWLeq1iYgJPbtnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQufT31OircHC9wEUKFtlIbqysGbapJAJ41VwpGeYx4WudCC4N
	9czLirCH63//NpnEyMigHLsjVrRieE3AH4yFGXUGZoVM7f7FYSGyY6fIS1Bk7+sTdmHUWfpKaRm
	E+/qA4JnqHVm7jtbOlPIsgA==
X-Received: from ejbd8.prod.google.com ([2002:a17:906:3448:b0:c12:65e7:ce30])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94d4:b0:c20:367b:acae with SMTP id a640c23a62f3a-c2073431341mr178529866b.32.1786050794894;
 Thu, 06 Aug 2026 14:13:14 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-1-vdonnefort@google.com>
Subject: [PATCH 0/6] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v2:

  - Prevent resizing of the persistent ring buffer
  - Add missing bpage::order init
  - Rework subbuf_size/subbuf_order (Sashiko)
  - Remove ring_buffer_per_cpu::mapped
  - Dynamically calculate trace_buffer::max_data_size

v1 (https://lore.kernel.org/all/20260805153225.2096152-1-vdonnefort@google.com/

Vincent Donnefort (6):
  ring-buffer: Prevent resizing of persistent ring buffer
  ring-buffer: Prevent subbuf order change when resizing is disabled
  ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()
  ring-buffer: Fix subbuf resize concurrency
  ring-buffer: Dynamically calculate max_data_size
  ring-buffer: Remove ring_buffer_per_cpu::mapped

 kernel/trace/ring_buffer.c | 216 ++++++++++++++++++++-----------------
 1 file changed, 117 insertions(+), 99 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.55.0.654.g21b8a5bc05-goog

