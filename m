Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D197C77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 13 May 2023 04:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEMESD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 13 May 2023 00:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMESC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 13 May 2023 00:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4CA3C1E;
        Fri, 12 May 2023 21:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9EA860BEA;
        Sat, 13 May 2023 04:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97846C433EF;
        Sat, 13 May 2023 04:17:59 +0000 (UTC)
Date:   Sat, 13 May 2023 00:17:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-ID: <20230513001757.75ae0d1b@rorschach.local.home>
In-Reply-To: <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
References: <20230510122045.2259-1-zegao@tencent.com>
        <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
        <ZFvUH+p0ebcgnwEg@krava>
        <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
        <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 12 May 2023 07:29:02 -0700
Yonghong Song <yhs@meta.com> wrote:

> A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> quite different... Thanks for working on this.

Hmm, I think I see the problem:

fprobe_kprobe_handler() {
   kprobe_busy_begin() {
      preempt_disable() {
         preempt_count_add() {  <-- trace
            fprobe_kprobe_handler() {
		[ wash, rinse, repeat, CRASH!!! ]

Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
versions, or fprobe_kprobe_handle() needs a
ftrace_test_recursion_trylock() call.

-- Steve
