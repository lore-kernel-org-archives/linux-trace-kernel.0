Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BD37F326
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667026; cv=none; b=V8h/2DVlJxeHkulpaOTTJg36J34WWBetM6+KR5+I97qZfKKpxkI//vdwxNeoHaiJ4d0luCmFl/XS6FqAmxV0tdisdzIhbisWqM9jOUnH1JsDql+1Y6mna9NPkj4j7qKVoXjKHKAV2YEcF/yIUpMn4+J5ZmJkFu+VjlvaEwpQaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667026; c=relaxed/simple;
	bh=DLQj/V29zC1RfFosf/sslm7+tSL/OlAM+ZEeoihtfLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmOZW/vV0HVqtcEdChxTR5/4eZtHQ6j9Oxiz8k6o3NSYQsIzIg8vL+/0lajbtYtVTObrP6VWImxfRgLOLKD4RmguKhb+k0QswLYQGoP+Dnea+de5LaP4WRywgzcPajuO3SmAAd/NkCzE54j78U2hdVsXQHihU8PsNO7uWbk/GvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnkQa/wG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnkQa/wG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f77cc7302so1806719b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787667025; x=1788271825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQP8HjkxkNDs2a4DRjbGf5EG1UJ31ewsQNHJNK1LDJM=;
        b=NnkQa/wGMibCbb5UQaH2WIFjSGVMgRvDEEY5CCgsT5qQwjkD1F9Qj9xe4OU+BfPQ8U
         fZbYgeS4Nw2Lb/nG5Ssgjqx3csz+eT6aDvmzA5e3tHewg0cMVVaVqQu3bJ4ePlzlcmjm
         kz5qOTGkEMOIYAJDZDhyHQUVw2cVY8dGB8Kf4pzE4cEOvDhccCRcHgQl3DrCbzQpGNn5
         jkKISvh0Od/hjLOG9oKfuA/aq6jkazKj04OTZVV6m5+d0piUPzmoOwAefNp+Fn8lzp3Y
         D9cEup6yzm6SH3JMptjKlHHaX1YKGNpZd+86AG0hqs/Lm2EqCOTQiv1qsvAk1NinuNj7
         1GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667025; x=1788271825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQP8HjkxkNDs2a4DRjbGf5EG1UJ31ewsQNHJNK1LDJM=;
        b=kkAOc6nn6qhSb1hmueSPxLtNp261DpUuqg+yl+Wc4yh81OPWuJ3wndUchtOb2mrl6C
         HEtrUQR6BUomDJGrnCSccF7N3IovMy0mxe28ONOmr22QaVC+7YtFqWcv78TYgHqCJc5t
         eMsn45GHV7MPQngBWOrj212Ntnxj7/z9JejYOpY21WvVuKvJJtbqlyr0/UKmUaw9BVKT
         RUGBABxYEpfNXE9UXEvl4vVhKutPME1bCNfWyqNBF/8uSn4fp1qG1NthiyLN9XpHwmt9
         /xCAnCQTcMA0+JNrk+zwXJNYriXXPVaW0j5wFRTDiysQj3f1UfzHkqushrjV3/WCwJLY
         OGsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRLmqBRueXaTe7a/bN/AID/3c26fcirCmsfdE/UqrKdF+W0+cLsT0tauztTnWy3i4PIrSzUrUyrxM/D57alRxKvTY=@vger.kernel.org
X-Gm-Message-State: AFuF++lnHV+3Yp6Dg2/pGk4xNceLFmGvo8lIT5LV/RfVPxgz4COWhnYW
	t+TMNj7RkYWFIzS4hidatf3bqt2iwjqB66c1a6dCNO0iPRFjwSHSnoVJF9nh9lKh
X-Gm-Gg: AR+sD1349jF9Hl6dc115jvRUQOFDDH0KRF7D/zqzV+3LgprJZk6KH/YUwRgiyvsgQ7q
	F1rbcSnGTK1Q6/tVmpBIHjhExEkqn7YsYGoKNwxgY3dQ95icqDpEDlLlYX7UvYvopPOFO4X3Nyu
	BNfAqWJrLgcAFYFOFqH4l0dORe1ARGz6qnkQ5tw5mw7OpAUT7lL70G8yWyQ6H91at3OOo+Q+v8D
	yW1dNwIbhLuTD/fxA0msEKxY7xuE714S5Hj/dYC7kN0mmnL2LVM0gyTZXA8AHQDjJ1EWoFBXYoQ
	+nTtrlkdG/5iZNoAKiJAvqgH5Dqs5atzkr9EvqlnL2SOfwZWy2QKKTlT7hCOy1NK+izejZ/3eIk
	akdrpLyr/IxDPpzE6sDyKkLt6kXRT1h7mL3RqLQX386uQZQIHxQoD5qYBpxcBD4bjk0WJIhcVLo
	9XpDTrEWvpmJreqDNYNCYiyR0qzoaJva7D+F2UlGm9d/N97LkLNtRG3Minq5/BK5HZ7LFAoyUbM
	1CkzoA099nu5P45sojCDVwlZJE/
X-Received: by 2002:a05:6a00:2990:b0:84e:216d:7e4e with SMTP id d2e1a72fcca58-8523c79ec79mr14351778b3a.1.1787667024493;
        Tue, 25 Aug 2026 07:10:24 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed22bbsm3143024b3a.11.2026.08.25.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:10:24 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiang Gao <gaoxiang17@xiaomi.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Gao Xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] tracing: aggregate ring-buffer memory statistics
Date: Tue, 25 Aug 2026 22:10:15 +0800
Message-Id: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a resend of the RFC for exposing tracing buffer memory
statistics under tracefs.

The motivation is Android lost-RAM attribution: tracing buffer memory
is not represented as a separate category, so it can be counted as lost
RAM. The memory can be spread across the global trace array, dynamically
created instances, and snapshot buffers, and userspace currently has to
discover and sum every instance.

The patch adds:

  /sys/kernel/tracing/trace_stats/total_memory_kb

reporting:

  total:
  buffers_mem:
  snapshot_buffers_mem:

The values cover the global trace array and all instances across all
CPUs. A per-CPU view is provided under:

  /sys/kernel/tracing/trace_stats/per_cpu/cpuN/total_memory_kb

These *_mem values report the full pages backing the data sub-buffers
and reader page, unlike buffer_size_kb / buffer_total_size_kb which
report usable data capacity. The new trace_stats directory is distinct
from the existing trace_stat directory used for function and branch
counters.

For example, with 4 CPUs and 2 sub-buffers per CPU on a 4 KiB page
system:

  buffer_size_kb        = (4096 - 16) * 2 / 1024 = 7 kB     (one CPU)
  buffer_total_size_kb  = 7 * 4 = 28 kB                    (one array)
  buffers_mem           = (2 + 1) * 4096 * 4 / 1024 = 48 kB

The extra memory in buffers_mem comes from the per-page header and the
reader page.

Slab-allocated ring-buffer metadata is not included.

One open question is whether reporting page memory only is acceptable
for the initial version.

Thanks,
Xiang
