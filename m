Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A761A8F97
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953539; cv=none; b=t42+SIFaxc6d4MqaPMUBpaTTP2yGRt/LGOaD3NSWfEmiNa03rf2wGgK+R2tCJr9bItUOWwGOzxzK1RdDJmVlMvOPUyoXDAt336te1lETz2fcwW9Y3FmNICI7JtZEp8qOfpDfiFj44fSArNSQ9ULC1xbYW5GamHhVMqilm2KAybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953539; c=relaxed/simple;
	bh=S3l06A1JhTVKNOxW4NkqhS6UTCCL23vhN0vivrl4ftk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc70LdMeotIVWSmRazqEh3ZNjHO9Nu8U4t2VYxVxem3nmOaa9TIbp04bUVe2idf4JwFLLaMOLDX4iAVSKzArHvBU+L2tmfgjn1KRidkQYxHMjf6puU1y0qZCYaYHBy5nyPb8O5VzB8HvSRoxKr6I/e/vr2tDbC2aQ4ZJk62niio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2FRKvFn; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2FRKvFn"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77f5d497692so4112053b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953537; x=1759558337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=h2FRKvFnM2QvlLTKNm93QTjvFGMEXmT851L9FMbzHxRTRxyQTb+H+K2t3kwhYEdkyr
         2/BC8GqRQ84QBmXvkqPeRRCHZ6d/OHTGwMEvg9bdSddhRFxr5tzLobKs5B1JYmxoDth3
         kBRyL7pJ21u+GDpcyRAvf87BRmCTkZfWkh0c4NB8HY3Hc27tIPIe9+dBkQMycXzdrNQF
         vRHWUaj8UhjTw/5nzc7iukSeoS7/yqDUy44Fr6QwOPNG66AHUO1n0/FuWhCkygjt/ELU
         Qaw6Jw3+HztrZcYt0GJfAKc8tLimS1Ubb13tM6xxlkBxv8jyjBxK1qcI9DzlvoIaXbj6
         QkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953537; x=1759558337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=rhoIII/+sOCpinwYGaDZvr75EpU3MityQpNpIi8sT6cfQcmZrfSWvphEK/ldPq6XX9
         Tk2EoYwf/wEhRvpuwhwQM+ThHFeONsm1NFQymkg/BraOdeGUGWduCgIbcstLu4XNdYpj
         kiAndJpzPGbndgCsdP+w/HFVPp43k9dS6E5+zDfgaS7Rtch8AxH38387vjAlxtItuuVQ
         KHSWfe0sjYvnZjeCSWaX+rQr9Q336POCD7VY2FwaX6z14kvTU6Mb7HZXHoGi31ytNCKU
         NZ9CwmR9gSqjzhZ+hPph9nfi2TNr+8ITR9a6xx2rSmi0e6d4wbn++VXCl9Oke3T/dp75
         zXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvszTO77zCLYqpCV/5iT4t8sOgxPFwf7Pw3wLrUvc8UKm7eDHH5vMtQbfKaTjIjF5Qo2MDKi1ePOtK9IkqpJ4Lh1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRrfjo1FruHPB1uir7R0A6JE8siSAv7izEHTzDeEAN0JAeOqy
	1T+PWWuK3XcvIlAHnyTYE26S6eewGNxPl5fH+h7l4xoJWa55xaukGdND
X-Gm-Gg: ASbGnctAxYrMAlG/H77xil4vBSlPcK12oKN5V2iH4682ZlKyFCC0xblOLVVDw/7VnVH
	HrWtjkjlQfP7LrngBCBYhtkEomS/7KJ5k2YB/2n+Fr3V7P8xCMHoLQfaiNKZ8Ys8YaMBs/AIuMG
	ZXqhF7i2r9309sihg3BsDnyAEVf0JnuRMXoaT03i0PSntJwjMpY/WGm6ZiJyY+iTDm0EsdDo/Pf
	Hab7062+ERggjpZX7kLt/a9GzsSgUVzjZpXcpSD3RQrAWY31n9rJX0n+k7Sp8SJ5WjJekQJrlib
	l0K8vF9EkPLjpR2HZ+B4RkPQg3dBLAsYvUnPuUf4RdscIAOGyfs0oRPElKU+a4HGU7iGz9MEF6a
	Tqb7Ewp53m50D+L04Q3TWdnPRjtUqtQ==
X-Google-Smtp-Source: AGHT+IFs9pSrNNpTib391I/iqQ3SZvzLn53SsMSuMurvpANlMS9GOQCN/CHJaj4SpF+KTUi5oYCZTw==
X-Received: by 2002:a05:6a00:3e0b:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-780fcef7c3emr9599121b3a.30.1758953537252;
        Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 0/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:07 +0800
Message-ID: <20250927061210.194502-1-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can do the memory read with bpf_core_cast, which is faster
than bpf_probe_read_kernel. But the memory probe read is not aware of the
read failure, and the user can't get such failure information.

I wanted to introduce a fault_callback to the BPF program, which can be
called when the memory read fails. Then I saw the BPF stream interface,
and it's already used in the error reporting. So I implement the probe
fault base on the BPF stream.

This series adds a new function bpf_prog_report_probe_violation to report
probe fault to BPF stderr. It is used to report probe read fault and probe
write fault.

The shortcoming of this way is that we can't report the fault event if the
memory address is not a kernel address. I remember that we will check if
the address is a kernel address in the JIT compiler, and it will not
trigger the fault event if the address is not a kernel address. If we
implement the fault callback, we call the callback during the address
checking by JIT.

Menglong Dong (3):
  bpf: report probe fault to BPF stderr
  x86,bpf: use bpf_prog_report_probe_violation for x86
  selftests/bpf: add testcase for probe read fault

 arch/x86/net/bpf_jit_comp.c                   |  2 ++
 include/linux/bpf.h                           |  1 +
 kernel/trace/bpf_trace.c                      | 18 +++++++++++++++
 .../testing/selftests/bpf/prog_tests/stream.c | 22 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 21 ++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.51.0

