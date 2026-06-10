Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B21F938;
	Wed, 10 Jun 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085266; cv=none; b=csVwTMs2PgFN+dcKxLpbTL7Mmyc5D2T/a74w9basfBHTVF5/1iakcewzCEfb+9AmAgR4TI0HFr192a1ryDxvLv2Wi1QWN1lPkCrbcOlLm4BYzALUpgLUHVhRQFDrOiTtdwwFJwsZGCfmLrorO2VaBqA7Yj4NU/hEMECOjfasv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085266; c=relaxed/simple;
	bh=8Pj1GunqJrcWqchsaEZS3wU/MEK03pcJuqgKQ3TmrBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvk8gXcYtoQ4OgcBCrfwZ+XVKECHHq96fdeH4LTbw8XA23+vJ//tu+nB8yMi/w6QglAMlWbI9uCDTac0RuFtDwscwt/9p0zTJU9jgDbc17lGjJImKfowB1BA70+WXlQIXDCAjSo03Zjr6YdVtGDe/30CHCTEv/76ksgk7URAapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jH67hAAN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jH67hAAN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WJ+oozuTPWZxI5kixO5e7S8FM2lyDR3C9rSQw3An66c=; b=jH67hAANF8wuJYBMqz+qTNr8+T
	nORRSP5pvnJJPbq5vwen1ZKCwTaW0SEbxnHjxJLzGVTBJM+PIWeXD4P1At/BzKrvIgotviRRpS+8g
	7nhaiWFOrrg8OWXQBAEM9PYMeCgg5S23Y3cx4YqzHUs1UQyPSlLjbBngmrAkVBgCZwxE9UMe7Ckuz
	XTy7BcjWOLSatFNmIjq1JmYPpB7j17bCoRVouLW5hy9fG1B4SUyE4zroqKZqNaYX+mWJYkfMzqLKg
	AFWQA4DMtBH4hodbla/UBBN0qaG2+ifF7eHoK1DcAUT8OvNtBYyQXwwoic+fNS5hK1Z8zeYe5McY3
	twfitMzw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXFdG-0096hL-1t;
	Wed, 10 Jun 2026 09:53:59 +0000
Date: Wed, 10 Jun 2026 02:53:52 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v9 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <aikz-gW9DHeyrksy@gmail.com>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
 <20260609-ecc_panic-v9-2-432a74002e74@debian.org>
 <174b8d76-5514-4942-af5d-c975ff95ee03@kernel.org>
 <aig7jzwDHfVCxikl@gmail.com>
 <cf2bb24e-9341-4ded-b238-064dca442a92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf2bb24e-9341-4ded-b238-064dca442a92@kernel.org>
X-Debian-User: leitao

On Tue, Jun 09, 2026 at 08:41:25PM +0200, David Hildenbrand (Arm) wrote:
> On 6/9/26 18:15, Breno Leitao wrote:
> > On Tue, Jun 09, 2026 at 04:41:01PM +0200, David Hildenbrand (Arm) wrote:

> >> a) HWPoisonKernelOwned: this is not the common style for us to name functions.
> >>
> >> is_kernel_owned_page() or sth like that would do.
> > 
> > Ack, I will rename it is_kernel_owned_page()
> > 
> > In my defence, most of the functions similar to HWPoisonKernelOwned()
> > has this name format, and I got this discussion earlier (with Lance?
> > I think). Here are the similar function names in that file:
> > 
> >  * HWPoisonHandlable
> >  * PageHWPoisonTakenOff()
> >  * SetPageHWPoisonTakenOff
> 
> Some of these probably date back to our old way of handling page flags and
> things, like PageLRU.
> 
> But we really should stop :)

Ack!

> > I will update in the new version.
> 
> Thanks! Probably best to wait a bit, the merge window is coming up either way,
> so this will have to wait a bit either way.

no hurry at all,

Thanks for the review,
--breno
