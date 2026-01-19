Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16F2F6577
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856763; cv=none; b=TDhiL/osQCdvQYDK3RVEV3zGncVhZG5IjTEWCun3XBMEpmW/UUnFtkfpIB2d8K0dinIyy+T2GFSTU6zXFcTp5EU5cjb+7KTMosbUpOUY4fsLLq+QheYu2qX5HGO5IY0xkPsLwXC7r4tfCPTXWcU/Yu7zcNjsOP7VXN/LumbxXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856763; c=relaxed/simple;
	bh=ulkyx3dFM1g81OXVdkTp9iCr+3y036Jq7Gt3gOY6cMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZT7QoRGTwlX4sgmdI6BmtN1vm06TWykLwlpYktS6BmDonVEowB8tIKb1u2YiLd69fhpCb3MoAtr2GMkgbU/wjzn04GWaMvG4byQCOwDJzWAnaaAvnKLmfj3T5zub1ZBPKfKh3Bi6+Mkc8655VOEZ92ao9SOHGuFK5eKnUoL3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk0/7OEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk0/7OEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w36A691xcoG0dFs107/UAjpDXJJuV8dxC4+rej1wdBE=;
	b=Sk0/7OELNjBiGSJNPGlalniX+FnoH6jubGL4ZzUHv3ae2lHASsSMCchmS0nP+P8fk5rR2g
	sxGtI3VWxpDaYqYOQKQ+0X1xNB0nqiAN8gmghXNnqHFr9ZO6IYqP4rTkEDQUtP041f/4qd
	RiKXxj/jtYT8PUqMYFgf3NLjinqe66s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-IoJZV2SQPe6cMEodh-boww-1; Mon,
 19 Jan 2026 16:05:57 -0500
X-MC-Unique: IoJZV2SQPe6cMEodh-boww-1
X-Mimecast-MFC-AGG-ID: IoJZV2SQPe6cMEodh-boww_1768856757
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4DC618005BA;
	Mon, 19 Jan 2026 21:05:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AD5119560AB;
	Mon, 19 Jan 2026 21:05:54 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to ltl2k
Date: Mon, 19 Jan 2026 17:45:54 -0300
Message-ID: <20260119205601.105821-19-wander@redhat.com>
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

The ltl2k class inherits from Monitor which requires subclasses to
implement fill_tracepoint_args_skel(). However, the ltl2k template
uses hardcoded tracepoint arguments rather than the placeholders that
this method would fill. The base class fill_trace_h() method calls
fill_tracepoint_args_skel() unconditionally, which was exposed when
the @not_implemented decorator was introduced.

Add a stub implementation that returns an empty string. Since the
ltl2k trace.h template does not contain the placeholder strings that
would be replaced, the empty return value has no effect on the
generated output while satisfying the base class interface contract.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index 94dc64af1716d..f1eafc16c754b 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -257,6 +257,9 @@ class ltl2k(generator.Monitor):
 
         return '\n'.join(buf)
 
+    def fill_tracepoint_args_skel(self, tp_type) -> str:
+        return ""
+
     def fill_monitor_class_type(self):
         return "LTL_MON_EVENTS_ID"
 
-- 
2.52.0

