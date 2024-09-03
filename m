Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2919A28D;
	Sat, 14 Sep 2024 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297410; cv=none; b=XZwDUV+vdK93KkSObux7ALut9NNZGZvCIwRMJzlMEPQFVLANCVCCBvBxxbavA08v1otGqQsvo+KzhEQqkLYSaFuIwYQImBIIbr2jH3JD6rUdG7SNgdNbQp7P8kckbPuYfoOUmb3huqEy51squHU7mUZJI6UP+dv40rSgdQd9w40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297410; c=relaxed/simple;
	bh=tcqWTr7Itqz6svcPpXaB8dypodWAkX77iIsMyl3DS6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDrjTpp/Buu3gIQQI+rxW5CWvLAlnDDOPu74vZb9yLq+y4WKzT7+ldcjGJOsDrmz011Ca94KbjGFppv2WWP+AL0Vn9ArPM36w9PLC45sovCLcQNnBEo2iZ/3SmmpefMwtQGe3bgaE2j/mwniOnXpxHPXpEBx3HLibao/7g3ZHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766e53533bbf-38bc5;
	Sat, 14 Sep 2024 15:03:16 +0800 (CST)
X-RM-TRANSID:2ee766e53533bbf-38bc5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566e535271fc-933a3;
	Sat, 14 Sep 2024 15:03:16 +0800 (CST)
X-RM-TRANSID:2ee566e535271fc-933a3
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: bajing@cmss.chinamobile.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] trace: Correct the grammatical errors in the comments
Date: Tue,  3 Sep 2024 08:30:19 +0800
Message-Id: <20240903003019.8969-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word "trace" begins with a consonant sound, 
so "a" should be used instead of "an".

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/verification/rv/src/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/src/trace.c
index 2c7deed47f8d..1b9f9bfa1893 100644
--- a/tools/verification/rv/src/trace.c
+++ b/tools/verification/rv/src/trace.c
@@ -81,7 +81,7 @@ void trace_instance_destroy(struct trace_instance *trace)
 }
 
 /**
- * trace_instance_init - create an trace instance
+ * trace_instance_init - create a trace instance
  *
  * It is more than the tracefs instance, as it contains other
  * things required for the tracing, such as the local events and
-- 
2.33.0



