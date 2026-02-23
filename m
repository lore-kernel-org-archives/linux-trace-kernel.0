Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF0310651
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864100; cv=none; b=QlseX9wWzyIQmw6984bOkrJRcZ0JgH/CS4/0o4CQuSc20RpILnvAvseEeUwSDVoYu5JQODOyc75n5n1Ez1QRzP9zU4o5at7b9+ZfnwfEpRwzvF3HyYuRECFi0MbPN6LfEyuNIYPT7Ar+eSRF2stE0FsYWMlHrl0SR/rPDtFSLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864100; c=relaxed/simple;
	bh=CQ8+qfz2sCZDuJ/AwN5KOiHhqxqCx7uNoqRGLi3yT0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JexRnTIZetX+x95YbD0NEFvolkb8b96j1PJ0vY5ZVQnn3lnqmp+GHukH8eYLsN0bIgisR7NORbvADiudbiChylYI59h1sGNfZTm6Ikiv9K3howR93WJGWjiO72XGjyz2tznuJ+x1xk+H3hNBeSc9/jfsrEdX/pvVf2QwhnzEFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOTLc3uY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOTLc3uY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MpwDsN2zeO6ezJv8SGR7mHck7dW4y6GEUXw6asn0Ng=;
	b=hOTLc3uYQ+qZrLbuRoYafYd675porA4f0NLV0n4zM3nfoXjbl/pKIuLCObn2evBMHbVTvK
	1PUyt0qUmqzdgmIx27OlKQQ0pHb0sBdlDz+NeFc59RfIWiE+yBjtyOHxTh99fXcLBCt3TD
	HZ9DR3uN02QMfzxPU99S3j7BSXdAkXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-T-KqSGAfNE6aN4wdMYNzDA-1; Mon,
 23 Feb 2026 11:28:11 -0500
X-MC-Unique: T-KqSGAfNE6aN4wdMYNzDA-1
X-Mimecast-MFC-AGG-ID: T-KqSGAfNE6aN4wdMYNzDA_1771864090
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75402195605A;
	Mon, 23 Feb 2026 16:28:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3186D1800370;
	Mon, 23 Feb 2026 16:28:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 09/19] rv/rvgen: fix DOT file validation logic error
Date: Mon, 23 Feb 2026 13:17:52 -0300
Message-ID: <20260223162407.147003-10-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: YQK-NEUNcTTiHNPvjr9G_oRmPLacQPoeTk0hPShkvh0_1771864090
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix incorrect boolean logic in automata DOT file format validation
that allowed malformed files to pass undetected. The previous
implementation used a logical AND operator where OR was required,
causing the validation to only reject files when both the first
token was not "digraph" AND the second token was not
"state_automaton". This meant a file starting with "digraph" but
having an incorrect second token would incorrectly pass validation.

The corrected logic properly rejects DOT files where either the
first token is not "digraph" or the second token is not
"state_automaton", ensuring that only properly formatted automaton
definition files are accepted for processing. Without this fix,
invalid DOT files could cause downstream parsing failures or
generate incorrect C code for runtime verification monitors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index e54486c69a191..e4c0335cd0fba 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -99,7 +99,7 @@ class Automata:
         # checking the first line:
         line = dot_lines[cursor].split()
 
-        if (line[0] != "digraph") and (line[1] != "state_automaton"):
+        if (line[0] != "digraph") or (line[1] != "state_automaton"):
             raise AutomataError(f"Not a valid .dot format: {self.__dot_path}")
         else:
             cursor += 1
-- 
2.53.0

