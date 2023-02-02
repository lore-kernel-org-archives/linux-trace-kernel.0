Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A59C05027
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Feb 2023 12:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBBMuv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBBMuu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:50:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C3540D2
        for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:50:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3651468wmb.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUjgR4xHlaACr4TQRqFooxU8k+EYMOnvAtOsfvgaNvM=;
        b=Pnet4SXIg9jq/fxFR7ECFSKcefF5q3TM/kUH+NVSyJgFg7kB3bvTSmZ+JJivhifa4k
         6R1g3NvnAkZGKCmqGtz7HrjSHRv8xAMQZaGjI14aPdCKfgAS6J0rebTWqmCGWriCmdSg
         SbsmR5GmJapD6fxtxovg0t+yLKq62BNHZsUADyC9jf8AJn5AHtrDRj9lwGjtlIBufYhW
         hz4ELUKCQsHOv9MGmY++pDBUcIPQoYKPdhc4UBi7qtpBxm54iIL//4OiGRKZ2pkoyNcY
         WZzH5lTcQELvq3/UVyvYSCXDd248qniLQ7g4MYdDSBP60pv3TufnADlZrZWWO4vfYf8L
         3o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUjgR4xHlaACr4TQRqFooxU8k+EYMOnvAtOsfvgaNvM=;
        b=DOyvEiXUVExUMDJk3AZmRkxafIt1O7ag13Zlce24wSEPp7jmWHPuY7DdopnvifZvUi
         2a5yXvYw87ewJ7q2LA+YZ0hhMN3b8HbOoIyq2qg5+BSgtFSLTQiUjk39tSxQkSkbAGJw
         eMSTLkwzIBR+8qbwGI8erhFDQ+WNqHxDf2on/oaps2AcVgFVdcqiyWztHdVTO9XXvtlH
         yT4R+ckTbvBt4osrb38AZe2K9ujMrMs0zlk2rOJ4iviHC9aAtESwVF6NDjIbjmk6atPb
         MBjEsjEyf4VDFIBTKYSYKTN+QmqtRprjZgPZT0BIbfoVM9mdr2DjbMxd/F8/e84upJFv
         iKBg==
X-Gm-Message-State: AO0yUKUGamw2C3W/lx7NGIejFXhgGYDdcbXLfSagZ/YH0lp59pjABnyD
        t04C0XzOwsbnu0d//od5zD6fMFtlSQU=
X-Google-Smtp-Source: AK7set8Npdom/6Ab01rx/ZQwXV6xEXnCB6T8XBiXq12kydnC71iL3vOvk2mGVCIYTt9NkXGqMxXaeg==
X-Received: by 2002:a05:600c:4f10:b0:3dc:58b9:83f7 with SMTP id l16-20020a05600c4f1000b003dc58b983f7mr5976636wmq.35.1675342247692;
        Thu, 02 Feb 2023 04:50:47 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b003de664d4c14sm4526945wmh.36.2023.02.02.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:50:47 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:50:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing: Allow synthetic events to pass around
 stacktraces
Message-ID: <Y9uxjD7jwHbjJB1G@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Steven Rostedt (Google),

The patch 00cf3d672a9d: "tracing: Allow synthetic events to pass
around stacktraces" from Jan 17, 2023, leads to the following Smatch
static checker warning:

	kernel/trace/trace_events_synth.c:567 trace_event_raw_event_synth()
	warn: inconsistent indenting

kernel/trace/trace_events_synth.c
    515 static notrace void trace_event_raw_event_synth(void *__data,
    516                                                 u64 *var_ref_vals,
    517                                                 unsigned int *var_ref_idx)
    518 {
    519         unsigned int i, n_u64, val_idx, len, data_size = 0;
    520         struct trace_event_file *trace_file = __data;
    521         struct synth_trace_event *entry;
    522         struct trace_event_buffer fbuffer;
    523         struct trace_buffer *buffer;
    524         struct synth_event *event;
    525         int fields_size = 0;
    526 
    527         event = trace_file->event_call->data;
    528 
    529         if (trace_trigger_soft_disabled(trace_file))
    530                 return;
    531 
    532         fields_size = event->n_u64 * sizeof(u64);
    533 
    534         for (i = 0; i < event->n_dynamic_fields; i++) {
    535                 unsigned int field_pos = event->dynamic_fields[i]->field_pos;
    536                 char *str_val;
    537 
    538                 val_idx = var_ref_idx[field_pos];
    539                 str_val = (char *)(long)var_ref_vals[val_idx];
    540 
    541                 len = kern_fetch_store_strlen((unsigned long)str_val);
    542 
    543                 fields_size += len;
    544         }
    545 
    546         /*
    547          * Avoid ring buffer recursion detection, as this event
    548          * is being performed within another event.
    549          */
    550         buffer = trace_file->tr->array_buffer.buffer;
    551         ring_buffer_nest_start(buffer);
    552 
    553         entry = trace_event_buffer_reserve(&fbuffer, trace_file,
    554                                            sizeof(*entry) + fields_size);
    555         if (!entry)
    556                 goto out;
    557 
    558         for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
    559                 val_idx = var_ref_idx[i];
    560                 if (event->fields[i]->is_string) {
    561                         char *str_val = (char *)(long)var_ref_vals[val_idx];
    562 
    563                         len = trace_string(entry, event, str_val,
    564                                            event->fields[i]->is_dynamic,
    565                                            data_size, &n_u64);
    566                         data_size += len; /* only dynamic string increments */
--> 567                 } if (event->fields[i]->is_stack) {

else if intended?

    568                         long *stack = (long *)(long)var_ref_vals[val_idx];
    569 
    570                         len = trace_stack(entry, event, stack,
    571                                            data_size, &n_u64);
    572                         data_size += len;
    573                 } else {
    574                         struct synth_field *field = event->fields[i];
    575                         u64 val = var_ref_vals[val_idx];
    576 
    577                         switch (field->size) {
    578                         case 1:
    579                                 *(u8 *)&entry->fields[n_u64] = (u8)val;
    580                                 break;
    581 
    582                         case 2:
    583                                 *(u16 *)&entry->fields[n_u64] = (u16)val;
    584                                 break;
    585 
    586                         case 4:
    587                                 *(u32 *)&entry->fields[n_u64] = (u32)val;
    588                                 break;
    589 
    590                         default:
    591                                 entry->fields[n_u64] = val;
    592                                 break;
    593                         }
    594                         n_u64++;
    595                 }
    596         }
    597 
    598         trace_event_buffer_commit(&fbuffer);
    599 out:
    600         ring_buffer_nest_end(buffer);
    601 }

regards,
dan carpenter
