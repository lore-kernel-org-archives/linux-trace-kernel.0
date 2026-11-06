Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978803;
	b=3x6x39o9ZrxyWlW29uoU75hARy5cqr/It9TKWaTLW5X+XxL9b65DzlDrlvGF7aQ8/9J/
	 6BxlRQWBm/g/uFMNI8l6an/CLLTWSYZgaFlIr3V3HFy8sjLCy2RhzXSTY5/XAmOGIBbHr
	 5VRvDOLqUYizlCS0F7PSFR7v2TMvESYf2P9GMuUgDlRxQITiYYFH+fBOH2yzY8OpakauT
	 JglGem1LdT0sWuWTbNsB79AwEKVJqcGPpmN2BHk1jLsNBcuFOqQIWF4kLBHzBdV0PIOIU
	 pfwh1V7oIaXG7HX7upnH80DaYn9TOwjLr3CTjKeV2DdrXHTPH2ur4dMMne/s6isjgxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NFRk93kVwDnKUZB/pcB0eF0UozOQGGbpKAYRpLOWGWw=;
	b=es+0Ennyjx2h1r5bxFe+DnX8VyGrdNwM+TN9jqdZBOgxB1X8HKDhZ6hxCkblbH5PK2JZ
	 lPIaU18qdGVEeAK6yIx/H2ld1ew8sa+7QYoTUBEBqdHgIO60ZqvwcF7Cqk6zjYoaWZ4VZ
	 iI4d3n/DF5fxFeJbaNnO3YpVtIPY7Qx+AN70xy6Z5PK6vfE/LLRSzYj8hrGWJaXGug8i0
	 PXoGA+AhOuuC0qf173Y7UlIrZ6NqxBWJpFbKTialhzOWrsrB26PZtJIwV1B1vWy4M6MqO
	 fMexWItXMYWDddqFyfSm5B+YZLi4Qhsl5AH/DvIC0yzA5w3yCjNqRixAQ+uII62FixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25E606D808;
	Fri,  6 Nov 2026 15:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3EA1F008A4;
	Fri,  6 Nov 2026 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793978797;
	bh=NFRk93kVwDnKUZB/pcB0eF0UozOQGGbpKAYRpLOWGWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hNmDLPIPCIvMSZn0FOQJtTkkZXYaqyFnlZNSYPuCKTcNHe51SqoKWL3VMdVHTVsM7
	 K9HIuP0ELk+KrsbSxnuHYQ2Ka8ZGcjchQ6Uxijf+zNY+KstKz0upt/iNNUPs6A4lbN
	 cpGjgUjU6ke1JlbVlOQ8kyyZm4LV2/eGZZyLR2rs=
Date: Fri, 6 Nov 2026 07:26:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Suren Baghdasaryan
 <surenb@google.com>, oe-kbuild-all@lists.linux.dev, Linux Memory Management
 List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation
 tracepoints
Message-Id: <20261106072636.524e8f0a6a618e7b28988273@linux-foundation.org>
In-Reply-To: <9a4323e1-a966-41fe-8268-9d6621346fea@linux.dev>
References: <37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat@google.com>
	<202611052344.mDV2DB89-lkp@intel.com>
	<20261105172104.339c6f598a65056ed46e56fc@linux-foundation.org>
	<9a4323e1-a966-41fe-8268-9d6621346fea@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 15:54:33 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> >  
> > -static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
> > +static __always_inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
> >  {
> >  	if (static_branch_unlikely(&alloc_tag_trace_key))
> >  		return tag && alloc_tag_is_traced(tag);
> > _
> > 
> 
> 
> Thanks a lot for looking at this - and for putting together a fix at all.
> 
> Perhaps alloc_tag_is_traced needs the same treatment as well?
> 
> Even with your patch applied, I still hit the warning, just attributed to a different symbol:
> 
> WARNING: modpost: vmlinux: section mismatch in reference:
> alloc_tag_is_traced+0x10 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> 
> Marking both helpers __always_inline clears the warning in my build, and it would fit what the series
> intends for the fast path anyway.

Great, thanks, I added another -fix on top:

--- a/include/linux/alloc_tag.h~alloc_tag-introduce-ioctls-to-toggle-allocation-tracepoints-fix-fix
+++ a/include/linux/alloc_tag.h
@@ -156,7 +156,7 @@ static inline void alloc_tag_clear_trace
 	atomic_andnot(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
 }
 
-static inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
+static __always_inline inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
 {
 	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
 }
_

