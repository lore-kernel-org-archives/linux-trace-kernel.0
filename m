Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F8281530
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216670; cv=none; b=tNisfspZXc9x9sp2U0o/+sSMpCuqI0Ki1QvyXBoOcb618z+vJ6upNqbVXk7eEzx+iwRONfZZh3ffyBk+EjX2ihL08ZOB7egKFCpDqYGvahwGAx4HJFNV8okXjQmn1OsEoC7z42B0d16HdTj4oMRE0xd/O7aKNkCyYk2uqQe9SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216670; c=relaxed/simple;
	bh=9c4O8Mdm+ewS4xkU8uOqSlYRYgEjTA8B0nGZ//Zuabc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qBCuTsEiiSMP7UrM7FsBgR02ecUaMCU5DTslJXv6aDT+Gr2HbbH9CaDau6H5WFxKWRitvmaqpRyUFlmKrAOwadTSzGcU3vgaRZdEtKoJCVqV4MYfxzy+8QT9OkpDS4HxWEhJGWu6tvr+l3reXPPPg1ekSN7LRDoUbH5lTALtApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGJy8eLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGJy8eLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sJU2RJB3KUNxhCCTIsG7NiQCqE4cV2jotMaoDK+oRk=;
	b=QGJy8eLF3QcVl3UOmYuF2RAWt2Mdb12sp5lF/6G9GTyN+yVMVpng8HdfhA7hqfOV1nl0fM
	HRACqhGXBufDIVPnTafebZVg6KrAEGkOejqJorncwkrtfujpLLngtgkyrZpPUFCnQj6DtE
	lIMdWatXkVB+M/oAKKsmAxwWIHn3SwY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-6akKEpkxPhusFHdnBJFHrw-1; Wed,
 04 Feb 2026 09:51:06 -0500
X-MC-Unique: 6akKEpkxPhusFHdnBJFHrw-1
X-Mimecast-MFC-AGG-ID: 6akKEpkxPhusFHdnBJFHrw_1770216665
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F8BC1956094;
	Wed,  4 Feb 2026 14:51:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C193A30001BC;
	Wed,  4 Feb 2026 14:51:02 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/20] rv/rvgen: replace __len__() calls with len()
Date: Wed,  4 Feb 2026 11:42:30 -0300
Message-ID: <20260204144914.104028-5-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: JIZo9ZGWzxx7FHgVYpenTWsEE6L41bUYWcME8kvk5rY_1770216665
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py |  2 +-
 tools/verification/rvgen/rvgen/dot2c.py    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index bd8c04526be3a..07ae81e9a49fa 100644
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
index 6a2ad4fbf7824..b3a49779d4cc5 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -64,14 +64,14 @@ class Dot2c(Automata):
     def get_minimun_type(self) -> str:
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
 
@@ -114,12 +114,12 @@ class Dot2c(Automata):
         return buff
 
     def __get_max_strlen_of_states(self) -> int:
-        max_state_name = max(self.states, key = len).__len__()
-        return max(max_state_name, self.invalid_state_str.__len__())
+        max_state_name = len(max(self.states, key=len))
+        return max(max_state_name, len(self.invalid_state_str))
 
     def get_aut_init_function(self) -> str:
-        nr_states = self.states.__len__()
-        nr_events = self.events.__len__()
+        nr_states = len(self.states)
+        nr_events = len(self.events)
         buff = []
 
         maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
-- 
2.52.0

