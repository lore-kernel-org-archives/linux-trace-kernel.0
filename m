Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A938E12B;
	Wed, 13 May 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684870; cv=none; b=s437odAUUDT7uZWn02o/ik0qaz2l41a11jx0T19MoIXTJGZ92F8kRLfkaDJ44zm/LUn4qAi8IgYSnQnn79tRMyxWT4XZHNXmSJsQuXh2/HMOprmRw/t323XYgHA+qjwWEtyNy1ArnCoJHMhxw5lrQhKCkKnHm5WjP/alDuaoC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684870; c=relaxed/simple;
	bh=ve1w5x6201cymLk1w3BH7b3L4LNYqn5VW9sa3pVEAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCooxzyPg1ZdKDDX38po1ju2QgfVdJ5Kq0rTsblqdtcqkZgPEm4ZqvGardQHi2uCUwr6qtnGi1wVO9pkvsoTwwaoSyWICJiI+d5SxPHTu/lbIucb9lvnqERfK4hiGJpli6/SnqbcRuBWsjfbJIXASIepAeU8e/14t35WcCAaWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nUa8RY6v; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nUa8RY6v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=evfqGNz0nsVJ8plAAlmr0vtrg9gduvV5egVZ+mMRUWQ=; b=nUa8RY6vasN4F1beCxc71NJLPV
	GS/zA+0YNRUxQM+w9SsSOrQ4QibOxolEwvp1R1Yf8/kY7VGz8l/3oPDDcXdSIX7iw8mOyIgwve8ra
	/QLSmFWd8l9W04J+aHO6EXdQ3oZSa05prFU6udPm6LlI75vao77xp7en1FspKqvYXwqlNeITlV+FP
	bHao4TiyuK78pJsh2fHe/WhEK+4g46JcdHvK8Ug0zDbuOW/BCDLX+H6qpuOKQevy7oIIGHz2KELZ/
	4wVkJnFrU4cIVS3TSuMtptbLaNJPTomYWewUTpFI4YiyfOjCXC64xLdd9ktVyBMZUyRFDq5LHe/wl
	2CtrCBng==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBB5-003FHA-1W;
	Wed, 13 May 2026 15:07:15 +0000
Date: Wed, 13 May 2026 08:07:08 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v6 2/4] mm/memory-failure: classify get_any_page()
 failures by reason
Message-ID: <agSR4oLjz_B40koq@gmail.com>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-2-183012ba7d4b@debian.org>
 <28b01c14-3d87-4cab-b695-5b9015578785@kernel.org>
 <agMpqhpgmezqnaA_@gmail.com>
 <3e5e8fb8-6957-46b7-9777-0ed1bff1d0fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5e8fb8-6957-46b7-9777-0ed1bff1d0fb@kernel.org>
X-Debian-User: leitao

On Wed, May 13, 2026 at 01:48:11PM +0200, David Hildenbrand (Arm) wrote:
> > @@ -1441,10 +1456,10 @@ static int get_any_page(struct page *p, unsigned long flags)
> >  			goto try_again;
> >  		}
> >  		put_page(p);
> > -		ret = -EIO;
> > +		ret = -ENOTRECOVERABLE;
> >  	}
> >  out:
> > -	if (ret == -EIO)
> > +	if (ret == -EIO || ret == -ENOTRECOVERABLE)
> >  		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
> >  
> >  	return ret;
> > @@ -2431,6 +2448,9 @@ int memory_failure(unsigned long pfn, int flags)
> >  			res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
> >  		}
> >  		goto unlock_mutex;
> > +	} else if (res == -ENOTRECOVERABLE) {
> > +		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
> > +		goto unlock_mutex;
> >  	} else if (res < 0) {
> >  		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
> >  		goto unlock_mutex;
> 
> That might probably read nicer as
> 
> switch (res) {
> case 0: ...
> case 1: ...
> case -ENOTRECOVERABLE:  ...
> case ...
> default:
> }
> 
> > 
> > 
> > If that is what you are suggestion, maybe we can create another
> > MF_MSG_RESERVED? and another return value for get_any_page() to track
> > the reserve pages ?
> 
> I guess "reserved" is really just like most other kernel pages. So I wouldn't
> special-case them here.
> 
> Or would there be a good reason?

Not really, treating them as MF_MSG_KERNEL is sufficient for my use
case.

Thank you for the review. I'm digesting all the feedback and will send
out a new revision shortly, where we can continue the discussion.

--breno
