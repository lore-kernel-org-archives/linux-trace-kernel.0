Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A21C5D72
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581986; cv=none; b=NO9RxFRLJb2NxUYRpCvBVpQuDI/tBhbwCnSPbgyqh1MKyOvYPoeI07MgEabXd+biY4/HhjZeMQEMyTU24CgJIRgpXAbouRccWDgqM3M4LOVFoUKdILkA3WLB4Q3jmk/A3iAEBjOuXyRALLni1JbJta8wd4/Z8e9W0itBVuLaufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581986; c=relaxed/simple;
	bh=4+71XntHF9I7Qtv+3R507T2pAwqnQEhwRWqeq7OxH+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lbWk1wplDTEzzDQoYjbvmZmBY5FgsDIYQIblVlY440VLa6SLvpQ1fdZ+Kr7cli258X8o9xLBA2jLI9iRRMLkuSbAd8h18oWq8R6LOLttE7Xi4Mslyl7Rfjdp6AKwYblJRSKUuJ4RfvRk2ce/iAgHvcCMctvA6ZmYmKGtta3OHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3nYMSZe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3nYMSZe"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458baf449cbso11493115e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754581982; x=1755186782; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgYWZn/Eywl+Mav1OP5OPQFwLYxPERTQWcamv2kYiM0=;
        b=J3nYMSZebw9VWmF/QFP0xi0DPINHaDxcmayNZVUhmhiwKjoyt5ksEhtLUPTmDpcW1R
         BdawAJiarGvfm0g3zwwGM40yiz70a84x6wL7bW4IX544Ai9msCNfQeZurvla4bfCNXhO
         VN053mU5vKFT2z2IBP4MqhFo99GUbKcdg77tvCRenlc83ADHHaPCz+zUBwG/tcHEpDSV
         JEdupUZcmcq1frML9VufMn3qdecUA5fLu7frG44Z1f8Im9ztnXEustPziVWpPbnOdOQ9
         xcQK8ATcDRc+sm4LZgmxV9pQuRpo8l8uBXfpKq3TxWVnhUyA1g3atPX/Hc3rTpc8FOSa
         vpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754581982; x=1755186782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgYWZn/Eywl+Mav1OP5OPQFwLYxPERTQWcamv2kYiM0=;
        b=W5mI21mE3vOZfofKIcDcKcFAmPDYAwhIyeqyIvKF3tgoG6xSifL90XTQcgcxbXSYA4
         zJElXzESOzlvaN+ufo5FuDfptLv+oVLXa6KXzy9fTglhJwfh4wLtmVtrPzpLjSoDVOAb
         uSmAPg31o0HWtRsDJEdebYFCvwrn/ioilz9Jp4Pv4pDWGhAUMZcOTVf3bqNY5LE8UuCu
         3HW7+15vx0a6Kv1xr4Z0XLbtEtjgOnnKrBIJ+PK10hQ40hRd10i/3jhd5t6fzK7RHsOJ
         Q9CmD3GVsC5ibVwSvaqViX3TZ466iVvIRNoyJCe2rdqW/oRKISylWlxQI0Htx4xybola
         rOTA==
X-Gm-Message-State: AOJu0YxPjMIwXYSmso78y61D+FNvhxGMbVBvhoLGJYOC1X7H9dbvcKYA
	9NqrrKn0UE72f1JuxQG4i4i3W4M0a+6g4So5arhzgiUiEKHnGlP3rruX5AyRdxJ4HLY=
X-Gm-Gg: ASbGncs9Jv5+QfXX1bIR/TB2vnKXqPUtTi+bs9MUSTNP/yqFv0wCb6dsJl/vVX35hap
	z6iDAkKJapcUUbPE08G9DbFJk17AybEA7KsIIjN/TLM3CCzOi9RhLjgMzzW1gb6NvFmKS2yAVQx
	wRINJc0JKqm9m3UxhRPnuHSVS3I65JYHUXRrU4/mQdq3re0KSB9OlZTMNU4S4epFt/5EofU3Yfx
	d801+kuhF6al+S6dbDgP8D7ne5GQ+XEwEW4R1rf6DC1VtxRzjKY8CTKslmsdWdk+MBSLflzwTic
	c4UXIwNHVceHnXtOq296IyNzs11R3y0bEg27FSc7xW52Bn2CUJMMGAyHjl9jUBgCGRCyYm+8I8H
	tWg3+MTLINkH3+phzWXZIrWgSOt4=
X-Google-Smtp-Source: AGHT+IG7LmqZc3afyVGoXFygF2Qr6GsvOxpLivjldZc89XSTKdKTr/iVT9W5lay9X9qjdsm04oWwmA==
X-Received: by 2002:a05:6000:1ac8:b0:3b7:88d8:efe with SMTP id ffacd0b85a97d-3b9000acb52mr152360f8f.41.1754581982388;
        Thu, 07 Aug 2025 08:53:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459db3048bdsm186191575e9.29.2025.08.07.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:53:01 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:52:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <srostedt@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing/events: add startup tests for events
Message-ID: <aJTL2Av9ph7vhQ_U@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt,

Commit e6187007d6c3 ("tracing/events: add startup tests for events")
from Apr 15, 2009 (linux-next), leads to the following Smatch static
checker warning:

	kernel/trace/trace_events.c:4704 event_test_stuff()
	error: 'test_thread' dereferencing possible ERR_PTR()

kernel/trace/trace_events.c
    4698 static __init void event_test_stuff(void)
    4699 {
    4700         struct task_struct *test_thread;
    4701 
    4702         test_thread = kthread_run(event_test_thread, NULL, "test-events");
    4703         msleep(1);
--> 4704         kthread_stop(test_thread);

Check for if (!IS_ERR(test_thread)) ?

    4705 }

regards,
dan carpenter
