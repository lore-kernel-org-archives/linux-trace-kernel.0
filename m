Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66222DF6F6;
	Thu,  4 Sep 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976951; cv=none; b=ipIsbcEMatMK0imTrBIEN1GT6zamEVdS0ToOEPYWZlRyP96a9knSwiwWWnMfhCW7I8EYsJqq60KgnF/Qja2kB+bwBWZfZ1qCObvBni27OFUdAUU1FwEI0kwOyYS/ahgZJYXKL7DmVqySVrGjJmpzK1NgQsPujfs3Mv39pmkHI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976951; c=relaxed/simple;
	bh=G/J06Q7pmBlKJjTl3EXiNLMWxSy8VxCDwe2a+IgycIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syMUpAGxeKrDvveUHA8oehdrBrin12YlOUN8V9KN2UDvU7SAdRwPzRHQH1h/M0W/IOwAvOnDgj6NVewI7NP//iguPthw35ke+9k1sP+0B5pPWlfyNWwLEEMRO1OS7w01PO8Xr0cndqacjevKf3PVwdWVPyO0VtFRvE05dF0hchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TMBW675y; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TMBW675y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X8lJPPz3uM+KxHe0Nl9wRADaXsNsKIAR64B5GXSwg2c=; b=TMBW675yw/+89loQ095MXEB8Z+
	IAvtY7OTS48P8otGdOUX5t3gH7wg1hgnvRzxzqQvG/POQ+aE6xCHUjEYcWYq35Q89VMtEcU6rPvei
	xS05RYuyHvCCXwJDs0XdEZnyNqXZKva4VndSsUtO6g9k1y2SydxgOYwtmJNDoCXeT/rqV9Q+vCVZ4
	0s1+e6W5wEsKpMXogMG6EX7nktGMcJEvZGVqfd8KX6M4ZIEgiPVBZkBJ7tqDToOE907Mfk26Yhnlx
	jPsLlSrjtg5c2O80LpZayRU5vOKpI9VV83hdMP6qv493DrjKaz4BR96anUG2OyE+ICXZEKaA/TsXp
	I00k4Uhg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uu5hw-002YvI-25;
	Thu, 04 Sep 2025 17:08:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Sep 2025 17:08:37 +0800
Date: Thu, 4 Sep 2025 17:08:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Message-ID: <aLlXFQaRmKaCeXTG@gondor.apana.org.au>
References: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
 <3005966.e9J7NaK4W3@7940hx>
 <aLfCa1FkLc3T4QI3@gondor.apana.org.au>
 <5038598.31r3eYUQgx@7940hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5038598.31r3eYUQgx@7940hx>

On Thu, Sep 04, 2025 at 11:37:35AM +0800, Menglong Dong wrote:
>
> Yeah, I understand what you mean. I noticed this, and that's why
> I added the rcu_read_lock() for rhashtable_lookup() only.
> 
> Maybe it is to obtain better performance? Just guess ;)
> And hlist_for_each_entry_rcu() also uses rcu_dereference_raw().

I did some digging and this appears to be the source of the
rcu_dereference_raw call:

commit 3120438ad68601f341e61e7cb1323b0e1a6ca367
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Feb 22 17:04:48 2010 -0800

    rcu: Disable lockdep checking in RCU list-traversal primitives

    The theory is that use of bare rcu_dereference() is more prone
    to error than use of the RCU list-traversal primitives.
    Therefore, disable lockdep RCU read-side critical-section
    checking in these primitives for the time being.  Once all of
    the rcu_dereference() uses have been dealt with, it may be time
    to re-enable lockdep checking for the RCU list-traversal
    primitives.

So I don't think there is a good reason to use rcu_dereference_raw
here at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
