Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FB17DE21
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204158; cv=none; b=GlS2/CisncrPSu0TQ4hT1PR0droIv3qskXLZGwkjx8ti/Y2SvRHMEdyarWi4Yr0AfSQcPBpTIqcAMy4edUkGCf2KeqZ0Essr7MgWb+tfxwASALk3KQhp22dW/kqdlVro87ifm1nSX25gktVTdZSPPYocwuskDAfda3uHCNgdHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204158; c=relaxed/simple;
	bh=xh6MUGu4by/vG11OEeezU9OPPR4k7PK3TGG2UVuMagc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7TBFOXHgp2sL7ef2y5hzTv3a7+i1mfjXN7AROn9pWVCtHyPlRMp/zR9svYkYkhb+H2YfjIpxGH4oUO25kgJnVVbZp7JKpNrDH5lo1FBUcvfq2/DA9wy2N8DkV4KrqYThjxllHnukRJdOinndbHGkMAHXCWhr+u/8TGs9ihb4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7Oj+tdX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7Oj+tdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FT0dvVd6Gm7M+CCKrZ6Jo3Pbd+HUvtG3ZBX2N+JLxYw=;
	b=g7Oj+tdXqhd2U2G8IUPcB+So7c7hfOnfBA+ASHeHDMg5hFcEKgp6xqKPZkLh/Occ1oWC9R
	g97AMirtW4z9EJQg2ehbQrjfAJps1YW4TbR+xbRtL+0K5WcwNiQQ8KaB1ZF6t9qfAdCy1e
	kxjFrdHjdtlrrg3Zy6h+TaFlNDqgbpc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-ZmrNPSz6OGmdv1ZqI9Knmw-1; Wed,
 12 Jun 2024 10:55:52 -0400
X-MC-Unique: ZmrNPSz6OGmdv1ZqI9Knmw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F8771955E72;
	Wed, 12 Jun 2024 14:55:51 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 273D31956087;
	Wed, 12 Jun 2024 14:55:48 +0000 (UTC)
From: tglozar@redhat.com
To: bristot@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/5] rtla: Support idle state disabling via libcpupower in timerlat
Date: Wed, 12 Jun 2024 16:54:34 +0200
Message-ID: <20240612145439.206990-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

rtla-timerlat allows reducing latency on wake up from idle by setting
/dev/cpu_dma_latency during the timerlat measurement. This has an effect on
the idle states of all CPUs, including those which are not used by timerlat.

Add option --disable-idle-states that disables all idle states only on
the CPUs where timerlat measurements are running.

libcpupower is used to do the disabling of idle states via the corresponding
sysfs interface.

Tomas Glozar (5):
  rtla: Add dependency on libcpupower
  rtla/utils: Add idle state disabling via libcpupower
  rtla/timerlat: Add --disable-idle-states for top
  rtla/timerlat: Add --disable-idle-states for hist
  rtla: Documentation: Add --disable-idle-states

 .../tools/rtla/common_timerlat_options.rst    |   6 +
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-libcpupower.c        |   8 ++
 tools/tracing/rtla/Makefile                   |   2 +
 tools/tracing/rtla/Makefile.config            |   9 ++
 tools/tracing/rtla/README.txt                 |   4 +
 tools/tracing/rtla/src/timerlat_hist.c        |  35 ++++-
 tools/tracing/rtla/src/timerlat_top.c         |  35 ++++-
 tools/tracing/rtla/src/utils.c                | 133 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h                |   4 +
 11 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libcpupower.c

-- 
2.43.0

