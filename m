Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEB2DFF0D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941370; cv=none; b=LlqGSTwlgN4m1Koxf3bEEPKh/VC2wVdUPSwGLujsRB4sCpj8afg76QNPAcr2nT7CGKrFx6y7Jlm6qEJ+Ozgh3rSLzBY2536CAjme+D2AAUaZg2kflc69imC2vB9SYMKP/6c8trpeElUxPU381icXj2ZPsqQ7ZOjeAFwdqJQA/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941370; c=relaxed/simple;
	bh=EldGwDwLj9lbQI5sLAfG3j4GNA2ETgNSDZ40/lKfj2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASXcwyTKFhhkivWLi5YIYkU0+TPZYpJ3i7NYYbf/3nL3GUa1Vv5uAOCEk006oPghUBOz9PEi7e4gDfKrCmXVIRRiw9EOlErG4w8LDu/lxIe54UjQ7DaLjTTZZx1MSF1C2MoMP7WOEQzMfrB7d4tJ+S2aUsk2e5lgeuhtt2TOUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqlCMjqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqlCMjqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6C4BdrJF7WIpqXdFpP6dYYZvXiO0SgJqw+aD3tRKE3Q=;
	b=IqlCMjqQcyMt8dsmtNXbEdoOEc9SNDHEqXBEfn7v4RN84nMyA6ivQKCD/c9RCs//Ry+fTd
	pYWlx0bhTdLVy4pgX85RSQUBnrdRy5mNlZORZhI/PaRabIj1+PkIKwck/YHJVhxiUh87E1
	wc51QS0rBEgigRjAQb75eIZgQoKZdAo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-B10s7GLmMveRAgPs2aXqFw-1; Thu,
 26 Jun 2025 08:36:06 -0400
X-MC-Unique: B10s7GLmMveRAgPs2aXqFw-1
X-Mimecast-MFC-AGG-ID: B10s7GLmMveRAgPs2aXqFw_1750941365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCB4D1944AA9;
	Thu, 26 Jun 2025 12:36:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57DAB18003FC;
	Thu, 26 Jun 2025 12:36:01 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/9] rtla/timerlat: Support actions on threshold and on end
Date: Thu, 26 Jun 2025 14:33:56 +0200
Message-ID: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series adds a feature that allows to user to specify certain
kinds of "actions" to be executed at one of two places in the rtla
measurement: when tracing is stopped on latency threshold, and at the
end of tracing.

Two new options are added: --on-threshold, and --on-end, taking
the action as an argument. For example:

$ rtla timerlat hist -T 10 \
--on-threshold shell,command="echo Threshold"
--on-end shell,command="echo Tracing stopped"

will print "Threshold" if a thread latency higher than 10 microseconds
is reached, and "Tracing stopped" always at the end.

The list of possible actions is extensible and is covered in
the commit messages. Later, a documentation patch series will be sent
with clear explanation of every action and its syntax.

Notably, a special action "continue" resumes tracing. For example:

$ rtla timerlat hist -T 100 \
--on-threshold shell,command="echo Threshold" \
--on-threshold continue -d 10s

will print "Threshold" as many times as tracing is stopped after
thread latency reaches 100us.

The feature was inspired by a case where collecting perf data on rtla
latency overflow was required, which can be done by sending a signal
to the perf process.

Example of this with Intel PT aux buffer:

$ perf record --cpu 0 -e intel_pt// -S -- rtla timerlat top -q -T 100 \
-c 0 --on-threshold signal,pid=parent,num=12 --on-theshold continue

In general, the feature is aiming to allow integration with external
tooling. To implement even more flexibility, passing context to the
shell through environmental variables, or even an entire scripting
language with access to the rtla internals can be implemented if
needed.

Changes since v1:
- Dropped short options on suggestion from Arnaldo.
- Added documentation.

Tomas Glozar (9):
  rtla/timerlat: Introduce enum timerlat_tracing_mode
  rtla/timerlat: Add action on threshold feature
  rtla/timerlat_bpf: Allow resuming tracing
  rtla/timerlat: Add continue action
  rtla/timerlat: Add action on end feature
  rtla/tests: Check rtla output with grep
  rtla/tests: Add tests for actions
  rtla/tests: Limit duration to maximum of 10s
  Documentation/rtla: Add actions feature

 .../tools/rtla/common_timerlat_options.rst    |  64 +++++
 tools/tracing/rtla/src/Build                  |   1 +
 tools/tracing/rtla/src/actions.c              | 260 ++++++++++++++++++
 tools/tracing/rtla/src/actions.h              |  52 ++++
 tools/tracing/rtla/src/timerlat.bpf.c         |  13 +-
 tools/tracing/rtla/src/timerlat.c             |  24 +-
 tools/tracing/rtla/src/timerlat.h             |  24 +-
 tools/tracing/rtla/src/timerlat_bpf.c         |  13 +
 tools/tracing/rtla/src/timerlat_bpf.h         |   3 +
 tools/tracing/rtla/src/timerlat_hist.c        | 140 +++++++---
 tools/tracing/rtla/src/timerlat_top.c         | 165 +++++++----
 tools/tracing/rtla/tests/engine.sh            |  21 +-
 tools/tracing/rtla/tests/hwnoise.t            |   8 +-
 tools/tracing/rtla/tests/osnoise.t            |   4 +-
 tools/tracing/rtla/tests/timerlat.t           |  36 ++-
 15 files changed, 712 insertions(+), 116 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h

-- 
2.49.0

