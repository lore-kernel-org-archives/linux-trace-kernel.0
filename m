Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612E7C001DF
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 26 Jul 2023 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGZUe0 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZUe0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:34:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0A2701;
        Wed, 26 Jul 2023 13:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E5961C50;
        Wed, 26 Jul 2023 20:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5987C433C7;
        Wed, 26 Jul 2023 20:34:20 +0000 (UTC)
Date:   Wed, 26 Jul 2023 16:34:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v5 07/10] eventfs: Implement functions to create files
 and dirs when accessed
Message-ID: <20230726163359.5c0f247b@rorschach.local.home>
In-Reply-To: <1690054625-31939-8-git-send-email-akaher@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
        <1690054625-31939-8-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 23 Jul 2023 01:07:02 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -23,6 +23,13 @@ struct file_operations;
>  
>  struct eventfs_file;
>  
> +struct dentry *eventfs_start_creating(const char *name,
> +				      struct dentry *parent);
> +
> +struct dentry *eventfs_failed_creating(struct dentry *dentry);
> +
> +struct dentry *eventfs_end_creating(struct dentry *dentry);
> +

These should go into the internal.h header and not be exposed to users
of tracefs.

-- Steve
