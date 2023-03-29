Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA79C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 13:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2NOj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2NOi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADA26BA;
        Wed, 29 Mar 2023 06:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9992B61CEB;
        Wed, 29 Mar 2023 13:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D76C433D2;
        Wed, 29 Mar 2023 13:14:36 +0000 (UTC)
Date:   Wed, 29 Mar 2023 09:14:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329091429.03d52dcc@rorschach.local.home>
In-Reply-To: <ZCQ4sXq0gmkgJvIe@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <ZCQtpbyWrjliJkdg@google.com>
        <20230329084735.6c4a9229@rorschach.local.home>
        <ZCQ4sXq0gmkgJvIe@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 29 Mar 2023 14:10:09 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> The v2 of this series only updates the head page in the update ioctl
> (ring_buffer_update_meta_page()) Couldn't find a nice way around that as it can
> be either updated by the reader or the writer. So the best solution seemed a
> call to set_head_page().

Yes, the update will race between readers and writers. Let's not worry
about this at the moment and not expose it yet. I'm looking at other
ways around this too.

-- Steve
