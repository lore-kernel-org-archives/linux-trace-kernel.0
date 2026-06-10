Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3702C031E;
	Wed, 10 Jun 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108255; cv=none; b=DD2mk/GzxuiUXRWanfbia73efRF15lSlh4k2AVuPY70FLt7y7Vt7RqqCd4xUHwYJo7Xb4qUnSZ1Epy5sI6O94MIOPaSp44ZZ3qEt3LuxrjDHpBmJfAcE7kA6OZxF9IpjzoH5zdkISRpFbFhbaZw7Fs5bdNAW9/3o0HuHt3El5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108255; c=relaxed/simple;
	bh=9cVKvpjd5Gam8N5fwXd88+t3q3x3QYyliGM5Ye+Jsl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcVvxeP0nx4TRo1KAt2T6dkDJGLQoTcjbM/Kvd8Ji4+W8aY5htJIp8QEtzd6e8KbLYYIuUFHby0R1GpcTor1zoWPJvY85ofwsfquNqV7Po1+PpRXY/1cgJUUZC49VuqZFoCFuSwupeDY+tVVZgEBt2n65rLcpycvDXtDB0T2+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B98F11201BA;
	Wed, 10 Jun 2026 16:17:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id AAA416000C;
	Wed, 10 Jun 2026 16:17:23 +0000 (UTC)
Date: Wed, 10 Jun 2026 12:17:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] ring-buffer: Fix event length with forced 8-byte
 alignment
Message-ID: <20260610121722.6909d3cf@robin>
In-Reply-To: <ea9d00cb-54c6-4635-aa13-e5a688375132@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
	<20260607072431.125633-2-hui.wang@canonical.com>
	<20260608180245.09e083867a7d4d96058d7323@kernel.org>
	<20260608125254.2598ef4e@fedora>
	<ea9d00cb-54c6-4635-aa13-e5a688375132@canonical.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AAA416000C
X-Stat-Signature: xht3qwnn1xs743nd4tjbyhmp9btw3g4f
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19doThCv13Pb45P4JVxBz7PB+/XlTk4x8Q=
X-HE-Tag: 1781108243-651871
X-HE-Meta: U2FsdGVkX180+jsezQOMjlZLFezq7woWKAN4J0H0txXoUeTNB2HSj6jxiDOPpBro7CUMNYkNQD0UGRMNuq0D84ti7B2QqqMB7iGEKXOR4P0Nh0CyvGEP4r4cqbzm+5BfwJABhxe49SOyfLkEQ8PU4ZZYaKBtNfX+fzVM5ItdzcNIcBhx2wDEt9DDs0ry7ZLXvJzuLREA6ctbsYjg+L6q4Lmtb6G2BQvHC47x4uY1wldCECXbWUwHllL7v2QwevlTOJr7SuD6wB1ZhNX7OAflHf5xlBamF/HkiMOq4CTuu/gNdViw4k94fQCnw4LZzpNCi6GMnZA7ITf4WmfBzd8xDHLgo9sdSfS2/TA+r1YNL7jTWEQsYIqyge/Gj8VKbx6K

On Tue, 9 Jun 2026 12:22:47 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> Thanks for the pointer. I reverted my two patches and applied the patch=20
> you referenced, but unfortunately it doesn't resolve the problem =E2=80=
=94 the=20
> testcase still fails in my environment (riscv64 kernel with=20
> CONFIG_HAVE_64BIT_ALIGNED_ACCESS enabled).
>=20
>  From what I can tell, that fix addresses a different problem than the=20
> one I'm hitting: it targets a 64K page-size issue, whereas my failure is=
=20
> caused by the 64-bit alignment requirement=20
> (CONFIG_HAVE_64BIT_ALIGNED_ACCESS). So I don't think they're the same=20
> root cause.
>=20
> So can you please take a look at them again.

OK, taking a deeper look at it, and yes, your are correct. Sorry for
jumping to the conclusion with thinking this was the same issue as what
was brought up before.

I'll take these.

Thanks,

-- Steve
