Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C437E5E5
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271419; cv=none; b=Vx4790V4FAEfKv5fLveCWCPDwipM8aySJ9wf2IbJTpT3k0ni4+X0gNnLtRgi7hfTUZrbcPCYwD/KsRuoS064dncXZCp70Y4DPJjhrLj/PACA1Efl9mRBBeeoC641NE0Pt+Jx7Mux9h4vbilUzyU5uH3LVmlfcighSRHsehkuWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271419; c=relaxed/simple;
	bh=YdyDvE3tN60IKzKfKyZI9bbbKb+LrCKA/IsBMvtv8gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJgStsTOPB4Ls7ALxpHUo3qrt9wy8NnnEY6kI5h4XQMZRHo9n9BcooJ1H2DPpkOiZ4XSS0BPwUCOze3x7bCK+HxpYYce414aF45Np60b3neOWOj+2H4aLdGnw+URYQALfqKgYme1dX7Qb8BwI0GzvLNJk6oAksLPtwXCd3C2JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QN3PvCMk; arc=none smtp.client-ip=95.215.58.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QN3PvCMk"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YdyDvE3tN60IKzKfKyZI9bbbKb+LrCKA/IsBMvtv8gM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788271415; v=1; x=1788876215;
 b=QN3PvCMkOmsnmsmxBsIxKWh1MLXPGkcc3sbyM9io/bH23fIOXCRcUoS72aabrWAeWufWz+FK
 7N231+KncTNWxFC9NEuJvZwrdGoI9JhYQGm8cHp7cJ4u75pbpU2k5jYkV1Q4eUV5j4Tn2TLmHHq
 MW9MXItXe5+ge8aOxCstOfto=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef121039728df9a3;
	Tue, 01 Sep 2026 14:03:34 +0000
X-Mizu-Trace-ID: ef121039728df9a3
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Quentin Perret <qperret@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	Fuad Tabba <fuad.tabba@linux.dev>
Subject: [PATCH v4 01/11] tracing: Include linux/types.h in trace_remote_event.h
Date: Tue,  1 Sep 2026 15:03:16 +0100
Message-Id: <20260901140326.3812068-2-fuad.tabba@linux.dev>
In-Reply-To: <20260901140326.3812068-1-fuad.tabba@linux.dev>
References: <20260901140326.3812068-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_remote_event.h uses bool without including linux/types.h, so a
translation unit that includes it ahead of anything else that pulls
types.h in fails to build, as with nvhe/trace.h at EL2.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/trace_remote_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
index c8ae1e1f5e721..e4cc2d4497bcf 100644
--- a/include/linux/trace_remote_event.h
+++ b/include/linux/trace_remote_event.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_TRACE_REMOTE_EVENTS_H
 #define _LINUX_TRACE_REMOTE_EVENTS_H
 
+#include <linux/types.h>
+
 struct trace_remote;
 struct trace_event_fields;
 struct trace_seq;
-- 
2.39.5

