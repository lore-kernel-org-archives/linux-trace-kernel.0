Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7418309F17
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576545; cv=none; b=bT5j+CuNBE+l/rWaaSzoTYR6Y1S0traZHzcQ2dqDGKX438z/ZXUrAQt5Sg+JRuq0peAZBNy+/NdGVn9KS4dyRHiZqFJ1fw6rf9HFnSqt+wOlvOIHpZD/Huh0yYjX/DwFAmLOQbF9SIkDzEk8jxMueLGwYkgqB8ABjaCdkTq4pXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576545; c=relaxed/simple;
	bh=YMf+9R/PB7Rn/nSanJ1qN6xwBpW1JxcXcqf/9NeCKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl7SXH5bzkf03O77gfuquZTCJHXTPp8Fm4YgVBTj4ndykKzThOi7SSiZZ7lEOTpJPeYdkucgGl/MrV1YlPIYEwCO6JXhW1y+lnjIumLXJAnC7CNYyTV9BYQ3tYV2mUZgZQ1ascwg5QosofcbIaU5cSZ5rQCOsJCQmjyqSMkMiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhJ+82Nb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhJ+82Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSN84v7pXU4iL2XOp2r81stsd6YXOv55W/nDN5c8mgU=;
	b=PhJ+82NbFhAZ7TdSIxizIQ0KRbsQSaa2LfZlhhxzW90aE/qe8v2GDsQbQCMSDYFwOB/Vv1
	5CC/qhvou5fXsFe1rbTljNNfb3Qt2GZ66M903HVxjLZQv5fVw2gacsjB4gCcB6TOoBIERS
	c3ijOmUnsHx8MTwlHRn0X4ytpAdaMAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-0k8VIRHROMutYg2ed3q6Aw-1; Mon,
 27 Oct 2025 10:48:58 -0400
X-MC-Unique: 0k8VIRHROMutYg2ed3q6Aw-1
X-Mimecast-MFC-AGG-ID: 0k8VIRHROMutYg2ed3q6Aw_1761576537
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EA3B1809A03;
	Mon, 27 Oct 2025 14:48:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E58611955F1B;
	Mon, 27 Oct 2025 14:48:53 +0000 (UTC)
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
Subject: [PATCH v2 5/7] rtla/tests: Run Test::Harness in verbose mode
Date: Mon, 27 Oct 2025 15:48:17 +0100
Message-ID: <20251027144819.1034041-6-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-1-tglozar@redhat.com>
References: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add -v flag to prove command to also print the names of tests that
succeeded, not only those that failed, to allow easier debugging of the
test suite.

Also, drop printing the option and value to stdout in
check_with_osnoise_options, which was a debugging print that was
accidentally left in the final commit, and which would be otherwise now
visible in make check output, as stdout is no longer suppressed.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.51.0

