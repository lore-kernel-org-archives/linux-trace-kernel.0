Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CF1BDC5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJfglORo"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166CDCA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:52:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40839807e82so5370845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697809969; x=1698414769; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41AXEYL2MTPfgKVH5aNADWWFa3XRT47NKp3h4dL1PFU=;
        b=yJfglORout7j5Pw8SDYTSO2k6er2ERv3Kd1EynNSnHOuSbeB+2U/RdbDEtZnVSJ94r
         WIdrX31xtIsvu2U4YnY2EkvzeqK87HhxCo+BCZH+Wvli83fAgr83W+1bAEVukBBtE1Vy
         hokiyNb+z5nZZcZBqvhoZ7fxwOS7nIFWtNqAWpUcaj2R6+Kh83qdRMSbufdaKApkLYm9
         MW1pPBmg48etLVI2jBndQGQTqKLYnBeE7Vf+r77g4opSUumQbmgMjYxpyLDEDR+jKfSK
         hmpM47q9daASrxjxKiCBEoqgX/+yP3E8C2KWw2aHQXn873U3yPHEs2wCz1Ug7n+tDxZR
         LiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809969; x=1698414769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41AXEYL2MTPfgKVH5aNADWWFa3XRT47NKp3h4dL1PFU=;
        b=FVIf0dXj1D4arNzyybnT9e289PzLy/xXxUFk06qMPjPUIuTOaPBGB/ch9Rr85fKRvw
         0h5PK0+eCPVzzk4n+gxdu7v2iLauCJQY8ucUPFkySAcbWhdr5qpSnfcwMbP40akKsRET
         5GL04l3en+ciQXot3GMatP6J7NmMJ9D6Aoje/c0oBW/aMRWtfb7HxPv1jEKZIaIIj463
         EXTHGblCYiwWWrTp7YcyC1gdYBKwqg7HcyLyzSDnV3pdI1+EBKM+4hxrFQ+Hqko7fzEO
         PTAOARQrVpxmP7qQk4zSzzBxOQZl1/7ojijlyPARiyfpovqQREaqT0iHEUwY5D3XmNsn
         trTQ==
X-Gm-Message-State: AOJu0YxTOy6FXMZMfJEYxwNhXWgPJnN+E6UjejPgwOQmMao6sL/DH/Z5
	XVxJd3Z2DRll5phjd4nn2sDAMMPfR/oAzcSLAmg=
X-Google-Smtp-Source: AGHT+IEsZZQsbAsyA0Ig8P8MK1b+yiaG8YgbGiIWc7MmG1HASfAtJ/ccHPH8BqbpqkkNYe5SHtyx0w==
X-Received: by 2002:a05:600c:35c3:b0:402:ebe1:7960 with SMTP id r3-20020a05600c35c300b00402ebe17960mr1872710wmq.2.1697809969422;
        Fri, 20 Oct 2023 06:52:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c431500b004076f522058sm6959791wme.0.2023.10.20.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:52:49 -0700 (PDT)
Date: Fri, 20 Oct 2023 16:52:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing: Fix a NULL vs IS_ERR() bug in event_subsystem_dir()
Message-ID: <ff641474-84e2-46a7-9d7a-62b251a1050c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The eventfs_create_dir() function returns error pointers, it never returns
NULL.  Update the check to reflect that.

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index db46d2116500..f9e3e24d8796 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2354,7 +2354,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		nr_entries = ARRAY_SIZE(system_entries);
 
 	ei = eventfs_create_dir(name, parent, system_entries, nr_entries, dir);
-	if (!ei) {
+	if (IS_ERR(ei)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
-- 
2.42.0

