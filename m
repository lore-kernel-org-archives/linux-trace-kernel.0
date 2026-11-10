Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351007;
	b=Bpe7EuzPgkjztca+MWTNfIPENfDYaraLK9jTqW5ptQEX2LHhOZhg+A8SzKHXcWZYX+9g
	 lerE5bTfau1YLcgpChiCuNR0rrJHC6TVcE+/0GJmH+rf8L1q700Z3rGbD6JM/TDmMw3Gu
	 tXJ6iAkWwy+voKVRXIBvM2fwWAVKS4OKWwCDzLE15mcbpsfNJ6A8iU0SAUzXHssYAJ6GD
	 pw/gzdkukcKSTUVP2wwiG8qX+Hi7jvqAxeng/McSaX5KzN+azH6Dum1xayqi+OfcPf1m8
	 sMYxpAewoO5QWPLzWuikZZ0cvh6qh0wiJ5+cVauXR4TVNDsitbBYXf2HlsYHtqwEOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351007;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=503JFiVK8vn/l3FW+t3kwxWFWPpMbnFzjHjaQEpu2Vo=;
	b=eiglvQLH9rP9sBx1r3IYEOB4ofhtDFOWpMdkR0XKLzZ2Qi6Y4wwHHqwEs3FcrtWw4FKn
	 kpKq+RRsghe0XL2/exQEVE/WUxkFnaXCgDQmYkW5SNJo47leq4BW8SAHglHE0oFiJRk4t
	 D7JcLqxUpGk8WWM2EnoGvb17r2POo7zTQr+nseeGi945qykgsMOzA5cYrxwFF1lMKZ/7S
	 bW6F2m028tEpC7As6R52VIEhqlQgjrFZHDz8fd4flfTXrSGEdk1ID8a43Du5S5O1Ayx+/
	 Ph7DjO71te3vKTaKxfmmssL7twRurXW9X5FFuQh8yA8gUNU6+SY/cCjuoF7yqiB9APg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=jISbMcXW;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0A606A320;
	Tue, 10 Nov 2026 22:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A0A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=jISbMcXW
Received: from [100.96.64.102] (unknown [52.179.129.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7F3420B7169;
	Tue, 10 Nov 2026 14:50:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7F3420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794351003;
	bh=503JFiVK8vn/l3FW+t3kwxWFWPpMbnFzjHjaQEpu2Vo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jISbMcXWAnWYOIBzcxe98miqDGDviywoQ+eXNQEp82At+GPcFejJCC2bL6+ZyXaUa
	 qYoBSzDBtLPFSKe2Guo/hr5GK3+oMHvjBB48m/3WhtIBxz4rWrcwLl3eALk8VRqO0B
	 xtGI+YgU8i69Jzg9xxpMV6I83VSm6dvSaoy0qwIw=
Date: Tue, 10 Nov 2026 17:50:03 -0500
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "=?utf-8?Q?mhiramat=40kernel.org?=" <mhiramat@kernel.org>, 
 "=?utf-8?Q?shuah=40kernel.org?=" <shuah@kernel.org>, 
 "=?utf-8?Q?beaub=40linux.microsoft.com?=" <beaub@linux.microsoft.com>, 
 "=?utf-8?Q?mathieu.desnoyers=40efficios.com?="
 <mathieu.desnoyers@efficios.com>, 
 "=?utf-8?Q?linux-trace-kernel=40vger.kernel.org?="
 <linux-trace-kernel@vger.kernel.org>, 
 "=?utf-8?Q?linux-kselftest=40vger.kernel.org?="
 <linux-kselftest@vger.kernel.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>
Message-ID: <40C83F97-D53F-4050-9CE4-19449912FB20@getmailspring.com>
In-Reply-To: <20261019103957.69759ee3@gandalf.local.home>
References: <20261019103957.69759ee3@gandalf.local.home>
Subject: Re: [PATCH v2 0/3] tracing/user_events: Share state with
 existing threads
X-Mailer: Mailspring
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Steve, Beau,

Gentle ping on this v2 series. I don't have any outstanding changes to
make at this point.
Just to clarify, this is a separate patch from the Fail fork one.
Please let me know if anything further is needed from my side. 

Thanks, Jeff


On Oct 19 2026, at 10:39 am, Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 19 Oct 2026 10:23:01 -0400
> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
> 
>> Gentle ping on this series.
>> 
>> Please let me know if there are any further comments or changes you'd
>> like me to make.
> 
> Hi Jeff,
> 
> FYI, always start a new thread when sending out a new series. Don't
> make it
> a reply to an old one. That makes it confusing to know which series to look
> at.
> 
> Also, I've was traveling between September 14th and October 10th and my
> backlog built up quite a bit.
> 
> If Beau can review this series, that would be great. I'm currently putting
> together several branches for the merge window. Unfortunately, due to my
> backlog, there's patches that have been sent this month that will need to
> be postponed to the next window.
> 
> As user_events are agnostic to other changes, there's still a chance your
> changes can get added this window.
> 
> -- Steve
> 
