Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C35189BB6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983578; cv=none; b=M4V6PrkD+bgSFOnw8oJpesQvbzY4P+Es2u2qxNvO1Sszgb5IeHTEDhhAbVp4bfS9RWPGtPUmvr8pWdVtg5JB6U5ViW5pdtGvDyfgVFfmxruUPkoUZ+0hIUSrTBYItan0ABfeneL6VcQadMIZhLS772vfjwrCg47tq9+TUlKLkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983578; c=relaxed/simple;
	bh=M+d3eeyRJDp8lq2b1FuTLoytddjo6EdJUp8ehWym4iU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=BEVc9utuzRHS/fvqoJf/PFwe9+SyKt1+lEwlVEMmBzyA8YcTZldPSh7sski48qlOPsAiHX/lx26LsfERm2vE+7I4gEnhR7noSOsD1waK8SsRfWSUVhn2ksPpkABScXPVksEz7G/ZAZRYUnKbxCIlrCEvYCo8LIZNbeiEJXMPdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWVDuFmk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWVDuFmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bABqLmZYMF+yAdDTmCHTcvVEVd1c5O5Y+vXfK82IHSY=;
	b=PWVDuFmky7J13yGDCVTCobo7DOXn6o3fUmnCcPmVScGYtG4xm+/P2JbJ0a32iyPCjouDV1
	eE+AKKy0qPsIcJTFAbQ6kliQsG9U4LHQIW+PJbrXOVG8wOINET6sFGRG71QmR649s6z0iQ
	QvxpnJR6pjC3d1RKUfLF+S7dbzIq3V0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356--LLC3F__Pwu_4MYVt0boTw-1; Fri, 13 Feb 2026 06:52:55 -0500
X-MC-Unique: -LLC3F__Pwu_4MYVt0boTw-1
X-Mimecast-MFC-AGG-ID: -LLC3F__Pwu_4MYVt0boTw_1770983574
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso12276475e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 03:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983574; x=1771588374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bABqLmZYMF+yAdDTmCHTcvVEVd1c5O5Y+vXfK82IHSY=;
        b=RF3Tvg31gnH0mizOhMlMrf4mIVnnSm3sNU9msMOWrSunWIk8M6izgk0GksiF55SI/d
         5DmMjjdbenO2ZKmlA/Wv++vM6ZKO85ZDQaQj0Jttcmeb8b9OK2NtOHKSrtjqqZnwVHhQ
         80Yp6FCC1kVC38gQh86ctpYwcs3TRIjKXTbW5bZ9VSZiO4S1/OqYNYJsDJokWP5fHmxG
         ElrSo0Ne9faT4ojVh1GcqC+3YuTEjls/4l0vZZ9gomRcYohZuk26+cg9cIKHzBdtdCH2
         G3LGd1a+3zZD2Ic3kQT1Y71sy3/Gvyvtd3evqX5JmISBr/GuWGKNObiYnqV0tu0RtXvb
         MMTA==
X-Forwarded-Encrypted: i=1; AJvYcCUksACo/QiCJUg1ttVy5cLnpok4WG+2HuvmUzxgNhw4xbhqIgPfMrQIoUuFboj5Nmjyv0W6/8ubvCjUG6X1YpjILPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnw0yMMwMBRQDXJ6xtMHFJNjRdoc039n2coafAMGYl63Xy01j
	hCYwPd1Maj6zzaFO5X9Wasgu7Cg1gfY5n0sxVIVnOrZ0UF9pDfH1d728Q/6RWjgYSIJv4E7Gjp4
	ZI4m7afE8WxJEmzSxD5PhNS1q4wl9iOME+pkELnnERxLP9UIz5htlk8KM8Yk5J85gY7NuU9u3vw
	==
X-Gm-Gg: AZuq6aICRzqAvgVgcYeMjZzvF/1dxHLjE6eaQ/9PzwmOe6Qpxenagt1gFiAYVmLD7/K
	pkgPGddHbCN7/FZwztGtfmr3yoKExNp4c7RhSHuUHtF0yjwco4+8kSlFVgQgsz6woiL3FmEc3gd
	GPuClRz9UqIIZQDd6lywa5c4LmCHX5VFg+8RbZKCRFIZtqy+liX0ovySeHwxYEwW81SYMkEg4l6
	3BLAQfXiTuPvgDWHK7XlTvnbspkD6BI8jthHOIb4LcaiBW4vCC14fHlNdBbO7v1xnz8qwjsC7dD
	kaVy0UB3RztkDHrjS/9O/3uRSj2wWVBNSC+NjPkS+c0enatEjy1spmfyXE/wCeOgr0HFeEbDjrf
	UoPJJnmm/DcI9trUR6YirmY7YA7Nryujs130=
X-Received: by 2002:a05:600c:4685:b0:483:361b:deff with SMTP id 5b1f17b1804b1-48373a25cadmr23354095e9.14.1770983573994;
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
X-Received: by 2002:a05:600c:4685:b0:483:361b:deff with SMTP id 5b1f17b1804b1-48373a25cadmr23353745e9.14.1770983573553;
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/5] tools/rtla: Consolidate nr_cpus usage
Date: Fri, 13 Feb 2026 13:52:29 +0200
Message-ID: <20260213115234.430232-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OWcoIy28VWjl8kYR-SfTlYg6EWy3LgpYrXJArCvPjLU_1770983574
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

V3:
- Remove unneeded cpus parameter from timerlat BPF functions as
  requested by Wander Costa.
v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (5):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
  tools/rtla: Remove unneeded cpus parameter from timerlat BPF functions

 tools/tracing/rtla/src/common.c        |  7 ++-
 tools/tracing/rtla/src/common.h        |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
 tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
 tools/tracing/rtla/src/timerlat.c      |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
 tools/tracing/rtla/src/timerlat_bpf.c  | 19 ++++----
 tools/tracing/rtla/src/timerlat_bpf.h  | 12 ++---
 tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
 tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h    |  1 +
 tools/tracing/rtla/src/utils.c         | 10 +----
 13 files changed, 88 insertions(+), 145 deletions(-)

-- 
2.52.0

