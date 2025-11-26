Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616E307494
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168166; cv=none; b=HxkGbPgmBjD9MENjvdv1Pfv70KcCiSNWxbn6S4NljeqMlQW7RQhGDwpHL+k/FGP2i1Ic3KXehjc2xWkVk0qhnchemoUhLoRR+LlXFuehoWQXTqtijUb8IzhjhOaO5CUUVyBT78gL7AK+Mj35Fe+xkDqpyeKyN+aIlTD816hs5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168166; c=relaxed/simple;
	bh=ZKUirnE+FdztIlMmCkueMs0Stkl49w0k12IORjr//HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTaIp0As+fcDaCAKZYeyiSCOJf6igx5NLARJSyhPmxs+COUgj8/dCTiBZA1e07HTbWEDKzf5n6nnGHIhkCAABfbbH639yqAbGha4BXvAQX5H5o7kkP0YyO49OIG9qGys+yPmO3hso+rqzvuCT7Md0gmwyYIxOSW9rOMj0x1R6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESQhPINM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESQhPINM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvzjNIyZOh7C1mDpRJpCLf4ka/AuEmYqm5zggI1KnzA=;
	b=ESQhPINM4y3XHg8epHrqYT0kVLutB0h5Ah4SET8gN5y5rUJMdAVxciDCHO5d6apmPXNiHr
	xZ9m9bNqveT9yUEiHelS2Nb+rk2EMQb9wQrIEX8r7rOc0v3JQLUBctTmwZPzrzRE7qFLNf
	D0ef5K4H6RPxVDjoCWGmjeLkf8gD9qU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-CrcYHruxPwu2oGc7vq-xcQ-1; Wed,
 26 Nov 2025 09:42:40 -0500
X-MC-Unique: CrcYHruxPwu2oGc7vq-xcQ-1
X-Mimecast-MFC-AGG-ID: CrcYHruxPwu2oGc7vq-xcQ_1764168159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7364E19560A1;
	Wed, 26 Nov 2025 14:42:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48F0230044DC;
	Wed, 26 Nov 2025 14:42:35 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 5/7] rtla/tests: Run Test::Harness in verbose mode
Date: Wed, 26 Nov 2025 15:42:03 +0100
Message-ID: <20251126144205.331954-6-tglozar@redhat.com>
In-Reply-To: <20251126144205.331954-1-tglozar@redhat.com>
References: <20251126144205.331954-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add -v flag to prove command to also print the names of tests that
succeeded, not only those that failed, to allow easier debugging of the
test suite.

Also, drop printing the option and value to stdout in
check_with_osnoise_options, which was a debugging print that was
accidentally left in the final commit, and which would be otherwise now
visible in make check output, as stdout is no longer suppressed.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/Makefile        | 2 +-
 tools/tracing/rtla/tests/engine.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index aef814b639b7..2701256abaf3 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -110,6 +110,6 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
 check: $(RTLA) tests/bpf/bpf_action_map.o
-	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
+	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f -v tests/
 examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index c7de3d6ed6a8..ed261e07c6d9 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -105,7 +105,6 @@ check_with_osnoise_options() {
 			[ "$1" == "" ] && continue
 			option=$(echo $1 | cut -d '=' -f 1)
 			value=$(echo $1 | cut -d '=' -f 2)
-			echo "option: $option, value: $value"
 			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
 		done
 	fi
-- 
2.51.1

