Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2667EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Jul 2023 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGEIQO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEIQN (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:16:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3010DD;
        Wed,  5 Jul 2023 01:16:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5014B1F460;
        Wed,  5 Jul 2023 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688544971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tUkIuCkSY6nqtqo0glV1weGN9mAs8kCdaJjxpHNVgc4=;
        b=i0S0u2HG2dQBweu8lRWrTw4+AWdEotnJ8Z3LX7Utkw4zRoddg2LFjGF524GTsmK13rnhLz
        E/MXXC2EAKK4pL//10OZr5tcBuMyP8+dOFObt7QhGaAYIxazXzDU3caQQQXu3DSVhcGqKd
        ArT0GFy1bkBI/AYrLr5L218a6AT0wNw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1182513460;
        Wed,  5 Jul 2023 08:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Acx5A8smpWRkRwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Wed, 05 Jul 2023 08:16:11 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org
Cc:     peterz@infradead.org, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] x86/retpoline,kprobes: Fix the [__indirect_thunk_start, ..end] range
Date:   Wed,  5 Jul 2023 10:15:45 +0200
Message-Id: <20230705081547.25130-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Fix problems with an output position of thunk sections and the
associated definition of range [__indirect_thunk_start,
__indirect_thunk_end] which affects the kprobes optimization.

Petr Pavlu (2):
  x86/retpoline,kprobes: Fix position of thunk sections with
    CONFIG_LTO_CLANG
  x86/retpoline,kprobes: Avoid treating rethunk as an indirect jump

 arch/x86/kernel/vmlinux.lds.S | 4 +---
 arch/x86/lib/retpoline.S      | 8 ++++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.35.3

