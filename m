Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AF6F309;
	Wed, 19 Jun 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779516; cv=none; b=YJWFmy5RNuf/fTI9XKReTjhPfGxGFIWqshq5aiFbUa9J/fV61rFdsAQjNUcPraKIDQxPfkMAZ+2WJbLBll2EjcjUYe3vshJ1usXCiuJJDlr7wsYBSWj3l1AZmvyJGzk00fLxJ6v/TdSK/CfVRgQ1tAB+eat9aUwEuopJbeTuHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779516; c=relaxed/simple;
	bh=tvaPmIa5fP6PJzISyx2xRHOhBOhwV6IopkhOpSgpc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7CrJogY9mUWVLij2nOCBNdaZjkBz7YmZv6MoRefyvQPPFHgQ9pZwyUMHV1agu12pqxc5UmWuLYWoch7lw2pbN/1B3b34Q/Q7jxWs03QBQ9Sd+gneqqgF7f3Maxfv/Bb2kWPiL67xaxQz1RPyLlqhmqtp5s2ueehxqsay+2qV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE1kclfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE1kclfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF51C2BBFC;
	Wed, 19 Jun 2024 06:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718779515;
	bh=tvaPmIa5fP6PJzISyx2xRHOhBOhwV6IopkhOpSgpc68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lE1kclfnRxIfJbtRgJPpMRydvWkD1TXX42z5UwjMdWbNKrpsFzTROwZGYZJpdr5mX
	 D3cLCF4bbIJWgVev+wlCAy9oAm8p6ngsq1n1kQCB6DCSZlJ401HetdsZeMLZuOM8x/
	 +XqYd0SjjqxogsMRWG76VijEcum92LSpq+ejydsFK1DPRFA93Jln0jrVVCzxxRdd0o
	 MUI6NFi4VC47w9Tx6OdnpwQflykJpUrKVHB7UK91XLGetKaFJEG61jEN/Nto6xIS62
	 GByIb3Ohpq+Xc+PUUs9I/38K+0DCPBO3mvs8nG2m1eamryV6ZcnvVs5ilTzb1VpkSD
	 v9YCC43FfFECA==
Date: Wed, 19 Jun 2024 09:42:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhengyejian <zhengyejian@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v6 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <ZnJ976eF8U_7EvNA@kernel.org>
References: <20240613155506.811013916@goodmis.org>
 <20240613155527.437020271@goodmis.org>
 <5ab67b75-4334-3678-40d2-8be98460d496@huaweicloud.com>
 <20240618120627.2002810a@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618120627.2002810a@rorschach.local.home>

On Tue, Jun 18, 2024 at 12:06:27PM -0400, Steven Rostedt wrote:
> On Tue, 18 Jun 2024 20:55:17 +0800
> Zhengyejian <zhengyejian@huaweicloud.com> wrote:
> 
> > > +	start = memblock_phys_alloc(size, align);
> > > +	if (!start)
> > > +		return -ENOMEM;
> > > +
> > > +	reserved_mem_add(start, size, name);
> > > +
> > > +	return 0;  
> > 
> > Hi, steve, should here return 1 ? Other __setup functions
> > return 1 when it success.
> 
> Ug, you're correct.
> 
> Mike, want me to send a v7?

I can fix it up while applying.
 
> -- Steve

-- 
Sincerely yours,
Mike.
