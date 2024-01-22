Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6B48CEF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959324; cv=none; b=SSARY6U6KiQN1Xl/hcartd1031+yPWUUThmrgRhjcmYdbX528BKZszt6jQK4QS8dKf3wZpJqwltQGC2DB8jI8BoHH/KJ90kgIkMi2MELXmU93dK9XJ4afCpnoa52f92FlgJP3R40cP0xPU13re7xa+uLLhzr2+UzW5+L7OUXY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959324; c=relaxed/simple;
	bh=tir7kge5xaX08VMRW1qUzxTUu9x6OO0aQSyK1LncuuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnLoh7hsMykozupqhrj2Q3ItPcmk2G+sOEIJuCRiae3Zfb9CL8MV3CIdOYogTiXxeaAOUVCGGimfhZvZ1ukbq3fDYHoCIqTNA8F0nIJsb08ZsABuiophAkkoMk8+q/EnvA7MDfweQz0Gh0WhLA4GqciCUjEUr/brnYhnQ394MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V4Rk67bh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4Rk67bh"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1371079a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959320; x=1706564120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=La/pQA6UxU8t2n1gEI32Cqq0uc4Tew1m9B7OoRZQ8SI=;
        b=V4Rk67bhj38bUYpTgO1fXNT7hlYfhelV36xIeufYYXG/jyrFnpW3z+ZFIoQNE/eiSz
         7F7EblPvj8mBUqZ4tkfYTHThHDwRYOueP8p409VYLs5dsXEPMFIurqLUt9qGQ1wNQpvW
         yxofseEB9WDEY9pPwhthu+mwYY3hrzwhMJeb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959320; x=1706564120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/pQA6UxU8t2n1gEI32Cqq0uc4Tew1m9B7OoRZQ8SI=;
        b=uO4fE6hSdqr/q4FBI/q3B5B28qLt1woRc0F8u/lqJWWWMgwBhW5pwH3vEFYFNCS8Te
         aqj/Iu5yf8wScloPn3qSwGJ6MRJdpedZaWhY+iXKW1Ck9XzmS27zgki+AkcLU56iG8fN
         ZVMzwdlcHI1AvJaMF3TPH0CeQqUWfnkf4QuInOSp60lutAeiEFxW0JInBx22HgNb3sqX
         CO1sbkBoYupm3mfX8PE+Zbc5dtPnMei+zT9iPdYw47nCyyNLzqxzFXppq3w+plyhrEnz
         0KTJnv0WcPsrOi2AP67t7C527zw/ySYIbJ+n5tg6RF18fIM0+JPo/eCphWQvB8vt3diG
         eOEA==
X-Gm-Message-State: AOJu0YxtwF0qerBvVtTZb7MnvzVGi1pwQgXvUyqERXeW0NcYTNh/WxP2
	70xmg6KGHqV1bmuQWyNx9URxL/RU6MnvlQRjgt5iHdS2f5C8+Up7AY7yVHmIxw==
X-Google-Smtp-Source: AGHT+IEhye246jTya1RIC7tJ0lpkhYypKWEZO4ePXa0bxP/yrVeg7EyStXAcy9+TrTGZeyn+aV1J5Q==
X-Received: by 2002:a17:90a:c0f:b0:28a:b5ac:514f with SMTP id 15-20020a17090a0c0f00b0028ab5ac514fmr1976731pjs.95.1705959319837;
        Mon, 22 Jan 2024 13:35:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pd5-20020a17090b1dc500b0028c5585fb41sm10145282pjb.45.2024.01.22.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:35:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:35:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] eventfs: Save directory inodes in the eventfs_inode
 structure
Message-ID: <202401221334.A6BC4754@keescook>
References: <20240122152748.46897388@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122152748.46897388@gandalf.local.home>

On Mon, Jan 22, 2024 at 03:27:48PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs inodes and directories are allocated when referenced. But this
> leaves the issue of keeping consistent inode numbers and the number is
> only saved in the inode structure itself. When the inode is no longer
> referenced, it can be freed. When the file that the inode was representing
> is referenced again, the inode is once again created, but the inode number
> needs to be the same as it was before.
> 
> Just making the inode numbers the same for all files is fine, but that
> does not work with directories. The find command will check for loops via
> the inode number and having the same inode number for directories triggers:
> 
>   # find /sys/kernel/tracing
> find: File system loop detected;
> '/sys/kernel/debug/tracing/events/initcall/initcall_finish' is part of the same file system loop as
> '/sys/kernel/debug/tracing/events/initcall'.
> [..]
> 
> Linus pointed out that the eventfs_inode structure ends with a single
> 32bit int, and on 64 bit machines, there's likely a 4 byte hole due to
> alignment. We can use this hole to store the inode number for the
> eventfs_inode. All directories in eventfs are represented by an
> eventfs_inode and that data structure can hold its inode number.
> 
> That last int was also purposely placed at the end of the structure to
> prevent holes from within. Now that there's a 4 byte number to hold the
> inode, both the inode number and the last integer can be moved up in the
> structure for better cache locality, where the llist and rcu fields can be
> moved to the end as they are only used when the eventfs_inode is being
> deleted.
> 
> Link: https://lore.kernel.org/all/CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com/
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 53c41052ba31 ("eventfs: Have the inodes all for files and directories all be the same")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Since I reviewed the earlier patch, I will repeat here for the formal
one too. :) Thanks for avoiding the hashing!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
