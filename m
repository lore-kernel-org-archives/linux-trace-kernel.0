Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B814C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 09:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCUJR6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCUJR5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:17:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B151A274B7
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:17:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l27so4561642wrb.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679390274;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8K/+NiN4CjC/yD8zoZTSu7i8Ui+vcohUaEzpKL14xn0=;
        b=K306WyzlUCaeIejpVC7J8OxDm5GiJd0JYcpGfNPDZbqNe5JpWSUqGQ93eDuz67VPF1
         634FhXZXFXUClby4TyKP36IMjyu+1AxHX7cQfnyJdTdF6hFahK5DPNiSD0I+BUiacecC
         XRsHmktUnPyoJzgBV7SGGxz3MBtUaG2Gf1MzXslOZJ2ah1ueHFNwKG6e5qIZ87Mr20G8
         pEdwwFYPdb6DFA5hywiXhboNftm4y1BoQvlGzpug5X9UYyrlCAhpinIOahqmP7B+SR3N
         hvTl1KRd7iaupaU0F/wPZto6+IwobHWZf2EfnSmkfv+YIf2dnPKTJe7ghzdIOfVJQ2Op
         pg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390274;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K/+NiN4CjC/yD8zoZTSu7i8Ui+vcohUaEzpKL14xn0=;
        b=NbZBR78gylgmv1+yEieTTNINLUrI6JC/Mz2UMEAxptFoULXjn6hnBmGiydsoh5eGc1
         H8Zdh+1DdSqfpS6MJ4azFai9Z8mAFxc8Oloe/IYSnY9cc3Y1En65ADe1P9VYMIH8ZMxV
         bpWVaRWgip5orRYIh3IpY4ZfGd/qVPplUYjrthIlIOIBMGs1JmZe957x2rMVdvyxvGOe
         b+FhT5fDprdbyLt3JK4JbycN3M+vq64LF/5nxHx9b9XugyqjEnviEB9Fe2XUWSwr+Gl6
         FSSsRRjNQSUzEGhOpTQjjEjdO7oty+bWAbRLsxA9sUK4ouIsRmTcDgcOZUzOMOw7NFiK
         aYWg==
X-Gm-Message-State: AO0yUKX0W6IrPUheTaLa3uWft7B/GVC2WR5H7UW5LpiPnGIg9tJiG72T
        Tdwrlj2KrV5iwAmklcGlKVs1urcSdEA=
X-Google-Smtp-Source: AK7set/pn/21uLxjHauyur2fEYUzyY8w44WUXyHRRRimFgUwqBfdSx73HhjPm4BnzRxG7bl4SFUCtg==
X-Received: by 2002:adf:e388:0:b0:2d3:b899:8a64 with SMTP id e8-20020adfe388000000b002d3b8998a64mr1860179wrm.55.1679390274107;
        Tue, 21 Mar 2023 02:17:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm10939571wrr.79.2023.03.21.02.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:17:53 -0700 (PDT)
Date:   Tue, 21 Mar 2023 12:17:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] ftrace: Store the order of pages allocated in
 ftrace_page
Message-ID: <26c8bb78-5645-4405-a9df-a19a089a611e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

[ I decided to bother Steven instead of Linus with this ancient bug
  report.  -dan ]

Hello Linus Torvalds,

The patch db42523b4f3e: "ftrace: Store the order of pages allocated
in ftrace_page" from Apr 1, 2021, leads to the following Smatch
static checker warning:

	kernel/trace/ftrace.c:7468 ftrace_free_mem()
	warn: variable dereferenced before check 'pg->records' (see line 7448)

kernel/trace/ftrace.c
    7420 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
    7421 {
    7422         unsigned long start = (unsigned long)(start_ptr);
    7423         unsigned long end = (unsigned long)(end_ptr);
    7424         struct ftrace_page **last_pg = &ftrace_pages_start;
    7425         struct ftrace_page *pg;
    7426         struct dyn_ftrace *rec;
    7427         struct dyn_ftrace key;
    7428         struct ftrace_mod_map *mod_map = NULL;
    7429         struct ftrace_init_func *func, *func_next;
    7430         struct list_head clear_hash;
    7431 
    7432         INIT_LIST_HEAD(&clear_hash);
    7433 
    7434         key.ip = start;
    7435         key.flags = end;        /* overload flags, as it is unsigned long */
    7436 
    7437         mutex_lock(&ftrace_lock);
    7438 
    7439         /*
    7440          * If we are freeing module init memory, then check if
    7441          * any tracer is active. If so, we need to save a mapping of
    7442          * the module functions being freed with the address.
    7443          */
    7444         if (mod && ftrace_ops_list != &ftrace_list_end)
    7445                 mod_map = allocate_ftrace_mod_map(mod, start, end);
    7446 
    7447         for (pg = ftrace_pages_start; pg; last_pg = &pg->next, pg = *last_pg) {
    7448                 if (end < pg->records[0].ip ||
    7449                     start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))

Unchecked dereferences.

    7450                         continue;
    7451  again:
    7452                 rec = bsearch(&key, pg->records, pg->index,
    7453                               sizeof(struct dyn_ftrace),
    7454                               ftrace_cmp_recs);
    7455                 if (!rec)
    7456                         continue;

bsearch() can't return non-NULL if pg->records is NULL.

    7457 
    7458                 /* rec will be cleared from hashes after ftrace_lock unlock */
    7459                 add_to_clear_hash_list(&clear_hash, rec);
    7460 
    7461                 if (mod_map)
    7462                         save_ftrace_mod_rec(mod_map, rec);
    7463 
    7464                 pg->index--;
    7465                 ftrace_update_tot_cnt--;
    7466                 if (!pg->index) {
    7467                         *last_pg = pg->next;
--> 7468                         if (pg->records) {

I think this NULL check can be deleted, yeah?

    7469                                 free_pages((unsigned long)pg->records, pg->order);
    7470                                 ftrace_number_of_pages -= 1 << pg->order;
    7471                         }
    7472                         ftrace_number_of_groups--;
    7473                         kfree(pg);
    7474                         pg = container_of(last_pg, struct ftrace_page, next);
    7475                         if (!(*last_pg))
    7476                                 ftrace_pages = pg;
    7477                         continue;
    7478                 }
    7479                 memmove(rec, rec + 1,
    7480                         (pg->index - (rec - pg->records)) * sizeof(*rec));
    7481                 /* More than one function may be in this block */
    7482                 goto again;
    7483         }
    7484         mutex_unlock(&ftrace_lock);
    7485 
    7486         list_for_each_entry_safe(func, func_next, &clear_hash, list) {
    7487                 clear_func_from_hashes(func);
    7488                 kfree(func);
    7489         }
    7490 }

regards,
dan carpenter
