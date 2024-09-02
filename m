Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697046B5;
	Sat, 14 Sep 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294299; cv=none; b=WfP0SudeIPEJfl56k0HBM3rbVWnMS5UDfGHwQrGV8jbiWuERrGqlAt+6WkOjhxxuzGmUoHLHb16fh7yCKobkCiDenqQRed8m7ybFxzDmG32/yvGXeKBA6X5J+Yo+qYwbF+HjyD0OjC1qqbHY2vFdTZnGMJhi2rYsBMqiUMpfIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294299; c=relaxed/simple;
	bh=8tu2uV8hS+EU2hygqdD72nUqmKt8uAWlTnFbTIrhI/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HBqb079f7c9Y/AGeMCErpgf8K9RnYhAvRYozvBh+1pUQXJCoHkMe0KAC0yXdHbjTwWxgiLUx7eFEvgOZjbUhqzGJRlY/fMgCWnXLlisFCNr+i/HgRfoCfOyy+yvuTL/p0o72LUo8KK9TnRKRtEAStYSXfN4YYfP82Z5j1V02CDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666e5290c0f9-069bc;
	Sat, 14 Sep 2024 14:11:25 +0800 (CST)
X-RM-TRANSID:2ee666e5290c0f9-069bc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366e5290089d-94cd0;
	Sat, 14 Sep 2024 14:11:25 +0800 (CST)
X-RM-TRANSID:2ee366e5290089d-94cd0
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: bristot@kernel.org,
	bajing@cmss.chinamobile.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] in_kernel: Correct the grammatical errors in the comments
Date: Tue,  3 Sep 2024 07:34:08 +0800
Message-Id: <20240902233408.8684-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The form of "print" should be consistent with "parses".

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/verification/rv/src/in_kernel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index f04479ecc96c..f2bbc75a76f4 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -332,7 +332,7 @@ static void ikm_print_header(struct trace_seq *s)
  * ikm_event_handler - callback to handle event events
  *
  * Called any time a rv:"monitor"_event events is generated.
- * It parses and print event.
+ * It parses and prints event.
  */
 static int
 ikm_event_handler(struct trace_seq *s, struct tep_record *record,
@@ -384,7 +384,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
  * ikm_error_handler - callback to handle error events
  *
  * Called any time a rv:"monitor"_errors events is generated.
- * It parses and print event.
+ * It parses and prints event.
  */
 static int
 ikm_error_handler(struct trace_seq *s, struct tep_record *record,
-- 
2.33.0



