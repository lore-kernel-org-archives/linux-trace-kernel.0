Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321393E7169
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175709; cv=none; b=YnxURCUa7OwF6STYO/aUoIyWc9ySzNCZWS7IOJcDZjt5QxpCEI3xaIWgrXwKLcdKeJQHwKmFY3Ykid7CPltMYOHpAJ5aw+QLgqWTR6TM15ECcZCZly3H6DQLSV/RQwQzyCSCCKEBaU7p/xjZvT73krkRMJ2dVA9hjoKVsVC9uAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175709; c=relaxed/simple;
	bh=DtLzW3cQXjdc0LEtuc7XOuuzDvrpWrzODP2loE65ijA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=iBwsB6FyB/FTmqhJWGUZVZ4XuQTdu/sTtAMkT/7zr+8oklsaysWdowYWA6vNf9GBT67ZvFDPeJ13ctvP8apjn5Ua593H13l9lIfjw8/hLvg41Jd7fzYkVhOmf5NcHePLOB4rvduzeoJ9mA8T/W3E/aZqOCBDkiU3iI6MSR+yY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3k/uvQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3k/uvQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776175707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wfYWtxK2qjVulYD9y3yJZ7bhykLSjiE8d+dj/8jLsiE=;
	b=R3k/uvQSxirh5JS9eRRTTM9k11VcofvnvLVcNrCuUj7TY3qTnVZXz93NfWVK3Fuv6pMnz1
	lOUZ+YdvdoKf+g9Y90/RuG7jXWaRcqL2kBqwrHSTxdACEDmyw9KViRivlTsOSMwGQCTwqs
	2WPbSIE5M3utV8d2KZYpHuE6QmPmous=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-dTjuEE4pMJmWZDxZ1oJmDQ-1; Tue, 14 Apr 2026 10:08:26 -0400
X-MC-Unique: dTjuEE4pMJmWZDxZ1oJmDQ-1
X-Mimecast-MFC-AGG-ID: dTjuEE4pMJmWZDxZ1oJmDQ_1776175704
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cff5ef652so3541585f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 07:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175704; x=1776780504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfYWtxK2qjVulYD9y3yJZ7bhykLSjiE8d+dj/8jLsiE=;
        b=cTJKubzF5oMLfv240D1aR42vImTGoCU6IQTN84EtuxtFAX5cL7+O9gEAxWEQfhGQrF
         yF3vI2lotyK4qfwdyx6jxqvaJBmsGxeMwcEA2OPO+AwFFSXH8hnkwTpKuOkGo3RIr5NA
         /x1Jrx5VP4W9C5hOMLnmvRLlyTPcDT2KhvtF0wpqGRaWN2Gfla3wetWLup+e0yvssn/z
         1qR04AJFF6hJJb+R5FqOg8Lk1bQvPkscGuj3p8JZEc+c8+jBfQuTykpNer7IKguSilOO
         RXYhwSUOsGH2IkTXME3T/Do0CsGu1fwOc/iMNgSjAeNiMSe7wNHPOcRihpVjeSahCiQP
         aL6A==
X-Forwarded-Encrypted: i=1; AFNElJ/QykbXyoCOiL3uvay+lk56fR3heSKOmPF0tG3RGqGr70U9vDzAVuUBymB8czjs9H9u7nCkPmEZWs70Tl+4pf6b3Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWckA67n0a5O8mcjxqIT0lx5tuIa383fZdgVFF4BqLylRPajhw
	tZJfMOPAhL/xJQKJ4zihhC13BV2Xr6yL9nw2SmDhzkSnZ955iEE4mjeV/fixU6Kq2zBjMxKqjpd
	mscAJIF/EUVNTwO0SSXEeaBQEVYHpAjql8l1bKeyDaJwtvv9Myq/RsuXgJzkrMmJdpSz9Xccruw
	==
X-Gm-Gg: AeBDiev6vvvhNzot+7+ccjlQO78+5kcBo2EuHiqTUvDigXq8GcSqIeTvkRmTR8XaJE9
	nqF/OwNl51wxEUKYh4HtBFzRETjPlvKj6olFSaMj+u3Sf207HnPYOslFoUaoCvPt4tLF7q+5Vnp
	KJbVUtUlZJkjPnUu6YNMHsFjmmrZ6YRaXuGjjz9yYAKl1iBNkvTz4rY2FYPrjwiYighfH7IJi5b
	LvehjnTeAu4+pLfGK6XREnbfC42nnY4Gl0T/ez22rEUjMm9C/T3iFoEfQa4S9LmH1E/94pF0pIP
	WtNglo3am08NGGHQK3iJHKgg/iFDHH3vQaC8eZZacL1Or0hSZRz/Hsu+feyBqysuMMlZRAb6OTb
	G/Iu4TiahHI8Zsm5ni8tH4JnwN+Jy/zObzyQ=
X-Received: by 2002:a5d:5848:0:b0:43e:a73e:cca8 with SMTP id ffacd0b85a97d-43ea73ece45mr3588916f8f.47.1776175703847;
        Tue, 14 Apr 2026 07:08:23 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:43e:a73e:cca8 with SMTP id ffacd0b85a97d-43ea73ece45mr3588860f8f.47.1776175703301;
        Tue, 14 Apr 2026 07:08:23 -0700 (PDT)
Received: from localhost ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6ffd3880sm26607472f8f.7.2026.04.14.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:08:22 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Fix --dump-task option name to --dump-tasks
Date: Tue, 14 Apr 2026 17:06:17 +0300
Message-ID: <20260414140621.28027-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nQwpvu0Ldi5idK9c25HRwpI8S6Bi6CVq_Dnqq5eMKUU_1776175704
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The option was inconsistently named --dump-task in the usage
string and getopt_long table while the actual implementation
uses --dump-tasks. Fix both occurrences to match.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 79142af4f566..3a15a85b7d72 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -694,7 +694,7 @@ static void timerlat_hist_usage(void)
 		"[-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-tasks] [-u|-k]",
 		"	  [--warm-up s] [--deepest-idle-state n]",
 		NULL,
 	};
@@ -808,7 +808,7 @@ static struct common_params
 			{"filter",		required_argument,	0, '7'},
 			{"dma-latency",		required_argument,	0, '8'},
 			{"no-aa",		no_argument,		0, '9'},
-			{"dump-task",		no_argument,		0, '\1'},
+			{"dump-tasks",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
 			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{"deepest-idle-state",	required_argument,	0, '\4'},
-- 
2.53.0

