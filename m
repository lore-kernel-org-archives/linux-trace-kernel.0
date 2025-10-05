Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF82C181
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673817; cv=none; b=YZ2ogenahSdvVMbOZiKzM0UuzPOY/4nrimVuGFigxpeJ3rrMJ04Bje3VR8abq6y0OPxQQRk+advxxyvxiHtTzXv1grG3bDdBVxWRViV29yqvSX63VnVb5tkUuWIo6lKrRMWfa45QhxfEGunotkOU5GsSPH+a9O/UI8CZormBzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673817; c=relaxed/simple;
	bh=MAFD07L/qdoSHf4v2SEn6E/CYOVj3EJRG/rAgBIkzT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzws6l9BNwneskgQHe7qmCK0NpZxtfkA2AiuKd+TkVJx60mg20M25/HYbthJHNNlzvHgaisCTOB5tDyRFcK/N6tQK7FlwyzpdZ2S3xaCHbNGtzWLcKJbKlySB4qCrh3iaBaMgvNUdkTYYMgKkkM+t3R9CRlY85dJuS1jCbieeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=caieUuLO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="caieUuLO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781010ff051so2799948b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759673815; x=1760278615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Yc/qvWyblSLPI0SiPJftDPwPdwcMYxlKtDo1UXOeD0=;
        b=caieUuLONTz78R8CVc1sc0p2nrZAfpjJtwn/PcWDttD0CKpPhFJKgwyHQFeEkDp/RL
         wPM0eUWzJVmfLNtFvCpxPoCrJLXEr9J6cf0DZsBYhOMIb2cW7/6dAih5fQerbZSC8Vl2
         SXAfnI6xNEkqk6yqQpqBvpBw8cJVZl4S4yYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673815; x=1760278615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Yc/qvWyblSLPI0SiPJftDPwPdwcMYxlKtDo1UXOeD0=;
        b=ut5c71FX9A+nAfPPkkE/5xZ3rdHt0WbAJk1UNIeRf6P6cYtl3pKDXfHLjjXDaPy1CE
         9vnhAX4aTDDt9nh1Y+SO0eVUGV3LgY+dLu6/gL3ksGiaQ+tSyyCma2BbznF3gQtxBVBc
         Binpy8E7ThHNvdFJFWeCHdGE7DeMQ3KiE3/jQf31b8d+YskN9otxw30WOUfCDFq5cvPW
         Ejvf34WBlXKD9xLrR2YbQ3QqA6BEp80YQHZVNZUN3DNKBFrv27uzHgKkqMj4wKgu47hI
         X2WkN/d8w8/Lclwe6oaNFV4XTSjg/SHQ/wyKTh+p0mBYYl4z0Z3Rfx0MFHyndH286dMv
         Skeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGE/ycyIT8LTtu/kgyonPUYhmm8oUZzbSfYkhLYQi0Ec3pUmbdlqOUmQwyRXyiDZsqb+s34dlNFKrmT9lDSSQG1Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/bEJpNTZe8sHTJxDA7GO5aDScceX3/ZbDBN7fwc3RNwNozBT
	0nrUmL0S/kbG5VbU/wrbHAKMX93J9rhDEhP8vWLhRaiR+55NUj5orkyeday+4k9LnRI=
X-Gm-Gg: ASbGnct2LE8iw1utOaI1HdAcq5gx4S+mAdPwypKtz6u3Jq959E4teqOUBUj9yTahLUi
	P39XcEEwccMl2d085B7c8+bxeto+wSmaW6dLNLbomr0KRiPRDnJWdME2Y+lFEjxZZai4Usp3UsL
	nnvG4v1a5HQfXFYcJbKkWJfF6WrLAfUww9qD3fyZ/lZ0zzzHtgTgZcgXV0gEupaSa+FHblJiS2G
	+AhO1CUawVnF8gOIF22GrxH37o6yn3sYhciTu5PC0pjMwp1ukCTU3zOFSaL7hHVgJKAWQExUjmo
	necxIJGT7orvEDe7vDz8o7y0mHbbPLYoP0z0cj7hHAIJ4hEQ4Fnfq7arBcCqjbTtKf3tkti2Ke6
	G2NCV8QGEb/RJptJ/uavI9Yn6KHSObk6MfXj9U8NHHArgvQ4OiU57+c3+nxIL7gvqZPCx9+JqI+
	Z9kq/iTGh0v+HGcnG/nifwr2bGTFU=
X-Google-Smtp-Source: AGHT+IHv+ZAL726mjCcBPtX6Ov3fWGZ0otnwsg5g72LayUkZ5zc7c370lf0Hek7AOgVQSc0P0/wuXw==
X-Received: by 2002:a05:6a00:13a5:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-78c98a40a56mr9244933b3a.3.1759673815518;
        Sun, 05 Oct 2025 07:16:55 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:a866:8cc0:feb5:15ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm8301295b3a.24.2025.10.05.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:16:55 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] trace/ring_buffer: Fix locking order in ring_buffer_map()
Date: Sun,  5 Oct 2025 19:46:36 +0530
Message-Id: <20251005141636.12405-2-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251005141636.12405-1-ssranevjti@gmail.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
 <20251005141636.12405-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The kernel's lockdep validator detected a circular locking dependency
in ring_buffer_map(). The function was acquiring the per-CPU
'cpu_buffer->mapping_lock' before the global 'buffer->mutex'.

This violates the established locking hierarchy where 'buffer->mutex'
should be acquired first, leading to a potential deadlock.

Fix this by reordering the mutex acquisition to lock 'buffer->mutex'
before 'cpu_buffer->mapping_lock', satisfying the lockdep requirements
and preventing the deadlock.

Reported-by: syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..82c3d5d2dcf6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7222,9 +7222,10 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
-
+	
 	cpu_buffer = buffer->buffers[cpu];
-
+	
+	guard(mutex)(&buffer->mutex);
 	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (cpu_buffer->user_mapped) {
-- 
2.34.1

