Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D835D5EE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Feb 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629092; cv=none; b=TN/BmlTjkM3CrKqb3VG8MZAHDQJdRf+ZXqDozTIzzivrhWeqhvKcyq4aWNBBDyxLQNyYrF5qvVmMRpxBEnCmOWCoeSGC4LdY2vQO+HCpGcgYCUUHVsuuvflkpAItl28PcDvrmP7ZRmAH/FnK+6YVEiSmyZbcvnvPSL6B04sqc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629092; c=relaxed/simple;
	bh=oMZCJO0yTscifwcXj4R3WuQPIdJONxUuM4HNF44NyU4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=pHFcL9mHJFLDjnqt2atFAW22QF3ZHVp04AoVGxoiBuf/RUPEmvp0nnU51Vy4vZT5czFP0dZoKJLZlx2eRiNBqa2FQ1DzpV7nyl0aS0yryNipcEJGJhfElQuuhWR7UeDWZ1lvW+O+Zi25heovtGbWrXvQA5LRDffw2OCnyw2Qg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2qdUD1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2qdUD1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770629090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMqFYnQMjoFuXB5XaZ4vn5x4ztczYNKK1AvuxdTtqYM=;
	b=c2qdUD1iiN2QEup2+QQWwFokPdMJZU5+/SgyDwURs4Lk7VO+C6udDxsQjZEzNveaSH7Nom
	zWWKYEXAIB075rnikOShstjCCz6pfSjPg8jGI3/bEtM82L81yDKoAGKMjGjR2xUR8vUSVP
	LUJOp44KeBoZ8yElLf9S66HJg2QOSv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-55P0haooPPisuFf62qRopQ-1; Mon, 09 Feb 2026 04:24:49 -0500
X-MC-Unique: 55P0haooPPisuFf62qRopQ-1
X-Mimecast-MFC-AGG-ID: 55P0haooPPisuFf62qRopQ_1770629088
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so58913685e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Feb 2026 01:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629088; x=1771233888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMqFYnQMjoFuXB5XaZ4vn5x4ztczYNKK1AvuxdTtqYM=;
        b=drJoXMQJ2hT4Yl3AOtkfDnN9JV27y6NKqjjsEEUJZYQA+nlR9gek/t87UniaMMEjzD
         IBMMmRkhHPlAWxzbfimlqmNmQJ7137i2rBJ2oZbzEjl7HGcAOyD2+xwYAkHBh+l29lYq
         +EsxFBzlORxmYTfIzYKhCQJSkGeexKnAzp2HttZcMigP2y1NQ+JN7PIrCeIgE4Yj0Shn
         7erSkC8kHra7ySmrVHlqTUGlHhxhIABpKA44Xy7O/zZ1ddkuEr8ci62wErPaebQmg9Cv
         1IbGAJw5BnNztGMtahaakiBxWcMCwT97EMNHLfHdX3a8zNoeiGnrPlz8xY/1XF26jsvp
         fP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSIbEDo2wFlB6fT/fuAgIThGyRgoaRUCcfp5nszNfJVHtzQuZe5nc57ETRBLzWKf9bctrpEqJ7bu7ue7qy7AAn4uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCSfDZjErXoYKqlAFXU+rUz2F0fRPeShGrLd4bIvTNpFg5bS5
	bHLkiFu2/WunPjCPhBOrsPYBV2pYkqPTxUn195kSkDzGx+GvKix2L4asVT32kgfAj4yFEXSDGSA
	CA6Dj8IcgTuAuQLehQ6fhK4+oLa0SID3Ma+bOgkNSlspggloA10WrbbEsSCRvulLTn2YeJ+mMVg
	==
X-Gm-Gg: AZuq6aJzCiuRESTdr2K4qtIL3vZt4YoAbm6+afiYzt1zi1PcxkUuBhTmP7vdzpF8frn
	LWkRHOtkoFl8oslIFItJZt/ZBx5B97Ed3CGI9+YEsYTH+fF8ufXktrCmFJbLcL01df0IfaEUbJo
	+wgG565C7XgTSchEPX0f0prnb6x4qvu9D92VEk8luxqAbL4ze7vdxCT+Dz/K14J9+PnrBi18mDc
	v2k3zIswIuWEy5qDDbEbnZB2OQ7tAuga2vn5CnnnTHJ5IzDguD1hl+fgKRDCvsrWzj79tWkxJHS
	419z9Y6Rv9kcSS7XW6s4kUCqii5bSWiTzCgnqRQH1M/3PvqXeG/dh6bZMu6xRHMRSRWeYGbEvR8
	jU7O4Jino+ilIR9HtTQMZfzqayg==
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48320231170mr161098345e9.21.1770629088347;
        Mon, 09 Feb 2026 01:24:48 -0800 (PST)
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48320231170mr161097875e9.21.1770629087862;
        Mon, 09 Feb 2026 01:24:47 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm316310295e9.5.2026.02.09.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:24:47 -0800 (PST)
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
Subject: [PATCH v2 0/4] tools/rtla: Consolidate nr_cpus usage
Date: Mon,  9 Feb 2026 11:24:32 +0200
Message-ID: <20260209092436.2899888-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lkoz5icsrNSo9t7pSUPp6CfpscGlDF_QV02bIN4mVio_1770629088
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (4):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu

 tools/tracing/rtla/src/common.c        |  7 ++-
 tools/tracing/rtla/src/common.h        |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
 tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
 tools/tracing/rtla/src/timerlat.c      |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
 tools/tracing/rtla/src/timerlat_bpf.c  |  5 +--
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 +--
 tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
 tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h    |  1 +
 tools/tracing/rtla/src/utils.c         | 10 +----
 13 files changed, 80 insertions(+), 133 deletions(-)

-- 
2.52.0

