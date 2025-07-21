Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E21A5BA4;
	Mon, 21 Jul 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137342; cv=none; b=dmCfH39pdocBlJeqZLdIGU0XHODNj+smETZc9SmxB/ttaiesHZGQQArXPIJ43kMYIaSf/Nen9Hdh9ExiY+rKgJEML10S4joZ2T1NckLWhTDn/55Dt//hm/ka0DoI9yXx+BjP1TT/X9WZBBglCmyXswxy8C8tzL4lE5xt67YtsyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137342; c=relaxed/simple;
	bh=7AG18qiQGOlMcjbUFddDVeyeUBg0jnfETbSe/AGbBsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsQYAJupwplbddoXEUQewF7MAI+HfbDGSFsTn3toRoZ0PwYDngEHoLIEdiN5L56GDX86X0YjmwAENQbJw5NZI4deQNJ/sQN1nY8Mn4Djo9yDcT0tsE+xYbCv6wGLg5bMZvdCbiygZbOk+xstrWc12KvV3LeMn5mECqb81Ivtbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 077B756433;
	Mon, 21 Jul 2025 22:35:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 963DB20027;
	Mon, 21 Jul 2025 22:35:35 +0000 (UTC)
Date: Mon, 21 Jul 2025 18:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
Message-ID: <20250721183606.0489b1cd@gandalf.local.home>
In-Reply-To: <20250626123405.1496931-10-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
	<20250626123405.1496931-10-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 963DB20027
X-Stat-Signature: ks1m4ht5mmp61ie7tbgzwg4eipwd8qa6
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18djCe0ggYH1k96IBvjYJcGA12/+S6PhOo=
X-HE-Tag: 1753137335-789960
X-HE-Meta: U2FsdGVkX19Qiotu+MuD6UYbiCIlUgReWBRsgqgWwM49OmfW3pE7cXFI4EA8TbKyR4JD0Vllu9aM5XOiDKZ6c8qC7lX3uho4e0ZnMjXEas3GGV/XNszLtapC0tmNUWcIM5ZSPiTYInXMEOtAxJxUOaflrLxvykkl33ctlRUNVOH2N7dvxyP/LwlSblQv87MqdyPfvPMyp2geJcVOhKuqT2zQwqTlEfjY1C90dvARvNLlC8uDUBy6sv0S5LTRBFdIbrLwc0f6aLM83caRGWqBxVJeT5gpU2YwMIZBBq+r7Lf82o52pku1S+3DuUJnoo6Xt2q6w2hLd/SVhQlIsjQlyVc7vHz3t6w+

On Thu, 26 Jun 2025 14:34:05 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> +        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
> +        support and RT priority. Note that due to implementational limitations, actions
> +        might be delayed up to one second after tracing is stopped if BPF mode is not
> +        available or disabled.
> +

I'm curious to what is looked for for triggering an action. We can poll on
events and get woken when they are triggered. It may be possible to add
even more ways to wake a task waiting for something to happen.

-- Steve
