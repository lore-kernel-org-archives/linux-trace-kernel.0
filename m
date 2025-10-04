Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CD25C818
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621846; cv=none; b=pAXxuXPrbN/gF+h1A7wTiAgQVscWE8sHJoICuaXOfAjZCwnh9Hl07Q6RCb9EPYNl6iL4Cbe6ojsWLnt6SkohUex2C37aKeoeYbIELmzjpQ1SMxDiajphbPpz7X+I14slzPpHcxCKp92KacVIImUgE+T/u8C8Y/Gzh4/caHTvogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621846; c=relaxed/simple;
	bh=PwSbstcnj8nUvIHNmAbBLq7n/u1XUkkYoyy8GQo7W84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llXqmm+QqP2aDQn/L1g34RCQXaOv9mdXeXTprAOPpVH6LH4D3igJesinfRAuYjOQrtmPme89z9D7UnbaGLbcDvqnxBRnsg2MxMb2D7IbEx1FN7H13UODikvCg6Ke33v+5XyimIwvaI2u6l2NQ4lS5nwJXXGMHDUVbC1rxBf9mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knZ/FzS5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knZ/FzS5"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79a7d439efbso32709216d6.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621844; x=1760226644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Zg/1Y7tRoNadojvxskF2acevAo1Z1Xk2uqZsYRAJI=;
        b=knZ/FzS5Gzsj8O28KdwfvuudokosabHdZD01pTtPrpKyrftL3icpAZ9dY9ZSxfp/zB
         9S0VmUe3nre0RIB/8KRb6e9VL++6mbiYI52QGUrVTEmK/844S9x1X9sfhKqNj9JtXgBs
         OVu6hlmjfR2XhJtvDErhCbc9/AudOBaDCuNl2xOUXJqTwqAKypvymGYMvzZhh+LotgHx
         V5KchoWQo3+VkDdXIwpZ9XB3dUzZQbjaPOikmNQiEXgvSFUSDZLDrZonC51I0RDzA7x/
         /O+pAWiXwp+7VSVBthMHPH0oRkHX7XjQ5mon/800W5W8tqo1hRCCs59cpvx2D4Temfj1
         U6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621844; x=1760226644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Zg/1Y7tRoNadojvxskF2acevAo1Z1Xk2uqZsYRAJI=;
        b=cMZgOG8oST2+ml4AD2yo/l7EgexNZ6mshXvHGh+B6/7f911YNhRf1sKk/j2mGTybcg
         bnCpmBwuSTUOY8jlaVGlzm58AxNK6y98fh4U97aeP2rKfXGWuknOPePkSjYlS+dVZII1
         NswdQ+QaRR+aiBTyqjf7kVKtWT/4MllN4+Q3aFW+cpChn0+xaCUkqoj7xsvy9dnVyNwt
         W9W5ZYe4YAEaTwEv2i7BYxZgFZKOR5T18Bqr0Ahlznofye8I9SZoBykFxayiachGAzpV
         AgtOi92ai2aTogx6uA6x2ybAX9unn1gxvVZnSoJwetyjEKF5ch4STHaiLobGKXeF/bQB
         nvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdH3cL7/IlsUX9Jqo/Ne8aisDy8Z2vp4QtIYMoHUmdDjQCb7lt7sbOiQvyAzDZHouuoppn9JNwaCfElMSHeDgBbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjVFFIIwCDelgHtBHkjfJZ+EJ3zjS6ke7OvlpPq7ZN1y44AzR
	QsX83APopVZjBbGJgng0nXrDQioTdWCsfNqvsGYLyN0UALOi0dSfi+ovaydUERH/
X-Gm-Gg: ASbGncvYfydaRWqdXYucuCdQDR0fVhTDvguWI0XsVpVYPPojxUWqdTVUn8US9kHF6hp
	h37y8jdDDWjvJtIFCJt6FZIKi7H357LEeSA4wWEnAkSUiA/vb2FrgwWqA6UnC8HNLsA+3EafiYf
	GHYXsxySF97+Spyat73fyzrptWcEhgMREzPjEZ0dzOipg03lnSs/Ed4EsjgJyAp56J9cjl8k2Ui
	qXXmnsPYyOAQxyhnJD8lnHVtFzqohhCgq5E6Tomsyj++oETqSc9Uax7rWFdEOt+bbdLWq1Au5QN
	pT/g7XGPGxx8dvfZ5HpESgYFNyFV8ryfGNbMgE+4W28bUpQqlsHEYsXVDB68VBOPZOFTJsoVUqn
	FNi2hU0TqYmfDYVZ4mcmsaZzdT9bG08L2k3FObDDFWBKOlrZgdzvPx6JolC3m5dUqWVGEBc2ay9
	NZv7PhWaBPze+puQk=
X-Google-Smtp-Source: AGHT+IECC20UZjnBEUBrVIWpdj8P1aH96WApe+AVKUjSXUYa+YVIzdIMuaznQLxMCYBN3sW2e1+1jQ==
X-Received: by 2002:a05:6214:4108:b0:81c:b934:a01 with SMTP id 6a1803df08f44-879dc83ec30mr102513536d6.31.1759621843927;
        Sat, 04 Oct 2025 16:50:43 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:42 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 5/5] selftests/ftrace: dynevent: add reject cases
Date: Sun,  5 Oct 2025 08:46:59 +0900
Message-ID: <20251004235001.133111-6-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index fee479295e2f..720c0047c0ff 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event parser error log check
 # requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
@@ -95,6 +96,18 @@ fi
 # %return suffix errors
 check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 
+# New list/wildcard syntax errors
+if grep -q: ":exit" README; then
+check_error 'f ^vfs_read, do_sys_open'	# LIST_NEEDS_EVENT
+check_error 'f ^vfs_read,do_sys_open'	# LIST_NEEDS_EVENT
+check_error 'f:dyn/ret_forbid vfs_*^%return'	# WILDCARD_WITH_RETURN
+check_error 'f:dyn/ret_forbid vfs_read,do_sys_open^%return'	# LIST_WITH_RETURN
+check_error 'f:dyn/list_bad ^,vfs_read'		# LEADING_COMMA
+check_error 'f:dyn/list_bad vfs_read,^'		# TRAILING_COMMA
+check_error 'f:dyn/list_bad vfs_read,^,do_sys_open'	# EMPTY_TOKEN
+check_error 'f:dyn/mixed vfs_read%return^:exit'		# MIXED_SUFFIX
+
+
 # BTF arguments errors
 if grep -q "<argname>" README; then
 check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
-- 
2.43.0

