Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9807EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 01:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGKBvZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGKBvR (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46EA4;
        Mon, 10 Jul 2023 18:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0811861217;
        Tue, 11 Jul 2023 01:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D4C433C7;
        Tue, 11 Jul 2023 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040241;
        bh=cTcnxfSzuVVM/ut1v16kNJC2utrcIMhUy/MYvzw6ZiY=;
        h=From:To:Cc:Subject:Date:From;
        b=k5BcaLv4ER43AGPRZqmLo7SZxdxqYVs9UMsjP/4SI9tQrN15Sfc2/JRCZyivckvqI
         3iAoFbakXjgK3TDOAkQ3I08SWC2tw01e0WaIJuBNVIlzInvXPEmy/NJUhtkSu+9Ap2
         nvrp0FeyFwYj7E0Dtrm4XK1nEMUyJJspz0UwZjVlcnp7IXS6rd8u8AJX3p13dS+A+n
         RO/CBQhv04A32sUyF7dySrQVZ5ZZjz7NCq6xBNyZeY53l75V8lgADgJ3u4ADUTDJj+
         sB0AMGFBGjVDhVIlihcXnKqJ2ksKptuVzia7wLzVm2IltwcYKFl0AACvQYVE3/75P5
         IMFFXNulbpxNQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/2] x86: kprobes: Fix CFI_CLANG related issues
Date:   Tue, 11 Jul 2023 10:50:35 +0900
Message-Id: <168904023542.116016.10540228903086100726.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the kprobe patches for kernel CFI.
Previous version is here;

https://lore.kernel.org/all/168899125356.80889.17967397360941194229.stgit@devnote2/

In this version "__pfx_" prefix symbols also are prohibited and that check
is done unconditionally [1/2].

- Prohibit probing on __cfi_* and __pfx_* preamble symbols, which have CFI info.
- Prohibit probing on compiler generated movl/addl which is used for
  detecting typeid on x86.

Thank you,

---

Masami Hiramatsu (Google) (2):
      kprobes: Prohibit probing on CFI preamble symbol
      x86/kprobes: Prohibit probing on compiler generated CFI checking code


 arch/x86/kernel/kprobes/core.c |   34 ++++++++++++++++++++++++++++++++++
 kernel/kprobes.c               |   14 +++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
