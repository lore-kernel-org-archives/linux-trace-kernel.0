Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B65287516;
	Tue, 13 Jan 2026 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327459; cv=none; b=NwCOShqsikEi3b+25YHWdL/ZaFqlgOWMjcm/Oexpxy7NXEh1VDnd1NVmpcMYwHguK4n42CiPrOlBLLVGEqwhXU82RGtmkUBhaPGsCTTFEc1Pvnwv4vAEj+AH0PVslufyPbpC/E/NuvXHbqEqlagJTgPMu4K1s4Sq6dy1vlCjR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327459; c=relaxed/simple;
	bh=mNKbWiRW7TNwS+m6OhzsXHXrrhOuwN7uaIkqO2pQaDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVbManNx5bdXFfKFQZu4ib9dkHqHHKbfgDp9CEgvPH5BqkUxLR73U9lUdtT1v95ayCYfxZGVlsE3iiBIPAAhB6xzv49L0EXqPrXp1Jdfe2E1TVX0w6sOoYvOm7suiJ/VzolmJ8O/zLUHvwB+0c78qNtVveFtb6DD1AuFwiFEa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9BF571B1F9;
	Tue, 13 Jan 2026 18:04:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7BAC12000D;
	Tue, 13 Jan 2026 18:04:01 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:03:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, tglx@kernel.org,
 peterz@infradead.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, aliceryhl@google.com, yury.norov@gmail.com,
 vmalik@redhat.com, kees@kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 mhiramat@kernel.org, brauner@kernel.org, jack@suse.cz, cyphar@cyphar.com,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2 3/6] tracing: Use copy_from_user_nul() instead of
 copy_from_user()
Message-ID: <20260113130359.43f5411a@fedora>
In-Reply-To: <aWZ7SXpUm8TwtUIT@yury>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
	<20260112073039.1185-4-fushuai.wang@linux.dev>
	<aWZ7SXpUm8TwtUIT@yury>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m64e71jw655zai1esa9jrkpnd6ki891s
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7BAC12000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+g4axEybdl6z3J/4fPQfenYkcAusx7pi4=
X-HE-Tag: 1768327441-463662
X-HE-Meta: U2FsdGVkX1/EAAlXgl1CQy0Wos3qVzV2ZFJEZcUZQI/vMwo+mjHRQ1UHl6cscFRT3b2uysHJyJzHBMj4aphzw9zc4MQdl8lsRR0rLjkZ8j5do+WkB5/JnoazcygLKvQmNZ09OBF55kulVe3RQ0B1AJRb6lmpT5OU9g5W16e8CdJUna0Bdckkl97IBTxjBMJgHOdJr6UMejd6Q6V9TDv3XDpJtwiZovtg2J1gx6zyDBmiQjX3kArnZ61AYBrX++P+rBTrDYslxEnBK1LuXX/0g7F9e7Qbf5tF0fJusmXBJ1EtUL42P+2IfPIts/3iujJXCZqEE+3D/OYFergxjMnf/2a4MReW66eBhn2bhXGIGca35MJyUOJQIg==

On Tue, 13 Jan 2026 12:05:13 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Mon, Jan 12, 2026 at 03:30:36PM +0800, Fushuai Wang wrote:
> > From: Fushuai Wang <wangfushuai@baidu.com>
> > 
> > Use copy_from_user_nul() instead of copy_from_user() to simplify
> > the code.
> > 
> > No functional change.
> > 
> > Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> > ---
> >  kernel/trace/trace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index baec63134ab6..b6ffd006fcf9 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -11266,10 +11266,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
> >  		if (size >= WRITE_BUFSIZE)
> >  			size = WRITE_BUFSIZE - 1;
> >  
> > -		if (copy_from_user(kbuf, buffer + done, size))
> > +		if (copy_from_user_nul(kbuf, buffer + done, size))
> >  			return -EFAULT;  
> 
> This hides the original error. Can you switch it to:
> 
>                 err = copy_xxx();
>                 if (err)
>                         return err;

No, the current way is fine. It's failing on reading user space. EFAULT
is good enough.

-- Steve


> 
> I understand that in this case EFAULT is the only possible error, but
> the above pattern is really error-prone, and is reproduced again and
> again over the kernel.
> 
> > -		kbuf[size] = '\0';
> >  		buf = kbuf;
> >  		do {
> >  			tmp = strchr(buf, '\n');
> > -- 
> > 2.36.1  

