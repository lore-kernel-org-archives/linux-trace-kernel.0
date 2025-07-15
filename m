Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE526FA4C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563712; cv=none; b=RLnZsDLnYmnpKNTnFiq/IXJd+cRMDPWmPkP9mdW8DUL/ahl7oetKDHs4Wbao59+F+YF5khfFtPbbwozojum77maDzLmJZucF2+if7BRQhvcLgwm+pyiyyv41rfILyYVRM13mE4K5NqQosEg7RlLDfPD2g0W7ATMshV7s1dKNTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563712; c=relaxed/simple;
	bh=yWiUq8fghZDhX5ma9boL3BXbQhkeBz7R0cP557CB3fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svpsXJ4clsS5vUj5dA+vV3wUFdbkLun8iYIsL4UhpTT+fFOfRFUhYiFUGpowQZNJA89tbS2mZKw1+/bz2t4G+sHQBSPvEtIA6N+2sWZrFaWAUmj3zc0RSIYa2Su769eAjOa5243se5mqIOnTaLrPqT1beM334oiXRkFrmBWGwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrrYjjHW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrrYjjHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltwOXqFjqgE+HbNtjGzELCnivw3kypC1AN2XcT9IjAE=;
	b=VrrYjjHWBX5ERkYANIpIcWlPBOKNkp6g08TUdmksZaKvtq5XShmRg3h3b+lZtKIPyEUodg
	J3ewQTiRB0EDj/9bgNKiDiiHqMd/mqOTgfhlXc8jc/TiGK7OxaostWWrkfkH/jnDFBXvVi
	4D7CRkQwjitwgYuHz93d5NJ8BqN8uSE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Aj74G9O4Nk-d2qmeGl_PSg-1; Tue,
 15 Jul 2025 03:15:06 -0400
X-MC-Unique: Aj74G9O4Nk-d2qmeGl_PSg-1
X-Mimecast-MFC-AGG-ID: Aj74G9O4Nk-d2qmeGl_PSg_1752563705
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8950180034E;
	Tue, 15 Jul 2025 07:15:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CCF818046C3;
	Tue, 15 Jul 2025 07:14:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 02/17] tools/rv: Stop gracefully also on SIGTERM
Date: Tue, 15 Jul 2025 09:14:19 +0200
Message-ID: <20250715071434.22508-3-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently the userspace RV tool starts a monitor and waits for the user
to press Ctrl-C (SIGINT) to terminate and stop the monitor.
This doesn't account for a scenario where a user starts RV in background
and simply kills it (SIGTERM unless the user specifies differently).
E.g.:
 # rv mon wip &
 # kill %

Would terminate RV without stopping the monitor and next RV executions
won't start correctly.

Register the signal handler used for SIGINT also to SIGTERM.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 239de054d1e06..b8fe24a87d97c 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -191,6 +191,7 @@ int main(int argc, char **argv)
 		 * and exit.
 		 */
 		signal(SIGINT, stop_rv);
+		signal(SIGTERM, stop_rv);
 
 		rv_mon(argc - 1, &argv[1]);
 	}
-- 
2.50.1

