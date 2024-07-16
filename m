Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D133C5;
	Tue, 16 Jul 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121456; cv=none; b=PoiFuEBC0id5hbj4IiSO2XhyQxnZEmcFWGNpFPblHvUe6Km8mR5AZ8MMQtFW7nMZ0oQ0MBtA2kIcpVX6Gp5GBmsj0Bs6Hk7oQiAQ5D9LwwlZyC3L7H7kcdqmoAPFSYGp2ipwUyOqq2QIcs8T+9OjPk0L0lkEDsc+59+q3PkgLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121456; c=relaxed/simple;
	bh=Jh2m5Mtxle7H3bxudQx7Nj8SXrnw+4DUZa401WmDq5w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ity//2hT346YyYtmla421yNSeyUCWyQupzSkB94hnO2PjCuHkigski8t1FmncEhmFYV4jYYpGqn8wNW3RvEVl9chwCXb8ep9rR4PpjinGJBPr/nelH76ZLLnHIkqozc/AvqNTsKdjrpu6KNWx+ItFXbb7wNBDULfDQmNwRycsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSYaV4nt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSYaV4nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10ADC116B1;
	Tue, 16 Jul 2024 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721121456;
	bh=Jh2m5Mtxle7H3bxudQx7Nj8SXrnw+4DUZa401WmDq5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSYaV4ntAyVcI6xVpaaoS7d/VuCLZyO7bR9XaG9mrMEPWNFFyR4hWaFJly6f50X+B
	 wuqfD+9NNlWiDHGq22y8g+prueBzZok5iL4GQB1tagEL3lhuvsNSLTwROyeW9wfbFm
	 1MIPu/2HKl9JoWlG8BbKDM46O+61h9E+BVpMMdJQ1hU4iJDHORs1cFkWE31ruBwk69
	 txEBwTrnYP9PdTHC/Iw/3l/VpF4mYBEXFwXUIKPfcPG9RsRze9y2zJLzdmuok+lAVM
	 YfrrNYFVogQ3bFRFkV85KFtdoqYLdTPDNcmwYM6zJCNUCPPG1KxDikiceTgePj7jle
	 08jORK+X+fsHQ==
Date: Tue, 16 Jul 2024 18:17:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri
 Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add uprobes entry
Message-Id: <20240716181730.28ae299f618b5fcb2429c3c8@kernel.org>
In-Reply-To: <20240715172152.GA15187@redhat.com>
References: <172074397710.247544.17045299807723238107.stgit@devnote2>
	<20240715181417.6421de1e1a18a39685533115@kernel.org>
	<20240715172152.GA15187@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 19:21:52 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/15, Masami Hiramatsu wrote:
> >
> > Hi Peter, Oleg,
> >
> > If this is OK for you, please give your Ack.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 

Thanks for the Ack!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
