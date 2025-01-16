Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4A22D4C5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039001; cv=none; b=CLFSISFP81HEpXdLwD2ep2Su2Li6L9FoR2A8aqh39bvkZKkcffltm36flt9G/4zmXfmmBZTOJvbnGAIucv6sFlfV8AqpmGMh04BjKHaWdvo3zpiDKaZbpMerlmUKIdun3gKHtlJo55Rx1sStoHQxWKbb0cINx6qtp4nm9HaYTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039001; c=relaxed/simple;
	bh=Jsb7pYTg9WzvWzi8cYDVw/IHpbIVZT1TYnVVZkqi78o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAQ0OCm6iacLnH18lN2af9EcDfzLZKNvGLcTnO5eAO33c3zTu+q04dTMMK1e13IGRrTdtK3NPvnnRbA89xDxyRFz6xhEQNoO1hjIr2aQ801zrqYJCADiHbtvps8ljjFtiZf4DftyTE647aUAABsdqN8HVePyjDkjQVvHkY5WQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ty8BB+cs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty8BB+cs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737038999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lelndRzIY6j2DK3PGpzRJhST3FAgpTlxEp0P39p2hx0=;
	b=Ty8BB+cs+XEK8JcsKVZhIL8oF/wFjTV6f3v/FCmz85FK1IbAsqEXNh73MRKC8txr9lCLUI
	XvORsqvC4YI9XjxA2u/pEUO+X1AU095XmtH1tBz8mZwY2HHVW4X5Y5RehBx7g1VmSN9m6Q
	505Gfduhrnl+Nr3hmBbJhhGLwxwzyxs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-pStkuUlxORa1zu8DofstWw-1; Thu,
 16 Jan 2025 09:49:55 -0500
X-MC-Unique: pStkuUlxORa1zu8DofstWw-1
X-Mimecast-MFC-AGG-ID: pStkuUlxORa1zu8DofstWw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D18E1954185;
	Thu, 16 Jan 2025 14:49:54 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA31119560BF;
	Thu, 16 Jan 2025 14:49:51 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/5] rtla/timerlat: Stop on signal properly when overloaded
Date: Thu, 16 Jan 2025 15:49:26 +0100
Message-ID: <20250116144931.649593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We have been seeing an issue where if rtla is run on machines with a high
number of CPUs (100+), timerlat can generate more samples than rtla is able
to process via tracefs_iterate_raw_events. This is especially common when
the interval is set to 100us (rteval and cyclictest default) as opposed
to the rtla default of 1000us, but also happens with the rtla default.

Currently, this leads to rtla hanging and having to be terminated with
SIGTERM. SIGINT setting stop_tracing is not enough, since more and more
events are coming and tracefs_iterate_raw_events never exits.

This patchset contains two changes:
- Stop the timerlat tracer on SIGINT/SIGALRM to ensure no more events are
generated when rtla is supposed exit. This fixes rtla hanging and should
go to stable.
- On receiving SIGINT/SIGALRM twice, abort iteration immediately with
tracefs_iterate_stop, making rtla exit right away instead of waiting for
all events to be processed. This is more of a usability feature: if the user
is in a hurry, they can Ctrl-C twice (or once after the duration has expired)
and exit immediately, discarding any events pending processing.

Note: I am sending those together only because the second one depends on
the first. Also this should be fixed in osnoise, too.

In the future, two more patchsets will be sent: one to display how many
events/samples were dropped (either left in tracefs buffer or by buffer
overflow), one to improve sample processing performance to be on par with
cyclictest (ideally) so that samples are not dropped in the cases mentioned
in the beginning of the email.

Tomas Glozar (5):
  rtla: Add trace_instance_stop
  rtla/timerlat_hist: Stop timerlat tracer on signal
  rtla/timerlat_top: Stop timerlat tracer on signal
  rtla/timerlat_hist: Abort event processing on second signal
  rtla/timerlat_top: Abort event processing on second signal

 tools/tracing/rtla/src/timerlat_hist.c | 19 ++++++++++++++++++-
 tools/tracing/rtla/src/timerlat_top.c  | 20 +++++++++++++++++++-
 tools/tracing/rtla/src/trace.c         |  8 ++++++++
 tools/tracing/rtla/src/trace.h         |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.47.1

