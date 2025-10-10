Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FA27B329
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085304; cv=none; b=eqNR58qGF+0rOgSl5MHCBDTVaWOTviEYqK87chBB3TDFCvsHAWvigVDJHXA2nl5j1AEMKA2QXaXxQlpfpYFH8Bi+hk1GbM/4kPWRvLdKNm80/Ayo64Z3WKL11upM04ohTu+Q2z5Gcg+wgvCMyZRNgTKlUWwzNNy+7sWR7bdSWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085304; c=relaxed/simple;
	bh=tRw5rg2zI8NC3fDx/8TBWVNhmxDyhE6zhiFF/+GfaIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csyqenrAq1o5c1y9FRI7rDcCuXObNGx9AksfKYDnJOOT+fe30na0fTu9zhuAhrsIYMMOVotjSUCKJeqDA7Bc2Ei13t0IQyxu7e4qkGHXwU97E/5Y2qIaR+i7RjAmNeaLdbn4uT/1oISLJgSeTq3MtD9MmulfJ0oHJnw9vJ2dl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDVzODCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDVzODCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEScr6rBc4nyrlbe3x+UnFuFXbffOUB35k7ObRLSOEw=;
	b=BDVzODCpO8HGr8SEC2Lob+TcsD0foHjKvENKB7PGXoIcXBiJEUjutV9sTJJ1GIN5PDxwTq
	68JXpRX2Ogkbo4o6XqWDIgV6x4VhYNIGNtrddKP6aNGfqgY51mSTHv+GQNwUWBm2IN33Y6
	5roztyM2xmalz3vXNtF0/sMuAtW+P74=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-aLW8leMqM9Ol3yimznfKbw-1; Fri,
 10 Oct 2025 04:34:58 -0400
X-MC-Unique: aLW8leMqM9Ol3yimznfKbw-1
X-Mimecast-MFC-AGG-ID: aLW8leMqM9Ol3yimznfKbw_1760085297
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48DD919560B1;
	Fri, 10 Oct 2025 08:34:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67E7919560BB;
	Fri, 10 Oct 2025 08:34:52 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 9/9] Documentation/rtla: Include defaults for tracer options
Date: Fri, 10 Oct 2025 10:33:38 +0200
Message-ID: <20251010083338.478961-10-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 0122938a7ab4 ("rtla: Always set all tracer options") changed the
behavior of RTLA to always set all osnoise and timerlat tracer options
to default values taken from the tracers whenever an RTLA measurement
is started. The change was done to make RTLA results consistent on
subsequent runs of the same command.

Include the default values for tracer options also in documentation
where appropriate.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 26e94d291a70..1c4f3e663cf5 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -2,10 +2,14 @@
 
         Set the |tool| tracer to run the sample threads in the cpu-list.
 
+        By default, the |tool| tracer runs the sample threads on all CPUs.
+
 **-H**, **--house-keeping** *cpu-list*
 
         Run rtla control threads only on the given cpu-list.
 
+        If omitted, rtla will attempt to auto-migrate its main thread to any CPU that is not running any workload threads.
+
 **-d**, **--duration** *time[s|m|h|d]*
 
         Set the duration of the session.
@@ -57,6 +61,8 @@
 **--trace-buffer-size** *kB*
         Set the per-cpu trace buffer size in kB for the tracing output.
 
+        If not set, the default tracefs buffer size is used.
+
 **--on-threshold** *action*
 
         Defines an action to be executed when tracing is stopped on a latency threshold
-- 
2.51.0

