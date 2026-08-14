Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2473446C4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715742; cv=none; b=Lf99vk6GOVgi+GlxHuaS7r5wGmqAr3zB7jXpSGIzXbkDDF1KuEmiJ+RhWKFjv/TPAdyb447gLd8Ywd90I73IVnK9SnFyCLixTnOGr8Ng4hlUZHK9BW2jVenwbKtOgwY7Vip5kHfeX0ze6GEAsqZiiaJKyivSy1N4inyaYZWCdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715742; c=relaxed/simple;
	bh=/B7dLrC7ZR1XcH6ZDmNSmvZVtC9qKBBteaHmiQhD7fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AA0bAPPocsMXAu3hCAzh8a3gqBl2sCI75i8shWKnKWbBkdu1SEvwdwQagM1h8QYRPUBKjKSdJxd371o2vhV4gXRIyDpl/laFcTGGidj5LkuG8T2ZpKKdzfCBdG79Lm4y+Z78T6Atp20iv5FI8Rk53MHN8+wTIxBDctz4GQYiDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcZ1mKh6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcZ1mKh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mMBtBjmsvECYZSFw/QOEsE83JT/liAdyQLN+vnMZoz8=;
	b=XcZ1mKh6WzeWQxa0h4Jpa79tOZ8MeyTJCO0dnB0kf2PHE7RTm1eEPwBMkN2NrP18iePlyW
	YLrty4Z0sAhQmMS0T0ejjGUCDqfXrfGOko8dy44bTbhW1EJkr1plXL+YiqJ490FglLxarE
	S3ix5bumpYszNb7pb+hHdL6GbFAGjmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-RNWHm8MXPUGGcUkHzxf--A-1; Fri,
 14 Aug 2026 09:55:34 -0400
X-MC-Unique: RNWHm8MXPUGGcUkHzxf--A-1
X-Mimecast-MFC-AGG-ID: RNWHm8MXPUGGcUkHzxf--A_1786715733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209CE1800653;
	Fri, 14 Aug 2026 13:55:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3FCE1800577;
	Fri, 14 Aug 2026 13:55:29 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 0/5] rtla: Implement more robust nr_cpus handling
Date: Fri, 14 Aug 2026 15:55:06 +0200
Message-ID: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: cCmIO8P0kuVEyz46Mr-zX2q87FeF1fyzHRgKXVVSx8g_1786715733
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA is an interface to the kernel osnoise and timerlat tracers, and as
such, operates on all CPUs seen by the kernel, regardless of any applied
user space CPU isolation. Currently, it uses libc's get_nprocs_conf()
function to get the total number of valid (configured) CPUs on the
system.

The number reported by the function may vary depending on both the
libc implementation and the environment. This can cause discrepancies,
including:

- RTLA crashing because of out-of-bounds access and/or memory
  corruption, as a result of reading kernel events with cpu >= nr_cpus
  and using it to index an nr_cpus-length buffer.
- nr_cpus mismatching the return value of libbpf_num_possible_cpus(),
  which is used in the per-CPU map size check, leading RTLA to fail to
  read BPF data.

To address both issues, this patchset switches RTLA to unconditionally
use the CPU count exposed through sysfs
(/sys/devices/system/cpu/possible) - the same interface through which
the tracers are accessed. As several places in RTLA assume the CPU count
correlates with the maximum CPU (pre-existing limitation), the new
mechanism also rejects possible CPU lists with holes or starting with
non-zero CPU.

As a safety measure, trace events are further validated and rejected
if their cpu field is greater or equal to nr_cpus. nr_cpus is
additionally validated for equality against osnoise's "all" cpu setting.
This is done to catch environments where sysfs is virtualized and
reports a different number of CPUs than the kernel.

Note: As an alternative approach - reading only the osnoise cpu "all"
setting and using it for nr_cpus - was considered. While it would make
patch 3 unnecessary and make RTLA compatible with environments with
virtualized sysfs, it would require separate handling of userspace and
kernel CPU number, as nr_cpus is also used to guard -H/--housekeeping
option argument. That does not appear to me to be worth it just to cover
for a very rare corner case; if such use case appears in the future, RTLA
can always be fixed.

Tomas Glozar (5):
  rtla: Replace get_nprocs_conf() with sysfs possible cpus
  rtla: Discard trace entries with cpu >= nr_cpus
  rtla: Abort on nr_cpus mismatch with tracer
  rtla/tests: Add unit test for cpu_list_iterate()
  rtla/tests: Add unit test for get_max_cpu_from_list()

 tools/tracing/rtla/src/common.c        |  29 +++-
 tools/tracing/rtla/src/common.h        |   3 +-
 tools/tracing/rtla/src/osnoise.c       |  70 +++++++++-
 tools/tracing/rtla/src/osnoise.h       |   2 +
 tools/tracing/rtla/src/osnoise_hist.c  |   1 +
 tools/tracing/rtla/src/osnoise_top.c   |   1 +
 tools/tracing/rtla/src/timerlat_hist.c |   1 +
 tools/tracing/rtla/src/timerlat_top.c  |   1 +
 tools/tracing/rtla/src/trace.c         |   7 +
 tools/tracing/rtla/src/trace.h         |   1 +
 tools/tracing/rtla/src/utils.c         | 181 +++++++++++++++++++++----
 tools/tracing/rtla/src/utils.h         |   6 +
 tools/tracing/rtla/tests/unit/utils.c  |  71 ++++++++++
 13 files changed, 342 insertions(+), 32 deletions(-)

-- 
2.55.0

