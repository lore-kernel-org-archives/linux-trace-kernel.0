Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB1C7EE21
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  4 May 2023 17:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEDRbS (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 4 May 2023 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRbS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:31:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C93F526E
        for <linux-trace-kernel@vger.kernel.org>; Thu,  4 May 2023 10:31:17 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id A39AB20EA209;
        Thu,  4 May 2023 10:31:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A39AB20EA209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683221476;
        bh=VRq2HdOuHxLXd88diSRXezZdyPSd6O0qzLpvNeuRvzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqMhZuFzkABb9CFp76mWeMgsEMk77IUOoZGRHBCvO+UqcNnHvHrFjRB3j7gFHuGBD
         +obXBWyA8Tk2fSvTJBrcHd7oIeQLyQ3l/d7W/KJ98JW7BSv4liYl3pTxrPIeaqgDvN
         prDQwYnIjYbGJL0xFXVPfbGRc26P9PQef+lIJJBg=
Date:   Thu, 4 May 2023 10:31:10 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/user_events: Add ioctl for disabling
 addresses
Message-ID: <20230504173110.GA117@W11-BEAU-MD.localdomain>
References: <6f758683-4e5e-41c3-9b05-9efc703e827c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f758683-4e5e-41c3-9b05-9efc703e827c@kili.mountain>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, May 04, 2023 at 02:57:53PM +0300, Dan Carpenter wrote:
> Hello Beau Belgrave,
> 

Hey Dan, thanks for taking the time to report this.

> The patch dcb8177c1395: "tracing/user_events: Add ioctl for disabling
> addresses" from Mar 28, 2023, leads to the following Smatch static
> checker warning:
> 
> 	kernel/trace/trace_events_user.c:2278 user_events_ioctl_unreg()
> 	warn: passing casted pointer '&enabler->values' to 'generic_test_bit()' 32 vs 64.
> 
> kernel/trace/trace_events_user.c
>     2246 static long user_events_ioctl_unreg(unsigned long uarg)
>     2247 {
>     2248         struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
>     2249         struct user_event_mm *mm = current->user_event_mm;
>     2250         struct user_event_enabler *enabler, *next;
>     2251         struct user_unreg reg;
>     2252         long ret;
>     2253 
>     2254         ret = user_unreg_get(ureg, &reg);
>     2255 
>     2256         if (ret)
>     2257                 return ret;
>     2258 
>     2259         if (!mm)
>     2260                 return -ENOENT;
>     2261 
>     2262         ret = -ENOENT;
>     2263 
>     2264         /*
>     2265          * Flags freeing and faulting are used to indicate if the enabler is in
>     2266          * use at all. When faulting is set a page-fault is occurring asyncly.
>     2267          * During async fault if freeing is set, the enabler will be destroyed.
>     2268          * If no async fault is happening, we can destroy it now since we hold
>     2269          * the event_mutex during these checks.
>     2270          */
>     2271         mutex_lock(&event_mutex);
>     2272 
>     2273         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
>     2274                 if (enabler->addr == reg.disable_addr &&
>     2275                     (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
>     2276                         set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
>     2277 
> --> 2278                         if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
> 
> This patch just warns about suspicious casting really...  There is a
> hidden cast in ENABLE_BITOPS().
> 
> The concern is that this would lead to memory corruption on big endian
> 64bit machines.  Those are not super common in real life...  But why not
> just declare enabler->values as an unsigned long.  64bit systems are
> going to have a struct hole after ->values anyway so it doesn't use any
> more space than before.
> 

Good catch and points, I'll work on a fix. Changing to unsigned long vs
int requires a few places to change as well, but I think is the right
choice. The values is masked and passed as the bit to set/clear in
other places I'll need to clean up.

>     2279                                 user_event_enabler_destroy(enabler);
>     2280 
>     2281                         /* Removed at least one */
>     2282                         ret = 0;
>     2283                 }
>     2284 
>     2285         mutex_unlock(&event_mutex);
>     2286 
>     2287         /* Ensure bit is now cleared for user, regardless of event status */
>     2288         if (!ret)
>     2289                 ret = user_event_mm_clear_bit(mm, reg.disable_addr,
>     2290                                               reg.disable_bit);
>     2291 
>     2292         return ret;
>     2293 }
> 
> regards,
> dan carpenter

Thanks,
-Beau
