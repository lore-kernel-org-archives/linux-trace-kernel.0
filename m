Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05D3C76BD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702308; cv=none; b=s+IoWcj1dPNth+qq6sUHzK7duVBN5uu3oL1sZr+BHBbpkqznhD9XhaG2SdqbV7cxxck2qu6FmvciiHI9VtosNWlurPgxzh7wOrTxiIBW1DbQQ6vyg3Dt2AD4BUdWiY2626inu4O8GnwMP+uPCwJ4NzIM7kLoVd8k3jGcPzR7s4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702308; c=relaxed/simple;
	bh=MCeh1YzlrMSIpzgMuJWvusd/9tGfEb3VP3Iy+aO/AVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J4TtNwPVLFXK4b6ZX4CnIzTTMiR+I1bAkAK387tvjXpHtelZplIixNt/hqceGqXasC3TUuWzEvj6j3IeBUqeQICO9haG6217ADZr2qeShKFn9FAO51x+kU9WXZII60o/Pr1H1j6Y55EoXk0csv4YpMW8FPh50a/i6yP5+0q3W7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs5hlXGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs5hlXGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781702306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VsqXFSMNs8zrw+jri9zTq847xOPB6KWpHG/yzX/wDzo=;
	b=cs5hlXGrS8uh8tgvVN1AvVyYy243AIyYBwcsNPvWQehWhUEbIIjltQKCCDs4JW+OpQ8gZy
	QnRiIjo9TSQPupD2f0BjQiHJuMx8ldZKXB1ugejTx82PRpWLyIzo2WU2EUmkWvLVH2Hri7
	cmk58We54H5eSlTdV3GokNrAeewLIiw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-60FLF4XzP5GKECGcO-qTPw-1; Wed,
 17 Jun 2026 09:18:23 -0400
X-MC-Unique: 60FLF4XzP5GKECGcO-qTPw-1
X-Mimecast-MFC-AGG-ID: 60FLF4XzP5GKECGcO-qTPw_1781702301
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9218B1954B07;
	Wed, 17 Jun 2026 13:18:21 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.165])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D188F180049F;
	Wed, 17 Jun 2026 13:18:17 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v2 0/4] tracing/osnoise: Track IPIs
Date: Wed, 17 Jun 2026 15:17:55 +0200
Message-ID: <20260617131803.2988989-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _eF_DtmGCTnTGihLnua7qNIWHHv5LbELY7EK9mc4hvc_1781702301
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

So I've seen a few times now reports of latency spikes caused by IPIs, usually
because of isolation misconfiguration, but only detected at the tail of end
e.g. a 24h timerlat run.

It's not because those IPIs are rare, but rather that they don't by themselves
cause a monitered CPU to reach the latency threshold, it's usually a combined
interference that gets us there.

I'd like to make it easier to detect such misconfigurations and thus IPIs
hitting supposedly-isolated CPUs. I initially kludged a timerlat option to stop
tracing as soon as an IPI was sent to a monitored CPU, regardless of the latency
threshold. It sort of did the trick, but Tomáš convinced me timerlat wasn't
really the place for that.

So here's IPI tracking added to osnoise. This time around fully in userspace, as
Tomáš pointed out to me that this will make it a lot easier to deploy to older
kernels.

Based on top of linux/next at 'next-20260616' to have the latest libsubcmd
changes.
  
Cheers,
Valentin

Revisions
=========

v1 -> v2
++++++++

o Dropped the in-kernel osnoise_sample changes and made it all userspace

Valentin Schneider (4):
  rtla/osnoise: Add IPI tracking cmdline option
  rtla/osnoise: Record IPI count in osnoise top
  rtla/osnoise: Trace IPI events when recording a trace file
  rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs

 Documentation/tools/rtla/rtla-osnoise-top.rst |   4 +
 tools/tracing/rtla/src/cli.c                  |   1 +
 tools/tracing/rtla/src/cli_p.h                |   3 +
 tools/tracing/rtla/src/common.c               |   2 +-
 tools/tracing/rtla/src/common.h               |   3 +-
 tools/tracing/rtla/src/osnoise.c              |  17 +-
 tools/tracing/rtla/src/osnoise_top.c          | 153 +++++++++++++++++-
 7 files changed, 179 insertions(+), 4 deletions(-)

--
2.54.0

