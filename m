Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63319C560
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Aug 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721403; cv=none; b=ahPq5WDxQgNNZc2/pbBEtkkTMWf0P055AMDwf61C4pCMQNA+D8kvRkFT405VD3Csr4aZQurS3xduv0lD2XJ7EasZWIRS64YruFlTPYL/MwzfCycJ/iVwWxja5Od35B0L+xgKETdRdtVW9E157hjWZux76WshlQAVxtJOxKouNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721403; c=relaxed/simple;
	bh=Ho91ac16/KHECqo1eDShFW3v/Gslza3laABM8iHK2Po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=doNZSDHjpfDFiNz4zp3Kju9NkizLkncaoLa8MCSon6V8utSJ9/0HYtisc5xFiKkLmFh9zRrQHClYmm6xCvgef3iNefAl+r4K/I/OYPBJY6r4XmRPU19gNWbEdYT5PWF63hSDaphnxqDzBoYGPSpX7q7qnu/P17OacUSwgCTLOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=qU8NdC0O; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="qU8NdC0O"
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 24835104CBB9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:06:29 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 24835104CBB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754721389; bh=Ho91ac16/KHECqo1eDShFW3v/Gslza3laABM8iHK2Po=;
	h=Date:From:To:Cc:Subject:From;
	b=qU8NdC0OI9MrhiDLmeH41uW2hPx+Yq7tx9R9RnoctTbmdtuUaWnggCzGIhzkqoKYv
	 PBR+g38/67WXGY8I1zEsSdZkZs0dqSsBc4NLSR3sh5YLP6U9Ajh+FLQjVEQVK7tseH
	 +lFWL0A55T5U59WL/dmmYKywRLEQ8WTyN+er2FGM=
Received: (qmail 9486 invoked by uid 510); 9 Aug 2025 12:06:29 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.44074 secs; 09 Aug 2025 12:06:29 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 9 Aug 2025 12:06:24 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 32EC6341555;
	Sat,  9 Aug 2025 12:06:24 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 00C0D1E813ED;
	Sat,  9 Aug 2025 12:06:23 +0530 (IST)
Date: Sat, 9 Aug 2025 12:06:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] include/linux/rv.h: remove redundant include file
Message-ID: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove redundant include <linux/types.h> to clean up the code.
Fix this redundancy introduced by commit [1].

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 include/linux/rv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..8b968b8ed77b 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -15,7 +15,6 @@
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
-#include <linux/types.h>
 #include <linux/array_size.h>
 
 /*
-- 
2.34.1

