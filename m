Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E872F7445
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856959; cv=none; b=Cx9uGJqO9pE4xaETsRNaHo1yuVVGos2mF//JvumiIG3aice/RMH0RgP7eVAKSvDgWe6lgwvWBbA6WH0sZmkGF2LvC+aWKbLzEPTFfIEhWEJeDO4lmKOSikVj1jjrVRhNCZigCoUywuJ02A+w8Yqe8MMUsnjNHTgB8sbcckqNWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856959; c=relaxed/simple;
	bh=UE5EVzP4Jwg5WCln9kZqxFNFL4Bs4RBJZ9N5G//80pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxgzDiv/qGtqUFyl+ZBOzFBv9pSQdEpdCJEdLcQGmNoB9y0ieJbHSNu9TISQp/l0uq7rYtD7E9XCTAlA8eEFshJsl+3k+MTcm9T44g8y16q1+tBhugsPf6+864LNObKt07RjAlPr+lpYNgP4LU8IFEo/prDAMtfA8Lohtl0Ht/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhgzItfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhgzItfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+P/u9BoRMOUVSt4UIw4hbVr4uE91hZVlQvF2Pvoxxk=;
	b=KhgzItfrBrk0hCBJJFbM/2y9XPwr0PqxiZXCk84F4Er57KOQEq5AcVxQuO5swvjLs2YQml
	kmnGI2gA3YD5Dy71AV3z3T4eJTZrJRWUg//VBV5+Eop6BtbgKZCyV9aSwIDFjGPlU8rBAW
	8DT4YkZ7I+dWwLPTHsMVEzoLR5JRkR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-a7aJK8nYO4KrqxRaE2wvAA-1; Mon,
 19 Jan 2026 16:09:13 -0500
X-MC-Unique: a7aJK8nYO4KrqxRaE2wvAA-1
X-Mimecast-MFC-AGG-ID: a7aJK8nYO4KrqxRaE2wvAA_1768856952
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4F6A1956080;
	Mon, 19 Jan 2026 21:09:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46DE819560AB;
	Mon, 19 Jan 2026 21:09:10 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 26/26] rv/rvgen: extract node marker string to class constant
Date: Mon, 19 Jan 2026 17:46:02 -0300
Message-ID: <20260119205601.105821-27-wander@redhat.com>
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

Add a node_marker class constant to the Automata class to replace the
hardcoded "{node" string literal used throughout the DOT file parsing
logic. This follows the existing pattern established by the init_marker
and invalid_state_str class constants in the same class.

The "{node" string is used as a marker to identify node declaration
lines in DOT files during state variable extraction and cursor
positioning. Extracting it to a named constant improves code
maintainability and makes the marker's purpose explicit.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index a6889d0c26c3f..5f23db1855cd3 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -29,6 +29,7 @@ class Automata:
 
     invalid_state_str = "INVALID_STATE"
     init_marker = "__init_"
+    node_marker = "{node"
 
     def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
@@ -76,7 +77,7 @@ class Automata:
         for cursor, line in enumerate(self.__dot_lines):
             split_line = line.split()
 
-            if len(split_line) and split_line[0] == "{node":
+            if len(split_line) and split_line[0] == self.node_marker:
                 return cursor
 
         raise AutomataError("Could not find a beginning state")
@@ -91,9 +92,9 @@ class Automata:
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
@@ -116,7 +117,7 @@ class Automata:
         # process nodes
         for line in islice(self.__dot_lines, cursor, None):
             split_line = line.split()
-            if not split_line or split_line[0] != "{node":
+            if not split_line or split_line[0] != self.node_marker:
                 break
 
             raw_state = split_line[-1]
-- 
2.52.0

