Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9741B37D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086350; cv=none; b=Aq5q+mAz6HEqk1/y2iwaUeFQmG9rlmyCejoaJo14Kg/iBtL/IVqk4kUCJXEAtUQ5RkpUA1yEl802amVN9GD3r1NHPh1y7F5xvlMRhvAPDQnXrEgrABm/Iaxpq9/elESqydzFeIPwhWiWZwkdSVDTZ8KgeZ6iYb3ajsGb2e/YvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086350; c=relaxed/simple;
	bh=r9t6smMnTUS3zCZn7LYwYxEmd4gVA+TWnRpLCV0+plc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=R1+zJ6rUeCrc3GW3f1jsjQ79AljlsZ2LOpnYZK5Q3ZOcwuwjGRKfbAvkmFCuEm/UIaJKNGDbGHa4r0ml++xtTJvpaeUsJqS6PZUVkOB5XRTVplt5dqpNi7HfVvaAMNa1d9wmtl65YlEtW/fhWANjr2KmDqn1fceMMDLXrK515wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLnFwHrG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLnFwHrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZC4dr+0SgUKaLvi8TlSk4n5/aQfq4mI2SOR4xSEnSg=;
	b=aLnFwHrGuXQXI7yCEvmn0YOr+JbXgBr55SVkJSpPsCbjojb8Ybx4yUyLSgCRng9YhT0Q5A
	UWbyvvCCpv5+5HoOyVrAQn9kp6/ulfe2Q1TauCCZp0ln0HM35bx8kQxZ/emBYd2nZnqIOm
	du+mgEP/71vwCPDOjQls0Ju5avxaM3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-qPCywmqPNfKu1epC8zCSsw-1; Mon,
 09 Mar 2026 15:59:03 -0400
X-MC-Unique: qPCywmqPNfKu1epC8zCSsw-1
X-Mimecast-MFC-AGG-ID: qPCywmqPNfKu1epC8zCSsw_1773086342
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04DFE195609F;
	Mon,  9 Mar 2026 19:59:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E7E530001A2;
	Mon,  9 Mar 2026 19:58:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 13/18] rtla: Use str_has_prefix() for option prefix check
Date: Mon,  9 Mar 2026 16:46:26 -0300
Message-ID: <20260309195040.1019085-14-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 7Cf7-qocJBAscyjkXt4NDA23f32UgFGQpxACmHddoM4_1773086342
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The argument parsing code in timerlat_main() and osnoise_main() uses
strncmp() with a length of 1 to check if the first argument starts
with a dash, indicating an option flag was passed.

Replace this pattern with str_has_prefix() for consistency with the
rest of the codebase. While character comparison would be slightly
more efficient, using str_has_prefix() provides better readability
and maintains a uniform coding style throughout the rtla tool.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 9d1fd9981fe91..2db3db155c44a 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1210,7 +1210,7 @@ int osnoise_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		osnoise_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (str_has_prefix(argv[1], "-")) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 8f8811f7a13bd..84577daadd668 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -272,7 +272,7 @@ int timerlat_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		timerlat_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (str_has_prefix(argv[1], "-")) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
-- 
2.53.0

