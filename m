Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8A39AD3A;
	Tue, 12 May 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594092; cv=none; b=Ff7wCpxGkKxOZn6Ojul/syiWR1y8KPggBregH/nCKJ1PUqrj4ZGYzv4+VkLq9fKigU4eTAdnwm8EhleZquT7ql3DK1VqTok10XcfvWlnqeLEFDeQI5I1oUL3W5nW0CWrxSZyihrwekL48ePyikCLLNjYLX0mIzMNROzDdayYFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594092; c=relaxed/simple;
	bh=ApEcoOsfF4OrmlzQfdeA1mAFv5Vr7V36IjGOn8+U6ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUAqyB0yMKzTNHjOwKjWJWfccrsn9NBGomr7wSTsihL1+uvaMyy4zN78CyR3lB7+VCIst8LT8TeFcerD7SglNcVzaK+z7zmrcw5p4+0Yxauhz6rSUGfCijzfB6a1jwRHzXPxc0nn1NXWijKg/npMFfzKf7r+X3xJScpj3UkCa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KjJEavW4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KjJEavW4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0gmvIlGDCBJCCwFZwzxI2Tc2mW0v8a2Eqvaha2GveJY=; b=KjJEavW4tUjj78ME52ZvXEML6z
	/mxGqfjOrE745srQS2fn1ocN7YHhJp9PG6rFnySm6JMHeNp+qQONV+voOlPbK/WuBxiNpdVo8xEiU
	SMwdxuMQIGA8m5rhmjzqK40B9Un+DGARfuG0j0GMSnz/R6tf74+K9q6mLYbxrPUzos0sb6jSCXjTi
	g/Sx/rC6cOX6KIb15QaT1xFYDOzMc9OCb11y0ZUl/dMz/Wsq9l0uYIaBwCKOv6suug8fuom49Algh
	6P5mOzS04kssJM0kk5K2wuqEdUfkoPQ+pVz1F1vygkao0doIOOzc07+5ZIfOaDUJ2OSw1MkwqUXDl
	itJ2w2ig==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMnZP-002QKv-1O;
	Tue, 12 May 2026 13:54:48 +0000
Date: Tue, 12 May 2026 06:54:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>, kernel-janitors@vger.kernel.org, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [bug report] bootconfig: init: Allow admin to use bootconfig for
 kernel command line
Message-ID: <agMwSwRYQhzGbDi-@gmail.com>
References: <af4YTUrDM-ciyoa-@stanley.mountain>
 <20260512091638.8b95253ab022d7dabf473465@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512091638.8b95253ab022d7dabf473465@kernel.org>
X-Debian-User: leitao

On Tue, May 12, 2026 at 09:16:38AM +0900, Masami Hiramatsu wrote:
> Hi Dan,
>
> Thanks for reporting. A similar problem is pointed by Sashiko [1].
>
> [1] https://sashiko.dev/#/patchset/20260508-bootconfig_using_tools-v1-0-1132219aa773%40debian.org
>
> On Fri, 8 May 2026 20:07:25 +0300
> Dan Carpenter <error27@gmail.com> wrote:
>
> > Hello Masami Hiramatsu,
> >
> > Commit 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig
> > for kernel command line") from Jan 11, 2020 (linux-next), leads to
> > the following Smatch static checker warning:
> >
> > 	init/main.c:368 xbc_snprint_cmdline()

For your information, I am moving this function to lib/bootconfig.

https://lore.kernel.org/all/20260508-bootconfig_using_tools-v1-1-1132219aa773@debian.org/

I understand that no action is required on this report, correct?

Thanks,
--breno
