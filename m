Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA521D590
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567192; cv=none; b=gd/zHI07X5aRqwXqbKx7rSXnB24TdjPXqXXlPJHcXDr9aIUsMDHBZoeVpWHX1lU1b36mm6haD2TEMc7jmqxn1+xmzFjAcDz/RLHgu1E+xrQH6ttE+pbS02C4ylsAOhUz6PGrZ0cMFx5oaOoVtnxyJ4m8YZiWZt/UOIzaqpEDSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567192; c=relaxed/simple;
	bh=Hp1UUc//HkW6+lKEgtSCyi+d4ZcTEwDVx10LTVXpvzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLkt75gSF9qDC5MQ9Rg4noE4rgZRcO80z78Y8OSsClbQZsiqkfzV8nvIvO/rvL22iTeHLcBUKzo/kZwbN5xKg/YFqHxoR9nw5b8R/CMyxPNK1CjAaa88jBJ/XFY3O/+f/cLsHL//jDuVcNx/w2Z6pEqjtU0XrA8OXCxoz4V9wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g265yFxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g265yFxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqglkPDvlxAEmEtclUgwCg2/uHzDAdN41CTr/RpBOsc=;
	b=g265yFxV8m7a3I2KBIs3HOv8rXm7TfyVFxAchhYadB1WwJ1Zwe8LofixwSeyuvWhSLdcjM
	IV3Ydajg0kOmInNIyUboYtki/v1Ik4psIqwI2OJO7R54VWBPuIPhEdS0+dZB+fjtCmkdrY
	+j2UXsyeISaSz/dz3jY1LYztLx6vqoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-xLpAehZBM26XL_7JKQKz9w-1; Fri,
 16 Jan 2026 07:39:42 -0500
X-MC-Unique: xLpAehZBM26XL_7JKQKz9w-1
X-Mimecast-MFC-AGG-ID: xLpAehZBM26XL_7JKQKz9w_1768567181
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFFF6180044D;
	Fri, 16 Jan 2026 12:39:41 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D4B71955F22;
	Fri, 16 Jan 2026 12:39:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 03/15] verification/rvgen: Allow spaces in and events strings
Date: Fri, 16 Jan 2026 13:38:59 +0100
Message-ID: <20260116123911.130300-4-gmonaco@redhat.com>
In-Reply-To: <20260116123911.130300-1-gmonaco@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently the automata parser assumes event strings don't have any
space, this stands true for event names, but can be a wrong assumption
if we want to store other information in the event strings (e.g.
constraints for hybrid automata).

Adapt the parser logic to allow spaces in the event strings.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 3f06aef8d4fd..977ba859c34e 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -127,14 +127,13 @@ class Automata:
             #  ------------ event is here ------------^^^^^
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                event = line[-2].replace('"','')
+                event = "".join(line[line.index("label")+2:-1]).replace('"','')
 
                 # when a transition has more than one lables, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
-                event = event.replace("\\n", " ")
-                for i in event.split():
+                for i in event.split("\\n"):
                     events.append(i)
             cursor += 1
 
@@ -167,8 +166,8 @@ class Automata:
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')
                 dest_state = line[2].replace('"','').replace(',','_')
-                possible_events = line[-2].replace('"','').replace("\\n", " ")
-                for event in possible_events.split():
+                possible_events = "".join(line[line.index("label")+2:-1]).replace('"','')
+                for event in possible_events.split("\\n"):
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             cursor += 1
 
-- 
2.52.0

