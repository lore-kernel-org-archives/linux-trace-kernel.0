Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E429D288
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856643; cv=none; b=NCT+PGISZnxF8F0qUxlKJ9I3IqrurRehN6n/zSQi6AQ4LywtSWUFqS8McBLy27pUOZPE3nGtnX24WHN/SaMVjaabFkgEbBF1SVOi4y1pDTR7sf4NH/F1x77SV1mHNSJhGmjXxJJzsFp/qRuE2ds12MnONsYv2HuUOYncCTksTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856643; c=relaxed/simple;
	bh=Sev0AxPxk+Ra1wIo2x3p+hSwngzBbfV+r9yoXlchcsk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTCiJu6ku0ZR+1hWUxjGdoBhP6N3VwwJZmKyHlKxHeTrlihPFX7/fzJxR0HUeXrU4+XLgbr/piJ+EGoWcxKnIVMcr2s07bp+VRtwLF0xzN1WsdvNp3RfctSztcGgYoR+vXGShOAbKGyBAyougWD/v9B23/B3gOzK9CW9PvuJjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGCS00/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGCS00/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHSvuXe04YeXTc67naYFod2Dxdx676n/IX7g6FD7phU=;
	b=XGCS00/T6Q/CjhTdW/FdSv2Wg8o/3frFChQRphnB6Xjk8O3qAQ4WHREOQGq2L+HwSa4RzV
	1NsiyA71amFke8FzjU6TocJKPc6l/+ihpB1RlBxYR5vg7TbZUgu6htZgksFtwZn5Z/pcD3
	3CXhUgWf+F045df7j5pAWSL9axD4W68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-cRz6FxXLN7Gi7uwh-9D9OA-1; Mon,
 19 Jan 2026 16:03:57 -0500
X-MC-Unique: cRz6FxXLN7Gi7uwh-9D9OA-1
X-Mimecast-MFC-AGG-ID: cRz6FxXLN7Gi7uwh-9D9OA_1768856636
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDBDA19560B0;
	Mon, 19 Jan 2026 21:03:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6017F1955F43;
	Mon, 19 Jan 2026 21:03:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 13/26] rv/rvgen: fix DOT file validation logic error
Date: Mon, 19 Jan 2026 17:45:49 -0300
Message-ID: <20260119205601.105821-14-wander@redhat.com>
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
---
 tools/verification/rvgen/rvgen/automata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 9e1c097ad0e4a..7841a6e70bad2 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -59,7 +59,7 @@ class Automata:
         # checking the first line:
         line = dot_lines[cursor].split()
 
-        if (line[0] != "digraph") and (line[1] != "state_automaton"):
+        if (line[0] != "digraph") or (line[1] != "state_automaton"):
             raise AutomataError(f"Not a valid .dot format: {self.__dot_path}")
         else:
             cursor += 1
-- 
2.52.0

