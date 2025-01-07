Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A913A3EC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jan 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261439; cv=none; b=mmMkJ867S/Y/bTQjPsSb9+RymT8k8hFMaD9OvI35szOVE8t+TieUo8liF28GFDSIsd+/Pok/EpGKj+qkETfg5Ja4CZp9HkGH17xEQVXTGRFmAtqFQKVWgkndalPg3B4tSZm54SQkZ/SCup+tfqBAhsCPpkHv5yF3KRHQiBV1vBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261439; c=relaxed/simple;
	bh=jx7MSXONEMkewiHPqI0CKO1/6b3kSIWtFDxzADugabA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkj/WvdRFuUXw2AWiL3Vl4otu2+9pYLH06NeQ+6Vh8X2NnhshVAr+Meh16f2/UYQeEj8JXjxUcHSOsemJEHuDI9EN168fJg6TivOMlmlBU0pJxlBr6wbdsJVWVzVR7wqrRistsNK3W86eYoPDYaR2oHIv2DeZaqPQ9I84wmOqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFkNTwqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFkNTwqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=db/ifMT0Kl/YwdvDcb/yrH5rQdPrqGphFy5z10CnGCk=;
	b=MFkNTwqXi2jb5aa7FsXkazsg76y+DBomWWzHThdmLGGQ6STfeTk7oAMNz6a1RpmmXj+Be1
	6PhI13uW/cmHIhg5NrhkfMnLW/cloBOcXcTpxU3zWpXiwP7DTiLjFs/ouQRzyv+LETokmO
	MO9LFFw9wgKq3T9Y9torRgYSw5qqifc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-2sgU8TtcNEuVqGcK5id1Pw-1; Tue,
 07 Jan 2025 09:50:33 -0500
X-MC-Unique: 2sgU8TtcNEuVqGcK5id1Pw-1
X-Mimecast-MFC-AGG-ID: 2sgU8TtcNEuVqGcK5id1Pw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A95381955F41;
	Tue,  7 Jan 2025 14:50:32 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC0641956088;
	Tue,  7 Jan 2025 14:50:30 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/3] rtla/timerlat: Set OSNOISE_WORKLOAD for kernel threads
Date: Tue,  7 Jan 2025 15:48:20 +0100
Message-ID: <20250107144823.239782-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The patchset makes both rtla-timerlat-hist and rtla-timerlat-top set
OSNOISE_WORKLOAD to the proper value ("on" when running with -k, "off"
when running with -u) every time the option is available instead of setting it
only when running with -u.

This prevents rtla timerlat -k from giving no results when
NO_OSNOISE_WORKLOAD is set, either manually or by an abnormally exited earlier
run of rtla timerlat -u.

osnoise_set_workload is made to distinguish between the option missing
altogether and it failing to be set. In the first case, rtla-timerlat will
ignore setting the option to preserve compatibility of kernel-thread mode
on older kernels without the OSNOISE_WORKLOAD option.

Tomas Glozar (3):
  rtla/osnoise: Distinguish missing workload option
  rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
  rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads

 tools/tracing/rtla/src/osnoise.c       |  2 +-
 tools/tracing/rtla/src/timerlat_hist.c | 15 +++++++++------
 tools/tracing/rtla/src/timerlat_top.c  | 15 +++++++++------
 3 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.47.1

