Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641035E1BD;
	Thu, 15 Oct 2026 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102323; cv=none; b=H2pqDJ3vCTAQdDjyvrELlDDv3cou7/Q+us0kC2JaaobBiFbzsIJg6SJTQSG0ll8VCrOHNho/d64C93m0tYJvm4pHzE8s/nbEtPpxt2WbmyCNgN9E71r8mwBz6J9d+eEb4jv4b1FsVnuHpd07mvJ8wPrPb6602BS/QZbuPxWjLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102323; c=relaxed/simple;
	bh=dq/p4u7linPgVLY1Brp7JZ8eab86tJng+Xjb5bkWI1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPojjzdQ+YoJyPlm7hnCcjKHZ895xrzAarhvclo9NWLDzyaTW8/+V7+CqLYJTXfli1W3XxjtMwyfTSl7sAMGfrPzGoId0O6/soUh7s9HVsnTs0c8mvmAYcESDF9pOA1LO+UaLu4Qj4TVe9vasMuhYXXgesMWHqelwEwq0g8Xkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PWICgcKI; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PWICgcKI"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6F0F512017C;
	Thu, 15 Oct 2026 22:11:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id A056E20027;
	Thu, 15 Oct 2026 22:11:57 +0000 (UTC)
Date: Thu, 15 Oct 2026 18:11:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, security@kernel.org
Subject: Re: [BUG] tracing: __copy_from_user without access_ok leaks kernel
 memory in syscall fault tracing
Message-ID: <20261015181156.5da3446c@gandalf.local.home>
In-Reply-To: <20261015094209.7177cf03@gandalf.local.home>
References: <6ad07a3c.6e2bf4e6.f29cc.dd67@mx.google.com>
	<2026101539-rinse-refocus-8203@gregkh>
	<b2dd26de-efd0-4b8d-8086-ee5878a5703f@gmail.com>
	<20261015094209.7177cf03@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A056E20027
X-Stat-Signature: 69aqsdjr6nc531gxyn8jqaanre4q8ghm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/K9s1xqpTyPJ6Pd+vXeE5IrQXp9CBxXJU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PF//Fb1xpNwGDqKk2nkQ5NahuE3IUiO6W5R3UAHjP2Q=; b=PWICgcKI7WRypv4OKYiorxmKpSr2Gz3axazC0d3sAgyLFFxRyrWY0Zg8l3PDllBd3+D36hoTuQ8muDHDGTqqj0h7Y/dnCucNIqy/xN17Gt68Hu/7DfAGAD6NIZGOYHMF2ylmdu1HE+sR4K9ratT3F4sM8OFi43RG7T/sFfvzv9w=
X-HE-Tag: 1792102317-932078
X-HE-Meta: U2FsdGVkX1+9O7VU/j9erXqyODSDviBKd3JiStZqlEesqxXeju2ZkuCa3VF1DHRAEjJDNnkVpoMzizkitUs4es6+ibXxuRRyuPBSmH1JQ+hWnq+n4LS9wWHIEQCaH0juK3xRfvVubJSeX0wIM7zMJklJF0k+g9NUiNDd5cH6aPwIEUb6JJWxbHJ7NdKQyYTdonSTw78WALAjyYLhzQ37ygMEboUULEbJ3MJgFqLS99V3dwc8sH2j9HEfY7FxmuwIqGysCoL3SmGOQojzrlbsD8M5xtZqHUTdOAN6K0obg+y81AuGUhYKhUzCgLktIfgYfVP+6BHhCASktCqSNofE3qJu/9C5CqJlHHJmsofOTAMna8vp9F7RWNF0rqMuBzMftxN68+3WvtkFBwdkc46WKqlmtjMxll5KryZbf0hSz7w=

On Thu, 15 Oct 2026 09:42:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Oct 2026 20:05:57 +0800
> Wang Haoran <haoranwangsec@gmail.com> wrote:
>=20
> Please send this to linux-trace-kernel@vger.kernel.org.
>=20
> >  From ca4e2a6928bbd9010ebec967440517b08909b992 Mon Sep 17 00:00:00 2001
> > From: Haoran Wang <haoranwangsec@gmail.com>
> > Date: Thu, 15 Oct 2026 19:12:21 +0800
> > Subject: [PATCH] tracing/syscalls: use copy_from_user for the faultable
> >  =C2=A0syscall buffer
> >=20
> > Here is a working fix for the report. The leak is not strictly root
> > only, so there is a security concern on systems that relax
> > perf_event_paranoid. =20
>=20
> Leave out any security details.
>=20
> Simply state that the current check is missing the access_ok.
>=20
> That is, this is a very trivial bug with a simple fix and a simple change
> log. It could be a security concern for machines that trust perf a bit too
> much.
>=20
> But to go upstream, it still needs to follow the process.
>=20

Heh, I just noticed that you *did* Cc upstream (in this email!). But
because you didn't have "[PATCH]" in the topic, it still didn't make it to
patchwork.

Can you please send a proper patch.

Thanks,

-- Steve
