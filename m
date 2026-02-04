Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1027F749
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216874; cv=none; b=XE44OnYTEJ+nN9q4HcpVKyNyBaduFlO3IaiQieRlkesHoLSQzBZwk4udsDrJCghpt+d0kUgRh4fW4cKmm6PFCL0qENsQ9yMMd6c6+vAWmpE1n6LTkPkbF1ot9SXqh145pnb7JCby0vuaCgYYvPt5Cx0kaw7E4b2tESP1dlXSEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216874; c=relaxed/simple;
	bh=+ffhunU6OovmpNadMKHHv6k31yBcnO46ZwFSJGigcH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gMUzbZTDY7Dt8vjcTq7Ab1WihZ7a60FgpN/j3Ths5YrXEfiHfeDUWit3L0cnRUfZdYmkAps8GrlRYS4Jkn/pxI8JqRVoetAtXqg1D1wUNxpGvrzoN4CCeY/3R1cAQmiC8lWKds0MBPYliYnI1W5wSU78Z6rKT3bbDj4/174sfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fvdmtykh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fvdmtykh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23hZsiknSb9Xi6KPa+kRsw/9VzcEStpN4mBV0Kd68lM=;
	b=Fvdmtykh4h4wAMlFKtLnElRRGTlwdwn2y8Wh3RBbDsNYHv02P3zBJ+53Oa3ABBstRF3o3z
	7IyWvCr4DKwtTsA7vCeX9uqhLtUkDDpmTFBN2al7YVc/eBkqzHiSmYjYSpIysDh/gBMaS6
	Zm98+l60k0nvpA9v5nZr5fUxLpfUrMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-IheHmhcTONmdqyUNaipxfg-1; Wed,
 04 Feb 2026 09:54:32 -0500
X-MC-Unique: IheHmhcTONmdqyUNaipxfg-1
X-Mimecast-MFC-AGG-ID: IheHmhcTONmdqyUNaipxfg_1770216871
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A15319560A5;
	Wed,  4 Feb 2026 14:54:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97FE130001A5;
	Wed,  4 Feb 2026 14:54:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/20] rv/rvgen: make monitor arguments required in rvgen
Date: Wed,  4 Feb 2026 11:42:40 -0300
Message-ID: <20260204144914.104028-15-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: t4hGKGriqTh-4oXCkwnX1Pf3Oy8jwmJAQk1heVB8wbQ_1770216871
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add required=True to the monitor subcommand arguments for class, spec,
and monitor_type in rvgen. These arguments are essential for monitor
generation and attempting to run without them would cause AttributeError
exceptions later in the code when the script tries to access them.

Making these arguments explicitly required provides clearer error
messages to users at parse time rather than cryptic exceptions during
execution. This improves the user experience by catching missing
arguments early with helpful usage information.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/__main__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 50b7d4227fb16..c4c795c15e853 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -32,10 +32,11 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-n', "--model_name", dest="model_name")
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
-    monitor_parser.add_argument('-c', "--class", dest="monitor_class",
+    monitor_parser.add_argument('-c', "--class", dest="monitor_class", required=True,
                                 help="Monitor class, either \"da\" or \"ltl\"")
-    monitor_parser.add_argument('-s', "--spec", dest="spec", help="Monitor specification file")
-    monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
+    monitor_parser.add_argument('-s', "--spec", dest="spec", required=True,
+                                help="Monitor specification file")
+    monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
     container_parser = subparsers.add_parser("container")
-- 
2.52.0

