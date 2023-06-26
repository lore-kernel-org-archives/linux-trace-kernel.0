Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B8EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 26 Jun 2023 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFZOdc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 26 Jun 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFZOda (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:33:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9D19F
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:33:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so2893796f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687790007; x=1690382007;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuPpt2a7e3qt/qKOQkrj6fV1TjEcFhIBWSuInyQ3BcY=;
        b=XszwfLgno3zi1nyS1sY4svZZ6Ow5A9U67atgROgls9vTUt9CnzFQajVJsFGooDgYDm
         /Aip7sjOi1N9NX9ENXIJ8F7vpOJvgvlmgicubEIep+b3v5+kg3SQcdn6Djzw7w8wW3d0
         mBqiWMxD69ha5f4cBG/5O6XMPK/J0H/KqdqNjH/lvLakLhiy89No03zZJF5vX4nqWx87
         NZLcex3mEDsxa0Hpp71TIR81m+hSbqPojLVTcbxAWuIbd0D2nv9uklYX3aq0dv+7NW69
         bjhmmvRfKqTnD29gi/EhfGJOQg7lUKt51L754VbxSlb1KGZMLrRsSmkJ1igkG+5sXHz9
         O9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790007; x=1690382007;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuPpt2a7e3qt/qKOQkrj6fV1TjEcFhIBWSuInyQ3BcY=;
        b=F+7xLfnHb9oNAjLnjbZQx+Pm7cJB0cdcttPjzwGEJbqiy+jBOJ5rrktIKyilCkGc8Q
         7Jc6kz2YCwSmgUO8R43WL661XnLrekyAj7/GbThoeFCHwHD5Pj6lmmiQzE85vK5vdhbn
         aVrtmsgczCu2gtvG/ioQIt/DE7R0MygUAsPqoXu9GST8siDPK78pNZGhp10TPGlwiN90
         MOXZAPh0sscUDnE/XkeQAhru7igqO92ROvV4Xuo6U5nVrV+hvy+Ff/5T6I+Y5oOKuGS9
         ZJQg5KVszos+2KF19NFhYGo82C3U3TZuuVNd9gPjsty2SGkurZbultr89MXJ2zTBdrwq
         0Pkw==
X-Gm-Message-State: AC+VfDyB1LpaqI+CBL9fz7aXzmNRY9NjvE6RYPkThiBg14NunNDtmevS
        yQdG+1dLr+CeroJtfMfPcr9jeGxtR/uGF3aopCs=
X-Google-Smtp-Source: ACHHUZ4mIuXobbkTU7Ue6dwb++EswvdOcjkaywbWqExRzvOnBWxWSuaSQ4yiwHI4vHcym6zQacdFQw==
X-Received: by 2002:adf:e910:0:b0:30f:c7e5:6176 with SMTP id f16-20020adfe910000000b0030fc7e56176mr27188015wrm.14.1687790007271;
        Mon, 26 Jun 2023 07:33:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b002fb60c7995esm7599648wrs.8.2023.06.26.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:33:25 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:33:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     mhiramat@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing: probeevent: Add array type support
Message-ID: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Masami Hiramatsu,

The patch 40b53b771806: "tracing: probeevent: Add array type support"
from Apr 25, 2018, leads to the following Smatch static checker
warning:

	kernel/trace/trace_probe_tmpl.h:207 process_fetch_insn_bottom()
	warn: using error codes for math 'ret'

kernel/trace/trace_probe_tmpl.h
    122 static nokprobe_inline int
    123 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
    124                            void *dest, void *base)
    125 {
    126         struct fetch_insn *s3 = NULL;
    127         int total = 0, ret = 0, i = 0;
    128         u32 loc = 0;
    129         unsigned long lval = val;
    130 
    131 stage2:
    132         /* 2nd stage: dereference memory if needed */
    133         do {
    134                 if (code->op == FETCH_OP_DEREF) {
    135                         lval = val;
    136                         ret = probe_mem_read(&val, (void *)val + code->offset,
    137                                              sizeof(val));
    138                 } else if (code->op == FETCH_OP_UDEREF) {
    139                         lval = val;
    140                         ret = probe_mem_read_user(&val,
    141                                  (void *)val + code->offset, sizeof(val));
    142                 } else
    143                         break;
    144                 if (ret)
    145                         return ret;
    146                 code++;
    147         } while (1);
    148 
    149         s3 = code;
    150 stage3:
    151         /* 3rd stage: store value to buffer */
    152         if (unlikely(!dest)) {
    153                 switch (code->op) {
    154                 case FETCH_OP_ST_STRING:
    155                         ret = fetch_store_strlen(val + code->offset);
    156                         code++;
    157                         goto array;
    158                 case FETCH_OP_ST_USTRING:
    159                         ret += fetch_store_strlen_user(val + code->offset);
    160                         code++;
    161                         goto array;
    162                 case FETCH_OP_ST_SYMSTR:
    163                         ret += fetch_store_symstrlen(val + code->offset);

I think all these functions return zero on error.

    164                         code++;
    165                         goto array;
    166                 default:
    167                         return -EILSEQ;
    168                 }
    169         }
    170 
    171         switch (code->op) {
    172         case FETCH_OP_ST_RAW:
    173                 fetch_store_raw(val, code, dest);
    174                 break;
    175         case FETCH_OP_ST_MEM:
    176                 probe_mem_read(dest, (void *)val + code->offset, code->size);
    177                 break;
    178         case FETCH_OP_ST_UMEM:
    179                 probe_mem_read_user(dest, (void *)val + code->offset, code->size);
    180                 break;
    181         case FETCH_OP_ST_STRING:
    182                 loc = *(u32 *)dest;
    183                 ret = fetch_store_string(val + code->offset, dest, base);

This function return -EFAULT if copy_from_user() fails.

    184                 break;
    185         case FETCH_OP_ST_USTRING:
    186                 loc = *(u32 *)dest;
    187                 ret = fetch_store_string_user(val + code->offset, dest, base);

Same.

    188                 break;
    189         case FETCH_OP_ST_SYMSTR:
    190                 loc = *(u32 *)dest;
    191                 ret = fetch_store_symstring(val + code->offset, dest, base);

My guess is that Smatch thinks this returns -ENOMEM.

    192                 break;
    193         default:
    194                 return -EILSEQ;
    195         }
    196         code++;
    197 
    198         /* 4th stage: modify stored value if needed */
    199         if (code->op == FETCH_OP_MOD_BF) {
    200                 fetch_apply_bitfield(code, dest);
    201                 code++;
    202         }
    203 
    204 array:
    205         /* the last stage: Loop on array */
    206         if (code->op == FETCH_OP_LP_ARRAY) {
--> 207                 total += ret;

This is an unpublished check because I need to go through and make a
list of all the functions which can't fail in real life.  But the rule
here is that Smatch doesn't like adding error codes to anything.

    208                 if (++i < code->param) {
    209                         code = s3;
    210                         if (s3->op != FETCH_OP_ST_STRING &&
    211                             s3->op != FETCH_OP_ST_USTRING) {
    212                                 dest += s3->size;
    213                                 val += s3->size;
    214                                 goto stage3;
    215                         }
    216                         code--;
    217                         val = lval + sizeof(char *);
    218                         if (dest) {
    219                                 dest += sizeof(u32);
    220                                 *(u32 *)dest = update_data_loc(loc, ret);
    221                         }
    222                         goto stage2;
    223                 }
    224                 code++;
    225                 ret = total;
    226         }
    227 
    228         return code->op == FETCH_OP_END ? ret : -EILSEQ;
    229 }

regards,
dan carpenter
