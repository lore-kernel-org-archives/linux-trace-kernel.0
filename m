Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DCC2FB;
	Wed,  3 Sep 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756873440; cv=none; b=rATNGFR8vmY2YaZVK0MgbQa2XNi9kq5SvSVK/k4nIsF8b8dS5oJQHaNfDVjWB2Vixjv1H9GscGvXUVqSsqsjt0NomREHmLsY2vkNGgQ78PxtbiGUWmDIBColh2Zdub6iOnnttZqTmywQbId6Aovjh128gPDi08JKvSA08MsO/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756873440; c=relaxed/simple;
	bh=svNKh6v9xSbreRbIN5AHavHDnFJA4RcUXkK5blEmANo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAgzzEBETtrJhYAE7PiReG/Dtq3My4V91SVD5kISwYh5xKj8I8GRFzelI463Cqq/M7pVf1sFWzCYta69TjJ5tvTqdBNmsjwT9kmznh1Cv0TNMWq3zDL2el8X36JnicOJ8uYQHo0/whe38XuOXJZKmdwf5jWhQJOYLATNs9ofrLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=rkHbc0bj; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="rkHbc0bj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pp1cKx0IjF5K66uP8QvoXn/uM1IyZZrNOlgAlK7jAEg=; b=rkHbc0bjzoSGPLg8QowyCMDRa2
	mDiMogQN8ftzE/WLFgxcQ5Npq8Fy1+YXuO+LOTraNb/8WwS2xIuS4dVTl99kK9fI4V6k25n2ZUV8N
	C+MK5H2GALbw5e6ku9TGmYbINza7l9Va0foMrr37d41gdte2weocoxDSuXagfZdLpYz/6q6qMlxka
	XX1I0m6MP+908gmfdxj7RYUBoBoBQMQRWjHEelmKv5cWuYx4jbbKkFy837JbsJ5hHCKpRhZehhFtj
	IRDhREp0+vEn1TWLbxnPqg/F1kl1VOypqBo84EG7eiePL2Lmiww4uPKkzSNasH2difB74s8n1gCqg
	UftTNCQQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1utemj-002CsD-2t;
	Wed, 03 Sep 2025 12:23:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Sep 2025 12:23:46 +0800
Date: Wed, 3 Sep 2025 12:23:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <dongml2@chinatelecom.cn>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Message-ID: <aLfC0gZS_F3_srMT@gondor.apana.org.au>
References: <20250829021436.19982-1-dongml2@chinatelecom.cn>
 <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
 <20250902105757.16a78aea@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902105757.16a78aea@batman.local.home>

On Tue, Sep 02, 2025 at 10:57:57AM -0400, Steven Rostedt wrote:
>
> And then have:
> 
>        quiet_rcu_read_lock_check();
>        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>        quiet_rcu_read_unlock_check();

The thing is that rhl_for_each_entry_rcu which is called right after
your unlock above should have created the same warning as
rhltable_lookup.  The fact that it doesn't appears to be a bug:
it's using rcu_dereference_raw and I don't see why that's safe
at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
