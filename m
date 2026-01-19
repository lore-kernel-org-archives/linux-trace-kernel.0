Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C979262D0B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856911; cv=none; b=CFvlbnSiGndVGl/oKcywLsZWSJdSd+y+PpCwR6FVGSITEURN6G0a2xiRzGHoBeamrlreFcUtBct4FJ+e6tfUDzwg9ueDJ6EcG+SmHvDYbyn81Q7xsIJcF7XOPZPz9Eg79zWYM76xWXDKoKyLv1krxMT1kZ+ZJRp6/IJmGFOnQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856911; c=relaxed/simple;
	bh=3N+pdb9b2gz7OYWhhC2LnYEQG8AAcdtLz2HIbt4U5AQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+W9rbxbjqgcOBCFxiyW6Y8Nkj1+hs56V+lqzBqM0OnAB64x9F6TlLlvZeHydmGfV2pzBE9d1eQhYe6PgDQeKGggbAla4dwr9KGxV79Ssb5NgHqO2SqPAz0zcRnzQFuFUBJGYbdV7gi5aqQOoDiJKbVjytVpZPmoMiVu7OyGmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOdSAM23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOdSAM23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfYhHmPFMzfU5sr2QO5tgwXVLa7hzCKz+9w5grrucRI=;
	b=YOdSAM23pNKnz2fKVwzkqhmNXW9rIDRqgASpeo+WUSiLJvaRkruf7ltHoPMg5khPuThGXs
	R3UXYpj+1g4gmwNQ7k+goIwnaAXJFQHlCd3hFbb5nANjcDU/25lfuGdnC1oR6Y1Hg+tFkB
	a70U0Vnbazqh0yHGNg/kP/OPXjSqkSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-QLT9wr7wOMy4J5YzTykjHg-1; Mon,
 19 Jan 2026 16:08:26 -0500
X-MC-Unique: QLT9wr7wOMy4J5YzTykjHg-1
X-Mimecast-MFC-AGG-ID: QLT9wr7wOMy4J5YzTykjHg_1768856904
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F003219560B2;
	Mon, 19 Jan 2026 21:08:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7391C1955F43;
	Mon, 19 Jan 2026 21:08:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 24/26] rv/rvgen: make monitor arguments required in rvgen
Date: Mon, 19 Jan 2026 17:46:00 -0300
Message-ID: <20260119205601.105821-25-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add required=True to the monitor subcommand arguments for class, spec,
and monitor_type in rvgen. These arguments are essential for monitor
generation and attempting to run without them would cause AttributeError
exceptions later in the code when the script tries to access them.

Making these arguments explicitly required provides clearer error
messages to users at parse time rather than cryptic exceptions during
execution. This improves the user experience by catching missing
arguments early with helpful usage information.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/__main__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index eeeccf81d4b90..f3e79b14c5d5d 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -28,10 +28,11 @@ if __name__ == '__main__':
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

