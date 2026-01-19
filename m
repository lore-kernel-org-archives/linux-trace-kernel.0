Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D02D780A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856665; cv=none; b=YpW56OMNVLL+S0o+5VSKV39s3sM9Msk0pZKL6PYblbOgt92U34panbrq5JjvrZnVhTI/jcqs+sjqYLlVv6uU4kQC0W+eyHOzjy/HihLiRN1JVhOOicZZbqSjbxrM/pkM2ebbf/MzV/T5XF8r6UJYIKgTupK5NVG/KC3h/1rqJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856665; c=relaxed/simple;
	bh=m9SgkT9h440yDgM1IFR3W05ovIC3RTHv6DSomoxtF6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6nUjAjNHtJRTHSXPWkzfvQZH35+Z2WfUJn5wzfH9imRdSbEuAfPWIox3r/pQkZr/CRX1jz1ucYIDW7LgBZx/RskoCsHukXCi3IHEWDfSfvAPdSD/gZ+U7sktbm6DfJxXQExufLoPlqZQ4yL8otnUqLQqRUj0aeyXSlTERUIDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmPgf8dj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmPgf8dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30iPcyx/O8od5igxVL7D4WfM9SXUj78edNZ/Hh8l0iU=;
	b=OmPgf8djfV2c7bvIoyFQqt15UtTaxRCqs6UyVvYlCNjWmE8w/zkfag5J/16nZPASIlABZq
	hMdv89KvI8f1wmYdL/oiI+UacZvRmxUPCCDldePLFPGdzguRsnA7QVgDFD1vOCSkvzgvjH
	GqUrUrSQrNasOWfqgLsUZH2s5g8xAng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-YVv8qnjTOS6Z50DaGdaPMw-1; Mon,
 19 Jan 2026 16:04:21 -0500
X-MC-Unique: YVv8qnjTOS6Z50DaGdaPMw-1
X-Mimecast-MFC-AGG-ID: YVv8qnjTOS6Z50DaGdaPMw_1768856660
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECCD11954B06;
	Mon, 19 Jan 2026 21:04:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E34B19560AB;
	Mon, 19 Jan 2026 21:04:17 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 14/26] rv/rvgen: remove redundant initial_state removal
Date: Mon, 19 Jan 2026 17:45:50 -0300
Message-ID: <20260119205601.105821-15-wander@redhat.com>
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

Remove an unnecessary and incorrect list removal operation in the
automata state variable processing. The code attempted to remove
initial_state from the states list, but this element was never
added to the list in the first place. States with the __init_
prefix are explicitly excluded from the states list during the
parsing loop, with only the initial_state variable being set
from them.

Calling remove() on an element that does not exist in a list
raises a ValueError. This code would have failed during execution
when processing any DOT file containing an initial state marker.
The subsequent insert operation at index 0 correctly adds the
initial_state to the beginning of the states list, making the
removal operation both incorrect and redundant.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 7841a6e70bad2..b302af3e5133e 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -111,7 +111,6 @@ class Automata:
             cursor += 1
 
         states = sorted(set(states))
-        states.remove(initial_state)
 
         # Insert the initial state at the beginning of the states
         states.insert(0, initial_state)
-- 
2.52.0

