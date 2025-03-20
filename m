Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF02139C9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462733; cv=none; b=ggHFwvdVKCaAwL0W2/MxX7DYuA4ZNSCVSs/Z/CEDGSYGp7tipeqxbAEE2a7K6PUHYMR0tCSoN8ZpZ96wI7i/8qjoPhzaA396kgnDoF0Lpx7DRDApUrfnsXzYx3FcFW8TG/jEXLDcP0zNA4FfnxAme71qqstsJsZYxxyCQ5Lm5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462733; c=relaxed/simple;
	bh=024QgvEdox7lmIFc6JNkbdRW+SBagty2L2qX4+Mqe8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D27w4JRWwscLdfwTwdYxpgOsqKs3N6DdXaw2Jc7MXDCasHGzj2q3Vtq6FMXjZ7npZwizgUHZz/lSkIs4Vqu7bSLUZaSmzDYrU3I/uXfg+k8Rlmnw81ixlzb1b7B/hEqbKG/FkAXnP/QgVyFp0pPr8O0xOrObsUr8VZGb/cHUfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkjznLyk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkjznLyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742462730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8MPzZFdU5NaYPh2NGTOtu5hpDZLpTD6ezNgyItb/nos=;
	b=OkjznLykVIWAdJwqHcxxpCOxSiHmXGvqTKklOIeSWhvVHavt1AIunEYhcZgBaQUoi553Ru
	Tny/59QDk1IWL/TrLC+6nxxfhKt/7juR0+/RRHZ5I9oEDJZ/vJGx7UNCrDhbcmhMBqzNoW
	zOUeOguAMhSdEHvepOpA4Y7ZjMdJOPA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-bdws55N7OSuKf7YmzmmnyA-1; Thu,
 20 Mar 2025 05:25:27 -0400
X-MC-Unique: bdws55N7OSuKf7YmzmmnyA-1
X-Mimecast-MFC-AGG-ID: bdws55N7OSuKf7YmzmmnyA_1742462726
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAAFF180882E;
	Thu, 20 Mar 2025 09:25:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A81D19560AF;
	Thu, 20 Mar 2025 09:25:23 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/6] rtla: Always set all tracer options
Date: Thu, 20 Mar 2025 10:24:54 +0100
Message-ID: <20250320092500.101385-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

rtla should not rely on osnoise tracer being set to default options,
since this might not be the case - either due to the user using the
tracer without rtla, or due to rtla exiting abnormally and not resetting
the options to their previous value.

A part of the problem is already fixed by commits 217f0b1e990e
("rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads") and
d8d866171a41 ("rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel
threads"), but for other options than for OSNOISE_WORKLOAD, and for all
options in the case of rtla-osnoise, it is not fixed.

This patchset sets all options to their default values, unless they are
set by command line options to different values.

Before doing that, code setting the tracer options is unified between
top and hist for both osnoise and timerlat.

Notes:
- The unification depends on a commit in linux-next that already does
that for rtla-timerlat, for the purpose of the implementation of the BPF
sample collection [1]. For rtla-osnoise, this is done in an analogous
commit in this patchset.
- Because of the former and because of the unification requiring changes
for older versions of the kernel, I do not Cc stable here. If needed,
I can sent the backport to stable manually after both this and the BPF
sample collection patchsets are in Linus's tree.

[1] https://lore.kernel.org/linux-trace-kernel/20250218145859.27762-2-tglozar@redhat.com/

Tomas Glozar (6):
  rtla/osnoise: Unify params struct
  rtla: Unify apply_config between top and hist
  rtla/osnoise: Set OSNOISE_WORKLOAD to true
  rtla: Always set all tracer options
  rtla/tests: Reset osnoise options before check
  rtla/tests: Test setting default options

 tools/tracing/rtla/src/osnoise.c       |  86 +++++++++++++++++-
 tools/tracing/rtla/src/osnoise.h       |  48 ++++++++++
 tools/tracing/rtla/src/osnoise_hist.c  | 118 +++---------------------
 tools/tracing/rtla/src/osnoise_top.c   | 120 +++----------------------
 tools/tracing/rtla/src/timerlat.c      | 106 ++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat.h      |  12 +--
 tools/tracing/rtla/src/timerlat_hist.c | 119 ++++--------------------
 tools/tracing/rtla/src/timerlat_top.c  | 110 +++--------------------
 tools/tracing/rtla/tests/engine.sh     |  66 ++++++++++++++
 tools/tracing/rtla/tests/osnoise.t     |   6 ++
 10 files changed, 370 insertions(+), 421 deletions(-)

-- 
2.48.1

