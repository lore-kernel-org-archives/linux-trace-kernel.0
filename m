Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FC288B5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247217; cv=none; b=O4ge4LH/AfteTKcC8Aah85JXKSddC+VxV/54ku1PjFU6gJYGA+Lsdum+5M7rGg8ZSCdZCkF+dETd0f+3PQInoMMR4tED9wvrU8cEJtAk2g3rPmpXP1B37F8XKJg9ER/Qa+0YBAJS7qL20RuC2GQQOKA9yAJzQCjhTXXjNDpY5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247217; c=relaxed/simple;
	bh=r9kf0qnXwSSLeWJNN9IRx8zdyaGKS9+VO6ORyI7NPGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdgMP+JRAgMxIdUJe6FascXiqIPcUMH24WDDflJks/Ys67Mv5EE0XuIBZRa31v+2nJV+b3gaV0GcOtfcyN5wPeOWtR+jm1lVnkLXIzG2LYD93RPNTpKww/ur3yyci5SDu6hVabuzC/QF6zecjC5LUT+nyWtjMyeIDaWSjYssWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P5PCAtDu; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P5PCAtDu"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e1baf0f764so1923326eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727247214; x=1727852014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PmnBcy5yJpNGNWEKH0ddst5UIranDsBHIcPf5w/S+c=;
        b=P5PCAtDuOMNlVX7HU2r+e+juYe5XW3BCoEqJDW9BPg6ZTlWFZxp1Tpz7bLI5lkq9QD
         sPdWjaddlJL0cY0fSwRX3XbzwpfMb5HvOFFlVQNOl2wYdeTLBdF/FizLZvTSikXtqt6F
         E7b0YaNJXpfAAQnLWHFqOfF+eQ6sTFtKB4fJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247214; x=1727852014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PmnBcy5yJpNGNWEKH0ddst5UIranDsBHIcPf5w/S+c=;
        b=V8sZvY/pkQJScTausMhMLu6lFDe6r/DY0WJqahhz77E1/9cYFYS/36tfMQ8uf/nRvN
         SWj4Sgi0jzNG3cVVW1yaUhvep9aEmA1F+qgLYkn/UkREBDBZyd1oJ5wa/ubQIO2Q3tTx
         /iuZ/jbFmo+R4U+ywwFSSemkQQwvKcPjOrjCt2+q9KAitHdUZv5dSZUZCkY8OJNl4OA8
         hiiHrL8b1M0lGUrAIAQnZhgYAwGSWaBqM+wwvGKoUdiW9O/2nzj045M+paJTdl7YErfk
         DKjrq8HWbe1O5ZVCqkCeuhww8CFFSYGeUJPtRhCp1KBzVJqGGS28fQk6/Oh6Q6q9pb/N
         KnUA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZG2MBt42bXfDWzgyk9SWHnsMt38tzSQCZpTde3THCiTnSTY62qPe56BJ3p8wwECNS8+vPC9dVQGPnC7YLC04wuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjJGcsiBIV5b9RMn7CXDWWfSv2DoX92XRUFEg1s1kvm9rB5iT
	zBCNjZjLZTe53F6U8flr2JO+KXfqv6rhU15dEAcYR0W0EOJoKGHphaG3cXpFCQ==
X-Google-Smtp-Source: AGHT+IHaAKW1G7G4hKmqrze6WNPhBVr8M5JmwpNcogPuxjcL+2zikfRrYl0d2dAryi2RUaSlQRjsGg==
X-Received: by 2002:a05:6870:14d0:b0:277:c113:5b26 with SMTP id 586e51a60fabf-286e12b8902mr1438664fac.7.1727247214307;
        Tue, 24 Sep 2024 23:53:34 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97b623sm2147203b3a.169.2024.09.24.23.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:53:33 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	jpoimboe@redhat.com,
	sashal@kernel.org,
	Shivani Agarwal <shivania2@vmware.com>
Subject: [PATCH 0/2 v5.10] Fix CVE-2024-38588
Date: Tue, 24 Sep 2024 23:53:22 -0700
Message-Id: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shivani Agarwal <shivania2@vmware.com>

Hi,

 To Fix CVE-2024-38588 e60b613df8b6 is required, but it has a dependency
 on aebfd12521d9. Therefore backported both patches for v5.10.

Thanks,
Shivani

Shivani Agarwal (2):
  x86/ibt,ftrace: Search for __fentry__ location
  ftrace: Fix possible use-after-free issue in  ftrace_location()

 arch/x86/kernel/kprobes/core.c | 11 +-----
 kernel/bpf/trampoline.c        | 20 ++--------
 kernel/kprobes.c               |  8 +---
 kernel/trace/ftrace.c          | 71 ++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 47 deletions(-)

-- 
2.39.4

