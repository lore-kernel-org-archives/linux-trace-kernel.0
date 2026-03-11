Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD13D6CC4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229989; cv=none; b=sK1XVFUzsboPFqnXLlE7cO2wlz0Soe4FpbZLfjbO6mFAl1TcmxJ6O++CdSuAwYeaQD/6Zq4BnznbdpHQjx3zsxY95l+qyWnTLaCeZV4IjeQreLSqOTBakqFixji50i/+bC9N1DaqZqztDSKJCZ4wCc9dVtiylj7q1g7beyNGRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229989; c=relaxed/simple;
	bh=SgzzhxCWuPKU87hF7zwmiXoVGYhYQd/RZUgCpsFS37A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOgg8xxy7EuRC/4rzes4taky5ZCOCyxIO88hVuh7dnpXyWobQIDvomVOC2WmKwlYkbrBERqyn++hzNwlC4YOY5dFlrIu4Xabbyht7AOF4hy+Ine2PtWmepBhjPdTVSMWqPTjmp+a8p70BGkytxs8R35cd4Gib1kED6cUcf/ZOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmZniczg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmZniczg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829781b2b01so4719408b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229988; x=1773834788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Tcuv/FKdpmW54ZWbVfc0fc5h5dY5q1jjZuFCsgdu2Q=;
        b=bmZniczgU2Ju5l7eI+lyUeMEjSHBDh0rEMeqGGZjn8SdE5QSELzM6F1qyvuHRlS6Cf
         rpfdULXtrxCzpuO5J8S+eehgInc7NrWju9anRqk9ofGDOmEYuS0I9MnSit4alhLFfHR/
         cFSfTdpWDOZ1nj0r9veeXP23UFMKJzCrkUyB79WlRt270EOEuyn8UGwxJhWm2IqKrYep
         HGI8b35ZBc4rqINSSwpbx0A7gpmJ/pBozjEjU2t6RKKaFfuUG9VH4FnTOq97w+/lA+2O
         xQZg3WA0hld/jFA9a6O07sV5Q2VX+c2K32sybuF+E67+4XCveGmXKmLA8HQrxNus81gA
         G/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229988; x=1773834788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Tcuv/FKdpmW54ZWbVfc0fc5h5dY5q1jjZuFCsgdu2Q=;
        b=EQGa45ntdU4o//CEJ/neNHsHgwbsT2b1wzJSp4so5WrsevyvPn6muQwgmj2yicEj7l
         j4S0YJv8EHZbFMHusCb3PhFKu12CAF8df5F7C7CcgnIIAsMoMGV0EjRL5D1l4THQQ6cx
         zZINRZ4CHCoXnCvrG5fRog6Wca90UJRYn53UdBuwtDSIlIuXxlfWcGKLGc8HkaIkEJrs
         /PpDQ5B16qC1KEsxTZkix3WONfTd5nmhO+9CauC2BtKuGquzZxV+HHgrBeZO945ipwun
         pL38v6trooPgqdyoWABOu4NpGLMsnDy7fPeWp8q5NIvm3veA2ld3fGnUAEyzcDmCrVHB
         qYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu43GCEqkD/ElYr6kfMLDBd11JXHBNfPJfXegb9Je0F8FH/Z9tL/BNG6XbVRH56I9InmwPStFbOikeq/d5QEBbM04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdT05sk/gPYuCSJ1c6ssMK3vtTYjQv8ERGzsaDxa+8KzGo/XS
	WgvtOFc2LWkeNEbqYVXiVxxPxnN121G8c+9FWdZoMc8yAigWca0DI9p5
X-Gm-Gg: ATEYQzzt5mG2haZKUwlzE7hOf1Ugt02UW5WaNjUBrPjnhia2+8OQnYDXeSbqORyS5MQ
	9b5nWw7rYakYbq7VS++gA04b4qibTKtg5amvwa/CsYf7OuwJ+ez0r6haF+6dZ9GlNZLi4cDNmQF
	npAdWYWwqXJRdb8L3ELnFKP3oz7MPYGzmJS6Zvqp2vfywfeiVvewuHP5y0mdMK0IgveyeHHnUdD
	vmqP6+zdtE4Cc8GiGhg6qRt/9Lz2rG+BfjOeNfGmn5fYzTubKCTEB+1C1ZfBo6C+5JPh/jHrfWe
	T4JAEj9/5QNXi+lkFzS0t/ABjazNFBpebmoDcEvZdAGRzKHB71RUKK0SjinRIfSu2Cj+0MPAaNG
	9RPAw2XBKEKi81vzEy/sZ+CPOVn6cV4AtGb7TsFpu9tdCNSlfP8ITXuRV3ntzMXR/sGwAyyEiSR
	ZoqI+lGMqoDJLCQLsS+MNBK9+Va79csp+JP2F4p3Y7FnsxomUSYSCPOORDf6Fb0RA=
X-Received: by 2002:a05:6a00:1c9e:b0:829:88e7:c89e with SMTP id d2e1a72fcca58-829f6ee65abmr2514048b3a.9.1773229988180;
        Wed, 11 Mar 2026 04:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b46:28af:1445:b4e2:b8bf:2d47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3aedsm2500588b3a.18.2026.03.11.04.53.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 04:53:07 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Date: Wed, 11 Mar 2026 19:52:47 +0800
Message-ID: <20260311115250.78488-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, we resolved a latency spike issue caused by concurrently running
bpftrace processes. The root cause was high contention on the ftrace_lock
due to optimistic spinning. We can optimize this by disabling optimistic
spinning for ftrace_lock.

While semaphores may present similar challenges, I'm not currently aware of
specific instances that exhibit this exact issue. Should we encounter
problematic semaphores in production workloads, we can address them at that
time.

PATCH #1: introduce slow_mutex_[un]lock to disable optimistic spinning
PATCH #2: add variant for rtmutex
PATCH #3: disable optimistic spinning for ftrace_lock

v1->v2:
- add slow_mutex_[un]lock (Steven)
- add variant for rtmutex (Waiman)
- revise commit log for clarity and accuracy (Waiman, Peter)
- note that semaphores may present similar challenges (David)

RFC v1: https://lore.kernel.org/bpf/20260304074650.58165-1-laoar.shao@gmail.com/

Yafang Shao (3):
  locking/mutex: Add slow path variants for lock/unlock
  locking/rtmutex: Add slow path variants for lock/unlock
  ftrace: Disable optimistic spinning for ftrace_lock

 include/linux/mutex.h        |   4 ++
 include/linux/rtmutex.h      |   3 +
 kernel/locking/mutex.c       |  41 +++++++++++---
 kernel/locking/rtmutex.c     |  37 +++++++-----
 kernel/locking/rtmutex_api.c |  47 +++++++++++++---
 kernel/trace/ftrace.c        | 106 +++++++++++++++++------------------
 6 files changed, 157 insertions(+), 81 deletions(-)

-- 
2.47.3

