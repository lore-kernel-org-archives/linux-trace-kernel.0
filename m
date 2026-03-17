Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38D2F3622;
	Tue, 17 Mar 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764086; cv=none; b=EC+NpTNjcr+FiDDh+ASXrx0kKpuPfCq7c/Rj0tVqRpasHTcshx9iTGJ6O6gUh4QMB7AJ90l9nKkseNWWI8b/tj56QlsylcUvWjgEdX85D+3AWyMjOCVNp54Dj7Irb1D5zqOCJjhc/Z5oy+FCUaFPwk2TWjI0QJb9ASB8eWydjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764086; c=relaxed/simple;
	bh=E79bV8sDdW6myXN8X9o8onTOSGBJnRWNWf1Bcohj57I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY0FeroOlGBTYlB43abb1yn1+RNFB63xTR5HT4/sHwI3UX2wPhSwmfu/NQnVNW1aOznUJuhyeyr/hSaSjbIzsRjV8Xtvz06v8KhnYBnBEL2JbLXpqfiA0d4/3DCHLkvBmQr4v3D1Jj7aQB0f5QxLM7uH3H51Fm/KT+lqpluPptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 931381A0247;
	Tue, 17 Mar 2026 16:14:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id C2A5C32;
	Tue, 17 Mar 2026 16:14:41 +0000 (UTC)
Date: Tue, 17 Mar 2026 12:15:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/17] lib/bootconfig: fix sign-compare in
 xbc_node_compose_key_after()
Message-ID: <20260317121507.30735331@gandalf.local.home>
In-Reply-To: <20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-17-objecting@objecting.org>
	<20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q4naa7r4h8smubg9ay85gzeuy67rt9pi
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C2A5C32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19esOO1CQ86SjScBf8kLI4i6zt347Vj1WU=
X-HE-Tag: 1773764081-444772
X-HE-Meta: U2FsdGVkX1/0uWKQzLUepXKTDYbLaMav7qmOwrqsJTf6LkBXXCE1m3ZKY+AqUEEwgBEi1lyIrjh97fvGJkXfQxwhyc5K1kRdByyRL4C10GFkIUbfHjVDKA2qAs9iNI5JjgCaKN+8EKW5tqEJqsup08D7XA55UNqCf4mbC8ORIuJlerD5x0kholHnKabkc3x11jd9OHsV9jaTSzb98925OIh5r/3XQUFIqhVnMoV023uU6Opcalml26BdaGbIfvO2OUsa2Dp7vH6V1sudo66Dto4FQktGyNHKTrALA9FEiOuBjV0AfgZC2WiHV58ITxGGiqgy3e+xDOwgUe+QPx1ovTd0sgLECYbu

On Tue, 17 Mar 2026 16:55:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
> >  			       depth ? "." : "");
> >  		if (ret < 0)
> >  			return ret;
> > -		if (ret >= size) {
> > +		if (ret >= (int)size) {  
> 
> nit:
> 
> 	if ((size_t)ret >= size) {
> 
> because sizeof(size_t) > sizeof(int).

I don't think we need to worry about this. But this does bring up an issue.
ret comes from:

		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
			       depth ? "." : "");

Where size is of type size_t

snprintf() takes size_t but returns int.

snprintf() calls vsnprintf() which has:

	size_t len, pos;

Where pos is incremented based on fmt, and vsnprintf() returns:

	return pos;

Which can overflow.

Now, honestly, we should never have a 2Gig string as that would likely
cause other horrible things. Does size really need to be size_t?

Perhaps we should have:

	if (WARN_ON_ONCE(size > MAX_INT))
		return -EINVAL;

?

-- Steve
