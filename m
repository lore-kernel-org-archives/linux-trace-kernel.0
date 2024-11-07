Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB161E5712;
	Thu,  7 Nov 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973218; cv=none; b=bHwrn2cIXwfRgQxwG9MSZR8lDC2OPTdJJLONnXQhemrGsBkRkmNJa6vrvPNOMUmmNDyRbicF5d+ffpqH3qUwc9wT2PIMardtLyItHtrQHvyw5zgQamIiZZpNXInqAud4FmASK/zEFacE7igGchfCf8N0RQUXaN9C5qy+yRmRLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973218; c=relaxed/simple;
	bh=fv84Rpal7tR/PY3lagKcTufB5f0bB+WIHvfU7u9TkkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpq19/jHh8mI5iQS+7HW8imagEke6yiNKzEAOMhAZiAsLA0Vwt/9193ClrlRh4BSzVb+RDbmvFNQKrjfgWjjJnKOVrT/lIjlIy4+btc2s6Zf1pCQ/C5bwmUTu/i0enrWfaRFTomeMsRWAwA7hMa+RuFxIsZ1Uj0w85I+DJK8gPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6672c8e19588-b6e54;
	Thu, 07 Nov 2024 17:53:30 +0800 (CST)
X-RM-TRANSID:2ee6672c8e19588-b6e54
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8672c8e18c7b-5e807;
	Thu, 07 Nov 2024 17:53:29 +0800 (CST)
X-RM-TRANSID:2ee8672c8e18c7b-5e807
From: liujing <liujing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ring-buffer: Correct the grammatical errors in the comments
Date: Thu,  7 Nov 2024 17:53:27 +0800
Message-Id: <20241107095327.6390-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word "trace" begins with a consonant sound,
so "a" should be used instead of "an".

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77dc0b25140e..8825ae8d7664 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4010,7 +4010,7 @@ static const char *show_irq_str(int bits)
 	return type[bits];
 }
 
-/* Assume this is an trace event */
+/* Assume this is a trace event */
 static const char *show_flags(struct ring_buffer_event *event)
 {
 	struct trace_entry *entry;
-- 
2.27.0



