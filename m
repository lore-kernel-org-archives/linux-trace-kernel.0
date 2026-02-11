Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31842367A2;
	Wed, 11 Feb 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833721; cv=none; b=gxaMbPX3adRnmL24jhRs/LplNLbYztBtmcwA2Rw5Dk92IuTwYaGDTQV88TeLvAtNgeGnjTiDEP+lJ6FD4WpubL3k+iI0JfK5MA9XYuoG144X9JVEnDQuvhaqD97BkCFLPmMPFSQKsRKUq0FP2r3CrfRuVbSCsqAPpGsZAjquwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833721; c=relaxed/simple;
	bh=s7FP0JHNhDR2j/TDugH5QuDbULPXLyikmLIbaz8BnsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlOd7Y1aRcxym9UNlhyXDe9I5xdQ/I0Hidf0MdWA+W7K+X85iUgV/8h+Zq/QQdtCQtqIotK97hEXBhTWMVpsDJgzWLwTNiCHvNILNRc5Q250LC9MKP8nGNh6LNyK/uRY9uyE4Cq++bH5fk6goIXMQ+dgtKg6kN/4loGaSZ5AX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E1CC71A04ED;
	Wed, 11 Feb 2026 18:15:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 52E9B20013;
	Wed, 11 Feb 2026 18:15:15 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:15:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <zanussi@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>, Shengming Hu
 <hu.shengming@zte.com.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: make tr->d_max_latency accessible without
 CONFIG_FSNOTIFY
Message-ID: <20260211131513.0278b1b3@fedora>
In-Reply-To: <20260211125152.3afe6e4f@fedora>
References: <20260210141310.1605322-1-arnd@kernel.org>
	<20260211125152.3afe6e4f@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 52E9B20013
X-Stat-Signature: ehh3ixgkmtr6wfghmo4nnjh4s7ustjqh
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5eij4Z2VX8Rzan+SVpLbCjUq/9410pec=
X-HE-Tag: 1770833715-715164
X-HE-Meta: U2FsdGVkX1+WZeI89WSRhmCkK0uQvsohZipEaMG5fTcnMgbFZpAkklPlFg6dN6lop11mYB9/2MiYGqcJFl6HTxy4CAOuBeGbQOmCDFZncJoRXNgO49rogUS4t6XRw7nLtTwcYKNOh5DSqKvrhKhRFiaYb3ILS/NMAPeKfg7KBJxR2u0x9i7LZ2ViGfHt9EhExABONkTUUNh8ahHMHqY91W0ggwl1t0y9eMx6r5Ly1Zr75B2kbz26QSxakVrEn9s7DRaVXvApYe1oEOhoB4aeJUi+PKnEtC0ukAhvNIMi4Ar+J2/TMfTVysD5sgck74theXoAHWtxkdJ2kI9+EkLXzlK7Qh5+w/WUDE7EsIN/b90O5XHoXgCn4CetZzfkREKc3JHvRpsbzzt+Deb6jpI1SA==

On Wed, 11 Feb 2026 12:51:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Feb 2026 15:13:06 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > A recent change attempted to make the tracing_max_latency file visible
> > unconditionally, but this lead to a build failure:
> > 
> > kernel/trace/trace.c: In function 'trace_create_maxlat_file':
> > kernel/trace/trace.c:1543:13: error: 'struct trace_array' has no member named 'd_max_latency'; did you mean 'max_latency'?
> >  1543 |         tr->d_max_latency = trace_create_file("tracing_max_latency",
> >       |             ^~~~~~~~~~~~~
> > 
> > Make the corresponding change in the header file.
> > 
> > Fixes: ba73713da50e ("tracing: Clean up use of trace_create_maxlat_file()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Beat you to it ;-)
> 
>  https://lore.kernel.org/linux-trace-kernel/20260209194631.788bfc85@fedora/

In fact, our changes were so identical that patchwork set both my patch
and your patch to queued when I applied mine to linux-next!

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20260210141310.1605322-1-arnd@kernel.org/

-- Steve

