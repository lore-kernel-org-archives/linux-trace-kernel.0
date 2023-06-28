Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAEBEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 28 Jun 2023 00:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjF1AKF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 27 Jun 2023 20:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1AKE (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BDA2119
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2286124B
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51575C433C8;
        Wed, 28 Jun 2023 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687911002;
        bh=HbULSK0GhW+/aJvOMjSjqEeEE0JdkgfD+IW3AsQwRYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q31WM5KIXcDbk4cumWYfK5EDjhh0mNfdZosvHFieb4A4r01rY8ztM8qQXm5Gzl5OR
         BYbbd/Dzt5m1+0SUSBwrudSGbwGSH6C7jk2CMq063NYdqbwkiFGY3EMS4mMGfY7bPQ
         kYs/+bG2QcaKtMhpMYDcA3RqGHkAzx6SRmcInnEF8CaIUZEMHHr2UKF6TSvtJzl/tT
         ulq0Nj4KXOED96bzKWnT8I7YUypOqSP4Eav39yJfP7DiL3Ytl2LuHHk8/EmkP/Vg5M
         eJlTyv4qpmXPM5xxKSm7+NVKWJ7SmSluOonGw3k7G2I2bsvayBJr7NZV/j1blktv4J
         LqnuEM306tB+g==
Date:   Wed, 28 Jun 2023 09:09:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing: probeevent: Add array type support
Message-Id: <20230628090958.68d85e87bab648bd70563d57@kernel.org>
In-Reply-To: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 26 Jun 2023 17:33:21 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Masami Hiramatsu,
> 
> The patch 40b53b771806: "tracing: probeevent: Add array type support"
> from Apr 25, 2018, leads to the following Smatch static checker
> warning:
> 
> 	kernel/trace/trace_probe_tmpl.h:207 process_fetch_insn_bottom()
> 	warn: using error codes for math 'ret'
> 
> kernel/trace/trace_probe_tmpl.h
>     122 static nokprobe_inline int
>     123 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>     124                            void *dest, void *base)
>     125 {
>     126         struct fetch_insn *s3 = NULL;
>     127         int total = 0, ret = 0, i = 0;
>     128         u32 loc = 0;
>     129         unsigned long lval = val;
>     130 
>     131 stage2:
>     132         /* 2nd stage: dereference memory if needed */
>     133         do {
>     134                 if (code->op == FETCH_OP_DEREF) {
>     135                         lval = val;
>     136                         ret = probe_mem_read(&val, (void *)val + code->offset,
>     137                                              sizeof(val));
>     138                 } else if (code->op == FETCH_OP_UDEREF) {
>     139                         lval = val;
>     140                         ret = probe_mem_read_user(&val,
>     141                                  (void *)val + code->offset, sizeof(val));
>     142                 } else
>     143                         break;
>     144                 if (ret)
>     145                         return ret;
>     146                 code++;
>     147         } while (1);
>     148 
>     149         s3 = code;
>     150 stage3:
>     151         /* 3rd stage: store value to buffer */
>     152         if (unlikely(!dest)) {
>     153                 switch (code->op) {
>     154                 case FETCH_OP_ST_STRING:
>     155                         ret = fetch_store_strlen(val + code->offset);
>     156                         code++;
>     157                         goto array;
>     158                 case FETCH_OP_ST_USTRING:
>     159                         ret += fetch_store_strlen_user(val + code->offset);
>     160                         code++;
>     161                         goto array;
>     162                 case FETCH_OP_ST_SYMSTR:
>     163                         ret += fetch_store_symstrlen(val + code->offset);
> 
> I think all these functions return zero on error.
> 
>     164                         code++;
>     165                         goto array;
>     166                 default:
>     167                         return -EILSEQ;
>     168                 }
>     169         }
>     170 
>     171         switch (code->op) {
>     172         case FETCH_OP_ST_RAW:
>     173                 fetch_store_raw(val, code, dest);
>     174                 break;
>     175         case FETCH_OP_ST_MEM:
>     176                 probe_mem_read(dest, (void *)val + code->offset, code->size);
>     177                 break;
>     178         case FETCH_OP_ST_UMEM:
>     179                 probe_mem_read_user(dest, (void *)val + code->offset, code->size);
>     180                 break;
>     181         case FETCH_OP_ST_STRING:
>     182                 loc = *(u32 *)dest;
>     183                 ret = fetch_store_string(val + code->offset, dest, base);
> 
> This function return -EFAULT if copy_from_user() fails.
> 
>     184                 break;
>     185         case FETCH_OP_ST_USTRING:
>     186                 loc = *(u32 *)dest;
>     187                 ret = fetch_store_string_user(val + code->offset, dest, base);
> 
> Same.
> 
>     188                 break;
>     189         case FETCH_OP_ST_SYMSTR:
>     190                 loc = *(u32 *)dest;
>     191                 ret = fetch_store_symstring(val + code->offset, dest, base);
> 
> My guess is that Smatch thinks this returns -ENOMEM.
> 
>     192                 break;
>     193         default:
>     194                 return -EILSEQ;
>     195         }
>     196         code++;
>     197 
>     198         /* 4th stage: modify stored value if needed */
>     199         if (code->op == FETCH_OP_MOD_BF) {
>     200                 fetch_apply_bitfield(code, dest);
>     201                 code++;
>     202         }
>     203 
>     204 array:
>     205         /* the last stage: Loop on array */
>     206         if (code->op == FETCH_OP_LP_ARRAY) {
> --> 207                 total += ret;
> 
> This is an unpublished check because I need to go through and make a
> list of all the functions which can't fail in real life.  But the rule
> here is that Smatch doesn't like adding error codes to anything.

Good catch! Yes, that is a problem. Let me fix that.

Thanks!

> 
>     208                 if (++i < code->param) {
>     209                         code = s3;
>     210                         if (s3->op != FETCH_OP_ST_STRING &&
>     211                             s3->op != FETCH_OP_ST_USTRING) {
>     212                                 dest += s3->size;
>     213                                 val += s3->size;
>     214                                 goto stage3;
>     215                         }
>     216                         code--;
>     217                         val = lval + sizeof(char *);
>     218                         if (dest) {
>     219                                 dest += sizeof(u32);
>     220                                 *(u32 *)dest = update_data_loc(loc, ret);
>     221                         }
>     222                         goto stage2;
>     223                 }
>     224                 code++;
>     225                 ret = total;
>     226         }
>     227 
>     228         return code->op == FETCH_OP_END ? ret : -EILSEQ;
>     229 }
> 
> regards,
> dan carpenter


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
