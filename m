Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5F3EF0A0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949700; cv=none; b=ubomecCutBSocZSb1Oc41Y6XqYKwONuQrSxWPOPwUitNZ+5TTfQb5yPJWj3/sZn44RfCV5AP6RJ5JcJR+RliIdfyBJy/TMb2Q+q7SgVrTCrXszyQ0ks0BKZO/EmF5SxWvMLJzmdd3tez2WyjkNRzgFhFHaTX/28uLr51Y+jjtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949700; c=relaxed/simple;
	bh=zufJnXWDyPeKufM90NOwYfmd/zaRGvkiBD94e46PFjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Ch1l6DULpDJ4X3+3fsyXGtOt9vEz8msHRayFUzuz5S6cKZFBwF2r4591OFa66T7MfOt//IaVhNv25Hiose4lfpNSVUXeW2KyCgljDh2+HgRy0H+Bc9aLWTgTUmmhFRCVZ3Y3GGysF0PpywUYy2iAwIeTaXdgtAPE9gwsHzu5o6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpwqvJNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpwqvJNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hr/ez8sNqgD6OzbSwn16HTFbZ7x0aqC7wOIkJ0foQXA=;
	b=hpwqvJNqJxItCCBSy1Nh+qGkGFNSeKRSR9+3myPMkClEa/bqp7kCbfWsKcL99wSqd+BApT
	k/hkBhKuk8Vjz962W3lpdzzHVpURBj/gnzCjzLAlsIKFa98DGdusWkQRnr1c8ROxlaM88D
	REBYB9bemysrFcCUhc1SVUBF7X4q/9E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-7LdbA8fwN32bviK7ABynLg-1; Thu,
 23 Apr 2026 09:08:14 -0400
X-MC-Unique: 7LdbA8fwN32bviK7ABynLg-1
X-Mimecast-MFC-AGG-ID: 7LdbA8fwN32bviK7ABynLg_1776949693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEE98180059B;
	Thu, 23 Apr 2026 13:08:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5BA73000709;
	Thu, 23 Apr 2026 13:08:10 +0000 (UTC)
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
Subject: [PATCH] rtla: Document tests in README
Date: Thu, 23 Apr 2026 15:07:59 +0200
Message-ID: <20260423130759.882247-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: I4ATm3sDo-g8K4SrFpY5ufEJejNpYHQa2FRWyXXKvcM_1776949693
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA tests are not documented anywhere. Mention both runtime and unit
tests in the README, with instructions on how to run them and a list of
dependencies and required system configuration.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/README.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index a9faee4dbb3a..8a782cd2c171 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -42,4 +42,34 @@ For development, we suggest the following steps for compiling rtla:
   $ make
   $ sudo make install
 
+Running tests
+
+RTLA has two test suites: a runtime test suite and a unit test suite.
+
+The runtime test suite is available as "make check" (root required) and has
+the following dependencies, in addition to RTLA build dependencies:
+
+- Perl
+- Test::Harness / TAP::Harness
+- bash
+- coreutils
+- ldd
+- util-linux
+- procps(-ng)
+- bpftool (if rtla is built against libbpf)
+
+as well as the following required system configuration:
+
+- CONFIG_OSNOISE_TRACER=y
+- CONFIG_TIMERLAT_TRACER=y
+- tracefs mounted and readable at /sys/kernel/tracing
+
+The unit test suite is available as "make unit-tests" and has the following
+dependencies:
+
+- libcheck
+
+Unlike the runtime test suite, root is not required to run unit tests, nor is
+a tracefs/osnoise/timerlat-capable kernel required.
+
 For further information, please refer to the rtla man page.
-- 
2.53.0

