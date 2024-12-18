Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1E1547FF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513231; cv=none; b=jdJ6BHkKB3L+hAMsqpbHNp3GfO5mdzY7VtKxoEeR8qay3xWIK5r8gfS4LTwMSKim/xCWIAnxMOaEuYZ3CLy1cs2MnxotM+Ly0uEivqKEUmUdaZebWbo/hR4kC6q6/APOYB5I/ceqHMJayZcWJfsVbnK6oqXPl1SD+hXFFzGbJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513231; c=relaxed/simple;
	bh=e8qRRHJBB1Zw5aMSsLSpvu5H4d99mxbbFZBcoxsP+0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdOIJAsSasbl7FnlKhieUHyRS4GafycIeTje58CY0gGBtQGkza9c+uGDCkoiKg/0f1IQgObYzdspes1kxfy2rdwzWkODDil004NytL0R9zzoq11AzsFJTmVEYa2X4wXcWeEn8YoRzBFzFo8ZlPeV0we1lRHG/zLiUpAOANyBWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bv42eUTO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bv42eUTO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43623f0c574so43646265e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 01:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734513228; x=1735118028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lubp7TmrMRaHXN+HPHkbndAYFbmY1ysENixYidV/1fI=;
        b=bv42eUTOQ06cESj27VthlyGqfyMLaFjCIBCrB6W4UO+a+X2/RgD77iResHDYKmnVty
         cI37x3kh9t2SdIsklp00+her7fzsiWT9LBFM3EFhbvyNzz4SD4wHyJSWkaGryg+NG+VW
         B02aghX0BHqGY5coebhEfvpdN0BkTezAa7aKifKvsl8pz49vx262eFs/YA/WApO16Rcd
         LzIXKzIhKnsS7CnBcwA1ioIQn497ffLWPccImXVktSDTllOyezF8OzP5l3jd96EupeeG
         6UJV+Slztxg6xnIjhPPdz74tVu93NbGbgmoc+BpJSdCI02Rtp6dsw0Zh4Y/uPB+dDGw2
         4KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513228; x=1735118028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lubp7TmrMRaHXN+HPHkbndAYFbmY1ysENixYidV/1fI=;
        b=mqnbE/15qnm//cg/GPpF+RBkqIuXDvTdOAENDHzFY27y9qEOdq9v55WlmkKp1XQtJ8
         7N/Azo2+uV3QZ4Mjx3SL9dEwnMGEQuSwVfaqdPVkf8MzHduAsaH8ToqNQdJX5/nc08j0
         F+yM37IIxCRWlgABTeSEhui6GfDWCZEmWXSGZOH2JRqQrlrWgUaDXyodXX8X4xYwOoOv
         fmmpalMBuGJ3t+rT69Vtlx3yJgsuryZNpuX2GjJ3Xjv0zqT9hWXPWwkAcpE8lzLtlVtD
         WeDzUHcYSYc+V+xFLOQMocpbI+zn5QkNnyD3wsN2zjv9uNOYuEtd67st2c/qZMWECx0n
         157g==
X-Forwarded-Encrypted: i=1; AJvYcCWrs1qE5Fp4pnED/p2qQ2uJQpDOuGJ+DbKOPBLRVPK9dTGWGi3pdj0rLFjELBLtt/3Z7PkII6VfCdhrnF9da7CriMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYYP5LUsIPeQ2O6FYvvwDk2ZMu4NEwhzsqUkDIVsJFgbVj2xl
	nlJz1QHERAseDqrsvz2+ZJW0KqRkUg3ELJUwjBOdIkUwyqcoAwzE5dKKGx5uow==
X-Gm-Gg: ASbGncuqVn/XsGxv1j/H5A8F3jpXt00xjC8XeDJwDpDNBaguKmSGKQZhihPLRlI5Bi6
	/Zkpu310Er6etys3pA7IcLlF+4pV0ejdBsEJJ09xmPzGIiQ8DTlYPIeQF3OYkz9vXsI9Ncwzfvn
	8lC/oZEwrHHEDzA45zdmzBSqVIZS/7fapxmcZCBgh+ZSYQgVd9Wf01rOScpzghKlVmA3uMXc/C5
	QbshWSXztQX2Czok2+JqXkLIXYB7RGXCsDMuNcQO+zjtXtshmoUMwWGSefDpa04PImP6x4LA/Qp
	RIynks9N4FYjRjiMzu5QkQ==
X-Google-Smtp-Source: AGHT+IEmVuLmxO+5c/aQMiwvDA8uTGHNLNQwbH3gtHZ7+gFscbX/+rvqkIK5kreCw5B70+Y0XGjs/Q==
X-Received: by 2002:a05:600c:511f:b0:434:f953:efb with SMTP id 5b1f17b1804b1-4365542e6a8mr14986285e9.32.1734513227738;
        Wed, 18 Dec 2024 01:13:47 -0800 (PST)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656afc1d3sm13772515e9.9.2024.12.18.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:13:47 -0800 (PST)
Date: Wed, 18 Dec 2024 09:13:43 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>, david@redhat.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <Z2KSR5QrAWYDEBVh@google.com>
References: <20241217124602.2d498c3f@gandalf.local.home>
 <tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
 <20241217194015.7a4f0dc8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217194015.7a4f0dc8@gandalf.local.home>

On Tue, Dec 17, 2024 at 07:40:15PM -0500, Steven Rostedt wrote:
> On Wed, 18 Dec 2024 07:43:46 +0800
> Edward Adam Davis <eadavis@qq.com> wrote:
> 
> > > 
> > > A proper fix is being discussed here:  
> > First, my fix is the first one.
> 
> Yes I saw that.
> 
> > Second, the root cause of the problem is an overflow when calculating nr_pages.
> > > 
> > > https://lore.kernel.org/linux-trace-kernel/20241216164931.57323-1-aha310510@gmail.com/
> > > 
> > > Thank you,
> > > 
> > > -- Steve
> > >   
> > The calculation of nr_pages below overflows because the pgoff value is 8,
> > the nr_subbufs value is 3, and the subbuf_order value is 0.
> 
> So basically you are saying that passing in the the mmap with the pgoff is
> what's causing it.
> 
> > > >  	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
> > > >  
> > > >  	nr_vma_pages = vma_pages(vma);  
> 
> 
> Thanks, I believe I now have a reproducer. And yes, I'll take your patch.
> (If Vincent is OK with it).

I wanted to look at the reproducer sent by Jeongjung yesterday but got
preempted. My bad.

To avoid repeating the (nr_subbufs + 1) << subbuf_order How about?

-       nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
+       nr_pages = ((nr_subbufs + 1) << subbuf_order); /* + meta-page */
+
+       if (pgoff > nr_pages)
+               return -EINVAL;
+
+       nr_pages -= pgoff;


And probably also 

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")

> 
> Here's the reproducer:
> 
> ------------------------8<-------------------------
> #include <fcntl.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <asm/types.h>
> #include <sys/mman.h>
> 
> int main(int argc, char **argv)
> {
> 	int page_size = getpagesize();
> 	int fd;
> 	void *meta;
> 
> 	system("echo 1 > /sys/kernel/tracing/buffer_size_kb");
> 	fd = open("/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw", O_RDONLY);
> 
> 	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, page_size * 5);
> }
> ------------------------>8-------------------------
> 
> Thanks,
> 
> 
> -- Steve
