Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E224C77B78
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  4 May 2023 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjEDO7d (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 4 May 2023 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjEDO7J (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:59:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D222D7C
        for <linux-trace-kernel@vger.kernel.org>; Thu,  4 May 2023 07:58:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3064099f9b6so422245f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 May 2023 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683212324; x=1685804324;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBMo/EIkGym5CsFwSf/m+tZPgy36IMdnUP4Ys9HtEAo=;
        b=EORlQYepVljQy1nVawpVkXfJ2rQijHa9PpGhJKZNLG3r421tBoMd+rtS3i127DO1wP
         CHAZI3gfzoVLfAtLyvJHe3r3yn/5N1mMpu2/SMywt3IYXHGi8ocIL9hXbmkrfHakVXZX
         ltmEoZqZOPBeiNxdc7ywwHUSBYOEZut2lifnTZXDG8D5+Spiy4/6Y79BLI+19Pq50eay
         rRR0XedReHLJ3ELK1QJnBzjPHjL+PY0x8Hb/sQwdfXKyXcfFVxy/0SHzR84QWiFudfwj
         E3o5ZS6r3sWZH5UaDMZx7GdfpsQSbsEOgrQ2MoHkBZfM71db3ifDG6VuJwiVW0MMq82v
         e61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212324; x=1685804324;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBMo/EIkGym5CsFwSf/m+tZPgy36IMdnUP4Ys9HtEAo=;
        b=KjPuzrbrTEkjx2+Telxxi4UEgJpB5P75dNnwXCGYh5g4svXVlOUqH7CEGxGSuRTMvD
         24X9LG2cSQke4qXOoeyD0t9lIJw0L7Chvs+W4subZ+1KK7ds1jHLIJZKflwi1nNZyqhW
         tc4gbfYvNJMakcgyOJmPrGLokRzPVzb6zUuaxTeB2jOlO+p3v+th2rsJIMf57ubrVMaf
         j6KPepOnn1JZHTMCVwJ1LTcKsrn+OU8hJLlbo9mGzfCNir7tP/CLaxgN2DmiEOKLI92+
         ERcnziLAIeMSWIKy86zWT6umNNJRxxz218WBdZoQA73eKDGJUr4OVDwirQAw3IgKHgZV
         b8BA==
X-Gm-Message-State: AC+VfDxisYySlR2+9yqyQRD9zwBfsozLuvAc24iQYTQaq5L8XawGyj+B
        38t2KaT4G1U7gAtcBJMLF3v3Pg6TiGlNx9JtfIs=
X-Google-Smtp-Source: ACHHUZ4WQI8bMTJYvqirQVWruukRwNtT/VC/i7yd+2EWqDTORnYv6fEvMB+7UatZMGkO48pU55/LcQ==
X-Received: by 2002:adf:fc83:0:b0:306:3be9:6ab with SMTP id g3-20020adffc83000000b003063be906abmr2961099wrr.54.1683212324478;
        Thu, 04 May 2023 07:58:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d60c9000000b002fbdb797483sm36768730wrt.49.2023.05.04.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:58:43 -0700 (PDT)
Date:   Thu, 4 May 2023 14:57:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     beaub@linux.microsoft.com
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing/user_events: Add ioctl for disabling addresses
Message-ID: <6f758683-4e5e-41c3-9b05-9efc703e827c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Beau Belgrave,

The patch dcb8177c1395: "tracing/user_events: Add ioctl for disabling
addresses" from Mar 28, 2023, leads to the following Smatch static
checker warning:

	kernel/trace/trace_events_user.c:2278 user_events_ioctl_unreg()
	warn: passing casted pointer '&enabler->values' to 'generic_test_bit()' 32 vs 64.

kernel/trace/trace_events_user.c
    2246 static long user_events_ioctl_unreg(unsigned long uarg)
    2247 {
    2248         struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
    2249         struct user_event_mm *mm = current->user_event_mm;
    2250         struct user_event_enabler *enabler, *next;
    2251         struct user_unreg reg;
    2252         long ret;
    2253 
    2254         ret = user_unreg_get(ureg, &reg);
    2255 
    2256         if (ret)
    2257                 return ret;
    2258 
    2259         if (!mm)
    2260                 return -ENOENT;
    2261 
    2262         ret = -ENOENT;
    2263 
    2264         /*
    2265          * Flags freeing and faulting are used to indicate if the enabler is in
    2266          * use at all. When faulting is set a page-fault is occurring asyncly.
    2267          * During async fault if freeing is set, the enabler will be destroyed.
    2268          * If no async fault is happening, we can destroy it now since we hold
    2269          * the event_mutex during these checks.
    2270          */
    2271         mutex_lock(&event_mutex);
    2272 
    2273         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
    2274                 if (enabler->addr == reg.disable_addr &&
    2275                     (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
    2276                         set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
    2277 
--> 2278                         if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))

This patch just warns about suspicious casting really...  There is a
hidden cast in ENABLE_BITOPS().

The concern is that this would lead to memory corruption on big endian
64bit machines.  Those are not super common in real life...  But why not
just declare enabler->values as an unsigned long.  64bit systems are
going to have a struct hole after ->values anyway so it doesn't use any
more space than before.

    2279                                 user_event_enabler_destroy(enabler);
    2280 
    2281                         /* Removed at least one */
    2282                         ret = 0;
    2283                 }
    2284 
    2285         mutex_unlock(&event_mutex);
    2286 
    2287         /* Ensure bit is now cleared for user, regardless of event status */
    2288         if (!ret)
    2289                 ret = user_event_mm_clear_bit(mm, reg.disable_addr,
    2290                                               reg.disable_bit);
    2291 
    2292         return ret;
    2293 }

regards,
dan carpenter
