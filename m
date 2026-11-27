Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779792;
	b=JFQ4fuiPH2RmLdZWw992RMVORVAQwPfx8/HXEbf+6drB3VdcV4AVkHEUD+qI8lWogi3L
	 AM3C5kva9fF6F49bjW6DvRs8JKWJ3cX+L+Smdn6SIr3h9jNcYdJqGI7tB6uG2mX1FBlps
	 iEyM1zoxoOBPK8KzqJeQFkjcuJWEOLtDAahNc8Y1w1/468+N+iEQgyoczwa78diQrO/ev
	 ZnDRq7/QR4Yq11pslyU6JswwYI4rtLhnT3MrlrKyRr6KP3t4vcl2nI0zUY/ER2uN2ckjH
	 qh0VLhf1qR14iwIOJygaqOS0j5tp1zuIAAOsVd56wsxtlbygnDhTcXinerhbjsFNvsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779792;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=YIvr+YErCcfP3XwbZJzx8QnN+Ul5xaS5/fCyy/OSZow=;
	b=gVN722t6qPRK7NBxw6ed6XxcKzogF7oZ4GFMpL6l2RYVcscrrpbQVoMFhQ/V08yNEpdY
	 byk2ht1EGuxrXtmrEmKAubHbZade1Ok+0gRN/DjhAA85+Ab+TmpOOGGWvtCg9Z3d62hwn
	 qMDf9zvAAiScz8i6lBK+nhEOBY/nwjZPaRs6Pe2lx8ikkPjH+zZKaV9Haa2Lrlzpe6xN3
	 8qEJ7E0MuOVjjvrTJ96ofnj+qvnrvr9vGvM3FWqtFnxK2DFk/+kaCU/5OExTjQHWoQJBg
	 qWsl/OuH9wR9QEAs/poDwBjdyVMiNBPhpSjBaFgzHIAg7Jgf5HZ6sGs6x707HefbxYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Im9VscMj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68041606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 11:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68041606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Im9VscMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795779791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIvr+YErCcfP3XwbZJzx8QnN+Ul5xaS5/fCyy/OSZow=;
	b=Im9VscMjVL4xZBMLN9vo8PvALA9wp9hHO7Z02zHSjb8uGg8HCjkntuFl6vnUA1BypoxoZo
	Rlt5bFoIE6iczviRkfOPkjiSBVz+FA2KAo6AwCWBexK0lbpKoeic5kvTQRsxMpo1M5Sciu
	j9SIWkz5g7PN9uP7Bak1J8uUArVzxvk=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-SX6_ejFVP26IfouzolT3yQ-1; Fri,
 27 Nov 2026 11:43:08 +0000
X-MC-Unique: SX6_ejFVP26IfouzolT3yQ-1
X-Mimecast-MFC-AGG-ID: SX6_ejFVP26IfouzolT3yQ_1795779788
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F19921955F45;
	Fri, 27 Nov 2026 11:43:07 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E830C589;
	Fri, 27 Nov 2026 11:43:05 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 2/2] rtla/tests: Test --aa-only with actions
Date: Fri, 27 Nov 2026 12:32:19 +0100
Message-ID: <20261127113219.86220-2-tglozar@redhat.com>
In-Reply-To: <20261127113219.86220-1-tglozar@redhat.com>
References: <20261127113219.86220-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8YEaJ9Gptt9Z38ezWT6puwjgGLKAUCoe9G7UUVl5gbY_1795779788
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a runtime test that verifies that actions trigger with rtla timerlat
top --aa-only in both BPF and tracefs mode.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 1d317c851a0fa..aab026ead6c55 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -138,6 +138,8 @@ check_top_hist "with trace output at end" \
 	"timerlat TOOL -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check_top_q_hist "action with no threshold" \
 	"timerlat TOOL -d 1s --on-threshold shell,command='echo BAD'" 0 "" "BAD"
+check "action with --aa-only" \
+	"timerlat top --aa-only 1 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
 
 # BPF action program tests
 if [ "$option" -eq 0 ]
-- 
2.56.1

