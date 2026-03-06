Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9883330B09
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826673; cv=none; b=sQvPgdbZJT6laSJYASWbCD1vMqBXjTXaz2TnT+gE0mrvJezcNOHDi+XTFlX91ltRwLhtL9fu1hJ8gGnKGfQS12wTy3HbpdmUQITdvgvf3D8FPOobmyKO9DsBaS9aIR3QhKoJJkiZnX5OdgYbhls5FYYy3r4kt8JzWnfdJUhV42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826673; c=relaxed/simple;
	bh=26QaMlsBHZXBBsoWb+RFPRcsWBtokGFkKVFb+dwgdz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=Z4I+3BvI8ZufgtpoLjmVbVXcBy4UzWbunlZvreGQG08BDfOTdTm6x++3tuV83fREsvTmd14a50u3lKqoDb4AXGHenFHiNe98hvHwkz1EkQLzVNQRQR6mtZrDq+vD12p+oSSvuu3a8qI1n550XKEbp5ih2vXh08U8U7ZeHGsIRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i35pQwmQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i35pQwmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lIsA0vBDr/Zf85MeCX2VIrGY0ZH9k8QbBxgGKGtnSCg=;
	b=i35pQwmQlmyjFVhn3B4LnrDKj6jhmN9bcy9s/JVj9rhiP9m0lbsPgF7YeWizeA7FgZ51vz
	shiPr3/GtlQzwhZ2ybYQZM+UAhdtzUB9fIr8XcKu0ME14qz6KD+f3Wh0r+sJ1uYGvfp2IJ
	MpVUnf4ijHlEN0TiRL/miwFAbcvjoeQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-0D4_6-w-NKCBYjbptJZSSw-1; Fri, 06 Mar 2026 14:51:09 -0500
X-MC-Unique: 0D4_6-w-NKCBYjbptJZSSw-1
X-Mimecast-MFC-AGG-ID: 0D4_6-w-NKCBYjbptJZSSw_1772826668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso53476715e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 11:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826668; x=1773431468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIsA0vBDr/Zf85MeCX2VIrGY0ZH9k8QbBxgGKGtnSCg=;
        b=Wk2Awuw7lfXi6dWALSdovm8lO5daBCpq9jGrr3xV+THCweTJxJUQcSxZDwNs1tMZeg
         o2b3QblhN+Tq3H9I+Tu6Qw0p0EuV5rDM5HrSAxu5yMp/XWO4kNuOCCQW5LrBJOhFJb4j
         35fEr7nf9BGikenYUY2rufFToVvWj/qKHu29tEb2dDu1hQIFaer8dnRfiQxxeDwiFHP8
         gHOjTgLYIb8UjiWgd9g7H3MasgIH+EL5NP8DtPrp10KOU61tUPrsVG4bG6Msc0FPXEmT
         mx5OcPV76RnZ0lw3eOVloGTepSsaaY5NNiHui5zh7mpYpuq9Iu7FzhxFosUgpghnGOvW
         wYSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/jmyDOtre91LscBtwjaCEM1Ge2MH/AFTEU+Z/8tTya6iwoLiNFwVQbXN4BwFN+xwUUPS5nj45mtSrd/t7v25f3Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1cUEz4w8hZshF6ul1Yyd38qBWVlhysBeZrjMeVyR9H2T1lo2
	EkgBWwtbdRGFvbYSZl92I/Dq15tKPvY7ep+bNQzENLy3O7+QJonIqWaKmu07IWvhTRs3MgFngtv
	TChEEjD59QyVQra5dQlsjv0Dv9tPO64AR2dN76QZ3NRXEe7jzjVPjU0ML4s1PuTgUA7MegAwhrg
	==
X-Gm-Gg: ATEYQzxWA7eU7wIwS/I9GbAsMGJLAMSDPLRN8CWVoEWBQAiRzP/Ujdvqffl4UkIlfcy
	LzrmAYucLuAhEFKf+gJljCRFXNeAFyljypP193KgPeaQs+cvHZ8ZMy4KldeRrBW07C9ITXorUtv
	DeXMn2gObPQkwFXGXi/EwaCdV84j2Cr+rsV4g7sBvc9Uf4ixPB/pwIZHIr7tKKlyiFZPaL/4ilT
	DmBjSLwSJzTSCfjzxPlbKDB6dviiOwQDnVCDe59gu7nYEe9Uia5/IIIgo+GOa3jH3xbRDkEi5Sw
	Z0pNiNePfKUffJl2TGlYoxTwG2HNgmbXCANbe9ctyKVLhBZEf0XneyqUR3QSsnEIFXLTEmT3VHf
	ZHGFBLUpdixoyDaD/65viEH0HRwY2jGH1xqmCIA==
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4852a85e711mr21979725e9.2.1772826668394;
        Fri, 06 Mar 2026 11:51:08 -0800 (PST)
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4852a85e711mr21979485e9.2.1772826667946;
        Fri, 06 Mar 2026 11:51:07 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:51:07 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 0/4] tools/rtla: Consolidate nr_cpus usage
Date: Fri,  6 Mar 2026 21:49:48 +0200
Message-ID: <20260306194953.2511960-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OvothC44O10-rbrarYc96LhETJxyRVkp9CwzoFdzazA_1772826668
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

v4:
- Reorder change of BPF functions
- Update unit test
v3:
- Remove unneeded cpus parameter from timerlat BPF functions as
  requested by Wander Costa.
v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (4):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu

 tools/tracing/rtla/src/common.c            |  7 ++-
 tools/tracing/rtla/src/common.h            |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c      | 26 ++++-----
 tools/tracing/rtla/src/osnoise_top.c       | 16 ++----
 tools/tracing/rtla/src/timerlat.c          |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c       | 11 ++--
 tools/tracing/rtla/src/timerlat_bpf.c      | 19 +++----
 tools/tracing/rtla/src/timerlat_bpf.h      | 12 ++---
 tools/tracing/rtla/src/timerlat_hist.c     | 62 +++++++++-------------
 tools/tracing/rtla/src/timerlat_top.c      | 47 ++++++----------
 tools/tracing/rtla/src/timerlat_u.c        |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h        |  1 +
 tools/tracing/rtla/src/utils.c             | 10 +---
 tools/tracing/rtla/tests/unit/unit_tests.c | 44 +++++++--------
 14 files changed, 108 insertions(+), 169 deletions(-)

-- 
2.53.0

