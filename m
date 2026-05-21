Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB742727F3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391735; cv=none; b=Zj259wDhoLnoH0uhHWGdkXTXIlXjXgFUxr7KKLTg9hw0TALIt97Q9mQyw1Q/+gTrhSU/n9dGdjn2Urnf3bbklzxTnvPV/G+bA0hPAJIE8Bnro9W9FaaGvg2+LM2dIVo6QmaG7e8NSM9WPfP2U6+cGUMlioxIIn5cLByhiafeZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391735; c=relaxed/simple;
	bh=3YazQbVfON4lS//SvqeMVwPFdfsmD9zG7tJup9sUdII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bh5lKZ20tcjKGX4z4UCuZwBdUF+5KPe1BWguKO+vhZh6/iC9hrmNMlskJnF1pbYl4vuTEQ+E6hIDbE5iwt/OYWy24t14wyJoG2/Cn+iQYLBJNPOgPAdsNmZkagItftpldzZg/rJ6kcYusocHIi0o73hDd1XCPk2DNMQpb10CWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am6drbpv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am6drbpv"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso2660369a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779391734; x=1779996534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuZACRn6n6kG+vjtvMbhcUq4v2SvjMEg1A3Y9ucG4Do=;
        b=am6drbpvIKW24r2e8yjAwjwLdV/33cs7SmytWyc2kFt/l6FMgIW7lu2yqBOVW5HZd+
         Pm5Bi2r6b3NsDQO9uokN0pn4egKjwL23e5E3aySOHqMVuUqko19CXHSKNsNqlhn7yWLG
         qyRC+A8BupG7dpv8dzkzMLaLJUz/IOg7Us8osmflm3nX5e3wtsS3ki3jY7cJHhWPix/K
         oLS4RmL2stQ2nsN/9lkWpEvq347SiBAhUsPX80ZhGOeckMlESjf7cHqQaPl4qVRk/PLg
         +rqAd4378bYjjf9R8EG7wj+vXVO95/KYJKCEae4q256xcdhWqMA4UT3LSTPTUQqs6A7x
         3vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391734; x=1779996534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuZACRn6n6kG+vjtvMbhcUq4v2SvjMEg1A3Y9ucG4Do=;
        b=MGvQZof4pWfItehgUL3quXQTdpeK/n+6JXvNfxASyz037vzzdEXF1hDmdz0mCABjkD
         TXRSsfdnIN/DImzIA/bzgJGN4P6lanSd64BNQj9/wKnlVN/C9B6s+7dHyO981yfeF3eX
         atjZtrZYlzIQmvGrtkoPMQDxov+0ugG3OiiULnCjdPFj1uji1dMbDUoM0QfTeV/boZPN
         w8tmqO9486WW+hxlF3Qm+Vm3N4TDuig3P3A1ehg1nAkk/Jmcyk7LMlB9/HQauQ0/XR8/
         aXYx21wXz+w/9YO9cS5MFlpDHWjNSI3o6/PcKKWOCLZtX2hSJ6wbodvWj3Ywa1UgrgsO
         /QyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oiwOwUKFhM16pnIppGa11PVhuFHdpU2GR6/I3f9mHxQSLX8oc4ujK9/G9XOBQaRy0dDfjt+BExjCwJlu47bN4C1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfhzSMbbquaSgZotNeKTr1VDGhPu6I5iZ2UEK2YN8fEwmo9i8
	Bm4tVMczutoGh+NbiDfGXDK0MYygoTnK5t/J3qGKGx0p8rn28C0ag/RmnauMqbq2
X-Gm-Gg: Acq92OGt6JAkdeRWLkEZlKSElAJ1cUoWlHi00mntEfBfqa4XHkI0GBLf5X5DuvY0o/b
	cXApRcKBcwZKSgv88TXbepkYrjRO5SquclvvN+0bDWpNK0cluNzDTvCStdvL4vbDFj02z11L2+f
	6AQKEvZGKlZofSWTN+0jhEpGBBwrjoOHTmwPuDaW9NV+tG0lgx91+LczYXjcsQOD3JRnjkuS2rI
	L1YYKN4wEVKwwP9GZG/Y1uiq+KR4Ws5qDRvWcwTKQEr0ZzzZjB9fqCgSL4U9ADAihH6SVLORA/5
	K4YRZUZ/ZYs9A6xLjxKYNsAAT5AwYnJPs2+Yy8yhnnmyJ+nXQm8spl4Kgc1P3sKuSwNHtgEtypA
	vNlVDo35ZBIz9sY627mxaKKjTz11N2xJHXYlBSdJ0d8yTz0OwMW0BYCphinBie/20B2w0PV/VhD
	f6MurpczZI865ZbZL12p20+5hjHt8YshLuuMFbuq0h5B4f
X-Received: by 2002:a05:6a21:4d0f:b0:3b3:10e1:a870 with SMTP id adf61e73a8af0-3b328e9cf93mr275729637.32.1779391733579;
        Thu, 21 May 2026 12:28:53 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85198f4be7sm1194020a12.19.2026.05.21.12.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:28:53 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] tracing: Replace BUG_ON with lockdep_assert_held in uprobe_buffer functions
Date: Fri, 22 May 2026 00:58:46 +0530
Message-ID: <20260521192846.8306-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG_ON(!mutex_is_locked(&event_mutex)) with
lockdep_assert_held(&event_mutex) in uprobe_buffer_enable() and
uprobe_buffer_disable().

BUG_ON() will crash the kernel. mutex_is_locked() only checks
if any task holds lock,but not the caller task. lockdep_assert_held()
also check current task for lock and no crash on true condition.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 kernel/trace/trace_uprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2cabf8a23ec5..aee0960d0cf7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -912,7 +912,7 @@ static int uprobe_buffer_enable(void)
 {
 	int ret = 0;
 
-	BUG_ON(!mutex_is_locked(&event_mutex));
+	lockdep_assert_held(&event_mutex);
 
 	if (uprobe_buffer_refcnt++ == 0) {
 		ret = uprobe_buffer_init();
@@ -927,7 +927,7 @@ static void uprobe_buffer_disable(void)
 {
 	int cpu;
 
-	BUG_ON(!mutex_is_locked(&event_mutex));
+	lockdep_assert_held(&event_mutex);
 
 	if (--uprobe_buffer_refcnt == 0) {
 		for_each_possible_cpu(cpu)
-- 
2.43.0

