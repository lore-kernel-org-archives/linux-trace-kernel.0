Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8564218A4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216940; cv=none; b=uC/eBrCoB0Y0/v+LcC3HnmXlu7WMwb+mp+eknU7uPzSdXjVAHr34reP9zBE5wfTdBujdt4XtDKdMV3DVXSzgOl2BqQmmARKRFEyKnjak0xChFS0nLHfzo57SflL/cumjP5tllwO8MVPyTYWBG2kK5H/UBBu1Z8FEUXPfypf/Kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216940; c=relaxed/simple;
	bh=KVa8VWvbhQKvIriopPHHlNR0vTBDZhyOsZUnhGC72wA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mvJQjbVxoQoqm5lMHxKBQzsqvB48zbwfCfsJXYoXXp+kiHEd8SHrqwPEwCUqZtdi0J5T1we+ht0tDQzf4cDtBZgaMfF9ehS7TYUcq+G8sG4obgO28SXVPgPamikv04xjd60KN1+0IELIgL5R9JyTb27aUv0NfFKEacEhwOteC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKuDr2Rf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKuDr2Rf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oc96eGDWBd34YoQhzQwIqlhjlF2jy/e1m69Oi5R+l4=;
	b=YKuDr2Rfy/YFTmlc8lz9LjS3s9AK4rnf15kswrfop3upKcU5YGxQMkjUJxBeBOeNnGXL9V
	Eb2O/Ju+sR5MXJwNrCitFcO5XzKmD1jKwkQYI6eEW4+dO7ESEa3CVWvgcZRNr8+IsTwdxV
	e8ajFbEGyEj7KUlsn7zfCuaeyPw/X3A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-SYGxsOCAPFyTZOxB7DJZXQ-1; Wed,
 04 Feb 2026 09:55:34 -0500
X-MC-Unique: SYGxsOCAPFyTZOxB7DJZXQ-1
X-Mimecast-MFC-AGG-ID: SYGxsOCAPFyTZOxB7DJZXQ_1770216933
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 675511956070;
	Wed,  4 Feb 2026 14:55:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E425130001A5;
	Wed,  4 Feb 2026 14:55:30 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 17/20] rv/rvgen: enforce presence of initial state
Date: Wed,  4 Feb 2026 11:42:43 -0300
Message-ID: <20260204144914.104028-18-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: duGAU_oSsUDkV82uR90sTizJfXGdyUHGMG-PTx87fIA_1770216933
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The __get_state_variables() method parses DOT files to identify the
automaton's initial state. If the input file lacks a node with the
required initialization prefix, the initial_state variable is referenced
before assignment, causing an UnboundLocalError or a generic error
during the state removal step.

Initialize the variable explicitly and validate that a start node was
found after parsing. Raise a descriptive AutomataError if the definition
is missing to improve debugging and ensure the automaton is valid.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 270a3d0bf4ce7..cf82f04dbc661 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -105,6 +105,7 @@ class Automata:
         # wait for node declaration
         states = []
         final_states = []
+        initial_state = ""
 
         has_final_states = False
         cursor = self.__get_cursor_begin_states()
@@ -131,6 +132,9 @@ class Automata:
                     final_states.append(state)
                     has_final_states = True
 
+        if not initial_state:
+            raise AutomataError("The automaton doesn't have an initial state")
+
         states = sorted(set(states))
         states.remove(initial_state)
 
-- 
2.52.0

