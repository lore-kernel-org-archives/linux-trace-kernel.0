Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B242701DC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864236; cv=none; b=RdHPqbp+4xrs5ohmasxxmpfdlFPSBwk88Zt0h6+Ov8+wT5bvC2l3Tz9sX2SUtfOxxcRMS+zwoQJD6OINoln5Q5ooEf6qVU/frfpPZViK/YmbJnT2lWTW+7igWY3Z+DQCdlhCH3V37FSCSjiNaCKdL6f7NZp7J8LiDwxTRsALtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864236; c=relaxed/simple;
	bh=JKCYNEeN/DjkXwRGymqHAF0dsNfsOprRq4sv49NAUYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ugTKnQz/SSa9Ri/Yuory0bDKyNlbZVhiir0SapkQH4l8qtnmAt+dl/pvS0ADObZHVrS4VK6XXiCtcJ9ZrPCkFDO0rjC95UaksRFvgh+lmD5TkmYRbLnZGqQJsxglgKV7/2km0ZOQVgVyf7B9ZlwIn5vhnoj7IkS728r6siO6A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA+7ssE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA+7ssE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C80re9BR9cuOqri0fwco4+uqG9iMQO/SIrKYil8gync=;
	b=IA+7ssE9qSD/EgtEvjmaoI4sCszp2JFj+kY7hYU1CBocRDx6W2bM+jDWls9JqZblyMBX/N
	pZGIJUit6njQSHshcg1bboW7NroM6+cbHatsKFMdpPggd5tsNaBvIcqmM3dE8CFY+ApjGG
	uKms/4iDrAoDWzEdnCM2/rpAKYhW3Qc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-bnehINCWOPKbnii0F-GiWQ-1; Mon,
 23 Feb 2026 11:30:30 -0500
X-MC-Unique: bnehINCWOPKbnii0F-GiWQ-1
X-Mimecast-MFC-AGG-ID: bnehINCWOPKbnii0F-GiWQ_1771864229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95F3019560B2;
	Mon, 23 Feb 2026 16:30:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DC811800669;
	Mon, 23 Feb 2026 16:30:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 16/19] rv/rvgen: extract node marker string to class constant
Date: Mon, 23 Feb 2026 13:17:59 -0300
Message-ID: <20260223162407.147003-17-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: VSnpMxAbmtzB3eOizzmMi2npTKAhhJcX_VaqMesWWGE_1771864229
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a node_marker class constant to the Automata class to replace the
hardcoded "{node" string literal used throughout the DOT file parsing
logic. This follows the existing pattern established by the init_marker
and invalid_state_str class constants in the same class.

The "{node" string is used as a marker to identify node declaration
lines in DOT files during state variable extraction and cursor
positioning. Extracting it to a named constant improves code
maintainability and makes the marker's purpose explicit.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 6613a9d6159a9..fd2a4a0c3f6eb 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -44,6 +44,7 @@ class Automata:
 
     invalid_state_str = "INVALID_STATE"
     init_marker = "__init_"
+    node_marker = "{node"
     # val can be numerical, uppercase (constant or macro), lowercase (parameter or function)
     # only numerical values should have units
     constraint_rule = re.compile(r"""
@@ -112,7 +113,7 @@ class Automata:
         for cursor, line in enumerate(self.__dot_lines):
             split_line = line.split()
 
-            if len(split_line) and split_line[0] == "{node":
+            if len(split_line) and split_line[0] == self.node_marker:
                 return cursor
 
         raise AutomataError("Could not find a beginning state")
@@ -127,9 +128,9 @@ class Automata:
                 continue
 
             if state == 0:
-                if line[0] == "{node":
+                if line[0] == self.node_marker:
                     state = 1
-            elif line[0] != "{node":
+            elif line[0] != self.node_marker:
                 break
         else:
             raise AutomataError("Could not find beginning event")
@@ -151,7 +152,7 @@ class Automata:
         # process nodes
         for line in islice(self.__dot_lines, cursor, None):
             split_line = line.split()
-            if not split_line or split_line[0] != "{node":
+            if not split_line or split_line[0] != self.node_marker:
                 break
 
             raw_state = split_line[-1]
-- 
2.53.0

