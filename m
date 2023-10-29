Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9636CA7C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxGW87Rv"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385819B;
	Sun, 29 Oct 2023 10:05:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c77449a6daso31777695ad.0;
        Sun, 29 Oct 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698599141; x=1699203941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JPSc4Nap6najUbfcZJRbqLOw6REvaIz1ji0EYTeQvI=;
        b=UxGW87RvTWdDYAwFynlBftvd1oxJKiDLfXiFXXBRWGMSJET+9qF+LHE71fRG6Q2Oz4
         yV71UDVBdYcu5pSxOvogu1Sm7TJAC1qjJLwE4KwvRQTfw/WOboIUaxNdnx86NxQ1fvS5
         zbc5FYlROXRA14jFw4XCBEckAeIT7oDeWyMiH4XlSr8c66/eyFSrOtnnJvtJlznKPGm4
         6gmwki30CWOWTkoOqAPGOUg2xmjA+DUGpR0eg6oStbpjbuaE7QR8g4GKAXWqGBiXgeQP
         plUMlIqr4S7ROlTphSec0ad2+0C2tZXf4Fn1k9l7ddjmes+/DIz7ze6Ak9iZfjmd4PbB
         YJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599141; x=1699203941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JPSc4Nap6najUbfcZJRbqLOw6REvaIz1ji0EYTeQvI=;
        b=j72z94LKt+8L9QpYcgLi19GelKJ8oOZ71NWEO2yp0P1/LUeXyGCp4UylFgzP6TaIpK
         ZMGMN/JxI5WXeYvo7VJT4B7IbGF6+mE8khKbrkCEZrpODG19JTtWfaHyVkyBjITfoaJ8
         CodxFoTfrDKiMydGKOxwYQ9fX8Oic6kMqw1klW5DZTkPW0P4sYYwZrtxOMdD9clBIiax
         m7P+YiekH5VcQv8JoOVzuqBhxZRsXcLMlRWf4WnTsdslvKie1ZOvFb9NYFu8laaU7vF6
         6tQTpLv2xR4NZBSqhMDKEiUZA/aki0wdley6ZdEG8laiAmGxD/+RKHN6enDis/lLcRGd
         V5Ww==
X-Gm-Message-State: AOJu0YwoFKm9dVSj+by1VJNFI0kpACgwrL3i/oOGWXg6VY6SOPvEItcr
	1+AQ5ThjyNT5RZ6FW1XMWrE=
X-Google-Smtp-Source: AGHT+IGCgrxTHFvYOhs4bQfWwClZD5OD5HjudhRP7kkNt7ZVzebQAHEmcUxWpPNrZRsa11c49xqzMA==
X-Received: by 2002:a17:902:d4c6:b0:1c5:ba50:2b28 with SMTP id o6-20020a170902d4c600b001c5ba502b28mr9032847plg.25.1698599141328;
        Sun, 29 Oct 2023 10:05:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001b81a97860asm2778266plk.27.2023.10.29.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 10:05:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 29 Oct 2023 10:05:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	sander@svanheule.net, ebiggers@google.com, dan.j.williams@intel.com,
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
	mattwu@163.com
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Message-ID: <b579d68f-f2ec-42ef-8366-6878c9930e0c@roeck-us.net>
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023112452.6290-1-wuqiang.matt@bytedance.com>

On Mon, Oct 23, 2023 at 07:24:52PM +0800, wuqiang.matt wrote:
> The objpool_push can only happen on local cpu node, so only the local
> cpu can touch slot->tail and slot->last, which ensures the correctness
> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
> of try_cmpxchg_acquire).
> 
> Testing with IACA found the lock version of pop/push pair costs 16.46
> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
> is improved to 1.019 times of the lock version for x86_64 systems.
> 
> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> 
>                  1T         2T         4T         8T        16T
>   lock:    29909085   59865637  119692073  239750369  478005250
>   local:   30297523   60532376  121147338  242598499  484620355
>                 32T        48T        64T        96T       128T
>   lock:   957553042 1435814086 1680872925 2043126796 2165424198
>   local:  968526317 1454991286 1861053557 2059530343 2171732306
> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>

This patch results in

lib/objpool.c:169:12: error: implicit declaration of function 'arch_cmpxchg_local' is invalid in C99

or

lib/objpool.c: In function 'objpool_try_add_slot':
include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'

for various architectures (I have seen it with arc, hexagon, and openrisc
so far).

As usual, my apologies for the noise if this has already been reported
and/or fixed.

Guenter
