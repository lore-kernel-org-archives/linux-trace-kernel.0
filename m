Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D728937E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650228; cv=none; b=pLlAMjH8y6hlGBKbXBz+t5nDbvDe8iYKxEY/EWyQT55bz4qpFfhH2F+NaMUshwmPvBYZMOQe8Acyw/MU3RWS6yukL9nt7jTDOOwRe8bYGJym5O73arYvuHkyCy9qfjwXsSXpI1WAuxQUayZ3WqcwtsYTKxtqa/flA5PyxIs4e/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650228; c=relaxed/simple;
	bh=PtwNFMm6TSFT9rh/6yYlx/h7Ig3gXuqYO1GwibaIaNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBccMxhEVEXNJ8atdULk5oxSuJOGU9Yltd8Ef/rdVtVzpgJuwMzJIEzHrCyQMaVJJqOkfR0B/SNysx45daKgQoySHu509Zz8Pr3SZvXrpSc+8+BfiBhYEKrGW+819VDZdrxm72Wh3n6qpgDInRWUTYTO6OVvhA9L2/XLyJp9QWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnGlM9JU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnGlM9JU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6FUPWHHcR0JatmzSzchERIjR2GyPvu7UE4LUtgRTBQ=;
	b=cnGlM9JUx/tVfV9LhoAetsrWvUyVEjGKbaT4W3D3zEvBm3rizouIvJ8CELQ5BLQvPUgPd3
	NiE6nA4dNvC3+w+a2yHa5tez8KpFrieL4/BRd2UdGncDiAj/OldOAF4ugg2Wx6a7r0c800
	xoI54UXpLcI+EH+VD/Ie26n/LcSJZTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-ng4wFBA7PaKn_Lpf2AZ6wA-1; Wed,
 11 Jun 2025 09:57:02 -0400
X-MC-Unique: ng4wFBA7PaKn_Lpf2AZ6wA-1
X-Mimecast-MFC-AGG-ID: ng4wFBA7PaKn_Lpf2AZ6wA_1749650221
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D02D180028B;
	Wed, 11 Jun 2025 13:57:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD69419560AF;
	Wed, 11 Jun 2025 13:56:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/8] rtla/timerlat: Support actions on threshold and on end
Date: Wed, 11 Jun 2025 15:56:36 +0200
Message-ID: <20250611135644.219127-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This series adds a feature that allows to user to specify certain
kinds of "actions" to be executed at one of two places in the rtla
measurement: when tracing is stopped on latency threshold, and at the
end of tracing.

Two new options are added: -A/--on-threshold, and -N/--on-end, taking
the action as an argument. For example:

$ rtla timerlat hist -T 10 -A shell,command="echo Threshold" \
-N shell,command="echo Tracing stopped"

will print "Threshold" if a thread latency higher than 10 microseconds
is reached, and "Tracing stopped" always at the end.

The list of possible actions is extensible and is covered in
the commit messages. Later, a documentation patch series will be sent
with clear explanation of every action and its syntax.

Notably, a special action "continue" resumes tracing. For example:

$ rtla timerlat hist -T 100 -A shell,command="echo Threshold" \
-A continue -d 10s

will print "Threshold" as many times as tracing is stopped after
thread latency reaches 100us.

The feature was inspired by a case where collecting perf data on rtla
latency overflow was required, which can be done by sending a signal
to the perf process.

Example of this with Intel PT aux buffer:

$ perf record --cpu 0 -e intel_pt// -S -- rtla timerlat top -q -T 100 \
-c 0 -A signal,pid=parent,num=12 -A continue

In general, the feature is aiming to allow integration with external
tooling. To implement even more flexibility, passing context to the
shell through environmental variables, or even an entire scripting
language with access to the rtla internals can be implemented if
needed.

Tomas Glozar (8):
  rtla/timerlat: Introduce enum timerlat_tracing_mode
  rtla/timerlat: Add action on threshold feature
  rtla/timerlat_bpf: Allow resuming tracing
  rtla/timerlat: Add continue action
  rtla/timerlat: Add action on end feature
  rtla/tests: Check rtla output with grep
  rtla/tests: Add tests for actions
  rtla/tests: Limit duration to maximum of 10s

 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/actions.c       | 260 +++++++++++++++++++++++++
 tools/tracing/rtla/src/actions.h       |  52 +++++
 tools/tracing/rtla/src/timerlat.bpf.c  |  13 +-
 tools/tracing/rtla/src/timerlat.c      |  24 ++-
 tools/tracing/rtla/src/timerlat.h      |  24 ++-
 tools/tracing/rtla/src/timerlat_bpf.c  |  13 ++
 tools/tracing/rtla/src/timerlat_bpf.h  |   3 +
 tools/tracing/rtla/src/timerlat_hist.c | 145 ++++++++++----
 tools/tracing/rtla/src/timerlat_top.c  | 167 ++++++++++------
 tools/tracing/rtla/tests/engine.sh     |  21 +-
 tools/tracing/rtla/tests/hwnoise.t     |   8 +-
 tools/tracing/rtla/tests/osnoise.t     |   4 +-
 tools/tracing/rtla/tests/timerlat.t    |  36 +++-
 14 files changed, 652 insertions(+), 119 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h

-- 
2.49.0

