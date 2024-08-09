Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D191DFF5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206877; cv=none; b=mqKYTVJaf02t/8ww7FZvHxnDdEkMYjibo1CFlPADzfNHFPsGE67jqd+/AEreQ30pB4XAJvZjLDy/CR2V26O8Foi5CrylbLktdaDRGvtqDjbQIIKEyPJbcHwEGUNeYPY8IzvL3tdZnKCgAo/JKENbSg2/Jy0pXgye4YPEgph/tA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206877; c=relaxed/simple;
	bh=dFQRHkthV2CiGWZy7z+Br0AUOk55fvfBCAujfUth+ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eC460S+xFbacQpJKgczEZVb0FtAHMuonTqHME1fDQsO5gO19JWjXQJVnevkZRd/80gQWU6huTfi68WF14amxIbzYOq6t4vx37Qf8K+1lFtoRpSi9ENA6lC+WjTM0vwdNF9yuZzwYx5F9iZ6ax815rWPdtzZFkiUZPNXG6G5Xg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiyMs+Pe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiyMs+Pe"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso174116066b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206874; x=1723811674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZDoeVn0Ui9DaBYyRf0yS/xJKDLJH8VgYEQMX6ljq/0=;
        b=XiyMs+PexbDUrvUz2Nls1SXA28OiFJAidssFsVyx+O/62AhitBne17u5Jj0MUZxILT
         Z8bAhCOB541b+4YsZNzd9L86loCGvZXGSr9Fo4A+ILgBIBP9aHPieCWMFZzoUkJ0Z5CE
         h0uvsv1nKh4kqEEDsx7enbLb1TK8FS94k9NTWmxox8XEOWlWH0eYPYvjPfyjzSK6s90i
         R8aKeviuP3YCNZUB5sWHK0DXCwCHhPEimE01wVetOwskh4ftbtSNrh9SuHOEy4IWt0AM
         5Zpjy/I9pyI+1xQpKqSMZT07YgfltJz1Hd08oNjAgDGzDdEh6Uixzsx1HLi59PCMazji
         ALfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206874; x=1723811674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZDoeVn0Ui9DaBYyRf0yS/xJKDLJH8VgYEQMX6ljq/0=;
        b=Yhg9IMNEfXoHN9/fDYkNpEOADh48GAa7bvzlGpe1bNUUTXQFZ4Iv5x9vYp0YUXTxQa
         qYdni312F4IZ/YZEmeGH8352reR9VxoSbzQSu8pmNvHqz3p4T2vjVS2/0FEPZdBiMHI7
         9Xh/O4Jayui6EzSta7GOozFiUwYhNZ7w2bIlW18rR0gInSJLUrYe+lYgROfK9ra0j+1A
         INRSVTDp8aWjITLvr5jPyVztO3TJPHHgSXfqgn72hmj0RHuev11rZ5IdZNuBmwf2pawG
         q6KB5UTMEHRq74ghCBKb79aM6L43DDfX2cGTQzAtHKQ4Uax1Z9eslAXLt8fbRiA28nn2
         y5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG9NfL+Vx1GUPFAdAuBfpREYBk4l3oa0tk9Fbsu3H8zT4SRBpGqeMP13YH5543nT/hxtTam6e7VE8Ah4om4EwURYoqihDOp+0G3AhcMwRfWU+f
X-Gm-Message-State: AOJu0Yx+8crHA6pNSBgE6vFpGwNJxfZXTyXamTj9iU/s5s7t2yjw0iuk
	YQ3sqfn+Pko8WrjbUXaEIaUT8Mqc2SJzmS+GwS6Bxwy9DkilbdPb++ceuAXwq1I=
X-Google-Smtp-Source: AGHT+IHhcQkeSlgaiaLuH3O2urxwGk6K9tJx15iJPwIKKgrG2LT/FmwImrhs1ImaNZ2v2YJcFRxg3A==
X-Received: by 2002:a17:907:60cd:b0:a7a:ab8a:38f with SMTP id a640c23a62f3a-a80aa5fb107mr120044866b.41.1723206874085;
        Fri, 09 Aug 2024 05:34:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4545dsm837841266b.124.2024.08.09.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:34:33 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:34:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] rtla/osnoise: prevent NULL dereference in error handling
Message-ID: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the "tool->data" allocation fails then there is no need to call
osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.

Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f594a44df840..2f756628613d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;
-- 
2.43.0

