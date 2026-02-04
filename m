Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A441C2E1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216774; cv=none; b=h6G7D3ruxR1Ck3UHvQR5B9O5dZxYh5OaobCJ08HH4G9i+rFufHHcfKnsIRjjifviHMdmhHHdsar2U62Su/e8JuDlZ/gAUc2SII6NBvZkIzJKcHMm9VeqyHaXF9FgNAm5mwinzmZmC91w6eBmZsmiZqbVDKLVApfHi1HR1ClRm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216774; c=relaxed/simple;
	bh=RzD5D5fXRBq5Dbj8AC1pdHSI8YInCViioqXr/ESnnCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SVk2i0u4QVPiMLSNSZQqDnnty71hv99uYW3QnKylQiB9ggthCXpsaiVpEabfYer1RzoZ4UCTCDc3eZJO4NUT2Or2P/S7lpUdGVSpdSGW2rUZOdDa7tzXdjRhDocUICPevwfP4QTaX25hPd+h2YErF7GtufvyMAgGGlAOrkrefUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJbVmhas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJbVmhas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXfGMOmVzPizwSIz/3wbC9ez+h/caatHyVW51rPHiK4=;
	b=MJbVmhasTip3KFHO67Cga0S/4TnYKivR/GXzNSCw9EOMJqCSKtc2QEfypbnoGyyhgzGk+L
	yvIQi46nKQcxyCsgKkUhn7y3b2hSe2VfpjcGwJ0LzGmVVxAbW+ysZTlaotY9+5UJd/RBzS
	DraRPTrz1M5TzDRVKlmsW62aJ5s78mM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-1jQGqCavO2-etlYfztdLiA-1; Wed,
 04 Feb 2026 09:52:50 -0500
X-MC-Unique: 1jQGqCavO2-etlYfztdLiA-1
X-Mimecast-MFC-AGG-ID: 1jQGqCavO2-etlYfztdLiA_1770216769
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F14F3180047F;
	Wed,  4 Feb 2026 14:52:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CD330001A5;
	Wed,  4 Feb 2026 14:52:46 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/20] rv/rvgen: fix DOT file validation logic error
Date: Wed,  4 Feb 2026 11:42:35 -0300
Message-ID: <20260204144914.104028-10-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: XTqOrGY3F_6BGNR55dY5Sql2GRA3sq-IdFn2e-T4RIo_1770216769
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
index deb1f09556c3c..38035d59cdd51 100644
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

