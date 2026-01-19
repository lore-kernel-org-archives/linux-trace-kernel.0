Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06E2F745B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856422; cv=none; b=JlaX+wyt6W4ghWE9t2As+151tzCe3uQIA0mxLUw79L0aZ7a73sPFyybYmq2iiJMr5G/Nb8OiGENuftTgHmZLaK/bKMLtLUK3skqX4pQCXi9zdaBIsVLbHdrqsQXuOc8ptA0Idca+d0IZ1UIg+mCv+LZN4x1eC6B2IHHjkFdZTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856422; c=relaxed/simple;
	bh=ywRHrFoq3RI/gRX/tSJBRYTnKKZls7HdKmG7OnKNVxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFs2PX91VQRVeeYitUTpv+TQe900Yzb3fZm0R7a+LJ7UimS1goKvpcZO06YgDQNm0TZobdKMHrCH4j3jo/fs+e+B0WlStnHQutmCj50p0KZomff1xq7aZUIjMmnuYoP9eHDaavxlNx6pW5o3qzvOzW3hmSalc4z+2qcH/z8VXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMPERq0e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMPERq0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqZNHfK8rT/x/qoAGa3l0nqLH4uXBfgeiwASt0ZjNik=;
	b=CMPERq0eCMMCPlQYC7E8IhTpfzesTFs4ahwOwOQYOZVC7Q/HQf4fjnSpX8s+mc1IHmBizn
	z2qEjdMaWiFAB0sr9e7MUfFy2xFTntxp34VGmu+Kl6j9Z2bnfzTXr313UBJyGCzAPDBEkM
	a8YhmAPfU5tN905HjtVHuCSEnMjtINA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-GmLDgP4sOJ6yG5jByqA7iw-1; Mon,
 19 Jan 2026 16:00:16 -0500
X-MC-Unique: GmLDgP4sOJ6yG5jByqA7iw-1
X-Mimecast-MFC-AGG-ID: GmLDgP4sOJ6yG5jByqA7iw_1768856415
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA2D18002C8;
	Mon, 19 Jan 2026 21:00:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65E9919560AB;
	Mon, 19 Jan 2026 21:00:12 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 04/26] rv/rvgen: replace __len__() calls with len()
Date: Mon, 19 Jan 2026 17:45:40 -0300
Message-ID: <20260119205601.105821-5-wander@redhat.com>
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

Replace all direct calls to the __len__() dunder method with the
idiomatic len() built-in function across the rvgen codebase. This
change eliminates a Python anti-pattern where dunder methods are
called directly instead of using their corresponding built-in
functions.

The changes affect nine instances across two files. In automata.py,
the empty string check is further improved by using truthiness
testing instead of explicit length comparison. In dot2c.py, all
length checks in the get_minimun_type, __get_max_strlen_of_states,
and get_aut_init_function methods now use the standard len()
function. Additionally, spacing around keyword arguments has been
corrected to follow PEP 8 guidelines.

Direct calls to dunder methods like __len__() are discouraged in
Python because they bypass the language's abstraction layer and
reduce code readability. Using len() provides the same functionality
while adhering to Python community standards and making the code more
familiar to Python developers.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py |  2 +-
 tools/verification/rvgen/rvgen/dot2c.py    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 3e24313a2eaec..ed02d0c69b410 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -42,7 +42,7 @@ class Automata:
             raise AutomataError(f"not a dot file: {self.__dot_path}")
 
         model_name = ntpath.splitext(basename)[0]
-        if model_name.__len__() == 0:
+        if not model_name:
             raise AutomataError(f"not a dot file: {self.__dot_path}")
 
         return model_name
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 78959d345c26e..0fb3617ad8ce9 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -86,14 +86,14 @@ class Dot2c(Automata):
     def get_minimun_type(self):
         min_type = "unsigned char"
 
-        if self.states.__len__() > 255:
+        if len(self.states) > 255:
             min_type = "unsigned short"
 
-        if self.states.__len__() > 65535:
+        if len(self.states) > 65535:
             min_type = "unsigned int"
 
-        if self.states.__len__() > 1000000:
-            raise AutomataError(f"Too many states: {self.states.__len__()}")
+        if len(self.states) > 1000000:
+            raise AutomataError(f"Too many states: {len(self.states)}")
 
         return min_type
 
@@ -149,12 +149,12 @@ class Dot2c(Automata):
         return buff
 
     def __get_max_strlen_of_states(self):
-        max_state_name = max(self.states, key = len).__len__()
-        return max(max_state_name, self.invalid_state_str.__len__())
+        max_state_name = len(max(self.states, key=len))
+        return max(max_state_name, len(self.invalid_state_str))
 
     def get_aut_init_function(self):
-        nr_states = self.states.__len__()
-        nr_events = self.events.__len__()
+        nr_states = len(self.states)
+        nr_events = len(self.events)
         buff = []
 
         maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
-- 
2.52.0

