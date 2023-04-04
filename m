Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7EEC7618D
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  4 Apr 2023 07:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDDHh4 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 4 Apr 2023 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjDDHhy (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:37:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF84137
        for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:37:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j24so31783673wrd.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680593872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seoNBFTF4gD2bGERn3rux8neCDK93XhgsoBfvJ4M+UI=;
        b=Aav7Czuz08kGIElQ+jeAEzZbX4sIGIRRc/HjRhRrNUpFP/PSTZy5LctZ68QwW7hAYv
         6yWMn9dk16pLOhPJY4J0bAMunwtxKYwJGWaHo0AO6HAAO6pH8rQsI4k8z4VdAN6uePXL
         +Jnzr9Y9UK9tc17wMoyee1RoeCKtbPoMS9tTGXGU5652FHpwyEeMKbhsr/tLuqlZ5IUW
         lkPDfmD0TVNGs7Mh9NOQiGz67n5pPLeKcdNzkwcixTtC8HaBSm678YHqx8UpChxwbtJK
         9dJQbsWwQgG2WucKPnGnb6tTQC/bim65Uk6MMsZEjh0xrLX4qYET9Hy1HmBykmmAfLbe
         /T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seoNBFTF4gD2bGERn3rux8neCDK93XhgsoBfvJ4M+UI=;
        b=p0cMUFDkvlg0HfbtaCoRbQVCjRgxK3L1EjKnRCXMyRWsM7P+jrfR8tYoA2+IWGtOwE
         h8ROOAqhZNvwol21RixAV6ADleZXR+v5cMN+2LBJfAgwRWB2TsY2wW+dG7TChdFNkmcS
         m3TXWXc2RO5kMXuufptm0ajsmv7ApDOiVGlCvDtnRJdX7KTl4mb9t4F2d0GyuChmwex1
         MleHurzjiJcUgnETpdxs9qMCD0tyHWiv7TG+6Rc06CB2SJBIxtiBUZGm93o7q75B6vMe
         fkkS37ews+frp7An3KeeOI0ImDWqduG/rhRS4BuwV/VJDqpByTFhmHVvQHVJnG0llXvm
         oDWQ==
X-Gm-Message-State: AAQBX9ebTySXzaILh5BwXY+7c5mMoRel6/ZSw35LdrfIynywP9kr5lql
        qm6DWaJ4dNGK51j01O+7uzg=
X-Google-Smtp-Source: AKy350aV0kW469W7C84G01LHuLzPP4XNrp8TdbxwnWdrwS8rZlJIVJJWhqGgqO6JfqNHC4oDLMPBrA==
X-Received: by 2002:adf:fc4d:0:b0:2c9:8df7:b390 with SMTP id e13-20020adffc4d000000b002c98df7b390mr855170wrs.63.1680593872242;
        Tue, 04 Apr 2023 00:37:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d4b85000000b002c559843748sm11604225wrt.10.2023.04.04.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:37:51 -0700 (PDT)
Date:   Tue, 4 Apr 2023 10:37:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     mhiramat@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] fprobe: Skip exit_handler if entry_handler returns !0
Message-ID: <85429a5c-a4b9-499e-b6c0-cbd313291c49@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Masami Hiramatsu (Google),

The patch 39d954200bf6: "fprobe: Skip exit_handler if entry_handler
returns !0" from Feb 2, 2023, leads to the following Smatch static
checker warning:

	kernel/trace/fprobe.c:59 fprobe_handler()
	error: uninitialized symbol 'ret'.

kernel/trace/fprobe.c
    49                 fpr->entry_ip = ip;
    50                 if (fp->entry_data_size)
    51                         entry_data = fpr->data;
    52         }
    53 
    54         if (fp->entry_handler)
    55                 ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);

ret is only initialized if there is an ->entry_handler

    56 
    57         /* If entry_handler returns !0, nmissed is not counted. */
    58         if (rh) {

rh is only true if there is an ->exit_handler.  Presumably if you have
and ->exit_handler that means you also have a ->entry_handler but Smatch
is not smart enough to figure it out.

--> 59                 if (ret)
                           ^^^
Warning here.

    60                         rethook_recycle(rh);
    61                 else
    62                         rethook_hook(rh, ftrace_get_regs(fregs), true);
    63         }
    64 out:
    65         ftrace_test_recursion_unlock(bit);
    66 }

regards,
dan carpenter
