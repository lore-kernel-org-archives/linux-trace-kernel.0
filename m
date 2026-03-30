Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA03AEF42
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861958; cv=none; b=laM2Ps9M7f85b0Jw8QsLjLrt70SSOVgSX1R9YzbuTX+2UKHk6JseGCKuJYhEfR1jD733RBwU9jUc7qyIlb2Z59X4Ttc+VaP0V8paqwWIbI61qriE3QJR3nZ9JWYKctxaVMQtVSIMcffpWo4e3S6pjzdLxqQ9sG9p3qSNeS2QEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861958; c=relaxed/simple;
	bh=y7Q5Ib2UgBOzKCSKBQpKN/ID969aZEB5jkNSBraOAbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=MVDyOms40VQLYY5ePtFfgoTopWfCBXs+RRk9XZX5sQ0QOjnGBzX/0oPRbDYuMGsxOA2bQdxiMCE8mFWnomC2spdrOx9gY/AYLxO/kHYvtatO+T2UZ3y5Y2GzdieiXsbhugy3x5tfVNLghNfzmJTY77k75bIqE527GCXj31Bo8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByatIz7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByatIz7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774861956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aji3OuIasTbG7nwf/w5iZ+Q2tfC4MvavQKG2epUf4Ok=;
	b=ByatIz7i9VOnnonPhMtZVXhZTxC2BXMhph//dinFR1prHFsEDCYnnuj3tzpewkkMeepURL
	XIqxmvd4ht5Dalw/fTsYUEUZqIo7qZclL3emk6fINcqGzto2RxO56IUtJHr2rkkGRpHsbm
	BpROCABwLzj3olgIL4+7KHxUCOvcV/Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-Li13eHcuO-KTXiiK-by_SA-1; Mon,
 30 Mar 2026 05:12:33 -0400
X-MC-Unique: Li13eHcuO-KTXiiK-by_SA-1
X-Mimecast-MFC-AGG-ID: Li13eHcuO-KTXiiK-by_SA_1774861952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 358F919560AF;
	Mon, 30 Mar 2026 09:12:32 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3D60180075E;
	Mon, 30 Mar 2026 09:12:28 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] rtla: Fix build without libbpf header
Date: Mon, 30 Mar 2026 11:12:07 +0200
Message-ID: <20260330091207.16184-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: rW7NEM6iJwrZKzDKsO9VGU-JyKs94IIlH8NClwbHTHk_1774861952
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

rtla supports building without libbpf. However, BPF actions
patchset [1] adds an include of bpf/libbpf.h into timerlat_bpf.h,
which breaks build on systems that don't have libbpf headers
installed.

This is a leftover from a draft version of the patchset where
timerlat_bpf_set_action() (which takes a struct bpf_program * argument)
was defined in the header. timerlat_bpf.c already includes bpf/libbpf.h
via timerlat.skel.h when libbpf is present.

Remove the redundant include to fix build on systems without libbpf
headers.

[1] https://lore.kernel.org/linux-trace-kernel/20251126144205.331954-1-tglozar@redhat.com/T/

Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260329122202.65a8b575@robin/
Fixes: 8cd0f08ac72e ("rtla/timerlat: Support tail call from BPF program")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 169abeaf4363..f7c5675737fe 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -12,7 +12,6 @@ enum summary_field {
 };
 
 #ifndef __bpf__
-#include <bpf/libbpf.h>
 #ifdef HAVE_BPF_SKEL
 int timerlat_bpf_init(struct timerlat_params *params);
 int timerlat_bpf_attach(void);
-- 
2.53.0

