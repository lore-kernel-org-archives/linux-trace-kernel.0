Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA22624;
	Fri, 12 Jul 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789832; cv=none; b=FjiXop4REaHRE3tDjXy9tPUZw3foESTPfjL3Nm/5VYfROvUVjJt0Ps+yAXAOwGBrO5ZHY0Ukl6zSKlbvAYeZPtS+WFRa3eaq3N/17Z68ccIOZhq0Zzw/X6yB0XQDWdWLz7XDl6odwOvaUkdgqXlVtJFrdR5dH9ApwxdgvohS8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789832; c=relaxed/simple;
	bh=Wd/y55LU2dzDLm3ncE/eYVAWkK86r0lKsYkhJVzCWLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGJA+YrjB4aY+3+Rx8zsPedCJHb27LPcoCXOpMX/14qfSY87cEiBG2rd9n/WUNvqxlMbh454LgMFlMlkIbMzGySYuBFOxTO9yuwVBTOoI4OrQn07rIVvVok7YPwSY4ggVw1LaZTp9mLZacZZYvQOSmaSXLUsdkO8v2VgyTaUc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qpq3qlOO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qpq3qlOO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JTQImQdeEtnT0WU6vnqgW1+IJ0T/HgauZhWUUHmvt1M=; b=Qpq3qlOODtmT/dbOCvyKoKxj6l
	GFAnz2rAdM+oH7CkhQ0+qlUOCmkuGdCAg1pbXEXzXkpEyeYGtZh6fobGkSpt+htdsKs/n7L+LFUC+
	OOYA4IbDDDhlZb8bMoN2lxfaKHfIPNcjmkrmR5tZQX/RjOuZoxLDnfojCit4DNyaWSZkdpt5htl5d
	RKZJUnZAoxe3rKdMK/hkMgz3wj7hDzPcDK1HI+PcNarz6FGIwb5SLZxj+FWZnfR61SZAluAdxIkhZ
	cdZPJTfnjys2efcLBsoJXMinKf42XCGTLs29D7I5/FnTtjIbTmfEwmmt0YagoTNjM18qGpdDA1bqa
	gaU16odQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSG2S-0000000CSbN-2aYg;
	Fri, 12 Jul 2024 13:10:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38D5F30050D; Fri, 12 Jul 2024 15:10:16 +0200 (CEST)
Date: Fri, 12 Jul 2024 15:10:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
Message-ID: <20240712131016.GI27299@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>

On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:

> Anyways, if you'd like to use it, it's at [0]. All you should need to
> build and run it is:
> 
>   $ cd examples/c
>   $ make -j$(nproc) uprobe-stress
>   $ sudo ./uprobe-stress -tN -aM -mP -fR

>   [0] https://github.com/libbpf/libbpf-bootstrap/commit/2f88cef90f9728ec8c7bee7bd48fdbcf197806c3

So, I cannot clone that [0] URL I had to click around github shite for a
while to figure out wtf to clone and where your commit lives, turns out
it is:

	$ git clone https://github.com/libbpf/libbpf-bootstrap.git
	$ cd libbpf-bootstrap
	$ git checkout uprobe-stress

But then I do the above and I'm greeted with:

root@ivb-ep:/usr/src/libbpf-bootstrap/examples/c# make -j40
  MKDIR    .output
  MKDIR    .output/libbpf
  MKDIR    bpftool
  LIB      libbpf.a
  BPFTOOL  bpftool/bootstrap/bpftool
make[1]: *** /usr/src/libbpf-bootstrap/libbpf/src: No such file or directory.  Stop.
make: *** [Makefile:87: /usr/src/libbpf-bootstrap/examples/c/.output/libbpf.a] Error 2
make: *** Waiting for unfinished jobs....
make[1]: *** /usr/src/libbpf-bootstrap/bpftool/src: No such file or directory.  Stop.
make: *** [Makefile:95: /usr/src/libbpf-bootstrap/examples/c/.output/bpftool/bootstrap/bpftool] Error 2


Now what ?!?

BPF is ever such unusable shite :/ It's very near as bad as qemu.

