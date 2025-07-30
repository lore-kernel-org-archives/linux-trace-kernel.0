Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D6293B4F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875067; cv=none; b=IsSiD/8D2NmRLEaVZLhNmfT5VmcVXYXGxjcLMvWjX5W+e+jGX6beUh6gFcBZQRNw+OwPr24q0qDlGTafTSKCrItRdAdU8GmdRC2q457cn5jjUH38LIju+QqFBVOdbQPomgAGbvssbp8B61/RocC0TIqcrx4WNBSEU46uB5b6WAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875067; c=relaxed/simple;
	bh=hAlHxZgp123abcDlCAe4hLooeK+QSEHWh7S7DenqCZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4pWDZlWMT02cwENPo6wzpHe1P9Kjcu/sCPLZL1MB5Ut5LTFWz7h2t8F74pmCeeZIBNmm34DdIhCbYggN/FAdtHO8G2gpAbv90cMba/EXwTvPW/4wdqoFbNfJpa31SY4MhrSfLnNlHd8ziwjWgJk3Mtkp/SkQeNOlwsofJttSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZ3CRW5q; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZ3CRW5q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753875061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyRW6+jgu8v2tPvU9GwSnYS/RWU/00H/0M7Q5DWKSUg=;
	b=IZ3CRW5ql5W1SFHbme8rf+aD0MUNBIrpKDdtgC2AONQrU/0nE0JzV3tHk/2L6H7HdR99OB
	hE+tF7yqhR7aIahcfLNXEbfLzRZ59nrohZLVQvClX8dFbOICIaYE1ugAXmPqU6SnXJAyTl
	Ho0smwdIbEnXLBoE+q0gUb0JiTZVENA=
From: Tao Chen <chen.dylane@linux.dev>
To: rostedt@goodmis.org,
	bristot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 2/2] rtla: Check pkg-config install
Date: Wed, 30 Jul 2025 19:30:28 +0800
Message-ID: <20250730113028.1666038-2-chen.dylane@linux.dev>
In-Reply-To: <20250730113028.1666038-1-chen.dylane@linux.dev>
References: <20250730113028.1666038-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The tool pkg-config used to check libtraceevent and libtracefs, if not
installed, it will report the libs not found, even though they have
already been installed.

Before:
libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

After:
Makefile.config:10: *** Error: pkg-config needed by libtraceevent/libtracefs is missing
on this system, please install it.

Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/tracing/rtla/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f2231d8d626..07ff5e8f3006 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.6
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
-- 
2.48.1

