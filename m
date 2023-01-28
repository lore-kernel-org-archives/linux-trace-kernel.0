Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE1C38142
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 28 Jan 2023 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjA1QYU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjA1QYT (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:24:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB1166D7
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:24:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vw16so21077706ejc.12
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm51asFusMaOnI4dbO4kmiyktN80gT+APvb33Ns9XI=;
        b=Y/+btvKrmgzXEKtyKX7991+a12JhQ7dalLgZnYYVwQvFFHfkh9OK3x3t5ZdVRfa4nk
         SGvuuUEPReexDl5lgCg7OQPPDhPjQc/Nawu+4iDR4/xCYRHMx+JyDhhwLTxpj7yT4d2X
         fARyrgIuCQ96nd0aTfGQ7zDZNuNJAsQNjEnFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdm51asFusMaOnI4dbO4kmiyktN80gT+APvb33Ns9XI=;
        b=j1eWV4RLUMM7Eb2bLZNdscL+bL8xYREtShxui3vdQFLzxIPYCvKgEa3J/IBq7nFDWX
         E/2txl5BCFnH+zay3RRXG2OumZy97SSJml2aj9O6UUImuvafZ7hJuEkAWV9SzMYRIzek
         5y4relwSpct+k5F0mfCKfcMGIDroQNjT91n0NptE0BxdBwh7bM4FMsUiFpgMNQ2t97Id
         swPuAq/iJp5PxixrU51fefDlGDrG9xt8r8vEYUwVEQcBNS8yvIu6mek19TpzPKPW4Apr
         aribd9CKhOpBUk5utEQyJtOhqeFvg8Btgalr794ELM+SxiON02O62uS9zZmjoAWc9zpq
         WrQg==
X-Gm-Message-State: AO0yUKUKia+Oc6fT3e6TUs0V7ARqwJT+ykmEzvK3uANGNYC2QlMWGPG4
        xcgRrQKyFPDO8HTfiynny6qzhSmA5bzbZhhVong=
X-Google-Smtp-Source: AK7set+3+WSurY2InJfAC27gcngmCjroEKMbPIUtbLMwyDnbgQkdHZBKAQR1RWIhIThi4NwuuTBT8Q==
X-Received: by 2002:a17:906:ad87:b0:885:5231:359c with SMTP id la7-20020a170906ad8700b008855231359cmr941135ejb.5.1674923056433;
        Sat, 28 Jan 2023 08:24:16 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id bu21-20020a170906a15500b00877557ae644sm4074279ejb.71.2023.01.28.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:24:16 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 28 Jan 2023 16:23:41 +0000
Subject: [PATCH] tracing/probe: trace_probe_primary_from_call(): checked
 list_first_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAA1M1WMC/x2NQQqDMBAAvyJ77oKJh4R+pfQQ42qWpmnZjaVF/
 Hujx2EYZgMlYVK4dhsIfVj5VRqYSwcxhbIQ8tQYbG+H3liPmbUilSo/LGvOGBPFBw7OOU/zFIyP
 0NoxKOEoocR01M+gleQQb6GZv+fwdt/3P09B60WAAAAA
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674923055; l=1355;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=IgyQXwB2Np3yDjGtNPNxtd/EaaynJb35GlVylgQexoU=;
 b=aVkW+zF9PsQ3O71+nDtJfYkLWvZCYJiNRI0xeZt5QAAdjwu1JqmFlMCjui9upEK7HOFroY9yGBLV
 CBgoW0g1BtQCJNuFS+N10G4El+VuNgRDemGjiXbVVFtS5ul7sTs0
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

All callers of trace_probe_primary_from_call() check the return
value to be non NULL. However, the function returns
list_first_entry(&tpe->probes, ...) which can never be NULL.
Additionally, it does not check for the list being possibly empty,
possibly causing a type confusion on empty lists.
Use list_first_entry_or_null() which solves both problems.

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 kernel/trace/trace_probe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 23acfd1c3812..f6b565dced56 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -307,7 +307,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
 {
 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
 
-	return list_first_entry(&tpe->probes, struct trace_probe, list);
+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)

---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230128-list-entry-null-check-37778efda18c

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
