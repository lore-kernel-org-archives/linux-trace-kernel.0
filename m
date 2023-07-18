Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454EC001DC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 18 Jul 2023 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjGRN4g (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGRN4f (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEB19BB;
        Tue, 18 Jul 2023 06:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68C8615A1;
        Tue, 18 Jul 2023 13:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74FCC433C7;
        Tue, 18 Jul 2023 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688571;
        bh=nnPZWvHoY77kG+SlMvaG8lbC6DoL7efDVhXqdZCs0cM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FaCU7LUNmr/X9YbW9RKlcMSPENlNZ2aELn1oB4f8Y561tZHX90uV5O+hqrXC8U3uM
         PlOX9wh1S6VfH8Zn3eDDfVSPPeOl7GEtZv22cpSH3TA7Dt6qOasGbtjOJmzwSUekvH
         ceDAYVf6T11lnyqChkIGSforIJ6lTDBIoQB9sPRzSmtDJyZ1vwDhoNFBybF6XO6A7C
         NN+NLNgcwVD56081TuoG9F3We5veJ1UrqRhfoNRXBD7+7EebQqcr5IwhDIsxZ0uXHX
         Q0lkneQl6jC0HZR3+ZrcBmBLLN0L5QCwDjmnpYH14xkJoFBoQ/foxTznXusKc3YryY
         DsM6N9tkz/vgw==
Date:   Tue, 18 Jul 2023 22:56:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Donglin Peng <dolinux.peng@gmail.com>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718225606.926222723cdd8c2c37294e41@kernel.org>
In-Reply-To: <20230718194431.5653b1e89841e6abd9742ede@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
        <20230718194431.5653b1e89841e6abd9742ede@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 18 Jul 2023 19:44:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > >                                                    bool tracepoint)
> > >  {
> > > +       struct btf *btf = traceprobe_get_btf();
> > 
> > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > if the function is
> > defined in a kernel module, we should get the module's btf.
> > 
> 
> Good catch! That should be a separated fix (or improvement?)
> I think it's better to use btf_get() and btf_put(), and pass btf via
> traceprobe_parse_context.

Hmm, it seems that there is no exposed API to get the module's btf.
Should I use btf_idr and btf_idr_lock directly to find the corresponding
btf? If there isn't yet, I will add it too.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
