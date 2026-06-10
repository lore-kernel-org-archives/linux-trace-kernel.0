Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F530C629;
	Wed, 10 Jun 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121094; cv=none; b=PMISbTs1jzjfdk1h4fYVKIEPhuFEVggTrkkXaXIqiTNElGmmiDOBNXr4MFMkeymf0vvIst15pEvvz176BFUN96vxjXdagPngyqwJSaKfgpVgaEkGzx6ikE1ZCKnBVpKP1PQooiOeNdB2xSljBJ935dbv5B6XK2UW3VoxMZ5KA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121094; c=relaxed/simple;
	bh=+AH/FqasSiuNkfQ7VgJC3EddiciO2ruM6zRYZJUzkFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGm+RqyeRFCHkoG/6dctWDiX7ufGKnuS3bA/oNH7B3zxuMtuLn6Qr5nBBAUE/tGTlrzj2QSe7yNtwQxAFYATZ3AE9bQivcPURGBLSyHsP+Zap23y9ffnMdYOpQtcUdszybHSU3KsRnNVYQM38psljvip1PoZVSfxKiDFFL9NP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 34F03402DD;
	Wed, 10 Jun 2026 19:51:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id CDF8E2001C;
	Wed, 10 Jun 2026 19:51:22 +0000 (UTC)
Date: Wed, 10 Jun 2026 15:51:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Markus
 Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-ID: <20260610155139.01b6def4@gandalf.local.home>
In-Reply-To: <20260610120659.7c61cfa6@pumpkin>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
	<20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
	<20260610120659.7c61cfa6@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CDF8E2001C
X-Stat-Signature: rxff1hj5rsz7jjwntfwxw86zob5ytdr1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OZ+hbMIfpG/05B/nS4JLz2+xamN3edX0=
X-HE-Tag: 1781121082-733007
X-HE-Meta: U2FsdGVkX18Epw5yADqQeuv1zb8Di3KFLdVdzC0ujN3OOggbQYDsDxMahcqSCjN1416OvfDlUaFo0IKYzkNWqRP5KzC2lcivd8vqxSW2AlIeQhBWTIWfmkCTny4F3lk6Jk7TDpjYWW3Q/hVA0YDwABsoZHQLhBeV+/yzfgwUwYDOAG5JiMlzOUunSZtM323mIdfj+BiiNhDHUTaGOJedBCFdup+aOhyTUfB15/aIjUMhbQ1zUTJheruR7V2flLxP9mqbw8Qn9dJLRiA0maX5HqYheL9RUbFSpO4tH9r7xh/oguWinA1YRFPPR6WV+LslHtREqTWyZUx0+4oQsQVicFFUlhYyLxM/dM/H2kChhDvp9xBvpkHxv8GXBS7VYyL0jMMvTPQ/fxxBgHOMq3Q8QA==

On Wed, 10 Jun 2026 12:06:59 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> So you only want __packed on structures that might be misaligned and those
> that contain misaligned members.
> 
> If the structure is only guaranteed to be 32bit aligned then use __packed
> __aligned(4) so that two 32bit accesses get used instead of 8 8bit ones.
> 
> -- David
> 
> > 
> > Thank you,
> >   
> > > Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
> > > ---
> > >  kernel/trace/fprobe.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index cc49ebd2a773..21751dcdb7b9 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *stack,
> > >  struct __fprobe_header {
> > >  	struct fprobe *fp;
> > >  	unsigned long size_words;
> > > -} __packed;
> > > +};
> > >  

Does "__packed" really do anything between a pointer and a long?

-- Steve
