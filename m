Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0AC77B7E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 25 May 2023 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbjEYOQP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 25 May 2023 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEYOQO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C3183;
        Thu, 25 May 2023 07:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F82164610;
        Thu, 25 May 2023 14:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A7CC433D2;
        Thu, 25 May 2023 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685024172;
        bh=N10Xh9Jo2X7q40vW1TQk3XJXStUWPtezpNSxbAU/zag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L40dSOEfKkgy2DcAQS4c6miQaY5NazUDb9rtKgkFSbFms7IPoPVKWVGVy1e6ASpqa
         f4f0t8iakbp+Emcod1MCdXDcg2CsJDV6rjwPjUu6QRnWPCmWShEqcsq/NG6sk5iHqH
         7lQ6UrC+1vB8RsKgxg7puOoWXy4I3GN/Y2v9WtLNh8aBHlXqbVqhKG7cl1cqiRuW7+
         pJlCxrH/H4OaoRiBqUA7AF9QCLrDhH/hYtOsC86cA0Ft2gBgLlum+AQtU6+EbZ8Bc8
         JML2bUgdlMHRZOPZ3hOFZpA9mp6R6+68ROx8C7tazMxTRML40bnOgmxMWipuEDseAo
         MVEa7MhZLvd+g==
Message-ID: <4f8f78c4-2af5-5089-a243-2df1c7cfb2d3@kernel.org>
Date:   Thu, 25 May 2023 16:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/3] tracing/timerlat: Add user-space interface
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <a7b2c215c763e95a56fa1258743332b570c81c9d.1684860626.git.bristot@kernel.org>
 <202305242020.VlsOXEMn-lkp@intel.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <202305242020.VlsOXEMn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 5/24/23 14:48, kernel test robot wrote:
> Hi Daniel,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.4-rc3 next-20230524]
> [cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/tracing-osnoise-Switch-from-PF_NO_SETAFFINITY-to-migrate_disable/20230524-012512
> base:   linus/master
> patch link:    https://lore.kernel.org/r/a7b2c215c763e95a56fa1258743332b570c81c9d.1684860626.git.bristot%40kernel.org
> patch subject: [PATCH V2 3/3] tracing/timerlat: Add user-space interface
> config: i386-randconfig-i014-20230523
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/89216b54eaf490480bc1929f5780f95a688a91bb
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/tracing-osnoise-Switch-from-PF_NO_SETAFFINITY-to-migrate_disable/20230524-012512
>         git checkout 89216b54eaf490480bc1929f5780f95a688a91bb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 olddefconfig
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305242020.VlsOXEMn-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace_osnoise.c: In function 'timerlat_fd_open':
>>> kernel/trace/trace_osnoise.c:2364:16: error: implicit declaration of function 'this_cpu_tmr_var'; did you mean 'this_cpu_osn_var'? [-Werror=implicit-function-declaration]
>     2364 |         tlat = this_cpu_tmr_var();
>          |                ^~~~~~~~~~~~~~~~
>          |                this_cpu_osn_var


Thanks robot, I forgot to test without timerlat enabled. Easy to fix, an ifdef
here and there.

-- Daniel
