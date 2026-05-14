Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB22EB84E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743850; cv=none; b=DhEdjGFnnjlrr2kbW2SMWHu23+n3kYUWamXn5ub+zjeIpZft5JL+oMDoZ2HPz6rfE+ki1qoj1qR7Uni8smDuaFNvN1ftIiEru4IgspCwRfLaHl7qYLV0qXxbehR9SMc3bicLE0ZkKPXzbO1c7cfVBQfaYEjzUxY1cS9my1Uruy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743850; c=relaxed/simple;
	bh=t0IMRjmO7nGl7Bz29HKR9UK68N+h1h/x1yRlahwTJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mz7gscuoSUOeemV6JGQX51J4iA/AiBT64DNi8A8miRAX+pzmfxJWlzbtbmNmpYR4CUQCX+BkpKc4OTugBF3CxjmYMDXbyfUuK9xbCSJAddXbH20vsBFiTqTRuqz5i65aQrvd6IUW1B2t1vownFayjf2aNJfMAPhsP35hbwLPOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCDZxmGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCDZxmGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778743847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mcvO6/sBe93rNf2rGMMO+vsFgltL388Pn96pJ1wvhKA=;
	b=gCDZxmGIIaPY+ZEgC9HlhyM5kv+wPwKPYQvnkX1Wpxu+Ns/k9riOk195U/3kIeT1gtOHPx
	LZTgKnAb65MjQ4Vo5TYqAAg6UxnfAHs11xdkwTl/r/VaHA211mMTxRmD8PDaIcMSK4soUt
	I/QJIk0iog/iFbKpfiw9kmK9xdUwALk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-ixvTufrLN4aKXxGUp3gqhA-1; Thu,
 14 May 2026 03:30:45 -0400
X-MC-Unique: ixvTufrLN4aKXxGUp3gqhA-1
X-Mimecast-MFC-AGG-ID: ixvTufrLN4aKXxGUp3gqhA_1778743844
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DA4918005B6;
	Thu, 14 May 2026 07:30:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CC4030002DD;
	Thu, 14 May 2026 07:30:40 +0000 (UTC)
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
Subject: [PATCH v2] rtla: Document tests in README
Date: Thu, 14 May 2026 09:30:38 +0200
Message-ID: <20260514073038.204428-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -qlGRjC6_0fm3Vssb1dR4gsBeeB5M-ngMqZjSqh34dI_1778743844
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA tests are not documented anywhere. Mention both runtime and unit
tests in the README, with instructions on how to run them and a list of
dependencies and required system configuration.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
v2: Add package hints for common distros for Test::Harness (suggested by
Crystal Wood).

v1: https://lore.kernel.org/linux-trace-kernel/20260423130759.882247-1-tglozar@redhat.com

 tools/tracing/rtla/README.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index a9faee4dbb3a..13b4a798b487 100644
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
+- Test::Harness (libtest-harness-perl on Debian/Ubuntu, perl-Test-Harness on Fedora/RHEL)
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

