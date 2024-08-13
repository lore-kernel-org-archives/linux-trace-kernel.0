Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882F1A0709
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564730; cv=none; b=ZAdJIiXCqHe05oQmC5TkQHCMEr28uo1JsxydVlHnQIb3i0ArhBF1cu5ZyxMVi7CWFoM4ILguYRyveW/SwdIFzLAW/ItIKL9+3pZBzqRX1YugkYdBCRwUxfxbApOM0gr/EcX+6HUP08YPNGa1+P5KcyERmW0a7A/yAblx4NrQH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564730; c=relaxed/simple;
	bh=faQ30bhsxMCzAuzrzTxRnC0eldEHqYwJ/9YpR+f9NTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhNOL1mlxgWZxQQIA23slOr6mrg3TdD1riNTaW6ajgGu44b19i+VPhEtm4yF3xTVipRqwqlmdUoBCoXXvjIcg9im+En08smPRM7BK2rSSYBGCaP9vp+r4dl0wQXNVt2wsD75f+lreQtjUmgZ1pLx3oERw/O59fttpsRISaRkzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMj1u1+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMj1u1+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723564727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EFhCdmKsJsPzstjdHKLzvluRw926TZ73hvSP8heyV50=;
	b=IMj1u1+Ar3M6GkWT2CuJ5d9RdVCmq6SSC3NP0QzohoZ+DIa+df1yF7J4LEo+n/FUmxXSPF
	1j+HoTU7rlECz51LMoT60N9tdm7ku03RfGvHkUbn42ivoo7o859LOVQu6jeC/+lqHmvNQW
	HV7ck5nW4eA+kGKoPJIgwUCTCU6gpW4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-u0twb30mP8yMdVEEKJ0oJA-1; Tue,
 13 Aug 2024 11:58:46 -0400
X-MC-Unique: u0twb30mP8yMdVEEKJ0oJA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77C6918EA817;
	Tue, 13 Aug 2024 15:58:45 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.249])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 959F81955F2D;
	Tue, 13 Aug 2024 15:58:38 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	jlelli@redhat.com,
	jkacur@redhat.com,
	williams@redhat.com,
	tglozar@redhat.com
Subject: [PATCH] rtla: Sync the help text between top tools
Date: Tue, 13 Aug 2024 17:58:31 +0200
Message-ID: <20240813155831.384446-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In addition, fix a typo in the error message generated when the
specified duration is invalid. Suggested by Tomas Glozar.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c  | 2 +-
 tools/tracing/rtla/src/timerlat_top.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 73106683c281..50e97dbc951d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -442,7 +442,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 94a2f5bbaeb7..312fc7e833ba 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -613,7 +613,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-- 
2.46.0

